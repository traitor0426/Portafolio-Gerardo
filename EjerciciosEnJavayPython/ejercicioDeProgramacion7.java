/* 
Elabora un programa que medante funciones y un menu, el usuario seleccione las unidades a convertir, 
por ejemplo con la temperatura en grados Fahrenheit, imprimiras su equivalente en grados Celsius, Kelvine y Rankine. 

Para convertir a Celsius a la temperatura Fahrenheit se le restan 32 y se multiplican por 5/9 Para convertir a Kelvin se le suma 273 a los grados Celsius. 
Para convertir a Rankine a los grados Fehrenheit se le suma 460. 
La función debera realizar las conversiones a las restantes unidades.

*/


import java.util.Scanner; 
public class ejercicioDeProgramacion7{
   public static void main(String[] a){
      int unidad; 
      double num;
      String respuesta; 
      Scanner sc = new Scanner(System.in);
      
      do{
         System.out.println("CONVERTIDOR DE TEMPERATURAS");
         System.out.println("1. FAHRENHEIT");
         System.out.println("2. CELSIUS");
         System.out.println("3. KELVIN");
         System.out.println("4. RANKINE");
         System.out.println("Selecciona  la unidad en la que esta la temperatura que deseas convertir: ");
         unidad = sc.nextInt(); 
         
         
         System.out.println("Ahora, ingresa la temperatura a convertir: ");
         num = sc.nextDouble(); 
         
         if (unidad == 1){
            fahrenheit(num); 
         }
         else{
            if (unidad == 2){
               celsius(num);
            
            }
            else{
               if (unidad == 3){
                  kelvin(num);
               
               }
               else{
                  if (unidad == 4){
                     rankine(num);
                  
                  }
               
               
               }
            
            }
         
         }

         
         
      
      
      
    System.out.println("Quieres hacer otra operación (Si/No)?: ");
      respuesta = sc.next();
      respuesta = respuesta.toLowerCase(); 
      }while(respuesta.equals("si"));
   
   }
   
   public static void fahrenheit(double num){
      double c, k, r;
      c = (num - 32)*0.5555;
      k = ((num-32)*0.5555)+273;
      r = 460 + num;
      System.out.println("CELSIUS: " + c); 
      System.out.println("KELVIN: " + k); 
      System.out.println("RANKINE: " + r); 
   }
   
   public static void celsius(double num){
      double f, k, r;
      f = (1.8*num) + 32; 
      k = num + 273; 
      r = f + 460; 
      System.out.println("FAHRENHEIT: " + f); 
      System.out.println("KELVIN: " + k); 
      System.out.println("RANKINE: " + r);
   
   }
   
   public static void kelvin(double num){
      double c, f, r;
      c = num - 273; 
      f = (1.8*c) + 32; 
      r = f + 460; 
      System.out.println("CELSIUS: " + c); 
      System.out.println("FAHRENHEIT: " + f); 
      System.out.println("RANKINE: " + r); 
      
   
   }
   
   public static void rankine(double num){
      double f, c, k; 
      f = num - 460; 
      c = (f - 32)*(0.5555); 
      k = c + 273; 
      System.out.println("FAHRENHEIT: " + f); 
      System.out.println("CELSIUS: " + c); 
      System.out.println("KELVIN: " + k); 
      
   
   }
   
   
}