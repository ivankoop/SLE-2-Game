/*
GRUPO 104
- Jorge Giucich: CO6218
- Ivan Koop: CO6219
*/

/*
	Programa principal que crea la interface del menu
	por el cual se puede acceder al juego, a la introduccion
	o salir.

	Utilizamos la FUNCION readkey() para mover las flechas
	y para acceder a las otras subrutinas.
*/
	
	
programa juegode15

const
	blanco = 8
var 
	opciones : vector [3] cadena
	continua : logico
	opcion : numerico
	uno = 49
	dos = 50
	tres = 51

inicio
	set_color(5, 1)
	cls ()
	continua = SI
	opciones[1] = "->"
	opciones[2] = " "
	opciones[3] = ""
	mientras(continua == SI)
	{
		cls ()
		titulito()
		bordes()
		dibujo_matriz()
		imprimir("\n")
		imprimir("\n")
		imprimir("\n")
		si (opciones[1] == "->")
		{
			set_color(5, 1)
		sino
			set_color(blanco , 1)
		}
		set_curpos(11 , 12);imprimir(" INTRODUCCIÓN")
		si (opciones[2] == "->")
		{
			set_color(5, 1)
		sino
			set_color(blanco , 1)
		}
		set_curpos(15 , 12);imprimir(" JUGAR")
		si (opciones[3] == "->")
		{
			set_color(5, 1)
		sino
			set_color(blanco , 1)
		}
		set_curpos(19 , 12); imprimir(" SALIR")
		imprimir("\n")
		imprimirflechas(opciones)
		opcion = readkey()
		si (opcion == 13)
		{
			eval 
			{
				caso(opciones[1] == "->")
					cls()
					intro()
				caso(opciones[2] == "->")
					cls()
					tutorial()
					jugar()
				caso(opciones[3] == "->")
					cls()
					exit()
			}
		}
		opciones = moverflechas(opciones, opcion)
		imprimirflechas(opciones)
	}
fin

//Imprime el TITULO

sub titulito()

inicio

	set_curpos (2, 9) 
	set_color(blanco, 1)
	imprimir("EL JUEGO DE QUINCE") 
	set_color (5, 1)

fin

//Imprime las FLECHAS

sub imprimirflechas(opciones : vector [3] cadena)

inicio
	set_color(5, 1)
	set_curpos(11, 10)
	imprimir (opciones[1])
	set_curpos(15, 10)
	imprimir (opciones[2])
	set_curpos(19, 10)
	imprimir (opciones[3])
	set_color(5, 1)

fin

/*
	Estas funcion recibe un parametro que determina
	si la flechita se va a mover hacia arriba o hacia
	abajo
*/

sub moverflechas(opciones : vector [3] cadena ; opcion : numerico) retorna vector [3] cadena

inicio
	eval
	{
		caso(opcion == 61)
			opciones = moverarr(opciones)
		caso(opcion == 63)
			opciones = moveraba(opciones)
	}
	retorna (opciones)
fin

/*
	Esta subrutina utiliza la funcion swap() para cambiar
	el lugar de la flecha de acuerdo al parametro del usuario
*/

sub moverarr(o : vector [3] cadena) retorna vector [3] cadena

var
	i : numerico
inicio
	desde i = 1 hasta 3
	{
		si (i > 1)
		{
			swap (o[i] , o[i - 1])
		}
	}
	retorna (o)
fin

/*
	Esta subrutina utiliza la funcion swap() para cambiar
	el lugar de la flecha de acuerdo al parametro del usuario
*/

sub moveraba(x : vector [3] cadena) retorna vector [3] cadena

var
	i, posi : numerico
inicio
	desde i = 1 hasta 3
	{
		si (x[i] == "->")
		{
			posi = i
		}
	}
	eval
	{
		caso (posi == 1)
			swap (x[1] , x[2])
		caso (posi == 2)
			swap (x[2] , x[3])
		caso (posi == 3)
			swap (x[3] , x[1])
	}
	retorna (x)
fin

/*
	Esta subrutina recibe una cadena del usuario y controla
	su longitud y otros factores que afectarian el juego
	y decide si la cadena ingresada cumple los requisitos
	escritos en la condicion. De no ser asi se repite hasta
	encontrar una cadena que los cumpla.
*/


sub jugar ()
var
	texto : cadena
	n, i, sumaTexto, sumaiguales : numerico
	x : logico
inicio
	cls()
	repetir
		sumaTexto = 0
		cls()
		x = SI
		ingresar_texto ()
		leer (texto)			
		set_color(5, 1)
		n = strlen (texto)
		desde i = 1 hasta n	//controla la cantidad de letras que posee
		{
			si (texto[i] <> " ")
			{
				sumaTexto = sumaTexto + 1
			}
		}
		desde i = 1 hasta n - 1
		{
			si ((texto[i] == " ") and (texto[i+1] == " "))
			{
				x = NO
			}
		}
		desde i = 1 hasta n - 1
		{
			si (texto[i] == texto[i+1])
			{
				sumaiguales = sumaiguales + 1
			}
		}
		si (sumaiguales == n-1)
		{
			x = NO
		}
	hasta ((sumaTexto >= 8 and sumaTexto <= 40) and (not texto[1] == " ") and (not texto[n] == " ") and (x == SI))	//no admite ningun input que el programa no pueda utilizar
	imprimir (sumaTexto)
	fragmentar_104 (texto)
