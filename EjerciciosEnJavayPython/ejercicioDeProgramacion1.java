/*Hacer un programa que lea del teclado N números, realice la suma de los números impares, 
la suma de los números pares y la suma de los números múltiplos de 3 y muestre los resultados.*/

import java.util.Scanner; 
public class ejercicioDeProgramacion1{
   public static void main(String[] a){

   int numDatos, numero, sumaImpares, sumaPares, sumaMul3; 
      
   Scanner sc = new Scanner(System.in);
   
      
   System.out.println("Cuantos numeros son: ");
   numDatos = sc.nextInt(); 
      
      
   sumaImpares = 0; 
   sumaPares = 0; 
   sumaMul3 = 0; 
      for(int nDato = 0; nDato < numDatos; nDato++) {
         System.out.println("Introduzca el numero: "); 
         numero = sc.nextInt(); 
      
         if (numero % 2 == 0){
            sumaPares = sumaPares + numero; 
         }
      
         else {
            if (numero % 2 == 1) {
               sumaImpares = sumaImpares + numero; 
            }
         }
         
         if (numero % 3 == 0){
            sumaMul3 = sumaMul3 + numero; 
         }
      
      
      
      
 
      }
   
      System.out.println("La suma de los numeros impares es:" + sumaImpares); 
      System.out.println("La suma de los numeros pares es:" + sumaPares); 
      System.out.println("La suma de los numeros multiplos de 3 es:" + sumaMul3); 

 }
}
