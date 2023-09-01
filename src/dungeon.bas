10 SYMBOL AFTER 256
20 CALL &BBFF: CALL &BB4E
30 SYMBOL AFTER 240
40 MODE 1: BORDER 0: INK 0,0: PAPER 0: PEN 2
50 DEFINT a-z
60 DEF FNroll(s,b)=(RND*s)+b
70 WHILE (1)
80 GOSUB 450
90 RANDOMIZE TIME
100 GOSUB 560
110 hab=1
120 GOSUB 700
130 GOSUB 1530
140 WHILE mon$<>"" OR obj$<>""
150 GOSUB 820
160 GOSUB 1040
170 GOSUB 1230
180 IF mon$<>"" THEN GOSUB 1420
190 IF pg1<1 AND ac1$<>"" THEN PEN 3:PRINT "El jugador 1 muere!":ac1$="":GOSUB 1560
200 IF pg2<1 AND ac2$<>"" THEN PEN 3:PRINT "El jugador 2 muere!":ac2$="":GOSUB 1560
210 IF pgm<1 AND mon$<>"" THEN PEN 3:PRINT "El monstruo muere!":mon$="":GOSUB 1560
220 PEN 2
230 GOSUB 430
240 IF pg1<1 AND pg2<1 THEN GOSUB 350: GOTO 70
250 WEND
260 hab=hab+1: IF hab>49 THEN GOSUB 280 ELSE 120
270 WEND
280 CLS
290 PRINT "¡Muy bien heroes! habeis conseguido"
300 PRINT "derrotar a todos los villanos de la"
310 PRINT "mazmorra. Estais listos para nuevas"
320 PRINT "aventuras."
330 GOSUB 410
340 RETURN
350 CLS
360 PRINT "Habeis muerto durante vuestra aventura."
370 PRINT "Otros aventureros tendran que ocupar"
380 PRINT "vuestro lugar."
390 GOSUB 430
400 RETURN
410 LOCATE 5,25: INPUT "Presiona INTRO para continuar",nop$
420 RETURN
430 FOR i=0 TO 4000: NEXT i
440 RETURN
450 CLS
460 LOCATE 10,5: PRINT "DUNGEONS AND HEROES"
470 LOCATE 10,6: PRINT STRING$(19, "=")
480 LOCATE 10,8: PRINT "Bienvenidos jugadores"
490 LOCATE 7,9: PRINT "Juego creado por Javi y Ada"
500 ENV 1,1,15,2,15,-1,34:ENT -1,4,3,2,4,-3,1
510 SOUND 1,0,0,0,1,0,12
520 SOUND 1,20,300,0,1,1,0
530 SOUND 1,400,500,0,1,1,0
540 GOSUB 410
550 RETURN
560 CLS
570 LOCATE 9,5: PRINT "CREACION DE LOS HEROES"
580 LOCATE 9,6: PRINT STRING$(22, "=")
590 LOCATE 5,10: INPUT "Nombre del primer heroe: ",nom1$
600 pg1=FNroll(20,5):atq1=FNroll(45,25):def1=FNroll(45,25)
610 LOCATE 5,11: INPUT "Nombre del segundo heroe: ",nom2$
620 pg2=FNroll(20,5):atq2=FNroll(45,25):def2=FNroll(45,25)
630 LOCATE 5,13: PRINT "Este es vuestro grupo de heroes:"
640 LOCATE 5,15: PRINT "HEROE 1: ";nom1$
650 LOCATE 5,16: PRINT "PV:";pg1;"ATQ:";atq1;"% DEF:";def1;"%"
660 LOCATE 5,18: PRINT "HEROE 2: ";nom2$
670 LOCATE 5,19: PRINT "PV:";pg2;"ATQ:";atq2;"% DEF:";def2;"%"
680 GOSUB 430
690 RETURN
700 ocu = RND*100: mon$="": obj$="": efe$="": pgm=0: atm=0: dem=0
710 if ocu>90 THEN obj$="Bebedizo":pgm=FNroll(10,1):efe$="mejora tu vida":RETURN
720 if ocu>80 THEN obj$="Bebedizo":atm=FNroll(10,1):efe$="mejora tu ataque":RETURN
730 if ocu>70 THEN obj$="Bebedizo":dem=FNroll(10,1):efe$="mejora tu defensa":RETURN
740 if ocu>65 THEN obj$="Bebedizo":pgm=-FNroll(10,1):efe$="es un veneno!":RETURN
750 if ocu>60 THEN mon$="Dragon":pgm=FNroll(15,15):atm=FNroll(50,20):dem=FNroll(20,20):RETURN
760 if ocu>40 THEN mon$="Trol":pgm=FNroll(10,10):atm=FNroll(20,20):dem=FNroll(20,20):RETURN
770 if ocu>30 THEN mon$="Orco":pgm=FNroll(8,8):atm=FNroll(20,20):dem=FNroll(15,20):RETURN
780 if ocu>20 THEN mon$="Zombi":pgm=FNroll(5,8):atm=FNroll(15,20):dem=FNroll(10,20):RETURN
790 if ocu>10 THEN mon$="Esqueleto":pgm=FNroll(5,5):atm=FNroll(20,10):dem=FNroll(10,10):RETURN
800 mon$="Goblin":pgm=FNroll(2,5):atm=FNroll(10,10):dem=FNroll(5,10)
810 RETURN
820 CLS
830 PRINT "ESTAIS EN LA HABITACION ";hab
840 PRINT
850 IF pg1<1 THEN pg1=0:PEN 3 ELSE IF pg1<5 THEN PEN 1 ELSE PEN 2
860 PRINT nom1$;" - PV:";pg1;"ATQ: ";atq1;"% DEF:";def1;"%"
870 IF pg2<1 THEN pg2=0:PEN 3 ELSE IF pg2<5 THEN PEN 1 ELSE PEN 2
880 PRINT nom2$;" - PV:";pg2;"ATQ: ";atq2;"% DEF:";def2;"%"
890 PEN 2:PRINT
900 PRINT "No estais solos, hay un:"
910 if mon$<>"" THEN PEN 3:PRINT mon$;" - PV:";pgm;"ATQ: ";atm;"% DEF:";dem;"%"
920 if obj$<>"" THEN PEN 1:PRINT obj$;" humeante"
930 PEN 2
940 PRINT
950 PRINT "++++++++++++"
960 PRINT "+          +"
970 PRINT "+   X      +"
980 PRINT "        E   "
990 PRINT "+   X      +"
1000 PRINT "+          +"
1010 PRINT "++++++++++++"
1020 PRINT
1030 RETURN
1040 IF pg1>0 THEN 1060
1050 PRINT "El jugador 1 esta muerto":pg1=0:RETURN
1060 ac1$="": INPUT "Accion del primer heroe (a/d/b/n): ", ac1$
1070 if ac1$<>"a" AND ac1$<>"d" AND ac1$<>"b" THEN PRINT "No haces nada":ac1$="":RETURN
1080 if ac1$<>"b" THEN 1140
1090 if obj$="" THEN PRINT "No hay nada que beber!": RETURN
1100 GOSUB 1620:PEN 1:PRINT "Te tomas el bebedizo y ";efe$:PEN 2
1110 pg1=pg1+pgm:atq1=atq1+atm:def1=def1+dem:obj$=""
1120 pg1=pg1 MOD 40:atq1=atq1 MOD 90:def1=def1 MOD 90
1130 RETURN
1140 IF ac1$<>"a" THEN 1210
1150 IF obj$<>"" THEN GOSUB 1590:PRINT "Rompes el bebedizo":obj$="":RETURN
1160 IF mon$="" THEN PRINT "No hay nada a lo que atacar!": RETURN
1170 IF RND*100>atq1 OR RND*100<=dem THEN 1190
1180 GOSUB 1590:PRINT "Golpeas al monstruo!":pgm=pgm-3: RETURN
1190 GOSUB 1500:PRINT "Fallas!"
1200 RETURN
1210 PRINT "Tratas de defender"
1220 RETURN
1230 IF pg2>0 THEN 1250
1240 PRINT "El jugador 2 esta muerto":pg2=0:RETURN
1250 ac2$="": INPUT "Accion del segundo heroe (a/d/b/n): ", ac2$
1260 if ac2$<>"a" AND ac2$<>"d" AND ac2$<>"b" THEN PRINT "No haces nada":ac2$="":RETURN
1270 if ac2$<>"b" THEN 1330
1280 if obj$="" THEN PRINT "No hay nada que beber!": RETURN
1290 GOSUB 1620:PEN 1:PRINT "Te tomas el bebedizo y ";efe$:PEN 2
1300 pg2=pg2+pgm:atq2=atq2+atm:def2=def2+dem:obj$=""
1310 pg2=pg2 MOD 40:atq2=atq2 MOD 90:def2=def2 MOD 90
1320 RETURN
1330 if ac2$<>"a" THEN 1400
1340 IF obj$<>"" THEN GOSUB 1590:PRINT "Rompes el bebedizo":obj$="":RETURN
1350 IF mon$="" THEN PRINT "No hay nada a lo que atacar!": RETURN
1360 IF RND*100>atq2 OR RND*100<=dem THEN 1380
1370 GOSUB 1590:PRINT "Golpeas al monstruo!":pgm=pgm-3: RETURN
1380 GOSUB 1500:PRINT "Fallas!"
1390 RETURN
1400 PRINT "Tratas de defender"
1410 RETURN
1420 IF pgm>0 THEN PRINT "El monstruo ataca y... "; ELSE RETURN
1430 IF RND*100>atm THEN 1480
1440 GOSUB 1590:PRINT "golpea!"
1450 IF ac1$="d" AND RND*100<=def1 THEN PRINT "Pero el jugador 1 defiende" ELSE pg1=pg1-3
1460 IF ac2$="d" AND RND*100<=def2 THEN PRINT "Pero el jugador 2 defiende" ELSE pg2=pg2-3
1470 RETURN
1480 GOSUB 1500:PRINT "falla!"
1490 RETURN
1500 ENV 1,20,2,1
1510 SOUND 1,278,40,0,1
1520 RETURN
1530 ENT 3,100,-2,2
1540 SOUND 1,142,140,15,0,3
1550 RETURN
1560 ENT 8,100,5,3
1570 SOUND 1,142,100,15,0,8
1580 RETURN
1590 ENV 4,15,1,1,15,-1,1:ENT -4,2,1,1,2,-1,1
1600 SOUND 1,2000,50,0,4,4,15
1610 RETURN
1620 ENV 1,5,3,3,1,-21,22,9,-3,2:ENT -1,10,2,2,5,-7,1,2,11,3,2,-4,8
1630 SOUND 1,19,46,12,1,1
1640 RETURN
