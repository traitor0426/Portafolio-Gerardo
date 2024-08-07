class Vista {
    constructor() {
        this.body = document.body;
        this.main = document.querySelector("main");
        this.elementos = ["nombre", "pApellido", "sApellido", "nacimiento", "genero", "login", "pwd", "foto"];
        this.configuracion(); // Llamar a la configuración cuando se crea la instancia
    }

    esElemento(elemento) {
        return this.elementos.includes(elemento);
    }

    configuracion() {
        if (!window.CONFIGURACION) {
            console.error("CONFIGURACION no está definido.");
            return;
        }

        for (const campo of CONFIGURACION) {
            switch (campo) {
                case "nombre":
                    this.main.append(this.input({ id: "nombre", type: "text", placeholder: "Nombre", class: ["input-field"] }));
                    break;
                case "pApellido":
                    this.main.append(this.input({ id: "pApellido", type: "text", placeholder: "Apellido", class: ["input-field"] }));
                    break;
                case "sApellido":
                    this.main.append(this.input({ id: "sApellido", type: "text", placeholder: "Segundo apellido", class: ["input-field"] }));
                    break;
                case "nacimiento":
                    this.main.append(this.input({ id: "nacimiento", type: "date", class: ["input-field"] }));
                    break;
                case "genero":
                    this.main.append(this.select({ id: "genero", class: ["input-field"] }));
                    break;
                case "login":
                    this.main.append(this.input({ id: "login", type: "text", placeholder: "Login", class: ["input-field"] }));
                    break;
                case "pwd":
                    this.main.append(this.input({ id: "pwd", type: "password", placeholder: "Contraseña", class: ["input-field"] }));
                    break;
                case "foto":
                    const fotoDiv = document.createElement('div');
                    fotoDiv.style.display = 'flex';
                    fotoDiv.style.alignItems = 'center';
                    fotoDiv.style.width = '100%';

                    const fotoInput = this.input({ id: "foto", type: "text", placeholder: "Foto", class: ["input-field"] });
                    const fotoButton = this.input({ id: "tomarFoto", type: "button", value: "Tomar foto", class: ["boton"] });

                    fotoButton.addEventListener('click', this.abrirCamara.bind(this));

                    fotoDiv.append(fotoInput);
                    fotoDiv.append(fotoButton);
                    this.main.append(fotoDiv);
                    break;
            }

            this[campo] = document.querySelector("#" + campo);
        }

        const archivoDiv = document.createElement('div');
        archivoDiv.style.display = 'flex';
        archivoDiv.style.alignItems = 'center';
        archivoDiv.style.width = '100%';

        const archivoInput = this.input({ id: "archivo", type: "file", class: [] });
        const archivoLabel = document.createElement('label');
        archivoLabel.textContent = "Subir Archivo";
        archivoLabel.htmlFor = "archivo";
        archivoLabel.style.marginRight = '10px';

        archivoDiv.append(archivoLabel);
        archivoDiv.append(archivoInput);
        this.main.append(archivoDiv);

        this.Procesar();
    }

    abrirCamara() {
        const cameraContainer = document.createElement('div');
        cameraContainer.style.position = 'fixed';
        cameraContainer.style.top = '50%';
        cameraContainer.style.left = '50%';
        cameraContainer.style.transform = 'translate(-50%, -50%)';
        cameraContainer.style.backgroundColor = '#fff';
        cameraContainer.style.padding = '20px';
        cameraContainer.style.border = '2px solid #000';
        document.body.appendChild(cameraContainer);

        if (navigator.mediaDevices && navigator.mediaDevices.getUserMedia) {
            navigator.mediaDevices.getUserMedia({ video: true }).then((stream) => {
                const video = document.createElement('video');
                video.style.width = '100%';
                video.style.height = 'auto';
                cameraContainer.appendChild(video);
                video.srcObject = stream;
                video.play();

                const captureButton = document.createElement('button');
                captureButton.textContent = 'Capturar';
                captureButton.classList.add("boton");
                captureButton.style.marginTop = '10px';

                cameraContainer.appendChild(captureButton);

                captureButton.addEventListener('click', () => {
                    const canvas = document.createElement('canvas');
                    canvas.width = video.videoWidth;
                    canvas.height = video.videoHeight;
                    const context = canvas.getContext('2d');
                    context.drawImage(video, 0, 0, canvas.width, canvas.height);

                    const dataURL = canvas.toDataURL('image/png');
                    document.querySelector('#foto').value = dataURL;

                    stream.getTracks().forEach(track => track.stop());
                    document.body.removeChild(cameraContainer);
                });
            }).catch(() => {
                alert('La API de getUserMedia no es soportada en este navegador.');
            });
        } else {
            alert('La API de getUserMedia no es soportada en este navegador.');
        }
    }

    Procesar() {
        const procesarBtn = this.input({
            id: "procesar",
            type: "button",
            value: "Modificar",
            class: ["boton", "oculto"] // Inicialmente oculto
        });

        this.main.append(procesarBtn);
        this.procesar = document.querySelector("#procesar");
        this.procesar.addEventListener("click", this.procesar_click.bind(this));

        // Validación de campos completos
        setInterval(() => {
            const datos = this.recuperar();
            if (this.validarCamposCompletos(datos)) {
                this.procesar.classList.remove('oculto');
            } else {
                this.procesar.classList.add('oculto');
            }
        }, 500);
    }

    procesar_click() {
        const datos = this.recuperar();
        datos.genero = parseInt(datos.genero); // Convertir género a entero
        controlador.procesar(datos);
    }

    input(setup) {
        const input = document.createElement("input");

        if (setup.hasOwnProperty("id")) input.id = setup.id;
        if (setup.hasOwnProperty("type")) input.setAttribute("type", setup.type);
        if (setup.hasOwnProperty("placeholder")) input.setAttribute("placeholder", setup.placeholder);
        if (setup.hasOwnProperty("value")) input.setAttribute("value", setup.value);
        if (setup.hasOwnProperty("accept")) input.setAttribute("accept", setup.accept);
        if (setup.hasOwnProperty("class")) {
            for (const clase of setup.class) {
                input.classList.add(clase);
            }
        }
        return input;
    }

    select(setup) {
        const select = document.createElement("select");

        if (setup.hasOwnProperty("id")) select.id = setup.id;
        if (setup.hasOwnProperty("class")) {
            for (const clase of setup.class) {
                select.classList.add(clase);
            }
        }
        return select;
    }

    generos(datos) {
        let indefinida = document.createElement("option");
        indefinida.value = DG.INDEFINIDO;
        indefinida.text = "Elija un género";
        this.genero.add(indefinida);

        for (const genero of datos) {
            let option = document.createElement("option");
            option.value = genero.genero;
            option.text = genero.descripcion;
            this.genero.add(option);
        }
    }

    recuperar() {
        const datos = {};
        for (const elemento of this.elementos) {
            if (this[elemento]) {
                datos[elemento] = this[elemento].value;
            }
        }
        return datos;
    }

    validarCamposCompletos(datos) {
        return Object.values(datos).every(value => value && value.trim() !== "");
    }

    mensaje(texto) {
        if (!this.mensajeContainer) {
            this.mensajeContainer = document.createElement('div');
            this.mensajeContainer.id = 'mensaje-container';
            this.mensajeContainer.style.position = 'fixed';
            this.mensajeContainer.style.bottom = '10px';
            this.mensajeContainer.style.right = '10px';
            this.mensajeContainer.style.padding = '10px';
            this.mensajeContainer.style.backgroundColor = 'rgba(0, 0, 0, 0.8)';
            this.mensajeContainer.style.color = '#fff';
            this.mensajeContainer.style.borderRadius = '5px';
            this.mensajeContainer.style.zIndex = '1000';
            document.body.appendChild(this.mensajeContainer);
        }

        this.mensajeContainer.textContent = texto;

        setTimeout(() => {
            this.mensajeContainer.textContent = '';
        }, 3000);
    }

    rellenarFormulario(datos) {
        for (const [key, value] of Object.entries(datos)) {
            if (this[key]) {
                this[key].value = value;
            }
        }
    }
}
