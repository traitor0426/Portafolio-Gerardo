#Hacer un diagrama de flujo para calcular el maximo de N numeros leidos por teclado, 
#se debe realizar de dos formas, una almacenando previamente los numeros dados por teclado en un array y 
#la otra calculando el maximo directamente segun se leen los numeros del teclado

N = int(input("Cuantos numeros son?"))
maximo = 0
for i in range(N):
   numeros = int(input("Introduce el numero"))
   if numeros > maximo: 
      maximo = numeros
      
      
print("El valor maximo es: ", maximo)
   
   
