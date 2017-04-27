#################################################################################################################################
## Autores: Gabriel Noya, Domingo Luis.																						   ##
## Ultima fecha de modificacion: 12/02/2017.																				   ##
#################################################################################################################################


#################################################################################################################################
##	Definiciones de constantes                                                                                                 ##
#################################################################################################################################
	.eqv FB_WIDTH 512			# FrameBuffer Width 128*4
	.eqv FB_LENGTH 65536			# 128*128*4
	
	.eqv SPRITE_WIDTH 52			# 13*4
	.eqv SPRITE_LENGTH 520			# 13*10*4

	.eqv BOSS_WIDTH 80			# 20*4
	.eqv BOSS_LENGTH 1040			# 20*13*4
	
	.eqv SCORE_WIDTH 176			# 44*4
	.eqv SCORE_LENGTH 1584			# 44*9*4
	
	.eqv SPACE_BARRERA1 39476		# (128 * 128 * 1 / 2) * 4 + 52 DEPENDE DE BARRERA WIDTH 32820
	.eqv SPACE_BARRERA2 39580		# (128 * 128 * 1 / 2) * 4 + 52 +52 +52 DEPENDE DE BARRERA WIDTH
	.eqv SPACE_BARRERA3 39728		# ((128 * 128 * 1 / 2) + 128) * 4 - 52 - 52 - 52 - 52 DEPENDE DE BARRERA WIDTH
	.eqv SPACE_BARRERA4 39832		# ((128 * 128 * 1 / 2) + 128) * 4 - 52 - 52  DEPENDE DE BARRERA WIDTH (Luego los baje 13 px a todos)
	
	.eqv SPACE1 4760			# Espacio entre sprites + 1152*4 (9 lineas para que no choque con el score) 4608
	.eqv SPACE2 4812			# Espacio entre sprites + 1152*4 (9 lineas para que no choque con el score)
	.eqv SPACE3 4864			# Espacio entre sprites + 1152*4 (9 lineas para que no choque con el score)
	.eqv SPACE4 9904			# Espacio entre sprites + 1152*4 (9 lineas para que no choque con el score)
	.eqv SPACE5 9956			# Espacio entre sprites + 1152*4 (9 lineas para que no choque con el score)
	.eqv SPACE_CANNON 59624			# Espacio del inicio del cañon 
	.eqv SPACEBOSS 4760			# Espacio de inicio del Boss + 1152*4 (9 lineas para que no choque con el score)
	.eqv SPACE_SCORE 168			# Espacio de inicio del sprite del score
	
	.eqv MOVE_SPEED_SPRT 4			# Que tantas direcciones salta al cargar el sprite en el bitmap
	.eqv BULLET_SPEED 1			# Cuantas lineas sube la bala por movimiento de los sprites
	.eqv LINE_JUMP 512			# Que tanto baja el Sprite 512*1
	.eqv RIGHT_BORDER 196			# Constante para el borde derecho (tiene que ser multiplos de MOVE_SPEED_SPRT)
	.eqv LEFT_BORDER -144			# Constante para el borde zquierdo (tiene que ser multiplos de MOVE_SPEED_SPRT)
	.eqv GAME_OVER_MOV 90			# Que tantas LINE_JUMP hace antes que se termine el juego
	.eqv LINE_JUMP_REP 4			# Repeticiones de LINE_JUMP para que genere mayor movimiento hacia abajo
	.eqv EXPT_VISIBILITY 12000		# Visibilidad de la explosion al morir un invader
#################################################################################################################################
##	Segmento de descripcion de data                                                                                        ##
#################################################################################################################################
	.data
FB:	.space FB_LENGTH

sprt1A: .space SPRITE_LENGTH
file1:  .asciiz "Invader1A.rgba"
	.word 0
	
sprt1B: .space SPRITE_LENGTH	
file2:  .asciiz "Invader1B.rgba"
	.word 0
	
sprt2A: .space SPRITE_LENGTH
file3:  .asciiz "Invader2A.rgba"
	.word 0
	
sprt2B: .space SPRITE_LENGTH
file4:  .asciiz "Invader2B.rgba"
	.word 0
	
sprt3A: .space SPRITE_LENGTH
file5:  .asciiz "Invader3A.rgba"
	.word 0
	
sprt3B: .space SPRITE_LENGTH
file6:  .asciiz "Invader3B.rgba"
	.word 0
	
GameOver:.space FB_LENGTH
file7:  .asciiz "GameOver.rgba"
	.word 0

Barrera:.space SPRITE_LENGTH
file8:  .asciiz "Defenses.rgba"
	.word 0

Cannon: .space SPRITE_LENGTH
file9:  .asciiz "Cannon.rgba"
	.word 0
	
Explosion:.space SPRITE_LENGTH
file10: .asciiz "Explosion1.rgba"
	.word 0
	
Erase:	.space SPRITE_LENGTH
file11:	.asciiz "Erase.rgba"
	.word 0
	
sprt4A: .space SPRITE_LENGTH
file12: .asciiz "Invader4A.rgba"
	.word 0
	
sprt4B: .space SPRITE_LENGTH
file13: .asciiz "Invader4B.rgba"
	.word 0
	
sprt5A: .space SPRITE_LENGTH
file14:  .asciiz "Invader5A.rgba"
	.word 0
	
sprt5B: .space SPRITE_LENGTH
file15: .asciiz "Invader5B.rgba"
	.word 0
	
YouWin: .space FB_LENGTH
file16: .asciiz "YouWin.rgba"
	.word 0
	
Boss:	.space BOSS_LENGTH
file17: .asciiz "Boss.rgba"
	.word 0
	
Score1: .space SCORE_LENGTH
file18:	.asciiz "Score1.rgba"
	.word 0
	
Score2: .space SCORE_LENGTH
file19:	.asciiz "Score2.rgba"
	.word 0

Score3: .space SCORE_LENGTH
file20:	.asciiz "Score3.rgba"
	.word 0
	
Score4: .space SCORE_LENGTH
file21:	.asciiz "Score4.rgba"
	.word 0
	
Score5: .space SCORE_LENGTH
file22:	.asciiz "Score5.rgba"
	.word 0
	
Score6: .space SCORE_LENGTH
file23:	.asciiz "Score6.rgba"
	.word 0
	
