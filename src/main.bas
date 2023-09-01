' DUNGEONS AND HEROS
' por Javi y Ada
' Agosto, 2023

' INICIALIZACION
::game_init
SYMBOL AFTER 256
CALL &BBFF: CALL &BB4E
SYMBOL AFTER 240
MODE 1: BORDER 0: INK 0,0: PAPER 0: PEN 2
DEFINT a-z
DEF FNroll(s,b)=(RND*s)+b

' MAIN LOOP
::game_main_loop
WHILE (1)
    GOSUB ::game_intro
    RANDOMIZE TIME
    GOSUB ::game_pjcreation
    hab=1
    ::game_resolve_room
    GOSUB ::game_room_content
    GOSUB ::game_play_newroom
    WHILE mon$<>"" OR obj$<>""
        GOSUB ::game_print_room
        GOSUB ::game_pj1_actions
        GOSUB ::game_pj2_actions
        IF mon$<>"" THEN GOSUB ::game_pnj_actions
        IF pg1<1 AND ac1$<>"" THEN PEN 3:PRINT "El jugador 1 muere!":ac1$="":GOSUB ::game_play_dead
        IF pg2<1 AND ac2$<>"" THEN PEN 3:PRINT "El jugador 2 muere!":ac2$="":GOSUB ::game_play_dead
        IF pgm<1 AND mon$<>"" THEN PEN 3:PRINT "El monstruo muere!":mon$="":GOSUB ::game_play_dead
        PEN 2
        GOSUB ::game_pause
        IF pg1<1 AND pg2<1 THEN GOSUB ::game_over: GOTO ::game_main_loop
    WEND
    hab=hab+1: IF hab>49 THEN GOSUB ::game_done ELSE ::game_resolve_room
WEND

   
' LOS JUGADORES GANAN
::game_done
    CLS
    PRINT "¡Muy bien heroes! habeis conseguido"
    PRINT "derrotar a todos los villanos de la"
    PRINT "mazmorra. Estais listos para nuevas"
    PRINT "aventuras."
    GOSUB ::game_press_anykey
    RETURN

' FIN DE PARTIDA
::game_over
    CLS
    PRINT "Habeis muerto durante vuestra aventura."
    PRINT "Otros aventureros tendran que ocupar"
    PRINT "vuestro lugar."
    GOSUB ::game_pause
    RETURN

' PAUSA PRESS INTRO
::game_press_anykey
    LOCATE 5,25: INPUT "Presiona INTRO para continuar",nop$
    RETURN

' PAUSA DE TIEMPO
::game_pause
    FOR i=0 TO 4000: NEXT i
    RETURN

' PANTALLA DE INICIO
::game_intro
    CLS
    LOCATE 10,5: PRINT "DUNGEONS AND HEROES"
    LOCATE 10,6: PRINT STRING$(19, "=")
    LOCATE 10,8: PRINT "Bienvenidos jugadores"
    LOCATE 7,9: PRINT "Juego creado por Javi y Ada"
    ENV 1,1,15,2,15,-1,34:ENT -1,4,3,2,4,-3,1
    SOUND 1,0,0,0,1,0,12
    SOUND 1,20,300,0,1,1,0
    SOUND 1,400,500,0,1,1,0
    GOSUB ::game_press_anykey
    RETURN

' Creacion de heroes
::game_pjcreation
    CLS
    LOCATE 9,5: PRINT "CREACION DE LOS HEROES"
    LOCATE 9,6: PRINT STRING$(22, "=")
    LOCATE 5,10: INPUT "Nombre del primer heroe: ",nom1$
    pg1=FNroll(20,5):atq1=FNroll(45,25):def1=FNroll(45,25)
    LOCATE 5,11: INPUT "Nombre del segundo heroe: ",nom2$
    pg2=FNroll(20,5):atq2=FNroll(45,25):def2=FNroll(45,25)
    LOCATE 5,13: PRINT "Este es vuestro grupo de heroes:"
    LOCATE 5,15: PRINT "HEROE 1: ";nom1$
    LOCATE 5,16: PRINT "PV:";pg1;"ATQ:";atq1;"% DEF:";def1;"%"
    LOCATE 5,18: PRINT "HEROE 2: ";nom2$
    LOCATE 5,19: PRINT "PV:";pg2;"ATQ:";atq2;"% DEF:";def2;"%"
    GOSUB ::game_pause
    RETURN

