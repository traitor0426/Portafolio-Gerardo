document.addEventListener("DOMContentLoaded", () => {
    document.getElementById("btnBajas").addEventListener("click", () => {
        window.location.href = "bajas.html";
    });

    document.getElementById("btnConsultaEdad").addEventListener("click", () => {
        window.location.href = "consultarEdad.html";
    });

    document.getElementById("btnConsultaEdadRango").addEventListener("click", () => {
        window.location.href = "consultarEdadRango.html";
    });

    document.getElementById("btnConsultaNombreC").addEventListener("click", () => {
        window.location.href = "consultarNombreCompleto.html";
    });
    document.getElementById("btnModificar").addEventListener("click", () => {
        window.location.href = "Modificar.html";
    });
});