Score7: .space SCORE_LENGTH
file24:	.asciiz "Score7.rgba"
	.word 0
	
Score8: .space SCORE_LENGTH
file25:	.asciiz "Score8.rgba"
	.word 0
	
Score0: .space SCORE_LENGTH
file26:	.asciiz "Score0.rgba"
	.word 0
#################################################################################################################################
##	SPACE INVADER... con limitantes (muchos limitantes)                                                                    ##
#################################################################################################################################
	.text
	.globl main
################################################## Carga de Frame Buffers #######################################################
main:
	la $t0, file1				# Cargamos el nombre del archivo a t0
	la $t1, sprt1A				# Cargamos la direccion de memoria(frame buffer) donde se ubicara el sprite
	li $t2, SPRITE_LENGTH			# Pasamos el valor de la longitud del sprite
	jal load_frame_buffer			# Hacemos un call y pasamos t0 y t1 como parametros yaque los registros a estaran ocupados
	
	la $t0, file2				# Cargamos el nombre del archivo a t0
	la $t1, sprt1B				# Cargamos la direccion de memoria(frame buffer) donde se ubicara el sprite
	li $t2, SPRITE_LENGTH			# Pasamos el valor de la longitud del sprite
	jal load_frame_buffer			# Hacemos un call y pasamos t0 y t1 como parametros yaque los registros a estaran ocupados
	
	la $t0, file3				# Cargamos el nombre del archivo a t0
	la $t1, sprt2A				# Cargamos la direccion de memoria(frame buffer) donde se ubicara el sprite
	li $t2, SPRITE_LENGTH			# Pasamos el valor de la longitud del sprite
	jal load_frame_buffer			# Hacemos un call y pasamos t0 y t1 como parametros yaque los registros a estaran ocupados
	
	la $t0, file4				# Cargamos el nombre del archivo a t0
	la $t1, sprt2B				# Cargamos la direccion de memoria(frame buffer) donde se ubicara el sprite
	li $t2, SPRITE_LENGTH			# Pasamos el valor de la longitud del sprite
	jal load_frame_buffer			# Hacemos un call y pasamos t0 y t1 como parametros yaque los registros a estaran ocupados

	la $t0, file5				# Cargamos el nombre del archivo a t0
	la $t1, sprt3A				# Cargamos la direccion de memoria(frame buffer) donde se ubicara el sprite
	li $t2, SPRITE_LENGTH			# Pasamos el valor de la longitud del sprite
	jal load_frame_buffer			# Hacemos un call y pasamos t0 y t1 como parametros yaque los registros a estaran ocupados
	
	la $t0, file6				# Cargamos el nombre del archivo a t0
	la $t1, sprt3B				# Cargamos la direccion de memoria(frame buffer) donde se ubicara el sprite
	li $t2, SPRITE_LENGTH			# Pasamos el valor de la longitud del sprite
	jal load_frame_buffer			# Hacemos un call y pasamos t0 y t1 como parametros yaque los registros a estaran ocupados
	
	la $t0, file7				# Cargamos el nombre del archivo a t0
	la $t1, GameOver			# Cargamos la direccion de memoria(frame buffer) donde se ubicara el sprite
	li $t2, FB_LENGTH			# Pasamos el valor de la longitud del sprite
	jal load_frame_buffer			# Hacemos un call y pasamos t0 y t1 como parametros yaque los registros a estaran ocupados

	la $t0, file8				# Cargamos el nombre del archivo a t0
	la $t1, Barrera				# Cargamos la direccion de memoria(frame buffer) donde se ubicara el sprite
	li $t2, SPRITE_LENGTH			# Pasamos el valor de la longitud del sprite
	jal load_frame_buffer			# Hacemos un call y pasamos t0 y t1 como parametros yaque los registros a estaran ocupados

	la $t0, file9				# Cargamos el nombre del archivo a t0
	la $t1, Cannon				# Cargamos la direccion de memoria(frame buffer) donde se ubicara el sprite
	li $t2, SPRITE_LENGTH			# Pasamos el valor de la longitud del sprite
	jal load_frame_buffer			# Hacemos un call y pasamos t0 y t1 como parametros yaque los registros a estaran ocupados

	la $t0, file10				# Cargamos el nombre del archivo a t0
	la $t1, Explosion			# Cargamos la direccion de memoria(frame buffer) donde se ubicara el sprite
	li $t2, SPRITE_LENGTH			# Pasamos el valor de la longitud del sprite
	jal load_frame_buffer			# Hacemos un call y pasamos t0 y t1 como parametros yaque los registros a estaran ocupados

	la $t0, file11				# Cargamos el nombre del archivo a t0
	la $t1, Erase				# Cargamos la direccion de memoria(frame buffer) donde se ubicara el sprite
	li $t2, SPRITE_LENGTH			# Pasamos el valor de la longitud del sprite
	jal load_frame_buffer			# Hacemos un call y pasamos t0 y t1 como parametros yaque los registros a estaran ocupados
		
	la $t0, file12				# Cargamos el nombre del archivo a t0
	la $t1, sprt4A				# Cargamos la direccion de memoria(frame buffer) donde se ubicara el sprite
	li $t2, SPRITE_LENGTH			# Pasamos el valor de la longitud del sprite
	jal load_frame_buffer			# Hacemos un call y pasamos t0 y t1 como parametros yaque los registros a estaran ocupados
	
	la $t0, file13				# Cargamos el nombre del archivo a t0
	la $t1, sprt4B				# Cargamos la direccion de memoria(frame buffer) donde se ubicara el sprite
	li $t2, SPRITE_LENGTH			# Pasamos el valor de la longitud del sprite
	jal load_frame_buffer			# Hacemos un call y pasamos t0 y t1 como parametros yaque los registros a estaran ocupados
	
	la $t0, file14				# Cargamos el nombre del archivo a t0
	la $t1, sprt5A				# Cargamos la direccion de memoria(frame buffer) donde se ubicara el sprite
	li $t2, SPRITE_LENGTH			# Pasamos el valor de la longitud del sprite
	jal load_frame_buffer			# Hacemos un call y pasamos t0 y t1 como parametros yaque los registros a estaran ocupados
	
	la $t0, file15				# Cargamos el nombre del archivo a t0
	la $t1, sprt5B				# Cargamos la direccion de memoria(frame buffer) donde se ubicara el sprite
	li $t2, SPRITE_LENGTH			# Pasamos el valor de la longitud del sprite
	jal load_frame_buffer			# Hacemos un call y pasamos t0 y t1 como parametros yaque los registros a estaran ocupados
	
	la $t0, file16				# Cargamos el nombre del archivo a t0
	la $t1, YouWin				# Cargamos la direccion de memoria(frame buffer) donde se ubicara el sprite
	li $t2, FB_LENGTH			# Pasamos el valor de la longitud del sprite
	jal load_frame_buffer			# Hacemos un call y pasamos t0 y t1 como parametros yaque los registros a estaran ocupados

	la $t0, file17				# Cargamos el nombre del archivo a t0
	la $t1, Boss				# Cargamos la direccion de memoria(frame buffer) donde se ubicara el sprite
	li $t2, BOSS_LENGTH			# Pasamos el valor de la longitud del sprite
	jal load_frame_buffer			# Hacemos un call y pasamos t0 y t1 como parametros yaque los registros a estaran ocupados

	la $t0, file17				# Cargamos el nombre del archivo a t0
	la $t1, Boss				# Cargamos la direccion de memoria(frame buffer) donde se ubicara el sprite
	li $t2, BOSS_LENGTH			# Pasamos el valor de la longitud del sprite
	jal load_frame_buffer			# Hacemos un call y pasamos t0 y t1 como parametros yaque los registros a estaran ocupados
	
	la $t0, file18				# Cargamos el nombre del archivo a t0
	la $t1, Score1				# Cargamos la direccion de memoria(frame buffer) donde se ubicara el sprite
	li $t2, SCORE_LENGTH			# Pasamos el valor de la longitud del sprite
	jal load_frame_buffer			# Hacemos un call y pasamos t0 y t1 como parametros yaque los registros a estaran ocupados
	
	la $t0, file19				# Cargamos el nombre del archivo a t0
	la $t1, Score2				# Cargamos la direccion de memoria(frame buffer) donde se ubicara el sprite
	li $t2, SCORE_LENGTH			# Pasamos el valor de la longitud del sprite
	jal load_frame_buffer			# Hacemos un call y pasamos t0 y t1 como parametros yaque los registros a estaran ocupados
	
	la $t0, file20				# Cargamos el nombre del archivo a t0
	la $t1, Score3				# Cargamos la direccion de memoria(frame buffer) donde se ubicara el sprite
	li $t2, SCORE_LENGTH			# Pasamos el valor de la longitud del sprite
	jal load_frame_buffer			# Hacemos un call y pasamos t0 y t1 como parametros yaque los registros a estaran ocupados
	
	la $t0, file21				# Cargamos el nombre del archivo a t0
	la $t1, Score4				# Cargamos la direccion de memoria(frame buffer) donde se ubicara el sprite
	li $t2, SCORE_LENGTH			# Pasamos el valor de la longitud del sprite
	jal load_frame_buffer			# Hacemos un call y pasamos t0 y t1 como parametros yaque los registros a estaran ocupados
	
	la $t0, file22				# Cargamos el nombre del archivo a t0
	la $t1, Score5				# Cargamos la direccion de memoria(frame buffer) donde se ubicara el sprite
	li $t2, SCORE_LENGTH			# Pasamos el valor de la longitud del sprite
	jal load_frame_buffer			# Hacemos un call y pasamos t0 y t1 como parametros yaque los registros a estaran ocupados
	
	la $t0, file23				# Cargamos el nombre del archivo a t0
	la $t1, Score6				# Cargamos la direccion de memoria(frame buffer) donde se ubicara el sprite
	li $t2, SCORE_LENGTH			# Pasamos el valor de la longitud del sprite
	jal load_frame_buffer			# Hacemos un call y pasamos t0 y t1 como parametros yaque los registros a estaran ocupados
	
	la $t0, file24				# Cargamos el nombre del archivo a t0
	la $t1, Score7				# Cargamos la direccion de memoria(frame buffer) donde se ubicara el sprite
	li $t2, SCORE_LENGTH			# Pasamos el valor de la longitud del sprite
	jal load_frame_buffer			# Hacemos un call y pasamos t0 y t1 como parametros yaque los registros a estaran ocupados
	
	la $t0, file25				# Cargamos el nombre del archivo a t0
	la $t1, Score8				# Cargamos la direccion de memoria(frame buffer) donde se ubicara el sprite
	li $t2, SCORE_LENGTH			# Pasamos el valor de la longitud del sprite
	jal load_frame_buffer			# Hacemos un call y pasamos t0 y t1 como parametros yaque los registros a estaran ocupados
	
	la $t0, file26				# Cargamos el nombre del archivo a t0
	la $t1, Score0				# Cargamos la direccion de memoria(frame buffer) donde se ubicara el sprite
	li $t2, SCORE_LENGTH			# Pasamos el valor de la longitud del sprite
	jal load_frame_buffer			# Hacemos un call y pasamos t0 y t1 como parametros yaque los registros a estaran ocupados
	
	j color_blanco				# Continuamos con el programa
	
