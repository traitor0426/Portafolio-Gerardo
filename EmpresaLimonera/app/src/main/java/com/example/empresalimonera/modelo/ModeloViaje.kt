package com.example.empresalimonera.modelo

import com.google.firebase.firestore.FirebaseFirestore

class ModeloViaje {
    private val db = FirebaseFirestore.getInstance()

    fun agregarViaje(viaje: Viaje, onSuccess: () -> Unit, onFailure: (Exception) -> Unit) {
        db.collection("viajes")
            .add(viaje)
            .addOnSuccessListener {
                onSuccess()
            }
            .addOnFailureListener { exception ->
                onFailure(exception)
            }
    }

    fun obtenerViajes(onComplete: (List<Viaje>) -> Unit) {
        db.collection("viajes")
            .get()
            .addOnSuccessListener { result ->
                val viajes = result.mapNotNull { it.toObject(Viaje::class.java) }
                onComplete(viajes)
            }
            .addOnFailureListener {
                onComplete(emptyList())
            }
    }
}