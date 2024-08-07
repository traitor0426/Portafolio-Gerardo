package com.example.empresalimonera

import android.os.Bundle
import androidx.activity.ComponentActivity
import androidx.activity.compose.setContent
import androidx.compose.foundation.clickable
import androidx.compose.foundation.layout.*
import androidx.compose.foundation.lazy.LazyColumn
import androidx.compose.foundation.lazy.items
import androidx.compose.material3.*
import androidx.compose.runtime.Composable
import androidx.compose.runtime.LaunchedEffect
import androidx.compose.runtime.collectAsState
import androidx.compose.runtime.getValue
import androidx.compose.runtime.rememberCoroutineScope
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.tooling.preview.Preview
import androidx.compose.ui.unit.dp
import androidx.compose.ui.unit.sp
import androidx.lifecycle.viewmodel.compose.viewModel
import androidx.navigation.NavHostController
import androidx.navigation.compose.rememberNavController
import com.example.empresalimonera.modelo.Viaje
import com.example.empresalimonera.modeloVista.MVViaje
import com.example.empresalimonera.ui.theme.EmpresaLimoneraTheme
import com.example.empresalimonera.ui.theme.verde

class Inicio : ComponentActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContent {
            EmpresaLimoneraTheme {
                Surface(
                    modifier = Modifier.fillMaxSize(),
                    color = MaterialTheme.colorScheme.background
                ) {
                    val navController = rememberNavController()
                    Inicio(navController = navController, correo = "example@example.com")
                }
            }
        }
    }
}

@Composable
fun Inicio(navController: NavHostController, correo: String?) {
    val mvViaje: MVViaje = viewModel()
    val viajes by mvViaje.viajes.collectAsState()
    val scope = rememberCoroutineScope()

    LaunchedEffect(Unit) {
        mvViaje.cargarViajes()
    }

    Scaffold(
        bottomBar = {
            BottomAppBar(
                contentPadding = PaddingValues(16.dp)
            ) {
                Spacer(modifier = Modifier.weight(1f, true))
                Button(
                    onClick = { navController.navigate("vistaAgregarViaje/$correo") },
                    colors = ButtonDefaults.buttonColors(
                        containerColor = verde,
                        contentColor = Color.White
                    )
                ) {
                    Text("Agregar viaje")
                }
            }
        }
    ) { innerPadding ->
        LazyColumn(
            modifier = Modifier
                .fillMaxSize()
                .padding(innerPadding)
                .padding(16.dp),
            horizontalAlignment = Alignment.CenterHorizontally,
            verticalArrangement = Arrangement.Top
        ) {
            item {
                Text(
                    modifier = Modifier.padding(10.dp),
                    text = "Viajes",
                    fontSize = 16.sp,
                    fontWeight = FontWeight.Bold,
                )
            }
            items(viajes) { viaje ->
                ViajeCard(viaje, onClick = { navController.navigate("vistaTarimas/${viaje.idViaje}") })
                Spacer(modifier = Modifier.height(8.dp))
            }
        }
    }
}

@Composable
fun ViajeCard(viaje: Viaje, onClick: () -> Unit) {
    Card(
        modifier = Modifier
            .fillMaxWidth()
            .clickable { onClick() },
        colors = CardDefaults.cardColors(containerColor = MaterialTheme.colorScheme.surface),
        elevation = CardDefaults.cardElevation(4.dp)
    ) {
        Column(
            modifier = Modifier.padding(16.dp),
            verticalArrangement = Arrangement.Center,
            horizontalAlignment = Alignment.Start
        ) {
            Text(text = "ID Viaje: ${viaje.idViaje}", fontWeight = FontWeight.Bold)
            Text(text = "Lugar: ${viaje.lugar}")
            Text(text = "Fecha de Salida: ${viaje.fechaSalida}")
            Text(text = "Total del Viaje: ${viaje.totalViaje}")
        }
    }
}

@Preview(showBackground = true)
@Composable
fun GreetingPreview3() {
    EmpresaLimoneraTheme {
        val navController = rememberNavController()
        Inicio(navController = navController, correo = "example@example.com")
    }
}