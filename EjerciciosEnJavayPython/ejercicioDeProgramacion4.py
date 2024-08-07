#Elabora un programa que solicite la medida en Pies y realice la conversión a pulgadas, yardas, cm y metros. 
#Toma en cuenta que un pie tiene 12 pulgadas y una pulgada equivale a 2.54 cm.

pies = float(input("Introduce la medida en pies"))

pulgadas = pies * 12 
cm = pulgadas * 2.54
metros = cm/100


print("En pulgadas: ", pulgadas)
print("En centimetros: ", cm)
print("En metros: ", metros)