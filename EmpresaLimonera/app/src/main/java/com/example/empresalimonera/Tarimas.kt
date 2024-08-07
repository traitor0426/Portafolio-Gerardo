package com.example.empresalimonera

import android.os.Bundle
import android.widget.Toast
import androidx.activity.ComponentActivity
import androidx.activity.compose.setContent
import androidx.compose.foundation.layout.*
import androidx.compose.foundation.lazy.LazyColumn
import androidx.compose.foundation.lazy.items
import androidx.compose.material3.*
import androidx.compose.runtime.*
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.platform.LocalContext
import androidx.compose.ui.text.font.FontWeight
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

class Tarimas : ComponentActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContent {
            EmpresaLimoneraTheme {
                Surface(
                    modifier = Modifier.fillMaxSize(),
                    color = MaterialTheme.colorScheme.background
                ) {
                    val navController = rememberNavController()
                    TarimasVentana(navController = navController, viajeId = "exampleViajeId")
                }
            }
        }
    }
}

@Composable
fun TarimasVentana(navController: NavHostController, viajeId: String) {
    val mvTarima: MVTarima = viewModel()
    val tarimas by mvTarima.tarimas.collectAsState()
    val context = LocalContext.current

    // Calcular el precio total de las tarimas
    val totalPrecio = tarimas.sumOf { it.totalTarima.toIntOrNull() ?: 0 }

    LaunchedEffect(viajeId) {
        mvTarima.cargarTarimas(viajeId)
    }

    Scaffold(
        bottomBar = {
            BottomAppBar(
                contentPadding = PaddingValues(16.dp)
            ) {
                Text(text = "Total del viaje: $totalPrecio", modifier = Modifier.weight(1f))
                Button(
                    onClick = { navController.navigate("vistaAgregarTarima/$viajeId") },
                    colors = ButtonDefaults.buttonColors(
                        containerColor = verde,
                        contentColor = Color.White
                    )
                ) {
                    Text("Agregar Tarima")
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
                    text = "Tarimas del Viaje",
                    fontSize = 16.sp,
                    fontWeight = FontWeight.Bold,
                )
            }
            items(tarimas) { tarima ->
                TarimaCard(tarima, onDeleteClick = {
                    mvTarima.eliminarTarima(tarima.idTarima, viajeId, {
                        Toast.makeText(context, "Tarima eliminada exitosamente", Toast.LENGTH_SHORT).show()
                    }, { exception ->
                        Toast.makeText(context, "Error al eliminar tarima: ${exception.message}", Toast.LENGTH_SHORT).show()
                    })
                })
                Spacer(modifier = Modifier.height(8.dp))
            }
        }
    }
}

@Composable
fun TarimaCard(tarima: Tarima, onDeleteClick: () -> Unit) {
    Card(
        modifier = Modifier
            .fillMaxWidth(),
        colors = CardDefaults.cardColors(containerColor = MaterialTheme.colorScheme.surface),
        elevation = CardDefaults.cardElevation(4.dp)
    ) {
        Column(
            modifier = Modifier.padding(16.dp),
            verticalArrangement = Arrangement.Center,
            horizontalAlignment = Alignment.Start
        ) {
            Text(text = "ID Tarima: ${tarima.idTarima}", fontWeight = FontWeight.Bold)
            Text(text = "Lugar: ${tarima.lugar}")
            Text(text = "Precio Tarima: ${tarima.totalTarima}")
            Text(text = "Tipo Limón: ${tarima.tipoLimon}")
            Spacer(modifier = Modifier.height(8.dp))
            Button(
                onClick = { onDeleteClick() },
                colors = ButtonDefaults.buttonColors(
                    containerColor = Color.Red,
                    contentColor = Color.White
                )
            ) {
                Text("Eliminar")
            }
        }
    }
}

@Preview(showBackground = true)
@Composable
fun TarimasPreview() {
    EmpresaLimoneraTheme {
        val navController = rememberNavController()
        TarimasVentana(navController = navController, viajeId = "exampleViajeId")
    }
}
