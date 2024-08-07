package com.example.gamerover

import android.os.Bundle
import androidx.activity.ComponentActivity
import androidx.activity.compose.setContent
import androidx.compose.foundation.clickable
import androidx.compose.foundation.layout.Arrangement
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.PaddingValues
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.layout.padding
import androidx.compose.material3.Button
import androidx.compose.material3.ButtonDefaults
import androidx.compose.material3.CardDefaults
import androidx.compose.material3.ElevatedCard
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.Surface
import androidx.compose.material3.Text
import androidx.compose.runtime.Composable
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.tooling.preview.Preview
import androidx.compose.ui.unit.dp
import androidx.compose.ui.unit.sp
import com.example.gamerover.ui.theme.GamerOverTheme

class InfoCompra : ComponentActivity() {
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
fun InformacionCompra() {

    ElevatedCard(
        elevation = CardDefaults.cardElevation(
            defaultElevation = 6.dp
        ),
        colors = CardDefaults.cardColors(
            containerColor = Color.White,
        ),
        modifier = Modifier
            //.size(width = 240.dp, height = 100.dp)
            .clickable { }
    ) {
        Column(
            modifier = Modifier

                .padding(16.dp),
            horizontalAlignment = Alignment.Start,
            verticalArrangement = Arrangement.Top
        ) {

            Text(
                modifier = Modifier
                    .padding(0.dp),
                text = "Nombre:",
                fontSize = 16.sp,
                fontWeight = FontWeight.Bold,
            )

            Text(
                modifier = Modifier
                    .padding(0.dp),
                text = "Cantidad:",
                fontSize = 16.sp,

                fontWeight = FontWeight.Bold,
            )

            Text(
                modifier = Modifier
                    .padding(0.dp),
                text = "Precio:",
                fontSize = 16.sp,

                fontWeight = FontWeight.Bold,
            )

        }
    }
}

@Preview(showBackground = true)
@Composable
fun GreetingPreview() {
    GamerOverTheme {
        InformacionCompra()
    }
}