fin

/*
	Esta subrutina recibe la cadena de la subrutina jugar() y
	las divide en 8 partes.
*/ 

sub fragmentar_104 (t : cadena) 

var
	diferencia : numerico
	//vectorEspacios : vector [40] numerico
	vectorFragmentos : vector [8] cadena
	j, k, z, w, n, i,  sumaFragmentos : numerico
	completo : logico
	vectorEspacios2 : vector [*] numerico
inicio
	set_color(5, 1)
	n = strlen(t)
	k = int(n/8) 
	z = 1
	/*
	El siguiente algoritmo recibe el vector y los separa en partes diferentes, busca que no comienzen ni terminen con espacios y que no tengan mas de 5 caracteres por casilla del vector
	*/
	repetir // Crea los fragmentos con la condicion de que no tengan mas de 5 caracteres ni empiecen o terminen con un espacio en blanco.
	desde i = 1 hasta 7
	{
		si (t[z] <> " ")
		{
			vectorFragmentos[i] = substr(t, z, k)
			z = int(z + k) 
		sino si (t[z] == " ")
		
			vectorFragmentos[i] = substr(t, z + 1, k)
			z = int(z + k)
			z = z + 1
		sino si (t[strlen(t)] == " ")
		
			vectorFragmentos[i] = substr(t, z - 1, k)
			z = int(z + k)
			z = z - 1
			
		}
	}
	si (t[z] <> " ")
	{
		vectorFragmentos[8] = substr(t, z, k*100)
		
	sino si (t[z] == " ")
		vectorFragmentos[8] = substr(t, z, k*100)
	sino si (t[strlen(t)] == " ")
		vectorFragmentos[8] = substr(t, z, k*100)

	}
	desde i = 8 hasta 2 paso - 1
	{
		si (strlen(vectorFragmentos[i]) > 5)
		{
			diferencia = strlen(vectorFragmentos[i]) - 5
			vectorFragmentos[i-1] = vectorFragmentos[i-1] + substr(vectorFragmentos[i], 1, diferencia)
			vectorFragmentos[i] = substr(vectorFragmentos[i], diferencia + 1)
		}
	}
	completo = SI
	desde i = 1 hasta 8
	{
		si (vectorFragmentos[i] == "")
		{
			//completo = NO
		}
	}
	hasta (completo == SI)
	mezclarFragmentos_104(vectorFragmentos)
	//imprimir (vectorFragmentos)
fin

/*
	Esta subrutina mezcla el vector, crea una copia del original para prueba y crea una matriz mezclada. 
*/

sub mezclarFragmentos_104(vector_Fragmentos : vector [8] cadena)

var
	vectorMezclar : vector [9] cadena
	matrizMezclada, matrizOrdenada : matriz [3, 3] cadena
	i, x : numerico