load_frame_buffer:
	# Cargamos el primer sprite a un frame buffer.
	# Abrimos el archivo .rgba del sprite
	li $v0, 13				# servicio de open file
	move $a0, $t0				# cargamos el nombre del archivo a a0
	li $a1, 0				# 0 para solo lectura
	li $a2, 0				# 0 es para ignorar
	syscall
	
	# Lo almacenamos en un frame buffer
	move $a0, $v0				# almacenamos el file descriptor en a0
	li $v0, 14				# servicio de read from file
	move $a1, $t1				# colocamos la direccion de memoria(frame buffer) donde se ubicara el sprite
	move $a2, $t2				# colocamos el tamaño de los bytes a leer
	syscall
	
	jr $ra

######################################################## Color blanco ###########################################################
color_blanco:
	li $t8, 0xFFFF				# Cargamos 0xFFFFFFFF (Color blanco) a t9.
	lui $t9, 0xFFFF
	add $t9, $t9, $t8

################################################ Impresion de los Sprites #######################################################

Sprites:
	la $s0, FB				# Usamos el registro s0 para guardar la direccion de origen de los invaders
	la $s1, FB				# Usamos el registro s1 para guardar la direccion de origen del cañon 
	li $t2, SPRITE_WIDTH			# Cargamos el valor de el ancho del sprite
	li $t3, SPRITE_LENGTH			# Cargamos la longitud de bytes del sprite
	li $t4, 0
	li $t5, 0
	li $t6, 0
	li $t7, 0
	li $t8, 0
	li $s3, 0				# Contador del movimiento derecha-izquierda
	li $s4, 0				# Enable para el cambio de direccion del movimiento derecha-izquierda
	li $s6, 31				# Registro de la vida de los invaders (una posicion por invader)
	li $s7, 0
	li $a3, 0
	
