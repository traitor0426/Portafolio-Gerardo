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
        datos["pagina"] = 0;
        datos["servicio"] = "CONSULTAS_NOMBRE";
        console.log(datos);

        try {
            let respuesta = await ajax.post(datos);
            respuesta = JSON.parse(respuesta);
            console.log(respuesta)

            if (respuesta.ok == DG.CONSULTA_EXITOSA) {
                vista.datosTabla.innerHTML = '';

                if (Array.isArray(respuesta.resultado)) {
                    // Iterar sobre los elementos si resultado es un array
                    respuesta.resultado.forEach(datos_obtenidos => {
                        const row = vista.datosTabla.insertRow(-1);
                        const cell1 = row.insertCell(0);
                        const cell2 = row.insertCell(1);
                        const cell3 = row.insertCell(2);

                        cell1.innerHTML = datos_obtenidos.nombreCompleto;
                        cell2.innerHTML = datos_obtenidos.login;
                        cell3.innerHTML = `<img src="${datos_obtenidos.foto}" alt="Foto" width="150" height="150">`;
                    });
                } else {
                    // Si resultado no es un array, manejarlo de acuerdo a su tipo
                    const row = vista.datosTabla.insertRow(-1);
                    const cell1 = row.insertCell(0);
                    const cell2 = row.insertCell(1);
                    const cell3 = row.insertCell(2);

                    cell1.innerHTML = respuesta.resultado.nombreCompleto;
                    cell2.innerHTML = respuesta.resultado.login;
                    cell3.innerHTML = `<img src="${respuesta.resultado.foto}" alt="Foto" width="150" height="150">`;
                }
            } else {
                throw DG.CONSULTA_FALLIDA;
            }
        } catch (e) {
            console.log(e);
            vista.mensaje("Ocurrió un error al buscar los nombres, vuelva a intentarlo");
        }
    }
}
