import openpyxl
import random
import time
from tkinter import *
from tkinter import filedialog

# Variables globales
laberinto = None
canvas = None
inicio_seleccionado = False
fin_seleccionado = False
posicion_inicio = None
posicion_fin = None

# Cargar el laberinto desde un archivo Excel
def cargar_laberinto(filename):
    global laberinto
    laberinto = []
    workbook = openpyxl.load_workbook(filename)
    sheet = workbook.active

    for row in sheet.iter_rows():
        laberinto_row = []
        for cell in row:
            laberinto_row.append(cell.value)
        laberinto.append(laberinto_row)

# Función para mover el agente
def acciones(pos_r, pos_c, ac, ambiente, inicio, fin):
    # Borrar la posición anterior del cuadro rojo
    canvas.create_rectangle(pos_c * 30, pos_r * 30, (pos_c + 1) * 30, (pos_r + 1) * 30, fill="white")

    #izquierda
    if ac == 1 and pos_c-1 >= 0 and ambiente[pos_r][pos_c-1] != 1:
        ambiente[pos_r][pos_c-1] = '*'
        ambiente[pos_r][pos_c] = 0
        pos_c -= 1

    #derecha
    if ac == 2 and pos_c+1 < len(ambiente[0]) and ambiente[pos_r][pos_c+1] != 1:
        ambiente[pos_r][pos_c+1] = '*'
        ambiente[pos_r][pos_c] = 0
        pos_c += 1

    #arriba
    if ac == 3 and pos_r-1 >= 0 and ambiente[pos_r-1][pos_c] != 1:
        ambiente[pos_r-1][pos_c] = '*'
        ambiente[pos_r][pos_c] = 0
        pos_r -= 1

    #abajo
    if ac == 4 and pos_r+1 < len(ambiente) and ambiente[pos_r+1][pos_c] != 1:
        ambiente[pos_r+1][pos_c] = '*'
        ambiente[pos_r][pos_c] = 0
        pos_r += 1

    return pos_r, pos_c


# Función para imprimir el laberinto en la interfaz
def imprimir(ambiente):
    for i in range(len(ambiente)):
        for j in range(len(ambiente[i])):
            if ambiente[i][j] == 1:
                canvas.create_rectangle(j * 30, i * 30, (j + 1) * 30, (i + 1) * 30, fill="black")
            elif ambiente[i][j] == 0:
                canvas.create_rectangle(j * 30, i * 30, (j + 1) * 30, (i + 1) * 30, fill="white")
            elif ambiente[i][j] == 2:
                canvas.create_rectangle(j * 30, i * 30, (j + 1) * 30, (i + 1) * 30, fill="green")
            elif ambiente[i][j] == '*':
                canvas.create_rectangle(j * 30, i * 30, (j + 1) * 30, (i + 1) * 30, fill="red")

    if inicio_seleccionado:
        canvas.create_rectangle(posicion_inicio[1] * 30, posicion_inicio[0] * 30,
                                (posicion_inicio[1] + 1) * 30, (posicion_inicio[0] + 1) * 30, fill="blue")

    if fin_seleccionado:
        canvas.create_rectangle(posicion_fin[1] * 30, posicion_fin[0] * 30,
                                (posicion_fin[1] + 1) * 30, (posicion_fin[0] + 1) * 30, fill="orange")

    window.update()

# Función para seleccionar el punto de inicio
def seleccionar_inicio(event):
    global inicio_seleccionado, posicion_inicio
    if not inicio_seleccionado and laberinto:
        x = event.x // 30
        y = event.y // 30
        if laberinto[y][x] != 1:
            inicio_seleccionado = True
            posicion_inicio = (y, x)
            imprimir(laberinto)

# Función para seleccionar el punto de fin
def seleccionar_fin(event):
    global fin_seleccionado, posicion_fin
    if not fin_seleccionado and laberinto:
        x = event.x // 30
        y = event.y // 30
        if laberinto[y][x] != 1:
            fin_seleccionado = True
            posicion_fin = (y, x)
            imprimir(laberinto)

# Función principal del agente
def agente():
    if laberinto is None or not inicio_seleccionado or not fin_seleccionado:
        return

    ambiente = laberinto.copy()  # Copia del laberinto para trabajar en ella
    pos_r, pos_c = posicion_inicio

    while (pos_r, pos_c) != posicion_fin:
        accion = random.randint(1, 4)
        pos_r, pos_c = acciones(pos_r, pos_c, accion, ambiente, posicion_inicio, posicion_fin)
        imprimir(ambiente)
        time.sleep(0.5)

# Función para cargar el archivo y comenzar el recorrido
def cargar_archivo():
    global laberinto, inicio_seleccionado, fin_seleccionado
    laberinto_filename = filedialog.askopenfilename(filetypes=[("Excel files", "*.xlsx")])
    if laberinto_filename:
        cargar_laberinto(laberinto_filename)
        inicio_seleccionado = False
        fin_seleccionado = False
        imprimir(laberinto)

# Crear la ventana de la interfaz
window = Tk()
window.title("Laberinto")

# Crear un botón para cargar el archivo
cargar_button = Button(window, text="Cargar Laberinto", command=cargar_archivo)
cargar_button.pack()

# Crear un botón para iniciar el recorrido del agente
iniciar_button = Button(window, text="Iniciar Recorrido", command=agente)
iniciar_button.pack()

# Crear un lienzo para mostrar el laberinto
canvas = Canvas(window, width=600, height=600)
canvas.pack()

# Asociar eventos de selección de inicio y fin al lienzo
canvas.bind("<Button-1>", seleccionar_inicio)
canvas.bind("<Button-3>", seleccionar_fin)



window.mainloop()
