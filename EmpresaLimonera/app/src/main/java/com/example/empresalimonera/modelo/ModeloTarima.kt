package com.example.empresalimonera.modelo

import com.google.firebase.firestore.FirebaseFirestore

class ModeloTarima {
    private val db = FirebaseFirestore.getInstance()

    fun agregarTarima(tarima: Tarima, onSuccess: () -> Unit, onFailure: (Exception) -> Unit) {
        db.collection("tarimas")
            .add(tarima)
            .addOnSuccessListener {
                onSuccess()
            }
            .addOnFailureListener { e ->
                onFailure(e)
            }
    }

    fun cargarTarimas(idViaje: String, onSuccess: (List<Tarima>) -> Unit, onFailure: (Exception) -> Unit) {
        db.collection("tarimas")
            .whereEqualTo("idViaje", idViaje)
            .get()
            .addOnSuccessListener { result ->
                val tarimasList = result.map { document ->
                    document.toObject(Tarima::class.java).apply {
                        idTarima = document.id
                    }
                }
                onSuccess(tarimasList)
            }
            .addOnFailureListener { e ->
                onFailure(e)
            }
    }

    fun actualizarTotalViaje(idViaje: String, total: Int, onSuccess: () -> Unit, onFailure: (Exception) -> Unit) {
        db.collection("viajes")
            .document(idViaje)
            .update("totalViaje", total.toString())
            .addOnSuccessListener {
                onSuccess()
            }
            .addOnFailureListener { e ->
                onFailure(e)
            }
    }

    fun calcularTotalViaje(idViaje: String, onSuccess: (Int) -> Unit, onFailure: (Exception) -> Unit) {
        db.collection("tarimas")
            .whereEqualTo("idViaje", idViaje)
            .get()
            .addOnSuccessListener { result ->
                val total = result.sumOf { it.getString("totalTarima")?.toIntOrNull() ?: 0 }
                onSuccess(total)
            }
            .addOnFailureListener { e ->
                onFailure(e)
            }
    }

    fun eliminarTarima(idTarima: String, onSuccess: () -> Unit, onFailure: (Exception) -> Unit) {
        db.collection("tarimas").document(idTarima)
            .delete()
            .addOnSuccessListener {
                onSuccess()
            }
            .addOnFailureListener { e ->
                onFailure(e)
            }
    }
}
