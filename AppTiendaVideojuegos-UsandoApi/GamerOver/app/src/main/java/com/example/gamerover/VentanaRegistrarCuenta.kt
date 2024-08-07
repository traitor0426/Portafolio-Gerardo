package com.example.gamerover

import android.annotation.SuppressLint
import android.os.Bundle
import android.util.Log
import androidx.activity.ComponentActivity
import androidx.activity.compose.setContent
import androidx.compose.foundation.layout.Arrangement
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.PaddingValues
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.lazy.LazyRow
import androidx.compose.foundation.lazy.items
import androidx.compose.foundation.rememberScrollState
import androidx.compose.foundation.text.KeyboardOptions
import androidx.compose.foundation.verticalScroll
import androidx.compose.material.icons.Icons
import androidx.compose.material.icons.filled.Create
import androidx.compose.material.icons.filled.Email
import androidx.compose.material3.Button
import androidx.compose.material3.ButtonDefaults
import androidx.compose.material3.Card
import androidx.compose.material3.ExperimentalMaterial3Api
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.OutlinedTextField
import androidx.compose.material3.Surface
import androidx.compose.material3.Text
import androidx.compose.material3.TextFieldDefaults
import androidx.compose.runtime.Composable
import androidx.compose.runtime.LaunchedEffect
import androidx.compose.runtime.getValue
import androidx.compose.runtime.mutableStateListOf
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
import androidx.lifecycle.viewModelScope
import com.example.gamerover.servicioWeb.Videojuegos
import com.example.gamerover.servicioWeb.VideojuegosViewModel
import com.example.gamerover.ui.theme.GreyClaro
import com.example.gamerover.ui.theme.ui.theme.GamerOverTheme
import kotlinx.coroutines.launch

