#Elabora un programa que calcule la suma de dos arreglos unidimensionales, 
#suponiendo que sus valores corresponden a la suma del salario quincenal de un empleado mas las prestaciones del mes, 
#por lo que obtendremos el salario integral del trabajador con la suma.

salarioInt = []
salarioMensual = []
prestaciones = []
prest = 0
N = int(input("Cuantos empleados son?"))

c = 0
for i in range(N):
   c = c + 1
   print("Empleado numero", c)
   salarioQuin = int(input("Introduce el salario quincenal del empleado"))
   salMen = salarioQuin * 2
   salarioMensual.append(salMen)
   
   print("A continuacion debera introducir el valor correspondiente a cada prestacion del mes: ")
   servCom = int(input("Cuanto se le paga por SERVICIO DE COMIDAS"))
   servTrans = int(input("Cuanto se le paga por SERVICIO DE TRANSPORTE (Viaticos)"))
   bonProduc = int(input("Cuanto se le paga por BONO DE PRODUCTIVIDAD"))
   horasTrab = int(input("Cuantas horas trabaja semanalmente"))
   if horasTrab > 40: 
      hrExtra = ((horasTrab - 40)*((salarioQuin/15)*2))
      print("Pago por HORAS EXTRAS DE: ", hrExtra)
      prest = servCom + servTrans + bonProduc + hrExtra
   else:
      prest = servCom + servTrans + bonProduc
   prestaciones.append(prest)
   
print("Listado de las prestaciones de cada empleado", prestaciones)
print("Listado del salario mensual de cada empleado", salarioMensual)


for i, w in enumerate(salarioMensual):
   salarioInt.append(salarioMensual[i] + prestaciones[i])

c2 = 0
for salFinal in salarioInt: 
   c2 = c2 + 1
   print("El salario integral del empleado", c , " ", "es: ",salFinal)
   
      

   
   
   
   
   
   
   
   

