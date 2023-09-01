# DUNGEON RACE

Un simple juego de mazmorreo creado junto a mi hija Ada durante el verano del 23 para nuestro Amstrad CPC. Sin embargo, se ha desarrollado sobre macos utilizando Visual Code y algunas de las herramientas que vienen en CPCTelera (como la utilidad para crear ficheros DSK).

Para facilitar la escritura en basic, se ha añadido un pequeño "parser" que nos permite trabajar más confortablemente en visual code. Entre otras cosas, dicho parser se encarga de coger nuestro fichero pseudo-BAS y tradicirlo a Locomotive BAS. Esto nos permite:

1. Eliminar cualquier línea que empiece por ' (un comentario). No si empiezan por **REM**.
1. No indicar números de línea, el parser los añadirá por nosotros.
1. Indicar puntos de salto mediante etiquetas. Las etiquetas deben empezar por el símbolo **::**. Los caracacteres válidos son A-Z,a-z,0-9,-,_
1. Permite identar líneas dentro de un WHILE o un FOR, ya que el parser suprime cualquier espacio al principio o al final de las líneas de código.

Por ejemplo, el siguiente código:

```bas
' Código de ejemplo
::main
PRINT "HOLA MUNDO"
GOTO ::main
```

Termina reescrito por el parser como:

```bas
10 PRINT "HOLA MUNDO"
20 GOTO 10
```



