#!/bin/bash

function extensions_disponibles()
{
LANG=C sox -h | grep "AUDIO FILE FORMATS"
}

function usage_audiollibre()
{
cat << EOF
Aquest script genera un audiollibre a partir d'un fitxer de text.
Ús:
$0 [-a autor] [-f ogg] fitxer.txt

Paràmetres:
 -a: Estableix l'etiqueta d'autor a l'audiollibre.
 -f: Extensió del fitxer de sortida [ogg]. Extensions disponibles:
EOF
extensions_disponibles
argdescription_divcapitols
cat << EOF

 fitxer.txt: Nom del fitxer de text a separar en capítols.

EOF
}


function usage_divcapitols()
{
cat << EOF
Aquest script separa un fitxer de text en diversos fitxers.
Està pensat per dividir un llibre en capítols.

Ús:
$0 [ ( -m 1|2|3|4 ) | ( -c REGEX ) ] fitxer.txt

Paràmetres:
EOF
argdescription_divcapitols
cat << EOF

 fitxer.txt: Nom del fitxer de text a separar en capítols.
EOF
}

function argdescription_divcapitols()
{
cat << EOF
 -m: Determina com es reconeixen els títols de capítols
    1: Els capítols comencen amb: "Capítol 1" (mode predefinit)
    2: Els capítols comencen només amb el nombre: "1"
    3: Format Projecte Gutemberg: "Capítol I"
    4: Format Manybooks: "I"
    5: Manuals (a): "1 Títol del capítol..." o "1. Títol del capítol..."

 -c: Especifica una expressió regular personalitzada per identificar l'inici dels capítols.
EOF
}


function setregex_divcapitols()
{
         case "$1" in
            1) 
               regex="/^Capítol /";;
            2) 
               regex="/^[0-9][0-9]*$/";;
            3) 
               regex="/^Capítol M{0,4}(CM|CD|D?C{0,4})(XC|XL|L?X{0,4})(IX|IV|V?I{0,4})$/";;
            4) 
               regex= "/^M{0,4}(CM|CD|D?C{0,4})(XC|XL|L?X{0,4})(IX|IV|V?I{0,4})$/";; # el {0,4} admet nombres com XXXX (tot i que no són correctes realment)
            5) 
               regex="/^[0-9][0-9]*\.?\s?[A-Za-z0-9]*/";;
            [?])
               echo "Aquest mode no està definit.";;
         esac
}


function usage_text2audio()
{
cat << EOF
Aquest script sintetitza un fitxer de text en un fitxer d'àudio.
Ús:
$0 [ -a autor ] [-p pista] [-f format ] fitxer.txt

Paràmetres:
 -a: Estableix l'autor del fitxer de text en les propietats del fitxer d'àudio.
 -p: Estableix el número de pista, útil per llibres.
 -f: Determina el format del fitxer de sortida. Extensions disponibles:
EOF
extensions_disponibles
cat << EOF

 fitxer.txt: Fitxer a convertir
EOF
}


function valida_audio_ext()
{
local avalext=$( extensions_disponibles | tail -c +20)
if [[ "$avalext" =~ "$1" ]]; then
   return 0
fi
cat << EOF
$0
ERROR:
Sembla que «$1» no és una extensió suportada.
Algun d'aquests paquets pot ser-vos útil:
libsox-fmt-all, libmp3lame0
Tingueu present que formats com «mp3» no són lliures i poden tenir patents a alguns països.
EOF
exit 1
}
