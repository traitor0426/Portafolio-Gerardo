package com.example.empresalimonera

import android.widget.Toast
import androidx.compose.foundation.layout.*
import androidx.compose.material3.*
import androidx.compose.runtime.*
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.platform.LocalContext
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.text.input.KeyboardType
import androidx.compose.ui.unit.dp
import androidx.compose.ui.unit.sp
import androidx.lifecycle.viewmodel.compose.viewModel
import androidx.navigation.NavHostController
import com.example.empresalimonera.modelo.Viaje
import com.example.empresalimonera.modeloVista.MVViaje
import com.example.empresalimonera.ui.theme.verde
import java.util.Calendar
import java.util.UUID

@OptIn(ExperimentalMaterial3Api::class)
@Composable
fun AgregarViajeVentana(navController: NavHostController, correo: String?) {
    val mvViaje: MVViaje = viewModel()
    var lugar by remember { mutableStateOf("") }
    var fechaSalida by remember { mutableStateOf("") }
    var responsable by remember { mutableStateOf("") }
    var showError by remember { mutableStateOf(false) }
    var errorMessage by remember { mutableStateOf("") }
    val context = LocalContext.current

    val calendar = Calendar.getInstance()
    val year = calendar.get(Calendar.YEAR)
    val month = calendar.get(Calendar.MONTH)
    val day = calendar.get(Calendar.DAY_OF_MONTH)

    val datePickerDialog = android.app.DatePickerDialog(
        context,
        { _, selectedYear, selectedMonth, selectedDay ->
            fechaSalida = "$selectedDay/${selectedMonth + 1}/$selectedYear"
        }, year, month, day
    )

    Column(
        modifier = Modifier
            .fillMaxSize()
            .padding(16.dp),
        horizontalAlignment = Alignment.CenterHorizontally,
        verticalArrangement = Arrangement.Center
    ) {
        Text(
            text = "Agregar Viaje",
            fontSize = 24.sp,
            fontWeight = FontWeight.Bold,
            color = verde
        )

        Spacer(modifier = Modifier.height(16.dp))

        RoundedTextField1(
            placeholder = "Lugar",
            value = lugar,
            onValueChange = { lugar = it },
            keyboardType = KeyboardType.Text
        )

        Spacer(modifier = Modifier.height(16.dp))

        Button(
            onClick = { datePickerDialog.show() },
            modifier = Modifier.fillMaxWidth().padding(10.dp),
            colors = ButtonDefaults.buttonColors(
                containerColor = verde,
                contentColor = Color.White
            )
        ) {
            Text(text = "Seleccionar Fecha de Salida")
        }

        Spacer(modifier = Modifier.height(8.dp))

        Text(text = "Fecha seleccionada: $fechaSalida")

        Spacer(modifier = Modifier.height(16.dp))

        RoundedTextField1(
            placeholder = "Responsable",
            value = responsable,
            onValueChange = { responsable = it },
            keyboardType = KeyboardType.Text
        )

        Spacer(modifier = Modifier.height(16.dp))

        if (showError) {
            Text(
                modifier = Modifier.padding(top = 8.dp),
                text = errorMessage,
                color = Color.Red
            )
        }

        Button(
            onClick = {
                if (lugar.isNotEmpty() && fechaSalida.isNotEmpty() && responsable.isNotEmpty()) {
                    val nuevoViaje = Viaje(
                        idViaje = UUID.randomUUID().toString(),
                        lugar = lugar,
                        fechaSalida = fechaSalida,
                        totalViaje = "",
                        responsable = responsable,
                        estadoViaje = "Pendiente"
                    )
                    mvViaje.agregarViaje(nuevoViaje, {
                        Toast.makeText(context, "Viaje agregado exitosamente", Toast.LENGTH_SHORT).show()
                        navController.navigate("vistaInicio/${correo}")
                    }, { exception ->
                        showError = true
                        errorMessage = "Error al agregar viaje: ${exception.message}"
                    })
                } else {
                    showError = true
                    errorMessage = "Por favor, complete todos los campos."
                }
            },
            modifier = Modifier.fillMaxWidth().padding(10.dp),
            colors = ButtonDefaults.buttonColors(
                containerColor = verde,
                contentColor = Color.White
            )
        ) {
            Text(text = "Agregar")
        }

        Spacer(modifier = Modifier.height(8.dp))

        Button(
            onClick = { navController.navigate("vistaInicio/$correo") },
            modifier = Modifier.fillMaxWidth().padding(10.dp),
            colors = ButtonDefaults.buttonColors(
                containerColor = Color.Gray,
                contentColor = Color.White
            )
        ) {
            Text(text = "Cancelar")
        }
    }
}