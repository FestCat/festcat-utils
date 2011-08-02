#!/bin/bash
# audiollibre: Converteix un fitxer de text a mp3, separant els capítols i llegint-los amb Festival, afegint el nom de l'fitxer a l'etiqueta ogg del títol, i opcionalment l'autor
# Ús: bash audiollibre.sh fitxer.txt [autor]
# Escrit per Paco Rivière http://pacoriviere.cat - Juny 2008 - Per a Ubuntu Hardy 8.04 - Llicència GNU\GPL
# Modificat per Sergio Oller sergioller@gmail.com - Agost 2011

. docfunctions.sh
usage=usage_audiollibre

# Parse arguments:
autor=
infile=
regex="/Capítol /"
oext="ogg"

while getopts "ha:m:c:f:" option;
do
   case "$option" in
      h) 
         $usage
         exit 0
         ;;
      a) 
         autor="$OPTARG"
         ;;
      m) 
         setregex_divcapitols "$OPTARG"
         ;;
      c)
         regex="$OPTARG"
         ;;
      f)
         oext="$OPTARG"
         ;;
    [?]) 
         $usage
         exit ;;
   esac
done
shift $(($OPTIND - 1)) 

valida_audio_ext "$oext"

if [ $# = 0 ]; then
   echo "$0: Cal indicar un fitxer de text."
   $usage
   exit 1
fi

infile="$1"
########

# Comproven que s'ha indicat un fitxer a convertir 
mime=$( file -ib $infile )

if [[ ! "$mime" =~ "text" ]]; then
   echo "$0: Cal indicar un fitxer de text."
   echo "    S'ha trobat un fitxer de tipus $mime"
   $usage
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
divcapitols.sh -c "$regex" "${outfile}"

outdir=${outfile%.*}.dir

# Passem els capítols a oext
PISTA=0
echo "$0 - Passant a $oext..."
  for fitxer in ${outdir}/${infile%.*}"_-_"* ;
  do
	PISTA=$[ $PISTA + 1 ]
 	text2audio.sh -a "$autor" -p "$PISTA" -f "$oext" "$fitxer"
  done
echo "$0 - Hem acabat"

