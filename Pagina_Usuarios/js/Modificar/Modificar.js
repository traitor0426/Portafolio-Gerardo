window.onload = () => {
    window.ajax = new Ajax("servicios/usuarios/");
    window.controlador = new Controlador(true);
    window.vista = new Vista(true);
};
