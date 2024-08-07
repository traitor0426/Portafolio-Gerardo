class Vista {
    constructor(reset = false) {
        if (reset === true) {
            this.main = document.querySelector("main");
            this.configuracion = ["login", "pwd"];

            const titulo = document.createElement('h2');
            titulo.innerText = "Iniciar sesión";
            titulo.classList.add("titulo");
            this.main.appendChild(titulo);

            const form = document.createElement('form');
            form.append(this.input({ id: "login", type: "text", placeholder: "Usuario", class: ["campos"] }));
            this.login = form.querySelector("#login");

            form.append(this.input({ id: "pwd", type: "password", placeholder: "Contraseña", class: ["campos"] }));
            this.pwd = form.querySelector("#pwd");

            form.append(this.input({ id: "btnIniciarSesion", type: "submit", value: "Iniciar sesión", class: ["boton"] }));
            this.btnIniciarSesion = form.querySelector("#btnIniciarSesion");
            this.btnIniciarSesion.addEventListener("click", this.btnIngresar_click.bind(this));

            this.main.appendChild(form);

            const registroEnlace = document.createElement('div');
            registroEnlace.classList.add("register");
            registroEnlace.innerHTML = '<p>¿Aun no tienes cuenta? <a href="registro.html">Registrate aquí</a></p>';
            this.main.appendChild(registroEnlace);
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

    btnIngresar_click(e) {
        e.preventDefault();

        if (this.login.value === "" || this.pwd.value === "") {
            this.mensaje("Todos los campos son obligatorios");
        } else {
            controlador.acceder(this.recuperar());
        }
    }

    recuperar() {
        let datos = {};

        for (const campo of this.configuracion)
            if (this[campo])
                datos[campo] = this[campo].value;
        return datos;
    }

    mensaje(text) {
        alert(text);
    }
}
