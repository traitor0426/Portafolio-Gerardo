package com.example.gamerover

import android.os.Bundle
import androidx.activity.ComponentActivity
import androidx.activity.compose.setContent
import androidx.compose.foundation.layout.Arrangement
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.PaddingValues
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.text.KeyboardOptions
import androidx.compose.material3.Button
import androidx.compose.material3.ButtonDefaults
import androidx.compose.material3.ExperimentalMaterial3Api
import androidx.compose.material3.Icon
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.OutlinedTextField
import androidx.compose.material3.Surface
import androidx.compose.material3.Text
import androidx.compose.material3.TextFieldDefaults
import androidx.compose.runtime.Composable
import androidx.compose.runtime.getValue
import androidx.compose.runtime.mutableStateOf
import androidx.compose.runtime.remember
import androidx.compose.runtime.setValue
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.graphics.vector.ImageVector
import androidx.compose.ui.text.TextStyle
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.text.input.KeyboardType
import androidx.compose.ui.tooling.preview.Preview
import androidx.compose.ui.unit.dp
import androidx.compose.ui.unit.sp
import androidx.navigation.NavHostController
import androidx.navigation.compose.NavHost
import androidx.navigation.compose.composable
import androidx.navigation.compose.rememberNavController
import com.example.gamerover.ui.theme.GreyClaro
import com.example.gamerover.ui.theme.GamerOverTheme
import com.example.gamerover.servicioWeb.Videojuegos
class MainActivity : ComponentActivity() {


    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContent {
            GamerOverTheme {
                // A surface container using the 'background' color from the theme
                Surface(
                    modifier = Modifier.fillMaxSize(),
                    color = MaterialTheme.colorScheme.background
                ) {
                    val navController = rememberNavController()
                    NavHost(navController = navController, startDestination = "loginScreen") {
                        composable("loginScreen") {
                            VistaBienvenida(navController = navController)
                        }

                        composable("videojue") {
                            //Videojue(navController = navController)
                            val listaLibros = remember { arrayListOf<Videojuegos>() }
                            RegistrarProducto(listaLibros)
                        }

                        composable("registrarproducto") {
                            val listaLibros = remember { arrayListOf<Videojuegos>() }
                            RegistrarProducto(listaLibros)
                        }

                        composable("fichacompra") {
                            FichaCompra()
                        }

                    }
                }
            }
        }
    }


    @Composable
    fun VistaBienvenida(navController: NavHostController) {
        Column(
            modifier = Modifier
                .fillMaxSize()
                .padding(30.dp),
            horizontalAlignment = Alignment.CenterHorizontally,
            verticalArrangement = Arrangement.Center
        ) {

            //Titulo iniciar sesion

            Text(
                modifier = Modifier
                    .padding(top = 0.dp),
                text = "Bienvenido a GAME OVER",
                fontSize = 20.sp,
                fontWeight = FontWeight.Bold,
            )

            Button(
                onClick = {navController.navigate("videojue")},
                modifier = Modifier
                    .padding(10.dp),
                colors = ButtonDefaults.buttonColors(
                    containerColor = Color.Black,
                    contentColor = Color.White
                ),
                contentPadding = PaddingValues(16.dp)
            ) {
                Text(text = "Ingresar")

            }

        }
    }



    @Preview(showBackground = true)
    @Composable
    fun GreetingPreview() {
        GamerOverTheme {
            val navController = rememberNavController()
           VistaBienvenida(navController = navController)
        }
    }
}