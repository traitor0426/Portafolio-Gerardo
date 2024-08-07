import path from 'path';
import { createServer } from 'http';
import { fileURLToPath } from 'url';
import { BD } from './BD.js';
import { Servicios } from './Servicios.js';
import { Requisicion } from './Requisicion.js';
import { createReadStream, existsSync, readFileSync, readdirSync, writeFile, mkdirSync } from 'fs';
import { setInterval } from 'timers';

class Server {
    constructor() {
        createServer((req, res) => {
            if (req.method === "GET") {
                this.GET(req, res);
            } else if (req.method === "POST") {
                this.POST(req, res);
            }
        }).listen(80, '127.0.0.1', () => {
            console.clear();
            console.info("Servidor web a la escucha en el puerto 80");
        });
        this.servicios = new Servicios();
    }

    GET(req, res) {
        const url = req.url === '/' ? './index.html' : req.url; // Para cuando teclean localhost
        const archivo = fileURLToPath(import.meta.url); // Archivo meta (el que se está ejecutando)
        const directorio = path.dirname(archivo); // Recupero mi directorio base
        const ruta = path.join(directorio, url); // Ruta absoluta del recurso solicitado

        if (existsSync(ruta)) {
            const flujo = createReadStream(ruta, 'UTF-8');
            const extension = this.extension(url).toLowerCase();

            res.writeHead(200, { 'Content-Type': this.contentType(extension) });
            if (this.esArchivoBinario(extension)) res.end(readFileSync(ruta), 'binary');
            else flujo.pipe(res); // Respuesta fragmentada al cliente (chunk)
        } else if (url.startsWith('/subidos/')) {
            // Manejar la solicitud de archivos en el directorio 'subidos'
            const rutaArchivo = path.join(directorio, url);
            if (existsSync(rutaArchivo)) {
                const flujo = createReadStream(rutaArchivo);
                const extension = this.extension(rutaArchivo).toLowerCase();
                res.writeHead(200, { 'Content-Type': this.contentType(extension) });
                if (this.esArchivoBinario(extension)) res.end(readFileSync(rutaArchivo), 'binary');
                else flujo.pipe(res);
            } else {
                res.writeHead(404, { 'Content-Type': this.contentType("txt") });
                res.end("404 Error: Archivo no encontrado");
            }
        } else if (url === '/archivos') {
            // Manejar solicitud para listar archivos subidos
            this.listarArchivos(res);
        } else {
            res.writeHead(404, { 'Content-Type': this.contentType("txt") });
            res.end("404 Error: Archivo no encontrado");
        }
    }

    async POST(req, res) {
        if (req.url === '/subir') {
            // Manejar subida de archivos
            this.subirArchivo(req, res);
        } else {
            let data = "";

            global.DB = new BD("CONFIGURACION");
            req.on('data', chunk => data += chunk); // Datos llegando, se está armando la requisición
            req.on('end', () => { // No hay más datos, la requisición ya está armada
                const solicitud = new Requisicion(this.esJSON(data)); // Espero un dato json, verifico

                if (solicitud.ok && this.servicios[solicitud.servicio]) { // ¿Solicitud bien formada y es legal?
                    let intervalo = setInterval(() => {
                        if (DB.configuracion) {
                            const funcion = this.servicios[solicitud.servicio](solicitud);

                            funcion.then((r) => {
                                res.writeHead(200, { 'Content-Type': this.contentType("json") });
                                res.end(JSON.stringify(r));
                            }).catch((error) => {
                                console.error("Ocurrio un error", error);
                            });
                            clearInterval(intervalo);
                        }
                    }, 100);
                } else {
                    res.writeHead(404, { 'Content-Type': this.contentType("txt") });
                    res.end("Servicio desconocido o formato de datos incorrecto");
                }
            });
        }
    }

    listarArchivos(res) {
        const directorio = path.join(path.dirname(fileURLToPath(import.meta.url)), 'subidos');
        try {
            const archivos = readdirSync(directorio);
            const archivosConRuta = archivos.map(archivo => ({
                nombre: archivo,
                url: `/subidos/${archivo}`
            }));
            res.writeHead(200, { 'Content-Type': this.contentType("json") });
            res.end(JSON.stringify({ archivos: archivosConRuta }));
        } catch (error) {
            res.writeHead(500, { 'Content-Type': this.contentType("txt") });
            res.end("Error al obtener los archivos");
        }
    }

