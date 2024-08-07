class Controlador {
    constructor(reset = true) {
        if (reset) {
            this.constantes();
            this.configuracion();
        }
    }

    async constantes() {
        const servicio = { servicio: "CONSTANTES" };

        try {
            let respuesta = await ajax.post(servicio);
            respuesta = JSON.parse(respuesta);

            window.DG = {}; // Creo el objeto global de las constantes
            for (const constante of respuesta.resultado)
                DG[constante.constante] = constante.valor;
        } catch {
            vista.mensaje("Ocurrió un error, vuelva a intentarlo");
        }
    }

    configuracion() {
        const intervalo = setInterval(async () => {
            if (window.hasOwnProperty("DG")) {
                try {
                    let configuracion = [], respuesta;
                    const servicio = { servicio: "CONFIGURACION" };

                    clearInterval(intervalo);
                    respuesta = await ajax.post(servicio);
                    respuesta = JSON.parse(respuesta);
                    if (respuesta.ok == DG.CONSULTA_EXITOSA) {
                        const campos = respuesta.resultado;

                        // Borro los campos inactivos o que no se consideran en esta vista
                        for (const campo in campos)
                            if (campos[campo] == DG.CAMPO_INACTIVO || !vista.esElemento(campo))
                                delete campos[campo];
                            else configuracion.push(campo);

                        // Conservo la configuración en global
                        window.CONFIGURACION = configuracion;

                        // Solicito a la vista que se actualice
                        vista.configuracion();

                        // Si es necesario, consulto los géneros
                        if (CONFIGURACION.includes("genero")) this.generos();
                    } else {
                        throw DG.CONSULTA_FALLIDA;
                    }

                } catch {
                    vista.mensaje("Ocurrió un error en la configuración, vuelva a intentarlo");
                }
            }
        }, 100);
    }

    async generos() {
        let servicio = { servicio: "CONSULTAS_CATALOGO", catalogo: "generos" };

        try {
            let respuesta = await ajax.post(servicio);
            respuesta = JSON.parse(respuesta);
            if (respuesta.ok == DG.CONSULTA_EXITOSA) vista.generos(respuesta.resultado);
            else throw DG.CONSULTA_FALLIDA;
        } catch {
            vista.mensaje("Ocurrió un error, vuelva a intentarlo");
        }
    }

    validar(datos) {
        for (const campo of CONFIGURACION) {
            switch (campo) {
                case "nombre":
                case "pApellido":
                case "sApellido":
                case "nacimiento":
                case "login":
                case "pwd":
                case "foto":
                    if (datos[campo] == "") return false;
                    break;
                case "genero":
                    if (parseInt(datos[campo]) == DG.INDEFINIDO) return false;
                    break;
                case "documento":
                    if (!datos[campo]) return false;
                    break;
            }
        }
        return true;
    }

    async procesar(datos) {
        datos["servicio"] = "ALTAS"

        try {
            console.log(datos);
            let respuesta = await ajax.post(datos);
            console.log(respuesta);
            respuesta = JSON.parse(respuesta);
            console.log(respuesta);

            if (!respuesta.ok) throw DG.ALTA_FALLIDA;
            else vista.mensaje("Registro exitoso");
        } catch (e) {
            console.log(e);
            vista.mensaje("Error al procesar el alta");
        }
    }
}