#Una empresa paga a sus 5 trabajadores semanalmente, de acuerdo con el numero de horas trabajadas, 
#a razon de X pesos por hora y al doble X pesos por cada hora extra. 
#Las horas extras son las que exceden de 40h. 
#Hacer el programa que dado el numero de horas trabajadas y el valor de x, calcule el salario que le corresponde a cada trabajador. 
#El programa mostrara al final el total a depositar en el banco.

trabajadores = ["Helen", "Lily", "Beth", "Daphne", "Lyra"]

totalDeposito = 0
for nombre in trabajadores: 
   horasTrab = int(input("Cuantas horas trabaja a la semana "+ nombre))
   costHora = int(input("Cuanto le pagan por hora a "+ nombre))
   
   costHoraExt = costHora * 2
   
   if horasTrab > 40: 
      hrNormal = 40 * costHora
      hrExt = (horasTrab - 40)*costHoraExt
      sueldo = hrNormal + hrExt
      totalDeposito = totalDeposito + sueldo
      print("Se le pagara a", nombre, "un sueldo de: ", sueldo)
         
   else: 
      sueldo = costHora * horasTrab
      print("Se le pagara a", nombre, "un sueldo de: ", sueldo)
      totalDeposito = totalDeposito + sueldo
      
print("Se requerira depositar en el banco el total de: ", totalDeposito, "pesos")

      

      