class VentanaRegistrarCuenta : ComponentActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContent {
            GamerOverTheme {
                // A surface container using the 'background' color from the theme
                Surface(
                    modifier = Modifier.fillMaxSize(),
                    color = MaterialTheme.colorScheme.background
                ) {

                }
            }
        }
    }
}
@Composable
fun VideojuegosListItem(videojuego: Videojuegos) {
    Card(
        modifier = Modifier
            .padding(8.dp)
            .fillMaxWidth()
    ) {
        Column(
            modifier = Modifier.padding(16.dp)
        ) {
            Text(text = "Nombre: ${videojuego.Nombre}", fontWeight = FontWeight.Bold)
            Text(text = "Descripción: ${videojuego.Descripcion}")
            Text(text = "Cantidad: ${videojuego.Cantidad}")
            Text(text = "Precio: ${videojuego.Precio}")
            Text(text = "Subtotal: ${videojuego.Subtotal}")
            // Agrega más campos según tu modelo de datos Videojuegos
        }
    }
}
@SuppressLint("RememberReturnType", "SuspiciousIndentation")
@Composable
fun RegistrarProducto(videojuegos: List<Videojuegos>) {
    var nombreProducto by remember { mutableStateOf("") }
    var cantidadProducto by remember { mutableStateOf("") }
    var precioProducto by remember { mutableStateOf("") }
    var descripcionProducto by remember { mutableStateOf("") }
    var precioTotal by remember { mutableStateOf(0f) }
    val viewModel = VideojuegosViewModel()
    Column(
        modifier = Modifier
            .fillMaxSize()
            .verticalScroll(rememberScrollState())
            .padding(16.dp),
        horizontalAlignment = Alignment.CenterHorizontally,
        verticalArrangement = Arrangement.Center
    ) {
        val video = remember { mutableStateListOf<Videojuegos>() }


        var Total by remember { mutableStateOf(0f) }
        LaunchedEffect(Unit) {
            viewModel.getVideojuego2 { videoResponse ->
                videoResponse?.let { video.addAll(it) }
            }
        }
        //Titulo iniciar sesion
        Text(
            modifier = Modifier.padding(16.dp),
            text = "Inventario",
            fontSize = 26.sp,
            fontWeight = FontWeight.Bold,
        )
        Text(
            modifier = Modifier.padding(16.dp),
            text = "Todos los productos",
            fontSize = 16.sp,
            fontWeight = FontWeight.Bold,
        )

        LazyRow {
            items(video) { videos ->
                VideojuegosListItem(videojuego = videos)
            }
        }
        Text(
            modifier = Modifier.padding(16.dp),
            text = "Agregar videojuego",
            fontSize = 16.sp,
            fontWeight = FontWeight.Bold,
        )
        // Email TextField
        RoundedTextField1(
            modifier = Modifier
                .fillMaxWidth()
                .padding(8.dp),
            leadingIcon = Icons.Default.Create,
            placeholder = "Nombre",
            textColor = GreyClaro,
            value = nombreProducto,
            onValueChange =  { nombreProducto = it }
        )

        // Email TextField
        RoundedTextField1(
            modifier = Modifier
                .fillMaxWidth()
                .padding(8.dp),
            leadingIcon = Icons.Default.Create,
            placeholder = "Cantidad",
            textColor = GreyClaro,
            value = cantidadProducto,
            onValueChange =  { cantidadProducto = it }
        )

        // Email TextField
        RoundedTextField1(
            modifier = Modifier
                .fillMaxWidth()
                .padding(8.dp),
            leadingIcon = Icons.Default.Create,
            placeholder = "Precio",
            textColor = GreyClaro,
            value = precioProducto,
            onValueChange =  { precioProducto = it }
        )
        // Email TextField
        RoundedTextField1(
            modifier = Modifier
                .fillMaxWidth()
                .padding(8.dp),
            leadingIcon = Icons.Default.Email,
            placeholder = "Descripcion",
            textColor = GreyClaro,
            value = descripcionProducto,
            onValueChange =  { descripcionProducto = it }
        )

        Button(
            onClick = {
                viewModel.viewModelScope.launch {
                val cantidad = cantidadProducto.toInt()
                val precio = precioProducto.toFloat()
                val resultado = viewModel.multiplicar(cantidad, precio)
                precioTotal = resultado
                Log.d("Precio", precioTotal.toString())

                val videoo = Videojuegos(
                    Nombre = nombreProducto,
                    Cantidad = cantidad,
                    Precio = precio,
                    Descripcion = descripcionProducto,
                    Subtotal = precioTotal


                )
                    viewModel.addVideojuego(videoo)
                    // Recargar la lista de videojuegos
                    viewModel.getVideojuego2 { videoResponse ->
                        videoResponse?.let {
                            video.clear() // Limpiamos la lista antes de agregar los nuevos elementos
                            video.addAll(it) // Agregamos los nuevos videojuegos a la lista
                        }
                    }
                }
                      },
            modifier = Modifier.padding(10.dp),
            colors = ButtonDefaults.buttonColors(
                containerColor = Color.Black,
                contentColor = Color.White
            ),
            contentPadding = PaddingValues(16.dp)
        ) {
            Text(text = "Agregar")
        }
    }
}



@OptIn(ExperimentalMaterial3Api::class)
@Composable
fun RoundedTextField1(
    modifier: Modifier = Modifier,
    leadingIcon: ImageVector? = null,
    placeholder: String,
    keyboardType: KeyboardType = KeyboardType.Text,
    textColor: Color = GreyClaro,
    value: String,
    onValueChange: (String) -> Unit
) {
    OutlinedTextField(
        value = value,
        onValueChange = onValueChange,
        modifier = modifier,
        label = { Text(text = placeholder, style = TextStyle(/*color = textColor*/)) },
        keyboardOptions = KeyboardOptions.Default.copy(keyboardType = keyboardType),
        shape = MaterialTheme.shapes.small,
        colors = TextFieldDefaults.outlinedTextFieldColors(
            focusedBorderColor = Color.Red,
            unfocusedBorderColor = Color.Black,
        ),
        textStyle = TextStyle(/*color = textColor*/)
    )
}

@Preview
@Composable
fun PreviewRegistrarProducto() {
    /*val videojuegos = listOf(
        Videojuegos("Videojuego 1", 10, 59.99f, "Descripción del videojuego 1"),
        Videojuegos("Videojuego 2", 5, 49.99f, "Descripción del videojuego 2")
    )
    RegistrarProducto(videojuegos)*/
}