inicio
	set_color(5, 1)
	cls()
	desde i = 1 hasta 8
	{
		vectorMezclar[i] = vector_Fragmentos[i]
	}
	vectorMezclar[9] = " "
	
	matrizOrdenada[1,1] = vector_Fragmentos[1]
	matrizOrdenada[1,2] = vector_Fragmentos[2]
	matrizOrdenada[1,3] = vector_Fragmentos[3]
	matrizOrdenada[2,1] = vector_Fragmentos[4]
	matrizOrdenada[2,2] = vector_Fragmentos[5]
	matrizOrdenada[2,3] = vector_Fragmentos[6]
	matrizOrdenada[3,1] = vector_Fragmentos[7]
	matrizOrdenada[3,2] = vector_Fragmentos[8]
	matrizOrdenada[3,3] = " "

	x = random (5) + 1
	eval
	{
		caso (x == 1)
			swap(vectorMezclar[8] , vectorMezclar[9])
			swap(vectorMezclar[5] , vectorMezclar[8])
			swap(vectorMezclar[2] , vectorMezclar[5])
			swap(vectorMezclar[3] , vectorMezclar[2])
			swap(vectorMezclar[6] , vectorMezclar[3])
			swap(vectorMezclar[9] , vectorMezclar[6])
		caso (x == 2)
			swap(vectorMezclar[8] , vectorMezclar[9])
			swap(vectorMezclar[7] , vectorMezclar[8])
			swap(vectorMezclar[4] , vectorMezclar[7])
			swap(vectorMezclar[5] , vectorMezclar[4])
			swap(vectorMezclar[8] , vectorMezclar[5])
			swap(vectorMezclar[9] , vectorMezclar[8])
			swap(vectorMezclar[6] , vectorMezclar[9])
			swap(vectorMezclar[3] , vectorMezclar[6])
			swap(vectorMezclar[5] , vectorMezclar[3])
			swap(vectorMezclar[4] , vectorMezclar[5])
			swap(vectorMezclar[1] , vectorMezclar[4])
			swap(vectorMezclar[2] , vectorMezclar[1])
			swap(vectorMezclar[5] , vectorMezclar[2])
			swap(vectorMezclar[8] , vectorMezclar[5])
			swap(vectorMezclar[9] , vectorMezclar[8])
		caso (x == 3)
			swap(vectorMezclar[6] , vectorMezclar[9])
			swap(vectorMezclar[5] , vectorMezclar[6])
			swap(vectorMezclar[2] , vectorMezclar[5])
			swap(vectorMezclar[1] , vectorMezclar[2])
			swap(vectorMezclar[4] , vectorMezclar[1])
			swap(vectorMezclar[7] , vectorMezclar[4])
			swap(vectorMezclar[8] , vectorMezclar[7])
			swap(vectorMezclar[9] , vectorMezclar[8])
		caso (x == 4)
			swap(vectorMezclar[6] , vectorMezclar[9])
			swap(vectorMezclar[5] , vectorMezclar[6])
			swap(vectorMezclar[4] , vectorMezclar[5])
			swap(vectorMezclar[1] , vectorMezclar[4])
			swap(vectorMezclar[2] , vectorMezclar[1])
			swap(vectorMezclar[5] , vectorMezclar[2])
			swap(vectorMezclar[8] , vectorMezclar[5])
			swap(vectorMezclar[9] , vectorMezclar[8])
		caso (x == 5)
			swap(vectorMezclar[8] , vectorMezclar[9])
			swap(vectorMezclar[7] , vectorMezclar[8])
			swap(vectorMezclar[4] , vectorMezclar[7])
			swap(vectorMezclar[1] , vectorMezclar[4])
			swap(vectorMezclar[2] , vectorMezclar[1])
			swap(vectorMezclar[5] , vectorMezclar[2])
			swap(vectorMezclar[8] , vectorMezclar[5])
			swap(vectorMezclar[9] , vectorMezclar[8])
	}
	matrizMezclada[1, 1] = vectorMezclar[1]
	matrizMezclada[1, 2] = vectorMezclar[2]
	matrizMezclada[1, 3] = vectorMezclar[3]
	matrizMezclada[2, 1] = vectorMezclar[4]
	matrizMezclada[2, 2] = vectorMezclar[5]
	matrizMezclada[2, 3] = vectorMezclar[6]
	matrizMezclada[3, 1] = vectorMezclar[7]
	matrizMezclada[3, 2] = vectorMezclar[8]
	matrizMezclada[3, 3] = vectorMezclar[9]

	jugarMatriz(matrizMezclada, matrizOrdenada)
fin

/*
	Esta subrutina contiene el juego y permite realizar los movimientos
	utilizando las flechitas del teclado. Termina cuando los movimientos
	llegan a 100 o se ordene la matriz.
*/

sub jugarMatriz (m, m2 : matriz [3, 3] cadena)

var
	j : numerico
	o, c, movimientosRestantes : numerico
	x, y : matriz [3, 3] cadena
inicio
	set_color(5, 1)
	cls()
	mostrarmatriz_104(m, 0)
	x = m
	movimientosRestantes = 0
	mientras (iguales_104(x, m2) == SI)
	{
		set_color(5, 1)
		o = readkey()
		y = x
		x = mover (o, x)
		c = c + controlarmovimientos(y, x)
		set_color(5, 1)
		mostrarmatriz_104(x, c)
		si (c == 100)
		{
			cls()
			perdiste(m2)
		}
	}
	cls()
	ganaste(c ,m2)
fin

/*
	Esta subrutina recibe la direccion en la cual moveremos la casilla vacia.
*/

sub mover (x : numerico ; m : matriz [3, 3] cadena) retorna matriz [3, 3] cadena

const
	arriba = 61
	abajo = 63
	derecha = 62
	izquierda = 60

var
	i, j : numerico
	z : matriz [3, 3] cadena
inicio
	z = m
	eval 
	{
		caso (x == arriba)
			z = movarriba(z)
		caso (x == abajo)
			z = movabajo(z)
		caso (x == derecha)
			z = movderecha(z)
		caso (x == izquierda)
			z = movizquierda(z)
		}
	retorna(z)
fin

// Mueve la casilla hacia ARRIBA.

sub movarriba(mat : matriz [3, 3] cadena) retorna matriz [3, 3] cadena

var
	i, j : numerico
inicio
	desde i = 1 hasta 3
	{
		desde j = 1 hasta 3
		{
			si (mat[i,j] == " ")
			{
				si (i > 1)
				{
					swap (mat[i,j], mat[i-1,j])
					salir
				}
			}
		}
	}
	retorna (mat)
fin

// Mueve la casilla hacia ABAJO.

sub movabajo(mat : matriz [3, 3] cadena) retorna matriz [3, 3] cadena

var
	i, j : numerico
	posi, posj : numerico
	sepuede : logico
inicio
	desde i = 1 hasta 3
	{
		desde j = 1 hasta 3
		{
			
			si (mat[i,j] == " ")
			{
				si (i < 3)
				{
					posi = i
					posj = j
					sepuede = SI
					salir
				}
			}
		}
	}
	si (sepuede == SI)
	{
		swap (mat[posi, posj], mat[posi + 1, posj])
	}
	retorna (mat)
