# Space-Invaders-MIPS
Juego Space Invaders realizado en el assembler de MIPS. Corrido con el simulador MARS.


Autores: Gabriel Noya, Domingo Luis.

Fecha de culminacion del juego: 12/02/2017
Fecha de carga a Github: 27/04/2017


# Caracteristicas

Este juego fue realizado en una resolucion de 128x128 pixeles e incluye las siguientes caracteristicas:

- 5 aliens, que descienden por la pantalla en un movimiento de zig-zag.
- 4 barreras cuyo proposito es bloquear el camino de la bala.
- 1 cañon capaz de moverse de izquierda a derecha en la parte inferior de la pantalla. Es capaz de disparar 1 bala a la vez.
- Puntuación. En la parte inferior posee el "Score", cuyo valor incrementa al eliminar un alien y disminuye cuando fallas un disparo.
- 1 jefe final que posee 3 vidas, es decir, debemos pegarle 3 veces para vencerlo.
- Sonido. Se añadieron sonidos MIDI cuando se realiza un disparo, cuando el disparo pega con algun objeto, en la pantalla de derrota y en la pantalla de victoria.
- Pantalla de derrota y victoria. Son pantallas que se muestran cuando pierdes o ganas respectivamente. Estas pantallas poseen la propiedad la cual te permite reiniciar el juego presionando un boton.


# Instrucciones

- Abrir MARS4_5.jar dentro de la carpeta con los archivos .rgba (Carpeta Space Invaders de este repositorio).
- Desde el MARS, abrir el archivo "Space Invaders MIPS.asm" y presionar el boton de Assemble (Dos herramientas en la parte superior).
- Dentro del MARS, ir a Tools -> Bitmap Display, y colocar los settings de la manera mostrada en la foto "Settings del display.png" que se encuentra en este repositorio. Recordar presionar "Connect to MIPS".
- Ir a Tools -> Keyboard and Display MMIO Simulator. Dar click a "Connect to MIPS".
- Darle al boton Run the program, es el icono de play en la parte superior de la ventana. En este momento se empezara a reproducir el juego, inmediatamente cambiar a la ventana del Keyboard and Display MMIO Simulator, dar click en la ventana de texto inferior, y empezar a jugar.

Las teclas de juego son las siguientes:

- Tecla "4": Cañon se mueve a la izquierda.
- Tecla "6": Cañon se mueve a la derecha.
- Tecla "Espacio": Cañon dispara.
