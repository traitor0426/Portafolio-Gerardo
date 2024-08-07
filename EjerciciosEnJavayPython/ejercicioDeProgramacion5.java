/*
Elabora un programa que calcule la suma de dos arreglos unidimensionales, 
suponiendo que sus valores corresponden a la suma del salario quincenal de un empleado más las prestaciones del mes, 
por lo que obtendremos el salario integral del trabajador con la suma.
*/

import java.util.Scanner; 
public class ejercicioDeProgramacion5{
   public static void main(String[] a){
   int c1, c2, c3; 
   int N, suma, salario, salQuin, salMen, servCom, servTrans, bonProduc, horasTrab, hrExtra, prest; 
   int salarioMensual[];
   int prestaciones[];
   int salarioInt[]; 
   
   Scanner sc = new Scanner(System.in);
   
   System.out.println("Cuantos empleados son"); 
   N = sc.nextInt();


   prestaciones = new int[N];
   salarioInt = new int[N];
   salarioMensual = new int[N];
   
   c1 = 0;
   for(int nDato = 0; nDato < N; nDato++){
      c1 = c1 + 1;
      System.out.println("Empleado numero" + c1); 
      System.out.println("Introduce el salario quincenal del empleado");
      salQuin = sc.nextInt(); 
      salMen = salQuin * 2; 
      salarioMensual[nDato] = salMen; 
      
      System.out.println("A continuacion debera introducir el valor correspondiente a cada prestacion del mes:");
      System.out.println("Cuanto se le paga por SERVICIO DE COMIDAS");
      servCom = sc.nextInt();
      System.out.println("Cuanto se le paga por SERVICIO DE TRANSPORTE (Viaticos)");
      servTrans = sc.nextInt();
      System.out.println("Cuanto se le paga por BONO DE PRODUCTIVIDAD");
      bonProduc = sc.nextInt(); 
      System.out.println("Cuantas horas trabaja semanalmente");
      horasTrab = sc.nextInt(); 
      
      if (horasTrab > 40){
        hrExtra = ((horasTrab - 40)*((salQuin/15)*2)); 
        System.out.println("Pago por HORAS EXTRAS DE: " + hrExtra);
        prest = servCom + servTrans + bonProduc + hrExtra;
        prestaciones[nDato] = prest;
      }
      else{
         prest = servCom + servTrans + bonProduc;
         prestaciones[nDato] = prest;
      }
          
      
   }
   
   c2 = 0;
   suma = 0;
   System.out.println("Se capturaron los siguientes datos: ");
   for(int nDato = 0; nDato < N; nDato++){
       c2 = c2 + 1;
       System.out.println("Prestaciones de empleado numero" + c2 + ":" + prestaciones[nDato]);
       System.out.println("Salario mensual de empleado numero"+ c2 + ":" + salarioMensual[nDato]);
       suma = prestaciones[nDato] + salarioMensual[nDato]; 
       salarioInt[nDato] = suma; 
           
   }
   
   c3 = 0; 
   for(int nDato = 0; nDato< N; nDato++){
      c3 = c3 + 1; 
      System.out.println("El salario integral del empleado numero " + c3 + "es de: " + salarioInt[nDato]); 
   }  
   

      
   

}
}