fin

// Mueve la casilla hacia la DERECHA

sub movderecha(mat : matriz [3, 3] cadena) retorna matriz [3, 3] cadena
var
	i, j : numerico
	posi, posj : numerico
	sepuede : logico
inicio
	desde i = 1 hasta 3
	{
		desde j = 1 hasta 3
		{
			si (mat[i,j] == " ")
			{
				si (j < 3)
				{
					posi = i
					posj = j
					sepuede = SI
					salir
				}
			}
		}
	}
	si (sepuede == SI)
	{
		swap (mat[posi, posj], mat[posi, posj + 1])
	}
	retorna (mat)
fin

// Mueve la casilla hacia la IZQUIERDA.

sub movizquierda(mat : matriz [3, 3] cadena) retorna matriz [3, 3] cadena
var
	i, j : numerico
	posi, posj : numerico
	sepuede : logico
inicio
	desde i = 1 hasta 3
	{
		desde j = 1 hasta 3
		{
			si (mat[i,j] == " ")
			{
				si (j > 1)
				{
					posi = i
					posj = j
					sepuede = SI
					salir
				}
			}
		}
	}
	si (sepuede == SI)
	{
		swap (mat[posi, posj], mat[posi, posj - 1])
	}
	retorna (mat)
fin


//imprimie una matriz en una estructura mas arreglada


sub mostrarmatriz_104 (mat : matriz [3, 3] cadena ; c : numerico)
	
var
	i, j : numerico
inicio
	cuadrito_feche()
	dibujo_movimientos ()
	set_color(5 , 1)
	set_curpos(12 , 26);imprimir(mat[1,1])
	set_color(5, 1)
	set_curpos(12 , 35);imprimir (mat[1,2])
	set_color(5, 1)
	set_curpos(12 , 44);imprimir (mat[1,3])
	set_color(5, 1)
	set_curpos(16 , 26);imprimir (mat[2,1])
	set_color(5, 1)
	set_curpos(16 , 35);imprimir (mat[2,2])
	set_color(5, 1)
	set_curpos(16 , 44);imprimir (mat[2,3])
	set_color(5, 1)
	set_curpos(20 , 26);imprimir (mat[3,1])
	set_color(5, 1)
	set_curpos(20 , 35);imprimir (mat[3,2])
	set_color(5, 1)
	set_curpos(20 , 44);imprimir (mat[3,3])
	imprimircontador(c)
	
	
fin

// Imprime le contador de movimientos.

sub imprimircontador(c: numerico)

inicio
	set_color(5, 1)
	set_curpos(8 , 37)
	imprimir (c)
fin

//controla que la matriz original y la matriz que se esta alterando durante el juego sean iguales o diferentes
sub iguales_104 (x, y : matriz [3, 3] cadena) retorna logico

var
	i, j, s : numerico
	log : logico
inicio
	desde i = 1 hasta 3
	{
		desde j = 1 hasta 3
		{
			si (x[i,j] == y[i,j])
			{
				s = s + 1
			}
		}
	}
	si (s == 9)
	{
		log = NO
	sino
		log = SI
	}
	retorna (log)
fin

// Muestra una pantalla con los creditos del juego.

subrutina creditos ()


var x, b: numerico
	a = 3

inicio
	set_color(5 , 1)
	cls ()
imprimir("\t    __   _                                 _    _ ___ ")
imprimir("\n" ,"\t  /  ` //                           /    //    //  ") 
imprimir("\n" ,"\t /--  //       o . . _  _,  __   __/ _  //    /'--.") 
imprimir("\n" ,"\t(___,</_      /_(_/_</_(_)_(_)  (_/_</_</_   / ___)") 
imprimir("\n" ,"\t            /          /|                         ") 
imprimir("\n" ,"\t          -'          |/  ")
	b = 5
	set_color(b , 1)
	imprimir("\n")
	imprimir("\n")
	imprimir("\n" , "\t" , "\tLead Developer:" )
	b = 10
	set_color(b , 1)
	imprimir("\tJorge Giucich")
	imprimir("\n")
	b = 5
	set_color(b , 1)
	imprimir("\n" , "\t" , "\tDeveloper & Design:")
	b = 10
	set_color(b , 1)
	imprimir(" " , "Ivan Koop")
	imprimir("\n")
	b = 5
	set_color(b , 1)
	imprimir("\n" , "\t" , "\tProfesor:")
	b = 10
	set_color(b , 1)
	imprimir(" " , "Carlos Filippi")
	imprimir("\n")
	b = 5
	set_color(b , 1)
	imprimir("\n" , "\t" , "\tUniversidad:")
	b = 10
	set_color(b , 1)
	imprimir(" " , "Catolica Nuestra Señora de la Asunción")
	imprimir("\n")
	imprimir("\n")
	imprimir("\n")
	b = 10
	set_color(b , 1)
	imprimir("\n", "\t" , "\t" , "\t__   _       ")
	imprimir("\n", "\t" , "\t" , "\t _) / \ /| |_|	")
	imprimir("\n", "\t" , "\t" , "\t/__ \_/  |   |	")
	imprimir("\n")
	imprimir("\n")
	b = 5
	set_color(b , 1)
	demo()
