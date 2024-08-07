class Vista {
    constructor(reset = false) {
        if (reset) {
            this.main = document.querySelector("main");
            this.configuracion = ["edad", "operador"]; // Agregar "operador" a la configuración

            // Crear un contenedor para encapsular los campos
            const formContainer = document.createElement("div");
            formContainer.classList.add("form-container");

            // Título del formulario
            const titulo = document.createElement("h2");
            titulo.innerText = "Consulta por Edad";
            titulo.classList.add("titulo");
            formContainer.appendChild(titulo);

            // Agregar campo de entrada para la edad
            formContainer.append(this.input({ id: "edad", type: "number", placeholder: "Ingrese la edad", class: ["input-field"] }));
            this.edad = formContainer.querySelector("#edad");

            // Agregar campo de selección para el operador
            const operadores = ["", ">", "<", "=", ">=", "<="]; // Opciones de operadores
            const selectOperador = this.select({ id: "operador", class: ["input-field"], options: operadores });
            formContainer.append(selectOperador);
            this.operador = formContainer.querySelector("#operador");

            // Botón de buscar
            formContainer.append(this.input({ id: "btnBuscar", type: "submit", value: "Buscar edad", class: ["boton"] }));
            this.btnBuscar = formContainer.querySelector("#btnBuscar");
            if (this.btnBuscar) {
                this.btnBuscar.addEventListener("click", (e) => this.btnBuscar_click(e));
            }

            // Añadir el formulario al main
            this.main.appendChild(formContainer);

            // Crear la tabla para mostrar los resultados
            this.crearTabla();
        }
    }

    btnBuscar_click(e) {
        e.preventDefault();
        const datos = this.recuperar();
        const operador = this.operador.value; // Obtener el valor del operador
        if (datos.edad && operador) { // Verificar que ambos datos estén presentes
            controlador.consultaEdad(datos, operador); // Pasar el operador como argumento
        } else {
            this.mensaje("Por favor complete todos los campos.");
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

    select(setup) {
        const select = document.createElement("select");

        if (setup.hasOwnProperty("id")) select.id = setup.id;
        if (setup.hasOwnProperty("class")) // Debe ser un array de cadenas
            for (const clase of setup.class)
                select.classList.add(clase);
        if (setup.hasOwnProperty("options")) {
            for (const option of setup.options) {
                const optionElem = document.createElement("option");
                optionElem.textContent = option;
                select.appendChild(optionElem);
            }
        }
        return select;
    }

    crearTabla() {
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

        this.main.appendChild(tabla);

        // Asignar referencia al elemento tbody
        this.datosTabla = document.querySelector("#datosTabla");
    }

    actualizarTabla(datos) {
        if (!this.datosTabla) {
            return;
        }

        this.datosTabla.innerHTML = ""; // Limpiar contenido anterior

        datos.forEach(dato => {
            const tr = document.createElement("tr");
            for (const key in dato) {
                const td = document.createElement("td");
                if (key === "foto") {
                    const img = document.createElement("img");
                    img.src = dato[key];
                    img.alt = `Foto de ${dato.nombreCompleto}`;
                    img.style.width = "50px"; // Ajustar tamaño según sea necesario
                    img.style.height = "50px"; // Ajustar tamaño según sea necesario
                    img.style.borderRadius = "50%"; // Hacer que la imagen sea circular
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
