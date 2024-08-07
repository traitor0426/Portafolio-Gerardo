package com.example.gamerover.servicioWeb

import retrofit2.Response
import retrofit2.http.Body
import retrofit2.http.GET
import retrofit2.http.POST
import retrofit2.http.Path

interface WebService {


    @GET("/videojuegos")
    suspend fun getVideojuegos(): Response<VideojuegosResponse>

    @GET("/videojuegos")
    suspend fun getVideojuegos2(): Response<List<Videojuegos>>

    @POST("/videojuegos")
    suspend fun addVideojuego(
        @Body libro: Videojuegos
    ): Response<VideojuegosResponse>

    @GET("/suma/{num1}/{num2}")
    suspend fun sumar(
        @Path("num1") num1: Number,
        @Path("num2") num2: Number
    ): Response<ResultadoResponse>

    @GET("/mult/{num1}/{num2}")
    suspend fun multiplicar(
        @Path("num1") num1: Int,
        @Path("num2") num2: Float
    ): Response<ResultadoResponse>

    @GET("/inventarioTotal")
    suspend fun getCantidadTotal(): Response<ResultadoResponse>

    @POST("/Videojuegos")
    suspend fun addVideojuegos(
        @Body usuario: Unit
    ): Response<VideojuegosResponse>

}