# Sprites a imprimir
Barreras:
	la $a0, Barrera				# Pasamos como parametro la direccion del frame buffer del sprite
	la $a2, 0($s0)				# Pasamos como parametro el inicio del FB
	li $a1, SPACE_BARRERA1			# Pasamos como parametro el espacio de inicio del sprite
	jal printspr
	li $a1, SPACE_BARRERA2			# Pasamos como parametro el espacio de inicio del sprite
	jal printspr
	li $a1, SPACE_BARRERA3			# Pasamos como parametro el espacio de inicio del sprite
	jal printspr
	li $a1, SPACE_BARRERA4			# Pasamos como parametro el espacio de inicio del sprite
	jal printspr

print1A:
	#Pintaremos el sprite
	andi $t0, $s6, 1			# Revisamos el primer bit del registro de vida de los invaders
	beq $t0, 0, print2A			# Si es igual a 0 esta muerto y lo saltamos	
	la $a0, sprt1A				# Pasamos como parametro la direccion del frame buffer del sprite
	li $a1, SPACE1				# Pasamos como parametro el espacio de inicio del sprite
	la $a2, 0($s0)				# Pasamos como parametro el inicio del FB
	jal printspr				# Saltamos a la rutina de pintar
	
print2A:
	#Pintaremos el sprite
	andi $t0, $s6, 2			# Revisamos el primer bit del registro de vida de los invaders
	beq $t0, 0, print3A			# Si es igual a 0 esta muerto y lo saltamos
	la $a0, sprt2A				# Pasamos como parametro la direccion del frame buffer del sprite
	li $a1, SPACE2				# Pasamos como parametro el espacio de inicio del sprite
	la $a2, 0($s0)				# Pasamos como parametro el inicio del FB
	jal printspr				# Saltamos a la rutina de pintar
	
print3A:
	#Pintaremos el sprite
	andi $t0, $s6, 4			# Revisamos el primer bit del registro de vida de los invaders
	beq $t0, 0, print4A			# Si es igual a 0 esta muerto y lo saltamos
	la $a0, sprt3A				# Pasamos como parametro la direccion del frame buffer del sprite
	li $a1, SPACE3				# Pasamos como parametro el espacio de inicio del sprite
	la $a2, 0($s0)				# Pasamos como parametro el inicio del FB
	jal printspr				# Saltamos a la rutina de pintar
	
print4A:
	#Pintaremos el sprite
	andi $t0, $s6, 8			# Revisamos el primer bit del registro de vida de los invaders
	beq $t0, 0, print5A			# Si es igual a 0 esta muerto y lo saltamos
	la $a0, sprt4A				# Pasamos como parametro la direccion del frame buffer del sprite
	li $a1, SPACE4				# Pasamos como parametro el espacio de inicio del sprite
	la $a2, 0($s0)				# Pasamos como parametro el inicio del FB
	jal printspr				# Saltamos a la rutina de pintar
	
print5A:
	#Pintaremos el sprite
	andi $t0, $s6, 16			# Revisamos el primer bit del registro de vida de los invaders
	beq $t0, 0, print1B			# Si es igual a 0 esta muerto y lo saltamos
	la $a0, sprt5A				# Pasamos como parametro la direccion del frame buffer del sprite
	li $a1, SPACE5				# Pasamos como parametro el espacio de inicio del sprite
	la $a2, 0($s0)				# Pasamos como parametro el inicio del FB
	jal printspr				# Saltamos a la rutina de pintar
	
print1B:
	#Pintaremos el sprite
	andi $t0, $s6, 1			# Revisamos el primer bit del registro de vida de los invaders
	beq $t0, 0, print2B			# Si es igual a 0 esta muerto y lo saltamos
	la $a0, sprt1B				# Pasamos como parametro la direccion del frame buffer del sprite
	li $a1, SPACE1				# Pasamos como parametro el espacio de inicio del sprite
	la $a2, 0($s0)				# Pasamos como parametro el inicio del FB
	jal printspr				# Saltamos a la rutina de pintar
	
print2B:
	#Pintaremos el sprite
	andi $t0, $s6, 2			# Revisamos el primer bit del registro de vida de los invaders
	beq $t0, 0, print3B			# Si es igual a 0 esta muerto y lo saltamos
	la $a0, sprt2B				# Pasamos como parametro la direccion del frame buffer del sprite
	li $a1, SPACE2				# Pasamos como parametro el espacio de inicio del sprite
	la $a2, 0($s0)				# Pasamos como parametro el inicio del FB
	jal printspr				# Saltamos a la rutina de pintar
	
print3B:
	#Pintaremos el sprite
	andi $t0, $s6, 4			# Revisamos el primer bit del registro de vida de los invaders
	beq $t0, 0, print4B			# Si es igual a 0 esta muerto y lo saltamos
	la $a0, sprt3B				# Pasamos como parametro la direccion del frame buffer del sprite
	li $a1, SPACE3				# Pasamos como parametro el espacio de inicio del sprite
	la $a2, 0($s0)				# Pasamos como parametro el inicio del FB
	jal printspr				# Saltamos a la rutina de pintar
	
print4B:
	#Pintaremos el sprite
	andi $t0, $s6, 8			# Revisamos el primer bit del registro de vida de los invaders
	beq $t0, 0, print5B			# Si es igual a 0 esta muerto y lo saltamos
	la $a0, sprt4B				# Pasamos como parametro la direccion del frame buffer del sprite
	li $a1, SPACE4				# Pasamos como parametro el espacio de inicio del sprite
	la $a2, 0($s0)				# Pasamos como parametro el inicio del FB
	jal printspr				# Saltamos a la rutina de pintar
	
