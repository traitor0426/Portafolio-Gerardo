#La gravedad de la Luna es de alrededor del 17% de la Tierra. Escribe un programa que calcule el peso efectivo de una persona en la luna.

masa = float(input("Introduce el peso de la persona"))
gravedad = 9.807 * .17;
peso = gravedad * (masa/9.807)

print("El peso de la persona en la luna es: ", peso)