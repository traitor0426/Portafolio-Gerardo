package com.example.empresalimonera

import android.os.Bundle
import android.widget.Toast
import androidx.activity.ComponentActivity
import androidx.activity.compose.setContent
import androidx.compose.foundation.layout.*
import androidx.compose.material3.*
import androidx.compose.runtime.*
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.platform.LocalContext
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.text.input.KeyboardType
import androidx.compose.ui.tooling.preview.Preview
import androidx.compose.ui.unit.dp
import androidx.compose.ui.unit.sp
import androidx.lifecycle.viewmodel.compose.viewModel
import androidx.navigation.NavHostController
import androidx.navigation.compose.rememberNavController
import com.example.empresalimonera.modelo.Tarima
import com.example.empresalimonera.modeloVista.MVTarima
import com.example.empresalimonera.ui.theme.EmpresaLimoneraTheme
import com.example.empresalimonera.ui.theme.verde
import java.util.UUID

class AgregarTarima : ComponentActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContent {
            EmpresaLimoneraTheme {
                Surface(
                    modifier = Modifier.fillMaxSize(),
                    color = MaterialTheme.colorScheme.background
                ) {
                    val navController = rememberNavController()
                    val idViaje = "exampleIdViaje" // Cambiar esto por el idViaje real
                    AgregarTarimaScreen(navController = navController, idViaje = idViaje)
                }
            }
        }
    }
}

@Composable
fun AgregarTarimaScreen(navController: NavHostController, idViaje: String) {
    val mvTarima: MVTarima = viewModel()
    var lugar by remember { mutableStateOf("") }
    var tipoLimon by remember { mutableStateOf("") }
    var totalTarima by remember { mutableStateOf("") }
    var showError by remember { mutableStateOf(false) }
    val context = LocalContext.current

    Column(
        modifier = Modifier
            .fillMaxSize()
            .padding(16.dp),
        horizontalAlignment = Alignment.CenterHorizontally,
        verticalArrangement = Arrangement.Center
    ) {
        Text(
            text = "Agregar Tarima",
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

        RoundedTextField1(
            placeholder = "Tipo Limón",
            value = tipoLimon,
            onValueChange = { tipoLimon = it },
            keyboardType = KeyboardType.Text
        )

        Spacer(modifier = Modifier.height(16.dp))

        RoundedTextField1(
            placeholder = "Total Tarima",
            value = totalTarima,
            onValueChange = { totalTarima = it },
            keyboardType = KeyboardType.Number
        )

        Spacer(modifier = Modifier.height(16.dp))

        if (showError) {
            Text(
                text = "Por favor, complete todos los campos.",
                color = Color.Red,
                modifier = Modifier.padding(bottom = 16.dp)
            )
        }

        Button(
            onClick = {
                if (lugar.isNotEmpty() && tipoLimon.isNotEmpty() && totalTarima.isNotEmpty()) {
                    showError = false
                    val nuevaTarima = Tarima(
                        idTarima = UUID.randomUUID().toString(),
                        idViaje = idViaje,
                        lugar = lugar,
                        totalTarima = totalTarima,
                        tipoLimon = tipoLimon
                    )
                    mvTarima.agregarTarima(nuevaTarima, {
                        mvTarima.actualizarTotalViaje(idViaje)
                        Toast.makeText(context, "Tarima agregada exitosamente", Toast.LENGTH_SHORT).show()
                        navController.navigate("vistaTarimas/$idViaje")
                    }, { exception ->
                        Toast.makeText(context, "Error al agregar tarima: ${exception.message}", Toast.LENGTH_SHORT).show()
                    })
                } else {
                    showError = true
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
            onClick = { navController.navigate("vistaTarimas/$idViaje") },
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

@Preview(showBackground = true)
@Composable
fun GreetingPreview5() {
    EmpresaLimoneraTheme {
        val navController = rememberNavController()
        val idViaje = "exampleIdViaje"
        AgregarTarimaScreen(navController = navController, idViaje = idViaje)
    }
}