print5B:
	#Pintaremos el sprite
	andi $t0, $s6, 16			# Revisamos el primer bit del registro de vida de los invaders
	beq $t0, 0, printS0			# Si es igual a 0 esta muerto y lo saltamos
	la $a0, sprt5B				# Pasamos como parametro la direccion del frame buffer del sprite
	li $a1, SPACE5				# Pasamos como parametro el espacio de inicio del sprite
	la $a2, 0($s0)				# Pasamos como parametro el inicio del FB
	jal printspr				# Saltamos a la rutina de pintar

printS0:
	#Pintaremos el sprite
	bne $s7, 0, printS1			# Si es igual a 0 esta muerto y lo saltamos
	li $t2, SCORE_WIDTH			# Cargamos el valor de el ancho del sprite
	li $t3, SCORE_LENGTH			# Cargamos la longitud de bytes del sprite
	la $a0, Score0				# Pasamos como parametro la direccion del frame buffer del sprite
	li $a1, SPACE_SCORE			# Pasamos como parametro el espacio de inicio del sprite
	la $a2, FB				# Pasamos como parametro el inicio del FB
	jal printspr				# Saltamos a la rutina de pintar

printS1:
	#Pintaremos el sprite
	bne $s7, 1, printS2			# Si es igual a 0 esta muerto y lo saltamos
	li $t2, SCORE_WIDTH			# Cargamos el valor de el ancho del sprite
	li $t3, SCORE_LENGTH			# Cargamos la longitud de bytes del sprite
	la $a0, Score1				# Pasamos como parametro la direccion del frame buffer del sprite
	li $a1, SPACE_SCORE			# Pasamos como parametro el espacio de inicio del sprite
	la $a2, FB				# Pasamos como parametro el inicio del FB
	jal printspr				# Saltamos a la rutina de pintar
	
printS2:
	#Pintaremos el sprite
	bne $s7, 2, printS3			# Si es igual a 0 esta muerto y lo saltamos
	li $t2, SCORE_WIDTH			# Cargamos el valor de el ancho del sprite
	li $t3, SCORE_LENGTH			# Cargamos la longitud de bytes del sprite
	la $a0, Score2				# Pasamos como parametro la direccion del frame buffer del sprite
	li $a1, SPACE_SCORE			# Pasamos como parametro el espacio de inicio del sprite
	la $a2, FB				# Pasamos como parametro el inicio del FB
	jal printspr				# Saltamos a la rutina de pintar
	
printS3:
	#Pintaremos el sprite
	bne $s7, 3, printS4			# Si es igual a 0 esta muerto y lo saltamos
	li $t2, SCORE_WIDTH			# Cargamos el valor de el ancho del sprite
	li $t3, SCORE_LENGTH			# Cargamos la longitud de bytes del sprite
	la $a0, Score3				# Pasamos como parametro la direccion del frame buffer del sprite
	li $a1, SPACE_SCORE			# Pasamos como parametro el espacio de inicio del sprite
	la $a2, FB				# Pasamos como parametro el inicio del FB
	jal printspr				# Saltamos a la rutina de pintar
	
printS4:
	#Pintaremos el sprite
	bne $s7, 4, printS5			# Si es igual a 0 esta muerto y lo saltamos
	li $t2, SCORE_WIDTH			# Cargamos el valor de el ancho del sprite
	li $t3, SCORE_LENGTH			# Cargamos la longitud de bytes del sprite
	la $a0, Score4				# Pasamos como parametro la direccion del frame buffer del sprite
	li $a1, SPACE_SCORE			# Pasamos como parametro el espacio de inicio del sprite
	la $a2, FB				# Pasamos como parametro el inicio del FB
	jal printspr				# Saltamos a la rutina de pintar
	
printS5:
	#Pintaremos el sprite
	bne $s7, 5, printS6			# Si es igual a 0 esta muerto y lo saltamos
	li $t2, SCORE_WIDTH			# Cargamos el valor de el ancho del sprite
	li $t3, SCORE_LENGTH			# Cargamos la longitud de bytes del sprite
	la $a0, Score5				# Pasamos como parametro la direccion del frame buffer del sprite
	li $a1, SPACE_SCORE			# Pasamos como parametro el espacio de inicio del sprite
	la $a2, FB				# Pasamos como parametro el inicio del FB
	jal printspr				# Saltamos a la rutina de pintar

printS6:
	#Pintaremos el sprite
	bne $s7, 6, printS7			# Si es igual a 0 esta muerto y lo saltamos
	li $t2, SCORE_WIDTH			# Cargamos el valor de el ancho del sprite
	li $t3, SCORE_LENGTH			# Cargamos la longitud de bytes del sprite
	la $a0, Score6				# Pasamos como parametro la direccion del frame buffer del sprite
	li $a1, SPACE_SCORE			# Pasamos como parametro el espacio de inicio del sprite
	la $a2, FB				# Pasamos como parametro el inicio del FB
	jal printspr				# Saltamos a la rutina de pintar
	
printS7:
	#Pintaremos el sprite
	bne $s7, 7, printS8			# Si es igual a 0 esta muerto y lo saltamos
	li $t2, SCORE_WIDTH			# Cargamos el valor de el ancho del sprite
	li $t3, SCORE_LENGTH			# Cargamos la longitud de bytes del sprite
	la $a0, Score7				# Pasamos como parametro la direccion del frame buffer del sprite
	li $a1, SPACE_SCORE			# Pasamos como parametro el espacio de inicio del sprite
	la $a2, FB				# Pasamos como parametro el inicio del FB
	jal printspr				# Saltamos a la rutina de pintar

printS8:
	#Pintaremos el sprite
	bne $s7, 8, PrintCannon			# Si es igual a 0 esta muerto y lo saltamos
	li $t2, SCORE_WIDTH			# Cargamos el valor de el ancho del sprite
	li $t3, SCORE_LENGTH			# Cargamos la longitud de bytes del sprite
	la $a0, Score8				# Pasamos como parametro la direccion del frame buffer del sprite
	li $a1, SPACE_SCORE			# Pasamos como parametro el espacio de inicio del sprite
	la $a2, FB				# Pasamos como parametro el inicio del FB
	jal printspr				# Saltamos a la rutina de pintar



