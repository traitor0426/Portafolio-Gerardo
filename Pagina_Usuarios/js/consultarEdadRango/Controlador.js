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
            console.error(error); // Agregamos la impresión del error en la consola para más detalles
        }
    }

    async consultaEdadR(datos) {
        datos["pagina"] = 0;
        datos["servicio"] = "CONSULTAS_EDADENRANGO";

        datos.inicio = parseInt(datos.inicio);
        datos.fin = parseInt(datos.fin);

        //console.log(datos);

        try {
            //console.log(datos);
            let respuesta = await ajax.post(datos);
            console.log(respuesta);
            respuesta = JSON.parse(respuesta);
            if (respuesta.ok == 1) {
                vista.crearTabla();
                // vista.actualizarTabla(respuesta.resultado);
                //vista.mensaje("Si hay resultados")
                for (const datos of respuesta.resultado) {
                    const fila = vista.datosTabla.insertRow(-1);
                    const fila1 = fila.insertCell(0);
                    const fila2 = fila.insertCell(1);
                    const fila3 = fila.insertCell(2);
                    const fila4 = fila.insertCell(3); // Nueva celda para la foto

                    fila1.innerHTML = datos.nombreCompleto;
                    fila2.innerHTML = datos.login;
                    fila3.innerHTML = datos.nacimiento;
                    fila4.innerHTML = `<img src="${datos.foto}" alt="Foto" width="150" height="150">`; // Mostrar la foto
                }
            } else {
                throw new Error(DG.CONSULTA_FALLIDA); // Lanzamos un nuevo error
            }
        } catch (error) {
            vista.mensaje("Error al buscar el rango de edades");
        }
    }
}
