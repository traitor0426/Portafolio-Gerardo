class Vista {
    constructor(reset = false) {
        if (reset) {
            this.main = document.querySelector("main");
            this.configuracion = ["nombre"];

            const titulo = document.createElement('h2');
            titulo.innerText = "Buscar Nombre Completo";
            titulo.classList.add("titulo");
            this.main.appendChild(titulo);

            const form = document.createElement('form');
            form.append(this.input({ id: "nombre", type: "text", placeholder: "Escriba su nombre completo", class: ["input-field"] }));
            this.nombre = form.querySelector("#nombre");

            form.append(this.input({ id: "btnBuscar", type: "submit", value: "Buscar nombre", class: ["boton"] }));
            this.btnBuscar = form.querySelector("#btnBuscar");
            this.btnBuscar.addEventListener("click", this.btnBuscar_click.bind(this));

            this.main.appendChild(form);

            this.crearTabla();
        }
    }

    input(setup) {
        const input = document.createElement("input");

        if (setup.hasOwnProperty("id")) input.id = setup.id;
        if (setup.hasOwnProperty("type")) input.setAttribute("type", setup.type);
        if (setup.hasOwnProperty("placeholder")) input.setAttribute("placeholder", setup.placeholder);
        if (setup.hasOwnProperty("disabled")) input.setAttribute("disabled", setup.disabled);
        if (setup.hasOwnProperty("value")) input.setAttribute("value", setup.value);
        if (setup.hasOwnProperty("class")) // Debe ser un array de cadenas
            for (const clase of setup.class)
                input.classList.add(clase);
        return input;
    }

    btnBuscar_click(e) {
        e.preventDefault();

        const datos = this.recuperar();
        controlador.consulta_nombreCompleto(datos);
    }

    crearTabla() {
        const tabla = document.createElement("table");
        tabla.id = "tablaConsultas";
        tabla.classList.add("table");

        const thead = document.createElement("thead");
        const tr = document.createElement("tr");

        const headers = ["Nombre", "Usuario", "Foto", "Acción"];
        for (const headerText of headers) {
            const th = document.createElement("th");
            th.textContent = headerText;
            tr.appendChild(th);
        }

        thead.appendChild(tr);
        tabla.appendChild(thead);

        const tbody = document.createElement("tbody");
        tbody.id = "datosTabla";
        tabla.appendChild(tbody);

        this.main.appendChild(tabla);

        // Asignar referencia al elemento tbody
        this.datosTabla = document.querySelector("#datosTabla");
    }

    recuperar() {
        let datos = {};

        for (const campo of this.configuracion)
            if (this[campo])
                datos[campo] = this[campo].value;
        return datos;
    }

    mensaje(texto) {
        alert(texto);
    }

    actualizarTabla(data) {
        this.datosTabla.innerHTML = ''; // Limpiar tabla existente

        data.forEach(item => {
            const tr = document.createElement("tr");

            const tdNombre = document.createElement("td");
            tdNombre.textContent = item.nombre;
            tr.appendChild(tdNombre);

            const tdUsuario = document.createElement("td");
            tdUsuario.textContent = item.usuario;
            tr.appendChild(tdUsuario);

            const tdFoto = document.createElement("td");
            const img = document.createElement("img");
            img.src = item.foto;
            img.alt = "Foto";
            tdFoto.appendChild(img);
            tr.appendChild(tdFoto);

            const tdAccion = document.createElement("td");
            const btnBorrar = this.botonBorrar(item.id);
            tdAccion.appendChild(btnBorrar);
            tr.appendChild(tdAccion);

            this.datosTabla.appendChild(tr);
        });
    }

    botonBorrar(id) {
        const btnBorrar = this.input({ type: "button", value: "Borrar", class: ["boton"] });
        btnBorrar.addEventListener("click", (e) => {
            e.preventDefault();
            controlador.borrar(id); // Pasar el id al controlador para que sepa qué borrar
        });
        return btnBorrar;
    }
}