PrintCannon:
	beq $s6, 0, Check_Keyboard
	#Pintaremos el sprite
	li $t2, SPRITE_WIDTH			# Cargamos el valor de el ancho del sprite
	li $t3, SPRITE_LENGTH			# Cargamos la longitud de bytes del sprite
	la $a0, Cannon				# Pasamos como parametro la direccion del frame buffer del sprite
	li $a1, SPACE_CANNON			# Pasamos como parametro el espacio de inicio del sprite
	la $a2, 0($s1)				# Pasamos como parametro el inicio del FB
	jal printspr				# Saltamos a la rutina de pintar
	
BossCheck:
	beq $s6, 224, Boss_Print
	beq $s6, 192, Boss_Print
	beq $s6, 128, Boss_Print
	j BalaPatch

Boss_Print:
	la $a0, Boss				# Pasamos como parametro la direccion del frame buffer del sprite
	li $a1, SPACEBOSS			# Pasamos como parametro el espacio de inicio del sprite (SPACE 1)
	la $a2, 0($s0)				# Pasamos como parametro el inicio del FB
	li $t2, BOSS_WIDTH			# Cargamos el valor de el ancho del sprite
	li $t3, BOSS_LENGTH			# Cargamos la longitud de bytes del sprite
	jal printBoss				# Saltamos a la rutina de pintar
	j BalaPatch

# Call que imprime los sprites
printspr:
	# Cargamos el sprite en el frame buffer
	move $t1, $a0				# Cargamos la direccion del frame buffer (del sprite) a t0
	move $t0, $a1				# Cargamos la direccion del frame buffer a t1
	add $t0, $t0, $a2			# Sumamos el inicio mas el espacio donde se colocara el sprite
	li $t4, 0				# i=0 (lo definimos aca para no dañar los loop)
	li $t5, 0				# j=0 (lo definimos aca para no dañar los loop)

printspr_loop_i:
	bge $t4, $t3, printspr_out		# Condicion para salir del loop y continuar al siguiente i >= SPRITE_LENGTH
	
printspr_loop_j:
	bge $t5, $t2, jump_line			# Condicion para salir de este loop j >= SPRITE_WIDTH
	lw $t6, ($t1)				# Cargamos el pixel del sprite a t6 apuntada por t1
	sw $t6, ($t0)				# Guardamos el pixel en la direccion del FB apuntada por t0
	addi $t0, $t0, 4			# Avanzamos a la siguiente direccion de la memoria en FB y sprt
	addi $t1, $t1, 4
	addi $t4, $t4, 4			# Incrementamos los contadores en 4 ya que los pixeles se cuentan por byte
	addi $t5, $t5, 4
	j printspr_loop_j			# Repetimos el loop con nuevas direcciones recien modificadas
	
jump_line:
	li $t5, 0				# Colocamos el contador de line (j) en 0 para empezar una nueva linea
	addi $t0, $t0, FB_WIDTH			# Le sumamos a la direccion de FB la longitud de una linea (bajar de linea)
	sub $t0, $t0, $t2			# Le restamos a la direccion de FB la longitud del sprite, asi regresando al principio de la linea
	j printspr_loop_i			# Volvemos a iniciar el loop1Ai
	
printspr_out:
	jr $ra

# Codigo para la impresion de la bala
BalaPatch:
	li $t4, 0
Bala:
	beq $a3, 0, movesprt			# Si a3 es 0, no hay una bala en el aire, asi que saltamos	#CAMBIAR A3 por otro reg
	beq $t4, 2, movesprt			# Si ya la bala se movio 4 veces, saltamos.
	jal pintarBala
	addi $t4, $t4, BULLET_SPEED		# Sumamos uno al contador de movimiento de la bala.
	j Bala
	
pintarBala:
	sw $zero, 0($t8)			# Guardamos negro ($zero) en la posicion actual de la bala.
	subi $t8, $t8, FB_WIDTH			# Movemos una linea hacia arriba la posicion de la bala.
	blt $t8, 0x10011200, FueraDeRango 	# Si llega al borde de arriba + 4 pixeles hacia abajo indica que fallaste el tiro.
	
Check_Hit:
	lw $t5, 0($t8)				# Cargamos el valor del pixel.
	beq $t5, $t9, Hit			# Si es blanco, hubo hit.
No_Hit:
	sw $t9, 0($t8)				# Guardamos blanco (0xFFFFFFFF) en la posicion actualizada de la bala.
	jr $ra					# Volvemos

FueraDeRango:
	li $a3, 0				# Ya no hay bala en el aire.
	addi $s7, $s7, -1
	blt $s7, 0, ScoreNegativo
	j Bala

ScoreNegativo:
	li $s7, 0
	j Bala
################################################ Hit check ######################################################################

Hit:
	li $v0, 31
	li $a0, 54
	li $a2, 127
	li $a1, 500
	li $a3, 125
	syscall
	
# Chequeamos a que le pegamos
	beq $s6, 224, BossHit1
	beq $s6, 192, BossHit2
	beq $s6, 128, MuerteBoss
	li $a3, 0				# Ya no hay bala en el aire.
	li $t4, 0
	li $t6, 0
	li $t7, 0
	
HitCheckLoop:
	beq $t4, 9, NoAlien			# Verificamos 10 movimientos verticales

HitChecki:
	beq $t6, 13, Hit_Linea			# Verificamos 13 movimientos a la izquierda
	addi $t7, $s0, SPACE1
	beq $t8, $t7, Muerte1
	
	addi $t7, $s0, SPACE2
	beq $t8, $t7, Muerte2
	
	addi $t7, $s0, SPACE3
	beq $t8, $t7, Muerte3
	
	addi $t7, $s0, SPACE4
	beq $t8, $t7, Muerte4
	
	addi $t7, $s0, SPACE5
	beq $t8, $t7, Muerte5
	
	addi $t6, $t6, 1
	addi $t8, $t8, -4			# Movemos el indicador un px a la izquierda
	j HitChecki
	
Hit_Linea:
	li $t6, 0
	addi $t8, $t8, SPRITE_WIDTH		# Devolvemos el indicador al punto horizontal donde hizo el hit.
	subi $t8, $t8, FB_WIDTH			# Lo subimos una linea
	addi $t4, $t4, 1			# Sumamos uno a la cantidad de lineas subidas.
	j HitCheckLoop
	
NoAlien:
	jr $ra
	