fin

// Termina el juego.

subrutina exit ()
inicio
continua = NO
creditos()
cls()
terminar()
fin

// Muestra una pantalla con la introduccion del juego.

subrutina intro ()
inicio
set_color(5 , 1)
imprimir("\nBIENVENIDOS AL JUEGO DEL 15")
imprimir("\n")
set_color(blanco , 1)
imprimir("\nEl juego del 15 es una cajita formada") 
imprimir("\npor 16 casillas de las cuáles sólo 15 están ocupadas.") 
imprimir("\nEl juego consiste en maniobrar todas las fichas para corregir") 
imprimir("\nel error que hay en la fila inferior de la cajita,") 
imprimir("\nde manera que todas las fichas queden en orden consecutivo.")
imprimir("\n")
set_color(5 , 1)
imprimir("\nHISTORIA:")
set_color(blanco , 1)
imprimir("\nEl juego ha sido durante mucho tiempo atribuido a Samuel Loyd") 
imprimir("\nen Estados Unidos a fines de la década de 1870. Sin embargo,")  
imprimir("\nhay fuentes que dicen que su verdadero autor fue Noyes Palmer Chapman.") 
imprimir("\n")
set_color(5 , 1)
imprimir("\nVERSION UCA")
set_color(blanco , 1)
imprimir("\nEn la version UCA el juego sigue las reglas del juego del 15,")
imprimir("\nsolo que hubieron unos cambios extras para mejorar la idea.")
imprimir("\nEn la version UCA el juego ultiliza datos alfanumericos,")
imprimir("\nsolo cuenta con 9 casillas las cuales 8 estan ocupadas.")
demo()
cls ()

fin

// Despliega una marquesina.

sub desplegar_marquesina (mag: cadena; ancho_vent : numerico
									ref col_actual : numerico)

var
	parte_mag : cadena
	len_mag = strlen (mag)
const
	LINEA_marq = 24
inicio
	si (col_actual > 0)
	{
		set_curpos (LINEA_marq, col_actual)
		parte_mag= substr (mag, 1, ancho_vent-col_actual+1)
	sino
		set_curpos (LINEA_marq, 1)
		si (col_actual == 0)
		{
			col_actual = -2
		}
		parte_mag = substr (mag, -col_actual)
	}

	set_color (3 , 1)
	imprimir (parte_mag)
	imprimir (' ')

	si (col_actual < -len_mag)
	{
		col_actual = ancho_vent + 1
	}
	dec (col_actual)
fin

// Mueve la marquesina.

sub demo()
var
	marq_mag = "Presione <enter> para continuar"
	marg_ancho_ventana = 80
	marg_col_actual = marg_ancho_ventana
inicio
	repetir
	desplegar_marquesina (marq_mag, marg_ancho_ventana, marg_col_actual)
	hasta (readkey(100) == 13)
fin

// Crea un cuadro para el juego principal.

sub cuadrito_feche()
inicio
	cls()
	set_color(10 , 1)
	set_curpos(10 , 24)
	imprimir("#########")
	set_curpos(11 , 24);imprimir("#")
	set_curpos(12 , 24);imprimir("#")
	set_curpos(11 , 33);imprimir("#")
	set_curpos(12 , 33);imprimir("#")
	set_curpos(13 , 33);imprimir("#")
	set_curpos(13 , 24);imprimir("#")
	set_curpos(14 , 24);imprimir("#########")

	set_curpos(15 , 24);imprimir("#")
	set_curpos(16 , 24);imprimir("#")
	set_curpos(15 , 33);imprimir("#")
	set_curpos(16 , 33);imprimir("#")
	set_curpos(17 , 33);imprimir("#")
	set_curpos(17 , 24);imprimir("#")
	set_curpos(18 , 24);imprimir("#########")
	
	set_curpos(19 , 24);imprimir("#")
	set_curpos(20 , 24);imprimir("#")
	set_curpos(19 , 33);imprimir("#")
	set_curpos(20 , 33);imprimir("#")
	set_curpos(21 , 33);imprimir("#")
	set_curpos(21 , 24);imprimir("#")
	set_curpos(22 , 24);imprimir("#########")
	
	
	set_curpos(10 , 33)
	imprimir("#########")
	set_curpos(11 , 42);imprimir("#")
	set_curpos(12 , 42);imprimir("#")
	set_curpos(13 , 42);imprimir("#")
	set_curpos(14 , 33);imprimir("#########")

	set_curpos(15 , 42);imprimir("#")
	set_curpos(16 , 42);imprimir("#")
	set_curpos(17 , 42);imprimir("#")
	set_curpos(18 , 33);imprimir("#########")
	
	set_curpos(19 , 42);imprimir("#")
	set_curpos(20 , 42);imprimir("#")
	set_curpos(21 , 42);imprimir("#")
	set_curpos(22 , 33);imprimir("#########")

	
	set_curpos(10 , 42)
	imprimir("##########")
	set_curpos(11 , 51);imprimir("#")
	set_curpos(12 , 51);imprimir("#")
	set_curpos(13 , 51);imprimir("#")
	set_curpos(14 , 42);imprimir("##########")

	set_curpos(15 , 51);imprimir("#")
	set_curpos(16 , 51);imprimir("#")
	set_curpos(17 , 51);imprimir("#")
	set_curpos(18 , 42);imprimir("##########")
	
	set_curpos(19 , 51);imprimir("#")
	set_curpos(20 , 51);imprimir("#")
	set_curpos(21 , 51);imprimir("#")
	set_curpos(22 , 42);imprimir("##########")
	set_color(5 , 1)
