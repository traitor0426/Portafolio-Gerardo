package com.example.empresalimonera.modeloVista

import androidx.lifecycle.ViewModel
import androidx.lifecycle.viewModelScope
import com.example.empresalimonera.modelo.ModeloViaje
import com.example.empresalimonera.modelo.Viaje
import kotlinx.coroutines.flow.MutableStateFlow
import kotlinx.coroutines.flow.StateFlow
import kotlinx.coroutines.launch

class MVViaje : ViewModel() {
    private val modeloViaje = ModeloViaje()
    private val _viajes = MutableStateFlow<List<Viaje>>(emptyList())
    val viajes: StateFlow<List<Viaje>> get() = _viajes

    fun agregarViaje(viaje: Viaje, onSuccess: () -> Unit, onFailure: (Exception) -> Unit) {
        viewModelScope.launch {
            modeloViaje.agregarViaje(viaje, {
                onSuccess()
                cargarViajes()
            }, { exception ->
                onFailure(exception)
            })
        }
    }

    fun cargarViajes() {
        viewModelScope.launch {
            modeloViaje.obtenerViajes { viajes ->
                _viajes.value = viajes
            }
        }
    }
}