Muerte1:
	la $a0, Explosion			# Pasamos como parametro la direccion del frame buffer del sprite
	li $a1, SPACE1				# Pasamos como parametro el espacio de inicio del sprite
	la $a2, 0($s0)				# Pasamos como parametro el inicio del FB
	andi $s6, $s6, 30			# Eliminamos el sprite
	addi $s7, $s7, 1			# Sumamos 1 al score
	j MuerteOut
	
Muerte2:
	la $a0, Explosion			# Pasamos como parametro la direccion del frame buffer del sprite
	li $a1, SPACE2				# Pasamos como parametro el espacio de inicio del sprite
	la $a2, 0($s0)				# Pasamos como parametro el inicio del FB
	andi $s6, $s6, 29			# Eliminamos el sprite
	addi $s7, $s7, 1			# Sumamos 1 al score
	j MuerteOut
	
Muerte3:
	la $a0, Explosion			# Pasamos como parametro la direccion del frame buffer del sprite
	li $a1, SPACE3				# Pasamos como parametro el espacio de inicio del sprite
	la $a2, 0($s0)				# Pasamos como parametro el inicio del FB
	andi $s6, $s6, 27			# Eliminamos el sprite
	addi $s7, $s7, 1			# Sumamos 1 al score
	j MuerteOut

Muerte4:
	la $a0, Explosion			# Pasamos como parametro la direccion del frame buffer del sprite
	li $a1, SPACE4				# Pasamos como parametro el espacio de inicio del sprite
	la $a2, 0($s0)				# Pasamos como parametro el inicio del FB
	andi $s6, $s6, 23			# Eliminamos el sprite
	addi $s7, $s7, 1			# Sumamos 1 al score
	j MuerteOut
	
Muerte5:
	la $a0, Explosion			# Pasamos como parametro la direccion del frame buffer del sprite
	li $a1, SPACE5				# Pasamos como parametro el espacio de inicio del sprite
	la $a2, 0($s0)				# Pasamos como parametro el inicio del FB
	andi $s6, $s6, 15			# Eliminamos el sprite
	addi $s7, $s7, 1			# Sumamos 1 al score
	j MuerteOut

BossHit1:
	addi $s6, $s6, -32
	li $a3, 0
	addi $s7, $s7, 1			# Sumamos 1 al score
	j print1A
	
BossHit2:
	addi $s6, $s6, -64
	li $a3, 0
	addi $s7, $s7, 1			# Sumamos 1 al score
	j print1A
	
MuerteBoss:
	li $s0, 0
	li $s6, 0
	li $a3, 0
	addi $s7, $s7, 1			# Sumamos 1 al score
	j Win
	
MuerteOut:
	jal printspr				# Saltamos a la rutina de pintar
	li $t0, 0				# Iniciamos el contador en 0
	
MuerteOut_loop:
	beq $t0, EXPT_VISIBILITY, Erase_invader	# chequeamos para salir del loop
	addi $t0, $t0, 1			# sumamos 1
	j MuerteOut_loop
	
Erase_invader:
	la $a0, Erase				# Pasamos como parametro la direccion del frame buffer del sprite
	jal printspr
	bne $s6, 0, print1A
	addi $s6, $s6, 224
	li $s3, 0
	la $s0, FB
	j print1A

############################################## Movimiento de los sprite #########################################################
movesprt:
	li $a2, 0				# Reseteamos el contador de movimiento de la bala
	
	# Chequeamos condiciones para saber a que direccion se moveran a los sprites
	beq $s3, RIGHT_BORDER, move_left	# Si el contador (s3) aumenta 800 (referencia a los aumento de direcciones)
	beq $s3, LEFT_BORDER, move_right	# Si el contador (s3) aumenta -208 (referencia a los aumento de direcciones)
	beq $s4, 1, move_left			# Si el enable esta en 1 saltamos a mover a la izquierda
	
move_right:
	beq $s3, LEFT_BORDER, move_down		# Chequeo para mover el sprite hacia abajo
move_right2:
	li $s4, 0
	addi $s0, $s0, MOVE_SPEED_SPRT		# Sumamos un valor a la direccion de inicio con el fin de mover a los sprites
	addi $s3, $s3, MOVE_SPEED_SPRT		# Sumamos al contador 4 por las direcciones
	j Check_Keyboard
	
move_left:
	beq $s3, RIGHT_BORDER, move_down	# Chequeo para mover el sprite hacia abajo
move_left2:
	li $s4, 1
	subi $s0, $s0, MOVE_SPEED_SPRT		# Restamos un valor a la direccion de inicio con el fin de mover a los sprites
	subi $s3, $s3, MOVE_SPEED_SPRT		# Restamos al contador 4 por las direcciones
	j Check_Keyboard			# Volvemos a imprimir en el bitmap

move_down:
	bge $s0, 0x1001C800, gameover		# Chequeamos si ha bajado lo suficiente como para imprimir Game Over
	beq $s5, LINE_JUMP_REP, md_loop		# Chequeamos cuantas veces se ha bajado el sprite
	addiu $s0, $s0, LINE_JUMP		# Sumamos un valor a la direccion de inicio con el fin de bajar a los sprites
	addi $s5, $s5, 1			# Aumento del contador de repeticiones del codigo "linea"
	j Check_Keyboard
	
md_loop:
	li $s5, 0				# Devolvemos el contador a 0.
	beq $s3,RIGHT_BORDER, move_left2	# Si el contador (s3) aumenta 800 (referencia a los aumento de direcciones).
	j move_right2				# Por descarte saltamos a derecha2.


################################################## Chequear teclado #############################################################

Check_Keyboard:
	lw $t7, 0xffff0000			# Cargamos la word en esta direccion. Si el ultimo bit es 1 se presiono una tecla.
	andi $t7, $t7, 1			# Filtramos el ultiumo bit.
	beq $t7, 1, KeyDetected			# Revisamos si ese bit es 1.
	beq $s6, 0, Win2			# Si estamos en win y no detectamos nada, volvemos a la pantalla de win.
	j print1A

