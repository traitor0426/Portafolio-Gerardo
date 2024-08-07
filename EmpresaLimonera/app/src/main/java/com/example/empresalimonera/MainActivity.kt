package com.example.empresalimonera

import android.os.Bundle
import androidx.activity.ComponentActivity
import androidx.activity.compose.setContent
import androidx.compose.foundation.layout.*
import androidx.compose.foundation.text.KeyboardOptions
import androidx.compose.material3.*
import androidx.compose.runtime.*
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.text.TextStyle
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.text.input.KeyboardType
import androidx.compose.ui.text.input.PasswordVisualTransformation
import androidx.compose.ui.tooling.preview.Preview
import androidx.compose.ui.unit.dp
import androidx.compose.ui.unit.sp
import androidx.navigation.NavHostController
import androidx.navigation.compose.NavHost
import androidx.navigation.compose.composable
import androidx.navigation.compose.rememberNavController
import com.example.empresalimonera.modelo.Usuarios
import com.example.empresalimonera.modeloVista.MVLogin
import com.example.empresalimonera.modeloVista.MVViaje
import com.example.empresalimonera.ui.theme.EmpresaLimoneraTheme
import com.example.empresalimonera.ui.theme.verde
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.GlobalScope
import kotlinx.coroutines.launch

class MainActivity : ComponentActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContent {
            EmpresaLimoneraTheme {
                Surface(
                    modifier = Modifier.fillMaxSize(),
                    color = MaterialTheme.colorScheme.background
                ) {
                    val navController = rememberNavController()

                    NavHost(navController = navController, startDestination = "vistaLogin") {
                        composable("vistaLogin") { backStackEntry ->
                            val correo = backStackEntry.arguments?.getString("correo")
                            VentanaLogin(navController = navController, correo = correo)
                        }
                        composable("vistaCrearCuenta") {
                            CrearCuenta(navController = navController)
                        }
                        composable("vistaInicio/{correo}") { backStackEntry ->
                            val correo = backStackEntry.arguments?.getString("correo")
                            val nombre = backStackEntry.arguments?.getString("nombre")
                            Inicio(navController = navController, correo = correo)
                        }

                        composable("vistaAgregarViaje/{correo}") { backStackEntry ->
                            val correo = backStackEntry.arguments?.getString("correo")
                            val nombre = backStackEntry.arguments?.getString("nombre")
                            AgregarViajeVentana(navController = navController, correo = correo)
                        }

                        composable("vistaTarimas/{idViaje}") { backStackEntry ->
                            val idViaje = backStackEntry.arguments?.getString("idViaje")
                            TarimasVentana(navController = navController, viajeId = idViaje ?: "")
                        }

                        composable("vistaAgregarTarima/{idViaje}") { backStackEntry ->
                            val idViaje = backStackEntry.arguments?.getString("idViaje")
                            AgregarTarimaScreen(navController = navController, idViaje = idViaje ?: "")
                        }
                    }
                }
            }
        }
    }
}

