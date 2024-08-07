//Elabora un programa que convierta un X número de galones en litros, ten en cuenta que hay 3.7854 litros en un galón

import java.util.Scanner; 
public class ejercicioDeProgramacion2{
   public static void main(String[] a){
   
   float galones;
   double litros; 
   Scanner sc = new Scanner(System.in); 
   
   System.out.println("Introduzca el numero de galones a convertir"); 
   galones = sc.nextFloat();
   
   litros = galones * 3.7854; 
   
   System.out.println("El numero de litros es: " + litros); 


}

}