KeyDetected:
	beq $s6, 0, Win3			# Si ya estamos en win, nos saltamos el resto y vamos a reinicio.
	li $s2, 0
	addi $s2, $s1, SPACE_CANNON
	lw $t7, 0xffff0004			# Cargamos la tecla presionada, vendra en codigo ASCII.
	beq $t7, 52, Cannon_Izquierda		# Ascii de 4.
	beq $t7, 54, Cannon_Derecha		# Ascii de 6.
	beq $t7, 32, Cannon_Disparo		# Ascii de Space.
	j print1A

Cannon_Izquierda:
	blt $s2, 0x1001E800, print1A		# Chequeamos el borde. 59392
	addi $s1, $s1, -8			# Movemos a la izquierda 2 px.
	j print1A
	
Cannon_Derecha:
	bgt $s2, 0x1001E9CC, print1A		# Chequeamos el borde.
	addi $s1, $s1, 8			# Movemos a la derecha 2 px.
	j print1A
	
Cannon_Disparo:
	beq $a3, 1, print1A			# Revisamos si hay una bala en el aire.
	move $v1, $a3
	li $v0, 31
	li $a0, 49
	li $a1, 400
	li $a2, 127
	li $a3, 120
	syscall
	move $a3, $v1
	move $t8, $s2				# Guardamos la posicion inicial de la bala.
	addi $t8, $t8, 28			# Llevamos la bala al centro sumandole la mitad del length del cannon.
	li $a3, 1				# Prendemos el enable de la bala.
	j print1A
	
##################################################### IMPRIMIR BOSS #############################################################

printBoss:
	# Cargamos el sprite en el frame buffer
	move $t1, $a0				# Cargamos la direccion del frame buffer (del sprite) a t0
	move $t0, $a1				# Cargamos la direccion del frame buffer a t1
	add $t0, $t0, $a2			# Sumamos el inicio mas el espacio donde se colocara el sprite
	li $t4, 0				# i=0 (lo definimos aca para no dañar los loop)
	li $t5, 0				# j=0 (lo definimos aca para no dañar los loop)

printBoss_loop_i:
	bge $t4, $t3, printBoss_out		# Condicion para salir del loop y continuar al siguiente i >= SPRITE_LENGTH
	
printBoss_loop_j:
	bge $t5, $t2, jump_Bossline			# Condicion para salir de este loop j >= SPRITE_WIDTH
	lw $t6, ($t1)				# Cargamos el pixel del sprite a t6 apuntada por t1
	sw $t6, ($t0)				# Guardamos el pixel en la direccion del FB apuntada por t0
	addi $t0, $t0, 4			# Avanzamos a la siguiente direccion de la memoria en FB y sprt
	addi $t1, $t1, 4
	addi $t4, $t4, 4			# Incrementamos los contadores en 4 ya que los pixeles se cuentan por byte
	addi $t5, $t5, 4
	j printBoss_loop_j			# Repetimos el loop con nuevas direcciones recien modificadas
	
jump_Bossline:
	li $t5, 0				# Colocamos el contador de line (j) en 0 para empezar una nueva linea
	addi $t0, $t0, FB_WIDTH			# Le sumamos a la direccion de FB la longitud de una linea (bajar de linea)
	subi $t0, $t0, BOSS_WIDTH		# Le restamos a la direccion de FB la longitud del sprite, asi regresando al principio de la linea
	j printBoss_loop_i			# Volvemos a iniciar el loop1Ai
	
printBoss_out:
	jr $ra



############################################ Imprimir pantalla de GAME OVER #####################################################

# Ya que el sprite de GameOver tiene el mismo length que FB, no necesitamos llevar un control de un salto de linea.

gameover:
	li $s6, 0
	la $t0, FB				# Cargamos la direccion del frame buffer a t0.
	la $t1, GameOver			# Cargamos la direccion del frame buffer (del sprite GameOver) a t1.
	li $t2, 0				# i = 0.
	
	#SONIDO
	li $v0, 31
	li $a0, 61
	li $a2, 0x1f
	li $a1, 300
	li $a3, 120
	syscall
	li $a0, 57
	syscall
	li $a0, 53
	syscall
	li $a0, 49
	syscall
	li $a0, 45
	li $a1, 1000
	syscall

loopGO:
	bge $t2, FB_LENGTH, Win2		# Condicion para salir de este loop i >= FB_LENGTH.
	lw $t6, ($t1)				# Cargamos el pixel del sprite GameOver a t6 apuntada por t1.
	sw $t6, ($t0)				# Guardamos el pixel en la direccion del FB apuntada por t0.
	addiu $t0, $t0, 4			# Avanzamos a la siguiente direccion de la memoria en FB y GameOver.
	addiu $t1, $t1, 4
	addiu $t2, $t2, 4			# Contador para saber cuantos bytes hemos cargado.
	j loopGO				# Repetimos el loop con nuevas direcciones recien modificadas.
	

Win:
	#SONIDO
	li $v0, 31
	li $a0, 61
	li $a2, 0x37
	li $a1, 500
	li $a3, 120
	syscall
	
	li $a0, 73
	syscall
	
	li $a0, 75
	syscall
	
	li $a0, 75
	syscall
	

	li $a0, 78
	syscall

	li $a0, 80
	syscall
	
	
	la $t0, FB				# Cargamos la direccion del frame buffer a t0.
	la $t1, YouWin				# Cargamos la direccion del frame buffer (del sprite GameOver) a t1.
	li $t2, 0
	
loopWin:
	bge $t2, FB_LENGTH, Win2		# Condicion para salir de este loop i >= FB_LENGTH.
	lw $t6, ($t1)				# Cargamos el pixel del sprite GameOver a t6 apuntada por t1.
	sw $t6, ($t0)				# Guardamos el pixel en la direccion del FB apuntada por t0.
	addiu $t0, $t0, 4			# Avanzamos a la siguiente direccion de la memoria en FB y GameOver.
	addiu $t1, $t1, 4
	addiu $t2, $t2, 4			# Contador para saber cuantos bytes hemos cargado.
	j loopWin				# Repetimos el loop con nuevas direcciones recien modificadas.
	

Win2:
	li $s0, 0				# Aseguramos que no salga la pantalla de Game Over duratne la de win.
	j printS0				# Loop.

Win3:
	li $t4, 0
	la $t5, FB
	
WinLoop:
	beq $t4, FB_LENGTH, Sprites
	sw $zero, 0($t5)
	addi $t5, $t5, 4
	addi $t4, $t4, 4
	j WinLoop
