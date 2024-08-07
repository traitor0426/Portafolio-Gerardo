#Hacer un programa que lea del teclado N numeros, realice la suma de los numeros impares, 
#la suma de los numeros pares y la suma de los numeros multiplos de 3 y muestre los resultados.

numDatos = int(input("Cuantos numeros son: "))
sumaImpares = 0; 
sumaPares = 0; 
sumaMul3 = 0;
 
for i in range(numDatos): 
   numero = int(input("Introduce el numero: "))
   
   if numero % 2 == 0: 
      sumaPares = sumaPares + numero
      
   else: 
      if numero % 2 == 1: 
         sumaImpares = sumaImpares + numero
         
   if numero % 3 == 0: 
      sumaMul3 = sumaMul3 + numero
      

print("La suma de los numeros impares es:", sumaImpares)
print("La suma de los numeros pares es:", sumaPares)
print("La suma de los numeros multiplos de 3 es:", sumaMul3)

