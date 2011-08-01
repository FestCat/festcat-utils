#!/bin/sh
# audiollibre: Converteix un arxiu de text a mp3, separant els capítols i llegint-los amb Festival, afegint el nom de l'arxiu a l'etiqueta ogg del títol, i opcionalment l'autor
# Ús: bash audiollibre.sh arxiu.txt [autor]
# Escrit per Paco Rivière http://pacoriviere.cat - Juny 2008 - Per a Ubuntu Hardy 8.04 - Llicència GNU\GPL
# Modificat per Sergio Oller

# Paràmeters
# $1 Arxiu de text a convertir - etiqueta del titol
# $2 Etiqueta de l'autor (paràmetre opcional)

# Comprovem que tenim el que ens cal: divcapitols.sh text2mp3.sh
[ ! -f divcapitols.sh ] && echo "Cal l'script divcapitols.sh. Falta un script necessari" && exit 1
[ ! -f text2mp3.sh ] && echo "Cal l'script text2mp3.sh. Falta un script necessari" && exit 1

# Comproven que s'ha indicat l'arxiu a convertir       
  if [ -z $1 ]; then
	echo $0: "Cal indicar un arxiu de text!"
	echo "Ús: bash $0 arxiu.txt [autor]"
	exit 1
  else
# Comprovem que l'arxiu té extensió .txt
	if [ $1 != ${1%.txt}.txt ]; then
		echo $0: "Cal que l'extensió de l' arxiu de text sigui txt"
		echo "Ús: bash $0 arxiu.txt  [autor]"
		exit 2
	fi
  fi

# 

# Separem els capitols
bash divcapitols.sh $1

# Passem els capítols a mp3
PISTA=0
echo "$0 - Passant a mp3..."
  for arxiu in ${1%.txt}/${1%.txt}"_-_"* ;
  do
 	bash text2mp3.sh $arxiu "$2" $PISTA;
	PISTA=$[ $PISTA + 1 ]
  done
echo "$0 - Hem acabat"

