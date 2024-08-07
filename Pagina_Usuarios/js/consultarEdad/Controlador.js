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
        catch (error) {
            vista.mensaje("Ocurrió un error, vuelva a intentarlo");
            console.error(error);
        }
    }

    async consultaEdad(datos, operador) {
        datos["operador"] = operador;
        datos["pagina"] = 0;
        datos["servicio"] = "CONSULTAS_EDAD";

        datos.edad = parseInt(datos.edad);

        console.log(datos)
        
        try {
            let respuesta = await ajax.post(datos);
            respuesta = JSON.parse(respuesta);
            console.log(respuesta);
            if (respuesta.ok == DG.CONSULTA_EXITOSA) {
                const datosDepurados = respuesta.resultado.map(item => ({
                    nombreCompleto: item.nombreCompleto,
                    login: item.login,
                    nacimiento: item.nacimiento,
                    foto: item.foto
                }));
                vista.actualizarTabla(datosDepurados);
            } else {
                throw DG.CONSULTA_FALLIDA;
            }
        } catch (error) {
            vista.mensaje("Ocurrió un error al buscar los nombres, vuelva a intentarlo");
        }
    }
}