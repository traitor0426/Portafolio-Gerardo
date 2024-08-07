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
            for (const constante of respuesta.resultado) {
                DG[constante.constante] = constante.valor;
            }
        } catch {
            vista.mensaje("Ocurrió un error, vuelva a intentarlo");
        }
    }

    async acceder(datos) {
        datos["servicio"] = "EXISTE";
        datos["login"] = datos["login"];
        datos["pwd"] = datos["pwd"];

        console.log(datos);

        try{
            let respuesta = await ajax.post(datos)
            respuesta = JSON.parse(respuesta)

            console.log(respuesta)
            if(respuesta.resultado.resultado == DG.CONSULTA_EXITOSA)
            window.location.href= "menu.html";
            else throw DG.CONSULTA_FALLIDA
        }catch(e){
            console.log(e)
            vista.mensaje("DATOS INCORRECTOS")
        }
    }
}
