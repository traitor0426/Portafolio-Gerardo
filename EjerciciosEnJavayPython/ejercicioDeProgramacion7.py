# Elabora un programa que medante funciones y un menu, el usuario seleccione las unidades a convertir, 
# por ejemplo con la temperatura en grados Fahrenheit, imprimiras su equivalente en grados Celsius, Kelvine y Rankine. 
# 
# Para convertir a Celsius a la temperatura Fahrenheit se le restan 32 y se multiplican por 5/9 Para convertir a Kelvin se le suma 273 a los grados Celsius. 
# Para convertir a Rankine a los grados Fehrenheit se le suma 460. 
# La funcion debera realizar las conversiones a las restantes unidades.

def fahrenheit(num):
   c = (num - 32)*(5/9)
   k = c + 273 
   r = 460 + num
   print("CELSIUS: ", c)
   print("KELVIN: ", k)
   print("RANKINE: ", r)

def celsius(num):
   f = ((9/5)*num) + 32 
   k = num + 273
   r = f + 460
   print("FAHRENHEIT: ", f)
   print("KELVIN: ", k)
   print("RANKINE: ", r)  
   
def kelvin(num):
   c = num - 273 
   f = ((9/5)*c) + 32 
   r = f + 460 
   print("CELSIUS: ", c)
   print("FAHRENHEIT: ", f)
   print("RANKINE: ", r) 

def rankine(num):
   f = num - 460 
   c = (f - 32)*(5/9)
   k = c + 273 
   print("FAHRENHEIT: ", f)
   print("CELSIUS: ", c)
   print("KELVIN: ", k)



respuesta = "si"

while respuesta == "si": 
   print("CONVERTIDOR DE TEMPERATURAS")
   print("1. FAHRENHEIT")
   print("2. CELSIUS")
   print("3. KELVIN")
   print("4. RANKINE")
   unidad = int(input("Selecciona  la unidad en la que esta la temperatura que deseas convertir: "))
   
   numero = float(input("Ahora, ingresa la temperatura a convertir: "))
   if unidad == 1: 
      fahrenheit(numero)
   else: 
      if unidad == 2: 
         celsius(numero)
      else: 
         if unidad == 3: 
            kelvin(numero)
         else: 
            if unidad == 4: 
               rankine(numero)
   
   
   
   
   respuesta = input("Quieres capturar otro numero (Si/No)?")
   respuesta = respuesta.lower()
