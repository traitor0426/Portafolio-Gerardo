class Controlador {

    constructor(reset = true) {
        if (reset) {
            this.constantes();
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
        }
        catch { vista.mensaje("Ocurrió un error, vuelva a intentarlo"); }
    }

    async consulta_nombreCompleto(datos) {
        console.log(datos);
        datos["pagina"] = 0;
        datos["servicio"] = "CONSULTAS_NOMBRE";
        console.log(datos);

        try {
            let respuesta = await ajax.post(datos);
            console.log(respuesta)
            respuesta = JSON.parse(respuesta);

            if (respuesta.ok == DG.CONSULTA_EXITOSA) {
                vista.datosTabla.innerHTML = '';

                if (Array.isArray(respuesta.resultado)) {
                    respuesta.resultado.forEach(datos_obtenidos => {
                        const row = vista.datosTabla.insertRow(-1);
                        const cell1 = row.insertCell(0);
                        const cell2 = row.insertCell(1);
                        const cell3 = row.insertCell(2);
                        const cell4 = row.insertCell(3);

                        cell1.innerHTML = datos_obtenidos.nombreCompleto;
                        cell2.innerHTML = datos_obtenidos.login;
                        const img = document.createElement("img");
                        img.src = datos_obtenidos.foto; // Utiliza directamente el valor base64
                        img.alt = "Foto de " + datos_obtenidos.nombreCompleto;
                        img.style.width = "50px"; // Ajusta el tamaño según sea necesario
                        img.style.height = "50px"; // Ajusta el tamaño según sea necesario
                        cell3.appendChild(img);
                        const btBorrar = vista.botonBorrar(datos_obtenidos.id); // Corregido para usar datos_obtenidos.id
                        cell4.appendChild(btBorrar);
                    });
                } else {
                    const row = vista.datosTabla.insertRow(-1);
                    const cell1 = row.insertCell(0);
                    const cell2 = row.insertCell(1);
                    const cell3 = row.insertCell(2);
                    const cell4 = row.insertCell(3);

                    cell1.innerHTML = respuesta.resultado.nombreCompleto;
                    cell2.innerHTML = respuesta.resultado.login;
                    const img = document.createElement("img");
                    img.src = respuesta.resultado.foto; // Utiliza directamente el valor base64
                    img.alt = "Foto de " + respuesta.resultado.nombreCompleto;
                    img.style.width = "150px"; // Ajusta el tamaño según sea necesario
                    img.style.height = "150px"; // Ajusta el tamaño según sea necesario
                    cell3.appendChild(img);
                    const btBorrar = vista.botonBorrar(respuesta.resultado.id);
                    cell4.appendChild(btBorrar);
                }
            } else {
                throw new Error(DG.CONSULTA_FALLIDA);
            }
        } catch (error) {
            console.error(error);
            vista.mensaje("Ocurrió un error al buscar los nombres, vuelva a intentarlo");
        }
    }

    async borrar(id) {
        const datos = {
            servicio: "BAJAS",
            id: id
        };

        try {
            let respuesta = await ajax.post(datos);
            respuesta = JSON.parse(respuesta);

            if (respuesta.ok) {
                vista.mensaje("Dato borrado exitosamente.");
                // Aquí podrías refrescar la tabla o realizar alguna acción adicional
                // después de borrar el dato, como llamar de nuevo a consulta_nombreCompleto()
                // para obtener los datos actualizados
            } else {
                throw new Error("La solicitud para borrar el dato no fue exitosa.");
            }
        } catch (error) {
            console.error(error);
            vista.mensaje("Ocurrió un error al intentar borrar el dato, vuelva a intentarlo.");
        }
    }
}