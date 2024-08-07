window.onload = () => {
	window.ajax = new Ajax("servicios/usuarios/")
	window.vista = new Vista(true)
	window.controlador = new Controlador()
}