fin

// Dibuja una matriz que aparece en el menu principal.

sub dibujo_matriz()

inicio
	set_color(5 , 1)
	set_curpos(9 , 42);imprimir("#########################")
	set_curpos(10 , 42);imprimir("#       #       #       #")
	set_curpos(11 , 42);imprimir("# GRU   # PO    # 104   #")      
	set_curpos(12 , 42);imprimir("#       #       #       #")
	set_curpos(13 , 42);imprimir("#########################")
	set_curpos(14 , 42);imprimir("#       #       #       #")
	set_curpos(15 , 42);imprimir("# JORGE # GIU   # CICH  #")	 		
	set_curpos(16 , 42);imprimir("#       #       #       #")
	set_curpos(17 , 42);imprimir("#########################")
	set_curpos(18 , 42);imprimir("#       #       #       #")
	set_curpos(19 , 42);imprimir("# IVAN  # KOOP  #       #")	 			
	set_curpos(20 , 42);imprimir("#       #       #       #")
	set_curpos(21 , 42);imprimir("#########################")
	
fin

// Imprime la palabra MOVIMIENTOS,

sub dibujo_movimientos ()
inicio
	set_color(5 , 1)
	set_curpos(8 , 24);imprimir("MOVIMIENTOS:")
	set_color(5 , 1)
fin

// Crea bordes para el menu principal.

sub bordes()
inicio
	set_color(5, 1)
	set_curpos(4,1); imprimir(strdup("#",80))
	
	set_curpos(1,75);imprimir("#")	
	
	set_curpos(2,75);imprimir("#")

	set_curpos(3,75);imprimir("#")
	
	set_curpos(4,75);imprimir("#")
	
	set_curpos(5,75);imprimir("#")
	
	set_curpos(6,75);imprimir("#")
	
	set_curpos(7,75);imprimir("#")
	
	set_curpos(8,75);imprimir("#")
	
	set_curpos(9,75);imprimir("#")

	set_curpos(10,75);imprimir("#")
	
	set_curpos(11,75);imprimir("#")
	
	set_curpos(12,75);imprimir("#")
	
	set_curpos(13,75);imprimir("#")
	
	set_curpos(14,75);imprimir("#")
	
	set_curpos(15,75);imprimir("#")
	
	set_curpos(16,75);imprimir("#")

	set_curpos(17,75);imprimir("#")
	
	set_curpos(18,75);imprimir("#")
	
	set_curpos(19,75);imprimir("#")
	
	set_curpos(20,75);imprimir("#")
	
	set_curpos(21,75);imprimir("#")
	
	set_curpos(22,75);imprimir("#")
	
	set_curpos(23,75);imprimir("#")
	
	set_curpos(24,75);imprimir("#")
	
	set_curpos(25,75);imprimir("#")
	
fin

// Crea una estructura visual donde se imprime 	INGRESE EL TEXTO.

sub ingresar_texto ()
inicio
	set_color(10 , 1)
	set_curpos(3,1);imprimir("El texto no debe tener doble espacio, tampoco espacio al comienzo ni al final.")
	set_curpos(2,1);imprimir("El texto debe tener entre 8 y 40 caracteres.")
	set_color(5 , 1)
	set_curpos(5,1); imprimir(strdup("=",80))
	set_curpos(7,1); imprimir(strdup("=",80))
	set_color(10 ,1)
	set_curpos(6,30); imprimir("INGRESE EL TEXTO")
	set_color(5, 1)
	imprimir("\n")
	imprimir("\n")

fin

// Cuenta los movimientos que realiza el jugador.

sub controlarmovimientos(x, y : matriz [3, 3] cadena) retorna numerico

var
	contar, i, j : numerico
inicio
	desde i = 1 hasta 3
	{
		desde j = 1 hasta 3
		{
			si (x[i,j] == y[i,j])
			{
				contar = contar + 1
			}
		}
	}
	si (contar <> 9)
	{
		contar = 1
	sino
		contar = 0
	}
	retorna (contar)
fin

// Despliega una pantalla de victoria.

sub ganaste(c : numerico ; x : matriz[3,3]cadena)

var
	cc : logico
	opciones : vector[2]cadena
	m : numerico
