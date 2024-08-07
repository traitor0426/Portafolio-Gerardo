/*Hacer un diagrama de flujo para calcular el máximo de N números leídos por teclado, 
se debe realizar de dos formas, una almacenando previamente los números dados por teclado en un array y 
la otra calculando el máximo directamente según se leen los números del teclado*/

import java.util.Scanner; 
public class ejercicioDeProgramacion6V2{
   public static void main(String[] a){
   
   int numeros, N, maximo; 
   maximo = Integer.MIN_VALUE;
   Scanner sc = new Scanner(System.in);
   
   System.out.println("Cuantos numeros son?"); 
   N = sc.nextInt();
   
   for(int nNum = 0; nNum < N; nNum++){
      System.out.println("Introduce el numero: "); 
      numeros = sc.nextInt();
      if (numeros > maximo){
         maximo = numeros; 
      }  
   }
   
   System.out.println("El maximo es: " + maximo);


 }
}