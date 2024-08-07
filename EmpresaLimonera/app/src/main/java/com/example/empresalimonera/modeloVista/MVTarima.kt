package com.example.empresalimonera.modeloVista

import androidx.lifecycle.ViewModel
import androidx.lifecycle.viewModelScope
import com.example.empresalimonera.modelo.ModeloTarima
import com.example.empresalimonera.modelo.Tarima
import kotlinx.coroutines.flow.MutableStateFlow
import kotlinx.coroutines.flow.StateFlow
import kotlinx.coroutines.launch

class MVTarima : ViewModel() {
    private val modeloTarima = ModeloTarima()
    private val _tarimas = MutableStateFlow<List<Tarima>>(emptyList())
    val tarimas: StateFlow<List<Tarima>> get() = _tarimas

    fun agregarTarima(tarima: Tarima, onSuccess: () -> Unit, onFailure: (Exception) -> Unit) {
        viewModelScope.launch {
            modeloTarima.agregarTarima(tarima, {
                cargarTarimas(tarima.idViaje)
                actualizarTotalViaje(tarima.idViaje)
                onSuccess()
            }, onFailure)
        }
    }

    fun cargarTarimas(idViaje: String) {
        viewModelScope.launch {
            modeloTarima.cargarTarimas(idViaje, { tarimasList ->
                _tarimas.value = tarimasList
            }, { _tarimas.value = emptyList() })
        }
    }

    fun actualizarTotalViaje(idViaje: String) {
        viewModelScope.launch {
            modeloTarima.calcularTotalViaje(idViaje, { total ->
                modeloTarima.actualizarTotalViaje(idViaje, total, {
                    // Total actualizado exitosamente
                }, { e ->
                    // Error al actualizar el total
                })
            }, { e ->
                // Error al calcular el total
            })
        }
    }

    fun eliminarTarima(idTarima: String, idViaje: String, onSuccess: () -> Unit, onFailure: (Exception) -> Unit) {
        viewModelScope.launch {
            modeloTarima.eliminarTarima(idTarima, {
                cargarTarimas(idViaje)
                actualizarTotalViaje(idViaje)
                onSuccess()
            }, onFailure)
        }
    }
}