inicio
	cc = SI
	cls ()
	opciones[1] = "->"
	opciones[2] = " "
	mientras (cc == SI)
	{
		cls()
		imprimir("\n $$$$$$\   $$$$$$\  $$\   $$\   $$$$$$\   $$$$$$\ $$$$$$$$\ $$$$$$$$\ ")      
		imprimir("\n$$  __$$\ $$  __$$\ $$$\  $$ |$$  __$$\  $$  _$$\\__$$  __$$  _____|")      
		imprimir("\n$$ /  \__|$$ /  $$ $$$$\ $$ |$$ /  $$ |$$ /  \__| $$ |  $$ |      ")      
		imprimir("\n$$ |$$$$\ $$$$$$$$ $$ $$\$$ |$$$$$$$$ |\$$$$$$\    $$ |  $$$$$\    ")      
		imprimir("\n$$ |\_ $$ $$  __$$ $$ \$$$$ |$$  __$$ | \____$$\   $$ |  $$  __|   ")      
		imprimir("\n$$ |  $$ $$ |  $$ $$ |\$$$ |$$ |  $$ |$$\   $$ | $$ |  $$ |      ")      
		imprimir("\n\$$$$$$  |$$ |  $$ $$ | \$$ |$$ |  $$ |\$$$$$$  | $$ |  $$$$$$$$\ ")
		imprimir("\n")
		imprimir("\nCANTIDAD DE MOVIMIENTOS:" , c)
		cuadrito_feche2(x)
		mostrarmatriz2(x)
		si (opciones[1] == "->")
		{
			set_color(5, 1)
		sino
			set_color(blanco , 1)
		}
		set_curpos(15, 4)
		imprimir ("Jugar de nuevo")
		si (opciones[2] == "->")
		{
			set_color(5, 1)
		sino
			set_color(blanco , 1)
		}
		set_curpos (20, 4)
		imprimir ("Salir")
		flechita (opciones)
		m = readkey()
		si (m == 13)
		{
			si (opciones[1] == "->")
			{
				jugar()
			sino
				cls()
				exit()
			}
		}
		opciones = moverflechita(m, opciones)
		flechita (opciones)
	}
fin

// Despliega una pantalla de derrota.

sub perdiste(x : matriz[3,3] cadena)

var
	m : numerico
	c : logico
	opciones : vector[2]cadena
inicio
	c = SI
	cls ()
	opciones[1] = "->"
	opciones[2] = " "
	mientras (c == SI)
	{
		cls ()
		imprimir("\n$$$$$$$\  $$$$$$$$\  $$$$$$$\   $$$$$$$\   $$$$$$\  $$$$$$\  $$$$$$$$\  $$$$$$$$\ ")
		imprimir("\n$$  __$$\ $$  _____|$$  __$$\  $$  __$$\ \_  $$  _|$$  _$$\\__ $$  __|$$  _____|")
		imprimir("\n$$ |  $$ $$ |      $$ |  $$ |$$ |  $$ |  $$ |  $$ /  \__|  $$ |   $$ |      ")
		imprimir("\n$$$$$$$  $$$$$\     $$$$$$$  |$$ |  $$ |  $$ |  \$$$$$$\     $$ |   $$$$$\    ")
		imprimir("\n$$  ____/$$  __|   $$  __$$< $$ |  $$ |  $$ |   \____$$\    $$ |   $$  __|   ")
		imprimir("\n$$ |     $$ |      $$ |  $$ |$$ |  $$ |  $$ |  $$\   $$ |  $$ |   $$ |      ")
		imprimir("\n$$ |     $$$$$$$$\  $$ |  $$ |$$$$$$$  |$$$$$$\ \ $$$$$$  |  $$ |   $$$$$$$$\ ")
		set_curpos(10 , 24);imprimir("LA MATRIZ ORIGINAL ERA:")
		cuadrito_feche2(x)
		mostrarmatriz2(x)
		si (opciones[1] == "->")
		{
			set_color(5, 1)
		sino
			set_color(blanco , 1)
		}
		set_curpos(15, 5)
		imprimir ("Jugar de nuevo")
		si (opciones[2] == "->")
		{
			set_color(5, 1)
		sino
			set_color(blanco , 1)
		}
		set_curpos (20, 5)
		imprimir ("Salir")
		flechita (opciones)
		m = readkey()
		si (m == 13)
		{
			si (opciones[1] == "->")
			{
				jugar()
			sino
				cls()
				exit()
			}
		}
		opciones = moverflechita(m, opciones)
		flechita (opciones)
	}
fin

// Crea un cuadro para la subrutina perdiste().