    subirArchivo(req, res) {
        const directorio = path.join(path.dirname(fileURLToPath(import.meta.url)), 'subidos');

        // Crear el directorio si no existe
        if (!existsSync(directorio)) {
            mkdirSync(directorio);
        }

        let data = Buffer.alloc(0);

        req.on('data', chunk => {
            data = Buffer.concat([data, chunk]);
        });

        req.on('end', () => {
            const boundary = this.getBoundary(req.headers['content-type']);
            const parts = this.parseMultipart(data, boundary);
            const filePart = parts.find(part => part.filename);

            if (filePart) {
                // Verificar que el archivo tenga extensión .pdf
                if (!filePart.filename.toLowerCase().endsWith('.pdf')) {
                    res.writeHead(400, { 'Content-Type': this.contentType("json") });
                    res.end(JSON.stringify({ ok: false, mensaje: 'Solo se permiten archivos PDF' }));
                    return;
                }

                const filePath = path.join(directorio, filePart.filename);
                writeFile(filePath, filePart.data, err => {
                    if (err) {
                        res.writeHead(500, { 'Content-Type': this.contentType("json") });
                        res.end(JSON.stringify({ ok: false, mensaje: 'Error al subir el archivo' }));
                    } else {
                        res.writeHead(200, { 'Content-Type': this.contentType("json") });
                        res.end(JSON.stringify({ ok: true, mensaje: 'Archivo subido exitosamente', url: `/subidos/${filePart.filename}` }));
                    }
                });
            } else {
                res.writeHead(400, { 'Content-Type': this.contentType("json") });
                res.end(JSON.stringify({ ok: false, mensaje: 'No se subió ningún archivo' }));
            }
        });
    }

    getBoundary(header) {
        const items = header.split(';');
        for (let i = 0; i < items.length; i++) {
            const item = items[i].trim();
            if (item.startsWith('boundary=')) {
                return item.slice(9);
            }
        }
        return '';
    }

    parseMultipart(buffer, boundary) {
        const parts = [];
        let start = buffer.indexOf(`--${boundary}`) + boundary.length + 4;
        let end = buffer.indexOf(`--${boundary}--`);

        while (start < end) {
            const headerEnd = buffer.indexOf('\r\n\r\n', start);
            const header = buffer.slice(start, headerEnd).toString();
            const contentStart = headerEnd + 4;
            const contentEnd = buffer.indexOf(`\r\n--${boundary}`, contentStart);
            const content = buffer.slice(contentStart, contentEnd);

            const part = this.parsePartHeader(header);
            part.data = content;
            parts.push(part);

            start = contentEnd + boundary.length + 6;
        }

        return parts;
    }

    parsePartHeader(header) {
        const part = {};
        const lines = header.split('\r\n');
        for (let i = 0; i < lines.length; i++) {
            const line = lines[i];
            if (line.startsWith('Content-Disposition:')) {
                const items = line.split(';');
                for (let j = 0; j < items.length; j++) {
                    const item = items[j].trim();
                    if (item.startsWith('name=')) {
                        part.name = item.slice(6, -1);
                    } else if (item.startsWith('filename=')) {
                        part.filename = item.slice(10, -1);
                    }
                }
            } else if (line.startsWith('Content-Type:')) {
                part.type = line.split(':')[1].trim();
            }
        }
        return part;
    }

    extension(archivo) {
        return archivo.slice((archivo.lastIndexOf(".") - 1 >>> 0) + 2);
    }

    contentType(extension) {
        switch (extension) {
            case "pdf": return 'application/pdf';
            case "png": return 'image/png';
            case "jpg": return 'image/jpeg';
            case "ico": return 'image/x-icon';
            case "css": return 'text/css; charset=UTF-8';
            case "txt": return 'text/plain; charset=UTF-8';
            case "html": return 'text/html; charset=UTF-8';
            case "js": return 'text/javascript; charset=UTF-8';
            case "json": return 'application/json; charset=UTF-8';
        }
        return 'text/plain';
    }

    esJSON(texto) {
        try { return JSON.parse(texto); }
        catch (e) { return false; }
    }

    esArchivoBinario(extension) {
        return ["pdf", "png", "jpg", "ico"].indexOf(extension) >= 0;
    }
}

new Server();
