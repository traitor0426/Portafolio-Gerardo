/*Elabora un programa que solicite la medida en Pies y realice la conversión a pulgadas, yardas, cm y metros. 
Toma en cuenta que un pie tiene 12 pulgadas y una pulgada equivale a 2.54 cm. */

import java.util.Scanner; 
public class ejercicioDeProgramacion4{
   public static void main(String[] a){
   
   float pies; 
   double pulgadas, yardas, cm, metros; 
   Scanner sc = new Scanner(System.in); 
   
   System.out.println("Introduce la medida en pies"); 
   pies = sc.nextFloat();
   
   pulgadas = pies * 12; 
   cm = pulgadas * 2.54; 
   metros = cm/100; 
   
   System.out.println("En pulgadas: " + pulgadas); 
   System.out.println("En centimetros: "+ cm); 
   System.out.println("En metros: "+ metros); 
   


}

}