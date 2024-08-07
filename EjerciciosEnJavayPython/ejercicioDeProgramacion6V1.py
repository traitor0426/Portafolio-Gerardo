#Hacer un diagrama de flujo para calcular el maximo de N numeros leidos por teclado, 
#se debe realizar de dos formas, una almacenando previamente los numeros dados por teclado en un array y 
#la otra calculando el maximo directamente segun se leen los numeros del teclado

numeros = []

N = int(input("Cuantos numeros son?"))
for i in range(N):
   num = int(input("Introduce el numero"))
   numeros.append(num)
   maximo = max(numeros)
      
print("El valor maximo es: ", maximo)