package com.example.gamerover.servicioWeb

data class VideojuegosResponse(
    var codigo: String,
    var mensaje: String,
    var data: ArrayList<Videojuegos>
)
