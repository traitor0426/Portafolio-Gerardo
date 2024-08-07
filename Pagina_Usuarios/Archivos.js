const {writeFile} = require("fs/promises")
const {appendFile} = require("fs/promises")

class archivo {
	constructor(nombre){
		this.nombre = nombre
	}

	/*
		- crear
		- Borrar
		- Leer
	*/

	async sobreescribir(datos, eol = "\n"){
		try{ await writeFile(this.nombre, datos + eol) }
		catch(err){ console.log(`Error al sobreescribir: ${err.message}`) }
	}

	async agregar(datos, eol = "\n"){
		try{ await appendFile(this.nombre, datos + eol) }
		catch(err){ console.log(`Error al agregar: ${err.message}`)}
	}
}

let arch = new archivo("log.txt")
arch.sobreescribir("Línea 1")
arch.agregar("Línea 2")
arch.agregar("Línea 3")