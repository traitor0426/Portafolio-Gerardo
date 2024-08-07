package com.example.gamerover.servicioWeb

import android.util.Log
import androidx.compose.runtime.getValue
import androidx.compose.runtime.mutableStateOf
import androidx.compose.runtime.setValue
import androidx.lifecycle.ViewModel
import androidx.lifecycle.viewModelScope
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.launch
import kotlinx.coroutines.withContext
import java.lang.Exception

class VideojuegosViewModel: ViewModel() {

    var _listaVideojuegos: ArrayList<Videojuegos> by mutableStateOf(arrayListOf())

    fun getVideojuegos() {
        viewModelScope.launch(Dispatchers.IO) {
            val response = RetrofitClient.webService.getVideojuegos()
            withContext(context = Dispatchers.Main) {
                if (response.body()!!.codigo == "200") {
                    _listaVideojuegos = response.body()!!.data
                }
            }
        }
    }
    fun getVideojuego2(callback: (List<Videojuegos>?) -> Unit) {
        viewModelScope.launch(Dispatchers.IO) {
            try {
                val response = RetrofitClient.webService.getVideojuegos2()
                withContext(Dispatchers.Main) {
                    if (response.isSuccessful) {
                        val carrito = response.body() // Aquí obtenemos la lista de libros de la respuesta
                        callback(carrito) // Pasamos la lista de libros al callback
                    } else {
                        // Manejar el caso en que la respuesta no sea exitosa
                        callback(null)
                    }
                }
            } catch (e: Exception) {
                // Manejar cualquier excepción que ocurra durante la llamada a la API
                Log.e("obtener videojuego", "Error al obtener videojuego", e)
                callback(null)
            }
        }
    }
    fun addVideojuego(videojuegos: Videojuegos) {
        viewModelScope.launch(Dispatchers.IO) {
            val response = RetrofitClient.webService.addVideojuego(videojuegos)
            withContext(Dispatchers.Main) {
                if (response.isSuccessful && response.body()!!.codigo == "200") {
                    getVideojuegos()
                }
            }
        }
    }

    suspend fun sumar(num1: Float, num2: Float): Float {
        return try {
            val response = RetrofitClient.webService.sumar(num1, num2)
            if (response.isSuccessful) {
                response.body()?.result ?: 0f
            } else {
                0f
            }
        } catch (e: Exception) {
            Log.e("VideojuegosViewModel", "Error al sumar", e)
            0f
        }
    }

    suspend fun multiplicar(num1: Int, num2: Float): Float {
        return try {
            Log.d("VideojuegosViewModel", "num1: $num1, num2: $num2")

            val response = RetrofitClient.webService.multiplicar(num1, num2)
            Log.d("VideojuegosViewModel", "Response body: ${response.body()}")
            if (response.isSuccessful) {
                val result = response.body()?.result ?: 0f
                Log.d("VideojuegosViewModel", "Resultado de la multiplicación: $result")
                result
            } else {
                Log.d("VideojuegosViewModel", "La respuesta no fue exitosa")
                0f
            }
        } catch (e: Exception) {
            Log.e("VideojuegosViewModel", "Error al multiplicar", e)
            0f
        }
    }

    suspend fun getCantidadTotal(): Float {
        return try {
            val response = RetrofitClient.webService.getCantidadTotal()
            if (response.isSuccessful) {
                response.body()?.result ?: 0f
            } else {
                0f
            }
        } catch (e: Exception) {
            Log.e("PedidosViewModel", "Error al obtener la suma total", e)
            0f
        }
    }
}