@Composable
fun VentanaLogin(navController: NavHostController, correo: String?) {
    var correo by remember { mutableStateOf(correo ?: "") }
    var contrasena by remember { mutableStateOf("") }
    var showError by remember { mutableStateOf(false) }
    var errorMessage by remember { mutableStateOf("") }

    val mUsuario = Usuarios()
    val vmUsuario = MVLogin(mUsuario)

    Column(
        modifier = Modifier
            .fillMaxSize()
            .padding(16.dp),
        horizontalAlignment = Alignment.CenterHorizontally,
        verticalArrangement = Arrangement.Center
    ) {
        Text(
            modifier = Modifier.padding(10.dp),
            text = "Empresa limonera",
            fontSize = 30.sp,
            fontWeight = FontWeight.Bold,
            color = verde
        )

        Text(
            modifier = Modifier.padding(10.dp),
            text = "Iniciar sesión",
            fontSize = 16.sp
        )

        RoundedTextField1(
            modifier = Modifier
                .fillMaxWidth()
                .padding(8.dp),
            keyboardType = KeyboardType.Email,
            placeholder = "Correo electrónico",
            value = correo,
            onValueChange = { correo = it },
            textColor = Color.Gray
        )

        RoundedTextField5(
            modifier = Modifier
                .fillMaxWidth()
                .padding(8.dp),
            placeholder = "Contraseña",
            keyboardType = KeyboardType.Password,
            value = contrasena,
            onValueChange = { contrasena = it }
        )

        if (showError) {
            Text(
                modifier = Modifier.padding(top = 8.dp),
                text = errorMessage,
                color = Color.Red
            )
        }

        Button(
            onClick = {
                if (correo.isNotEmpty() && contrasena.isNotEmpty()) {
                    GlobalScope.launch(Dispatchers.Main) {
                        val autenticacionExitosa = mUsuario.autenticarUsuario(navController, correo, contrasena)
                        if (autenticacionExitosa) {
                            val isVerified = mUsuario.isEmailVerified()
                            if (isVerified) {
                                val usuario = vmUsuario.obtenerUsuario(correo)
                                if (usuario != null) {
                                    navController.navigate("vistaInicio/$correo")
                                }
                            } else {
                                showError = true
                                errorMessage = "Por favor, verifica tu correo electrónico antes de iniciar sesión."
                            }
                        } else {
                            showError = true
                            errorMessage = "Credenciales incorrectas. Inténtalo de nuevo."
                        }
                    }
                } else {
                    showError = true
                    errorMessage = "Por favor, complete todos los campos."
                }
            },
            modifier = Modifier
                .fillMaxWidth()
                .padding(10.dp),
            colors = ButtonDefaults.buttonColors(
                containerColor = verde,
                contentColor = Color.White
            )
        ) {
            Text(text = "Ingresar")
        }

        Button(
            onClick = {
                navController.navigate("vistaCrearCuenta")
            },
            modifier = Modifier
                .fillMaxWidth()
                .padding(10.dp),
            colors = ButtonDefaults.buttonColors(
                containerColor = Color.Gray,
                contentColor = Color.White
            )
        ) {
            Text(text = "Nueva cuenta")
        }
    }
}

@OptIn(ExperimentalMaterial3Api::class)
@Composable
fun RoundedTextField1(
    modifier: Modifier = Modifier,
    placeholder: String,
    keyboardType: KeyboardType = KeyboardType.Text,
    textColor: Color = Color.Gray,
    value: String,
    onValueChange: (String) -> Unit
) {
    OutlinedTextField(
        value = value,
        onValueChange = onValueChange,
        modifier = modifier,
        label = { Text(text = placeholder, style = TextStyle(color = textColor)) },
        keyboardOptions = KeyboardOptions.Default.copy(keyboardType = keyboardType),
        shape = MaterialTheme.shapes.small,
        colors = TextFieldDefaults.outlinedTextFieldColors(
            focusedBorderColor = Color(0xff0afb3a),
            unfocusedBorderColor = Color(0xff00913f),
            cursorColor = textColor
        ),
        textStyle = TextStyle(color = textColor)
    )
}

@OptIn(ExperimentalMaterial3Api::class)
@Composable
fun RoundedTextField5(
    modifier: Modifier = Modifier,
    placeholder: String,
    keyboardType: KeyboardType = KeyboardType.Password,
    textColor: Color = Color.Gray,
    value: String,
    onValueChange: (String) -> Unit
) {
    OutlinedTextField(
        value = value,
        onValueChange = onValueChange,
        modifier = modifier,
        label = { Text(text = placeholder, style = TextStyle(color = textColor)) },
        keyboardOptions = KeyboardOptions.Default.copy(keyboardType = keyboardType),
        visualTransformation = PasswordVisualTransformation(),
        shape = MaterialTheme.shapes.small,
        colors = TextFieldDefaults.outlinedTextFieldColors(
            focusedBorderColor = Color(0xff0afb3a),
            unfocusedBorderColor = Color(0xff00913f),
            cursorColor = textColor
        ),
        textStyle = TextStyle(color = textColor)
    )
}

@Preview(showBackground = true)
@Composable
fun GreetingPreview() {
    EmpresaLimoneraTheme {
        val navController = rememberNavController()
        val correo = ""
        VentanaLogin(navController = navController, correo = correo)
    }
}
