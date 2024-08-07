//La gravedad de la Luna es de alrededor del 17% de la Tierra. Escribe un programa que calcule el peso efectivo de una persona en la luna.

import java.util.Scanner; 
public class ejercicioDeProgramacion3{
   public static void main(String[] a){
   
   float masa;
   double gravedad, peso, pesoEnLuna; 
   Scanner sc = new Scanner(System.in); 
   
   System.out.println("Introduce el peso de la persona"); 
   masa = sc.nextFloat();
   
   gravedad = 9.807 * .17;
   
   peso = gravedad * (masa/9.807);
   
   
   System.out.println("El peso de la persona en la luna es: " + peso); 
   

   
   


}

}