' CONTENIDO DE LA HABITACION
::game_room_content
    ocu = RND*100: mon$="": obj$="": efe$="": pgm=0: atm=0: dem=0
    if ocu>90 THEN obj$="Bebedizo":pgm=FNroll(10,1):efe$="mejora tu vida":RETURN
    if ocu>80 THEN obj$="Bebedizo":atm=FNroll(10,1):efe$="mejora tu ataque":RETURN
    if ocu>70 THEN obj$="Bebedizo":dem=FNroll(10,1):efe$="mejora tu defensa":RETURN
    if ocu>65 THEN obj$="Bebedizo":pgm=-FNroll(10,1):efe$="es un veneno!":RETURN
    if ocu>60 THEN mon$="Dragon":pgm=FNroll(15,15):atm=FNroll(50,20):dem=FNroll(20,20):RETURN
    if ocu>40 THEN mon$="Trol":pgm=FNroll(10,10):atm=FNroll(20,20):dem=FNroll(20,20):RETURN
    if ocu>30 THEN mon$="Orco":pgm=FNroll(8,8):atm=FNroll(20,20):dem=FNroll(15,20):RETURN
    if ocu>20 THEN mon$="Zombi":pgm=FNroll(5,8):atm=FNroll(15,20):dem=FNroll(10,20):RETURN
    if ocu>10 THEN mon$="Esqueleto":pgm=FNroll(5,5):atm=FNroll(20,10):dem=FNroll(10,10):RETURN
    mon$="Goblin":pgm=FNroll(2,5):atm=FNroll(10,10):dem=FNroll(5,10)
    RETURN

' MOSTRAR HABITACION
::game_print_room
    CLS
    PRINT "ESTAIS EN LA HABITACION ";hab
    PRINT
    IF pg1<1 THEN pg1=0:PEN 3 ELSE IF pg1<5 THEN PEN 1 ELSE PEN 2
    PRINT nom1$;" - PV:";pg1;"ATQ: ";atq1;"% DEF:";def1;"%"
    IF pg2<1 THEN pg2=0:PEN 3 ELSE IF pg2<5 THEN PEN 1 ELSE PEN 2
    PRINT nom2$;" - PV:";pg2;"ATQ: ";atq2;"% DEF:";def2;"%"
    PEN 2:PRINT 
    PRINT "No estais solos, hay un:"
    if mon$<>"" THEN PEN 3:PRINT mon$;" - PV:";pgm;"ATQ: ";atm;"% DEF:";dem;"%"
    if obj$<>"" THEN PEN 1:PRINT obj$;" humeante"
    PEN 2
    PRINT
    PRINT "++++++++++++"
    PRINT "+          +"
    PRINT "+   X      +"
    PRINT "        E   "
    PRINT "+   X      +"
    PRINT "+          +"
    PRINT "++++++++++++"
    PRINT
    RETURN

' ACCIONES PJ1
::game_pj1_actions
    IF pg1>0 THEN ::pj1_alive
        PRINT "El jugador 1 esta muerto":pg1=0:RETURN
    ::pj1_alive
    ac1$="": INPUT "Accion del primer heroe (a/d/b/n): ", ac1$
    if ac1$<>"a" AND ac1$<>"d" AND ac1$<>"b" THEN PRINT "No haces nada":ac1$="":RETURN
    if ac1$<>"b" THEN ::pj1_no_drink
        if obj$="" THEN PRINT "No hay nada que beber!": RETURN
        GOSUB ::game_play_drink:PEN 1:PRINT "Te tomas el bebedizo y ";efe$:PEN 2
        pg1=pg1+pgm:atq1=atq1+atm:def1=def1+dem:obj$=""
        pg1=pg1 MOD 40:atq1=atq1 MOD 90:def1=def1 MOD 90
        RETURN
    ::pj1_no_drink
    IF ac1$<>"a" THEN ::pj1_no_attack
        IF obj$<>"" THEN GOSUB ::game_play_hit:PRINT "Rompes el bebedizo":obj$="":RETURN 
        IF mon$="" THEN PRINT "No hay nada a lo que atacar!": RETURN
        IF RND*100>atq1 OR RND*100<=dem THEN ::pj1_no_hit
            GOSUB ::game_play_hit:PRINT "Golpeas al monstruo!":pgm=pgm-3: RETURN
        ::pj1_no_hit
        GOSUB ::game_play_fail:PRINT "Fallas!"
        RETURN
    ::pj1_no_attack
    PRINT "Tratas de defender"
    RETURN

