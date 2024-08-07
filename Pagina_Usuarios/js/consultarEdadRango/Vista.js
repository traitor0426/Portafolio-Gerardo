class Vista {
    constructor(reset = false) {
        if (reset == true) {
            this.main = document.querySelector("main");
            this.configuracion = ["inicio", "fin"];

            // Crear un contenedor para encapsular los campos
            const formContainer = document.createElement("div");
            formContainer.classList.add("form-container");

            // Título del formulario
            const titulo = document.createElement("h2");
            titulo.innerText = "Consulta por Rango de Edad";
            titulo.classList.add("titulo");
            formContainer.appendChild(titulo);

            // Agregar campo de entrada para la edad inicial
            formContainer.append(this.input({ id: "inicio", type: "number", placeholder: "Edad inicial", class: ["input-field"] }));
            this.inicio = formContainer.querySelector("#inicio");

            // Agregar campo de entrada para la edad final
            formContainer.append(this.input({ id: "fin", type: "number", placeholder: "Edad final", class: ["input-field"] }));
            this.fin = formContainer.querySelector("#fin");

            // Botón de buscar
            formContainer.append(this.input({ id: "btnBuscar", type: "submit", value: "Buscar", class: ["boton"] }));
            this.btnBuscar = formContainer.querySelector("#btnBuscar");
            if (this.btnBuscar) {
                this.btnBuscar.addEventListener("click", (e) => this.btnBuscar_click(e));
            }

            // Añadir el formulario al main
            this.main.appendChild(formContainer);

            // Crear la tabla para mostrar los resultados si no existe
            this.crearTabla();
        }
    }

    btnBuscar_click(e) {
        e.preventDefault();

        const datos = this.recuperar();
        controlador.consultaEdadR(datos);
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

    crearTabla() {
        // Verificar si la tabla ya existe
        if (!document.querySelector("#tablaConsultas")) {
            const tableContainer = document.createElement("div");
            tableContainer.classList.add("table-container");

            const tabla = document.createElement("table");
            tabla.id = "tablaConsultas";
            tabla.classList.add("table");

            const thead = document.createElement("thead");
            const tr = document.createElement("tr");

            const headers = ["Nombre", "Usuario", "Nacimiento", "Foto"];
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

            tableContainer.appendChild(tabla);
            this.main.appendChild(tableContainer);

            // Asignar referencia al elemento tbody
            this.datosTabla = document.querySelector("#datosTabla");
        } else {
            // Si ya existe, asignar la referencia
            this.datosTabla = document.querySelector("#datosTabla");
        }
    }

    actualizarTabla(datos) {
        if (!this.datosTabla) {
            console.error("Elemento datosTabla no encontrado.");
            return;
        }

        this.datosTabla.innerHTML = ""; // Limpiar contenido anterior

        datos.forEach(dato => {
            const tr = document.createElement("tr");
            for (const key in dato) {
                const td = document.createElement("td");
                if (key === 'foto') {
                    const img = document.createElement("img");
                    img.src = dato[key];
                    img.alt = 'Foto';
                    img.width = 100; // Ajustar el tamaño según sea necesario
                    img.height = 100; // Ajustar el tamaño según sea necesario
                    td.appendChild(img);
                } else {
                    td.textContent = dato[key];
                }
                tr.appendChild(td);
            }
            this.datosTabla.appendChild(tr);
        });
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
}
