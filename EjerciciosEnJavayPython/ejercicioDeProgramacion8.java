/*Una empresa paga a sus 5 trabajadores semanalmente, de acuerdo con el numero de horas trabajadas, 
a razon de X pesos por hora y al doble X pesos por cada hora extra. 
Las horas extras son las que exceden de 40h. 
Hacer el programa que dado el numero de horas trabajadas y el valor de x, calcule el salario que le corresponde a cada trabajador. 
El programa mostrara al final el total a depositar en el banco.*/

import java.util.Scanner; 

public class ejercicioDeProgramacion8{
   public static void main(String[] a){
   int horasTrab, costHora, costHoraExt, hrNormal, hrExt, sueldo, totalDeposito; 
   Scanner sc = new Scanner(System.in);
   totalDeposito = 0; 

   for(int i = 0; i < 5; i++){
      System.out.println("Cuantas horas trabaja a la semana?"); 
      horasTrab = sc.nextInt(); 
      System.out.println("Cuanto le pagan por hora?");
      costHora = sc.nextInt();
      costHoraExt = costHora * 2;
      
      if (horasTrab > 40){
         hrNormal = 40 * costHora;
         hrExt = (horasTrab - 40)*costHoraExt;
         sueldo = hrNormal + hrExt;
         totalDeposito = totalDeposito + sueldo;
         System.out.println("Se le pagara al trabajador" + i + "un sueldo de" + sueldo); 
      }
      
      else{
         sueldo = costHora * horasTrab;
         totalDeposito = totalDeposito + sueldo;
         System.out.println("Se le pagara al trabajador" + i + "un sueldo de" + sueldo); 
      }  
        
   }

   
   
   System.out.println("Se requerira depositar en el banco el total de: " + totalDeposito + "pesos");
   
 }
}