' ACCIONES PJ2'
::game_pj2_actions
    IF pg2>0 THEN ::pj2_alive
        PRINT "El jugador 2 esta muerto":pg2=0:RETURN
    ::pj2_alive
    ac2$="": INPUT "Accion del segundo heroe (a/d/b/n): ", ac2$
    if ac2$<>"a" AND ac2$<>"d" AND ac2$<>"b" THEN PRINT "No haces nada":ac2$="":RETURN
    if ac2$<>"b" THEN ::pj2_no_drink
        if obj$="" THEN PRINT "No hay nada que beber!": RETURN
        GOSUB ::game_play_drink:PEN 1:PRINT "Te tomas el bebedizo y ";efe$:PEN 2
        pg2=pg2+pgm:atq2=atq2+atm:def2=def2+dem:obj$=""
        pg2=pg2 MOD 40:atq2=atq2 MOD 90:def2=def2 MOD 90
        RETURN
    ::pj2_no_drink
    if ac2$<>"a" THEN ::pj2_no_attack
        IF obj$<>"" THEN GOSUB ::game_play_hit:PRINT "Rompes el bebedizo":obj$="":RETURN 
        IF mon$="" THEN PRINT "No hay nada a lo que atacar!": RETURN
        IF RND*100>atq2 OR RND*100<=dem THEN ::pj2_no_hit
            GOSUB ::game_play_hit:PRINT "Golpeas al monstruo!":pgm=pgm-3: RETURN
        ::pj2_no_hit
        GOSUB ::game_play_fail:PRINT "Fallas!"
        RETURN
    ::pj2_no_attack    
    PRINT "Tratas de defender"
    RETURN

' ACCIONES DEL ENEMIGO
::game_pnj_actions
    IF pgm>0 THEN PRINT "El monstruo ataca y... "; ELSE RETURN
    IF RND*100>atm THEN ::pnj_no_hit
        GOSUB ::game_play_hit:PRINT "golpea!"
        IF ac1$="d" AND RND*100<=def1 THEN PRINT "Pero el jugador 1 defiende" ELSE pg1=pg1-3
        IF ac2$="d" AND RND*100<=def2 THEN PRINT "Pero el jugador 2 defiende" ELSE pg2=pg2-3
        RETURN
    ::pnj_no_hit
    GOSUB ::game_play_fail:PRINT "falla!"
    RETURN

' SONIDO FALLO
::game_play_fail
    ENV 1,20,2,1
    SOUND 1,278,40,0,1
    RETURN

' SONIDO NUEVA HABITACION
::game_play_newroom
    ENT 3,100,-2,2
    SOUND 1,142,140,15,0,3
    RETURN

' SONIDO MUERTE
::game_play_dead
    ENT 8,100,5,3
    SOUND 1,142,100,15,0,8
    RETURN

' SONIDO HIT
::game_play_hit
    ENV 4,15,1,1,15,-1,1:ENT -4,2,1,1,2,-1,1
    SOUND 1,2000,50,0,4,4,15
    RETURN

::game_play_drink
    ENV 1,5,3,3,1,-21,22,9,-3,2:ENT -1,10,2,2,5,-7,1,2,11,3,2,-4,8
    SOUND 1,19,46,12,1,1
    RETURN
