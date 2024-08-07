package com.example.empresalimonera.modeloVista

import android.widget.Toast
import androidx.navigation.NavController
import com.example.empresalimonera.modelo.Usuario
import com.example.empresalimonera.modelo.Usuarios
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.launch
import kotlin.coroutines.resume
import kotlin.coroutines.suspendCoroutine

class MVLogin (private val mUsuario: Usuarios) {
    suspend fun registrarUsuario(
        navController: NavController,
        correo: String,
        contra: String
    ): Boolean {
        return mUsuario.registrarUsuario(navController,correo, contra)
    }

    fun registrar(
        navController: NavController,
        nombre: String,
        apepat: String,
        apemat: String,
        correo: String

    ) {
        val nuevoUsuario = Usuario(nombre, apepat, apemat, correo)

        mUsuario.agregarUsuario(navController.context, nuevoUsuario)

    }

    suspend fun obtenerUsuario(correo: String?): Usuario? {
        return suspendCoroutine { continuation ->
            mUsuario.obtenerUsuario(correo) { usuario ->
                continuation.resume(usuario)
            }
        }
    }

    fun actualizarUsuario(navController: NavController, correo: String?, nombre: String, apellidopat: String, apellidomat: String) {

        mUsuario.actualizarNombreUsuario(correo, nombre, apellidopat, apellidomat) { success ->
            if (success) {
                // Mostrar un Toast indicando que el usuario se actualizó correctamente
                CoroutineScope(Dispatchers.Main).launch {
                    Toast.makeText(navController.context, "Usuario actualizado correctamente", Toast.LENGTH_SHORT).show()
                }

            } else {
                // Si la actualización falló, continuamos con null

            }
        }

    }







}