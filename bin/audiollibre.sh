#!/bin/bash
# audiollibre: Converteix un fitxer de text a mp3, separant els capítols i llegint-los amb Festival, afegint el nom de l'fitxer a l'etiqueta ogg del títol, i opcionalment l'autor
# Ús: bash audiollibre.sh fitxer.txt [autor]
# Escrit per Paco Rivière http://pacoriviere.cat - Juny 2008 - Per a Ubuntu Hardy 8.04 - Llicència GNU\GPL
# Modificat per Sergio Oller

# Paràmetres
# $1 Fitxer de text a convertir - etiqueta del titol
# $2 Etiqueta de l'autor (paràmetre opcional)

function usage()
{
cat << EOF
$0 [-a autor]  fitxer.txt
EOF
}


# Parse arguments:
autor=
infile=
while getopts "ha:" option;
do
   case "$option" in
      h) usage
         exit 0
         ;;
      a) autor="$OPTARG";;
      [?]) usage
           exit ;;
   esac
done
shift $(($OPTIND - 1)) 

if [ $# = 0 ]; then
   echo "$0: Cal indicar un fitxer de text."
   usage
   exit 1
fi

infile="$1"
########

# Comproven que s'ha indicat el fitxer a convertir 
mime=$( file -ib $infile )

if [[ ! "$mime" =~ "text" ]]; then
   echo "$0: Cal indicar un fitxer de text."
   echo "    S'ha trobat un fitxer de tipus $mime"
   usage
   exit 1
fi

# Si el fitxer de text és UTF-8, llavors el convertim a ISO-8859-15
if [[ "$mime" =~ "charset=utf-8" ]]; then
   outfile="${infile}.tmp"
   iconv -f UTF-8 -t ISO-8859-15//TRANSLIT//IGNORE -o $outfile $infile || \
   ( echo "No s'ha pogut convertir $infile a ISO-8859-15."; exit 1 ) 
else
   outfile="$infile"
fi

# 

# Separem els capitols
divcapitols.sh "$infile"

# Passem els capítols a mp3
PISTA=0
echo "$0 - Passant a mp3..."
  for fitxer in ${infile%.*}.tmp/${infile%.*}"_-_"* ;
  do
 	text2mp3.sh "$fitxer" "$autor" "$PISTA";
	PISTA=$[ $PISTA + 1 ]
  done
echo "$0 - Hem acabat"

