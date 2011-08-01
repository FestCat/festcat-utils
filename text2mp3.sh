#!/bin/sh
# text2mp3: Converteix un arxiu de text a mp3 llegint-lo amb Festival, afegint el nom de l'arxiu a l'etiqueta mp3 del títol, i opcionalment l'autor
# Ús: bash text2mp3.sh arxiu.txt [autor [pista]]
# Escrit per Paco Rivière http://pacoriviere.cat - Juny 2008 - Per a Ubuntu Hardy 8.04 - Llicència GNU\GPL
# Aquest script està escrit suposant que tenim la veu catalana triada per omissió:
# https://wiki.ubuntu.com/CatalanTeam/Tutorials/S%c3%adntesiDeVeu/Scripts

# Paràmeters
# $1 Arxiu de text a convertir - etiqueta del titol
# $2 Etiqueta de l'autor (paràmetre opcional, tot i que cal indicar l'autor per poder indicar la pista)
# $3 Pista de l'arxiu mp3 (paràmetre opcional)
ETIQU="$2"
PISTA=$3

# Comprovacions per poder començar
# ================================
# Comprovem que hi ha els paquets que necesitem
[ ! -f `which lame` ] && echo "Cal el paquet lame. Feu sudo apt-get install lame." && exit 1
[ ! -f `which festival` ] && echo "Cal el paquet zenity. Feu sudo apt-get install festival." && exit 1

# Extensions admissibles
ext=".[tT][xX][tT]"
#Constants
ANY=`date +%Y`
COMENT="`festival -v`"

# Comprovem que s'ha indicat l'arxiu a convertir       
  if [ -z $1 ]; then
	echo $0: "Cal indicar un arxiu de text! (codificat amb latin-1!)"
	echo "Ús: bash $0 arxiu.txt [autor [pista]]"
	exit 2
  else
# Comprovem que l'arxiu té extensió .txt
	if [ $1 != ${1%$ext}.txt ]; then
		echo $0: "Cal que l'extensió de l' arxiu de text sigui txt"
		echo "Ús: bash $0 arxiu.txt [autor [pista]]"
		exit 3
	fi
  fi

# Abans de començar comprovem si existeix l'arxiu mp3, per no perdre el temps
	if [ -f ${1%$ext}.mp3 ]; then
# Si l'arxiu mp3 ja existeix preguntem el que cal fer
		echo $0: "Ja existeix un arxiu amb el nom "${1%$ext}.mp3", primer l'heu d'esborrar o canviar de nom"
		echo "Què voleu fer?"
		echo "0 - Sortir"
		echo "1 - Esborrar l'arxiu (sense confirmació!)"
		echo "2 - Canviar el nom de l'arxiu"
		read Opcio
		case "$Opcio" in
		  0   ) exit 4 ;;
		  1   ) rm ${1%$ext}.mp3; echo "S'ha esborrat l'arxiu" ${1%$ext}.mp3;;
		  2   ) echo "Entreu el nou nom (sense espais ni extensió)" ; read NouNom ; mv ${1%$ext}.mp3 $NouNom.mp3 ;;
		esac
	fi

# Passem a wav (si existeix l'arxiu txt)
# ======================================
  if [ -f $1 ]; then
	if [ -f ${1%$ext}.wav ]; then
# Si l'arxiu wav ja existeix preguntem el que cal fer
		echo $0: "Ja existeix un arxiu amb el nom "${1%$ext}.wav", primer l'heu d'esborrar o canviar de nom"
		echo "Què voleu fer?"
		echo "0 - Sortir"
		echo "1 - Esborrar l'arxiu (sense confirmació!)"
		echo "2 - Canviar el nom de l'arxiu"
		read Opcio
		case "$Opcio" in
		  0   ) exit 4 ;;
		  1   ) rm ${1%$ext}.wav; echo "S'ha esborrat l'arxiu" ${1%$ext}.wav;;
		  2   ) echo "Entreu el nou nom (sense espais ni extensió)" ; read NouNom ; mv ${1%$ext}.wav $NouNom.wav ;;
		esac
	else
		echo $0: "S'està llegint l'arxiu en format wav"
# Substituim caràcters problemàtics - Aportació d'Antonio Bonafonte
cat $1 | tr "\255\264\341\354\371" "-'\340\355\372" |\
   tr -c  '\- \t\n\r[:alnum:]\341\340\351\350\355\354\363\362\372\371\374\357\347\361\301\300\311\310\315\314\323\322\332\331\334\317\307\321[]{}\272\252\\!|@"\267#\$~%&/()=?\047\277\241*+_.:,;<>\244' ' '  > /tmp/$$.txt
# I llegim l'arxiu
		LC_ALL=ca_ES text2wave -o ${1%$ext}.wav /tmp/$$.txt
		rm /tmp/$$.txt
	fi
  else
	echo $0: "No es pot trobar l'arxiu" $1
	exit 5
  fi

# Passem a mp3 (si existeix el wav)
# =================================
  if [ -f ${1%$ext}.wav ]; then

# Comprovem si s'ha indicat l'Autor
	if [ -z "$ETIQU" ]; then
		ETIQU="Convertit amb $0 i ${COMENT:10}"
	fi
# Comprovem si s'ha indicat la pista
	if [ -z $PISTA ]; then
		PISTA=1
	fi
# Conversió a mp3
	echo $0: "S'està convertint l'arxiu a format mp3"
#echo        lame --tt "${1%$ext}" --ta "\"$ETIQU\"" --tg Speech --tn $PISTA --ty $ANY --tl ${1%_-_*} --tc "\"Convertit amb  $0 i ${COMENT:10}\"" ${1%$ext}.wav ${1%$ext}.mp3
        lame --tt "${1%$ext}" --ta "\"$ETIQU\"" --tg Speech --tn $PISTA --ty $ANY --tl ${1%_-_*} --tc "\"Convertit amb  $0 i ${COMENT:10}\"" ${1%$ext}.wav ${1%$ext}.mp3
  else
	echo $0: "No es pot generar l'arxiu" ${1%$ext}.wav
	exit 6
  fi

# Esborrem el wav (si existeix)
# =============================
  if [ -f ${1%$ext}.wav ]; then
	rm ${1%$ext}.wav
  fi

# Si hem arribat aquí vol dir que tot ha anat bé
  echo $0: "L'arxiu" $1 "s'ha convertit al" ${1%$ext}.mp3
  exit 0