sub cuadrito_feche2(x : matriz [3,3] cadena)
inicio
	set_color(10 , 1)
	set_curpos(12 , 24)
	imprimir("#########")
	set_curpos(13 , 24);imprimir("#")
	set_curpos(14 , 24);imprimir("#")
	set_curpos(13 , 33);imprimir("#")
	set_curpos(14 , 33);imprimir("#")
	set_curpos(15 , 33);imprimir("#")
	set_curpos(15 , 24);imprimir("#")
	set_curpos(16 , 24);imprimir("#########")

	set_curpos(17 , 24);imprimir("#")
	set_curpos(18 , 24);imprimir("#")
	set_curpos(17 , 33);imprimir("#")
	set_curpos(18 , 33);imprimir("#")
	set_curpos(19 , 33);imprimir("#")
	set_curpos(19 , 24);imprimir("#")
	set_curpos(20 , 24);imprimir("#########")
	
	set_curpos(21 , 24);imprimir("#")
	set_curpos(22 , 24);imprimir("#")
	set_curpos(21 , 33);imprimir("#")
	set_curpos(22 , 33);imprimir("#")
	set_curpos(23 , 33);imprimir("#")
	set_curpos(23 , 24);imprimir("#")
	set_curpos(24 , 24);imprimir("#########")
	
	
	set_curpos(12 , 33)
	imprimir("#########")
	set_curpos(13 , 42);imprimir("#")
	set_curpos(14 , 42);imprimir("#")
	set_curpos(15 , 42);imprimir("#")
	set_curpos(16 , 33);imprimir("#########")

	set_curpos(17 , 42);imprimir("#")
	set_curpos(18 , 42);imprimir("#")
	set_curpos(19 , 42);imprimir("#")
	set_curpos(20 , 33);imprimir("#########")
	
	set_curpos(21 , 42);imprimir("#")
	set_curpos(22 , 42);imprimir("#")
	set_curpos(23 , 42);imprimir("#")
	set_curpos(24 , 33);imprimir("#########")

	
	set_curpos(12 , 42)
	imprimir("##########")
	set_curpos(13 , 51);imprimir("#")
	set_curpos(14 , 51);imprimir("#")
	set_curpos(15 , 51);imprimir("#")
	set_curpos(16 , 42);imprimir("##########")

	set_curpos(17 , 51);imprimir("#")
	set_curpos(18 , 51);imprimir("#")
	set_curpos(19 , 51);imprimir("#")
	set_curpos(20 , 42);imprimir("##########")
	
	set_curpos(21 , 51);imprimir("#")
	set_curpos(22 , 51);imprimir("#")
	set_curpos(23 , 51);imprimir("#")
	set_curpos(24 , 42);imprimir("##########")
	set_color(5 , 1)
	mostrarmatriz2(x)
fin

// Muestra la matriz original en la subrutina perdiste().

sub mostrarmatriz2 (m2: matriz [3, 3] cadena)

inicio

	set_curpos(14 , 26);imprimir (m2[1,1])
	set_curpos(14 , 35);imprimir (m2[1,2])
	set_curpos(14 , 44);imprimir (m2[1,3])
	set_curpos(18 , 26);imprimir (m2[2,1])
	set_curpos(18 , 35);imprimir (m2[2,2])
	set_curpos(18 , 44);imprimir (m2[2,3])
	set_curpos(22 , 26);imprimir (m2[3,1])
	set_curpos(22 , 35);imprimir (m2[3,2])
	set_curpos(22 , 44);imprimir (m2[3,3])
fin

// Imprime las flechitas de la subrutina ganaste().

sub flechita(opciones : vector [2] cadena)

inicio
	set_color(5, 1)
	set_curpos(15, 1)
	imprimir (opciones[1])
	set_curpos(20, 1)
	imprimir (opciones[2])
fin

// Mueve la flechita en la subrutina ganaste().

sub moverflechita (m : numerico ; o : vector [2] cadena) retorna vector [2] cadena

inicio
	si ((m == 61) or (m == 63))
	{
		swap (o[1], o[2])
	}
	retorna (o)
fin

// Enseña como jugar el juego.

sub tutorial ()

inicio
	set_color(5 , 1)
	imprimir("\n")
	set_curpos(4 , 25);imprimir("MOVIMIENTO:")
	set_color(10 , 1)
	set_curpos(5 , 21);imprimir("Utilizando el cursor")
	set_color(5 , 1)
	set_curpos(4 , 55);imprimir("OBJETIVO:")
	set_color(10 , 1)
	set_curpos(5 , 50);imprimir("Ordenar las frases")
	set_curpos(8 , 1);imprimir("		           ----- 			")
	set_curpos(9 , 1);imprimir("			  |  ^  |			")
	set_curpos(10 , 1);imprimir("			  |  |  |			")
	set_curpos(11 , 1);imprimir("			  |  |  |			")
	set_curpos(12 , 1);imprimir("		     ----- ----- -----		")
	set_curpos(13 , 1);imprimir("	            |	  |  |  |     |	")
	set_curpos(14 , 1);imprimir("	            |<--- |  |  | --->|	")
	set_curpos(15 , 1);imprimir("                    |	  |  v  |     |	")
	set_curpos(16 , 1);imprimir("		     ----- ----- -----  	")
	set_curpos(10 , 55);imprimir(" -- -- --")
	set_curpos(11 , 55);imprimir("| e| x| i|")
	set_curpos(12 , 55);imprimir(" -- -- -- ")
	set_curpos(13 , 55);imprimir("| g| e| n|")
	set_curpos(14 , 55);imprimir(" -- -- -- ")
	set_curpos(15 , 55);imprimir("| t| e|  |")
	set_curpos(16 , 55);imprimir(" -- -- -- ")
	set_color(5 , 1)
	set_curpos(20 , 8);imprimir("SOLO PUEDES HACER HASTA 100 MOVIMIENTOS")
	demo()
	cls ()
	jugar()
fin 




































































































































































