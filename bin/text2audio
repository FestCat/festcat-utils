#!/bin/bash
# text2audio: Converteix un arxiu de text a un format d'audio llegint-lo amb Festival, afegint el nom de l'arxiu a l'etiqueta mp3 del títol, i opcionalment l'autor
# Ús: bash text2audio.sh arxiu.txt [autor [pista]]
# Escrit per Paco Rivière http://pacoriviere.cat - Juny 2008 - Per a Ubuntu Hardy 8.04 - Llicència GNU\GPL
# Modificat per Sergio Oller sergioller@gmail.com Agost 2011
# Aquest script està escrit suposant que tenim la veu catalana triada per omissió:
# https://wiki.ubuntu.com/CatalanTeam/Tutorials/S%c3%adntesiDeVeu/Scripts

. docfunctions.sh
usage=usage_text2audio

#Constants
ANY=`date +%Y`
COMENT=$(festival -v)

autor="Convertit amb $0 i ${COMENT:10}"
PISTA=1
oext="ogg"

while getopts "ha:p:f:" option;
do
   case "$option" in
      h) $usage
         exit 0
         ;;
      a) 
         autor="$OPTARG"
         ;;
      p)
         PISTA=$OPTARG
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

# Comprovem que s'ha indicat el fitxer a convertir 
mime=$( file -ib "$infile" )

if [[ ! "$mime" =~ "text" ]]; then
   echo "$0: Cal indicar un fitxer de text en ISO-8859-15 (o latin-1)."
   echo "    S'ha obtingut: $mime"
   $usage
   exit 2
fi

# Si el fitxer de text és UTF-8, llavors el convertim a ISO-8859-15
if [[ "$mime" =~ "charset=utf-8" ]]; then
   outfile="${infile}.tmp"
   iconv -f UTF-8 -t ISO-8859-15//TRANSLIT//IGNORE -o $outfile $infile || \
   ( echo "No s'ha pogut convertir $infile a ISO-8859-15."; exit 1 ) 
else
   outfile="$infile"
fi


outfile=${infile%.*}.$oext
# Abans de començar comprovem si existeix l'arxiu oext, per no perdre el temps
if [ -f "$outfile" ]; then
# Si l'arxiu oext ja existeix preguntem el que cal fer
cat << EOF
$0: Ja existeix un arxiu amb el nom "$outfile", primer l'heu d'esborrar o canviar de nom.
Què voleu fer?
 0 - Sortir
 1 - Esborrar l'arxiu (sense confirmació!)
 2 - Canviar el nom de l'arxiu
EOF
read Opcio
  case "$Opcio" in
   0) 
      exit 4
      ;;
   1) 
      rm "$outfile"
      echo "S'ha esborrat l'arxiu $outfile"
      ;;
   2) 
      echo "Entreu el nou nom (amb extensió)"
      read NouNom
      mv "$outfile" "$NouNom";;
  esac
fi

outwav=${infile%.*}.wav
# Passem a wav
# ======================================
if [ -f "$outwav" ]; then
# Si l'arxiu wav ja existeix preguntem el que cal fer
   echo $0: "Ja existeix un arxiu amb el nom "${outwav}", primer l'heu d'esborrar o canviar de nom"
   echo "Què voleu fer?"
   echo "0 - Sortir"
   echo "1 - Esborrar l'arxiu (sense confirmació!)"
   echo "2 - Canviar el nom de l'arxiu"
   read Opcio
   case "$Opcio" in
    0) 
       exit 4
       ;;
    1) 
       rm "$outwav"
       echo "S'ha esborrat l'arxiu $outwav"
       ;;
    2) 
       echo "Entreu el nou nom (sense extensió)"
       read NouNom
       mv "$outwav" "$NouNom.wav"
       ;;
   esac
else
   echo "$0: S'està llegint l'arxiu en format wav"
# Substituim caràcters problemàtics - Aportació d'Antonio Bonafonte
   cat $infile | tr "\255\264\341\354\371" "-'\340\355\372" | tr -c  '\- \t\n\r[:alnum:]\341\340\351\350\355\354\363\362\372\371\374\357\347\361\301\300\311\310\315\314\323\322\332\331\334\317\307\321[]{}\272\252\\!|@"\267#\$~%&/()=?\047\277\241*+_.:,;<>\244' ' '  > /tmp/$$.txt
# I llegim l'arxiu
   LC_ALL=ca_ES text2wave -o $outwav /tmp/$$.txt
   rm /tmp/$$.txt
fi

# Passem a $oext (si existeix el wav)
# =================================
if [ -f "$outwav" ]; then
# Conversió a $oext
   echo $0: "S'està convertint l'arxiu a format mp3"
   sox "$outwav" "$outfile"
else
   echo $0: "No s'ha pogut generar l'arxiu $outwav"
   exit 6
fi

if [ "$oext" = "mp3" ]; then
   id3 -t "${infile%.*}" -a "$autor" -g "Speech" -T $PISTA -y $ANY -A ${infile%_-_*} -c "\"Convertit amb  $0 i ${COMENT:10}\"" "${outfile}" > /dev/null
elif [ "$oext" = "ogg" ]; then
   vorbiscomment -t "TITLE=${infile%.*}"   \
                 -t "ARTIST=$autor"        \
                 -t "ALBUM=${infile%_-_*}" \
                 -t "GENRE=Speech"         \
                 -t "TRACKNUMBER=$PISTA"   \
                 -t "YEAR=$ANY"            \
                 -t "COMMENT=Convertit amb  $0 i ${COMENT:10}" \
                 -w "$outfile"
else
   echo "Encara no s'ha implementat el marcat de l'autor, l'any i la pista per $oext"
fi

# Esborrem el wav (si existeix)
# =============================
if [ -f "$outwav" ]; then
   rm "$outwav"
fi

# Si hem arribat aquí vol dir que tot ha anat bé
echo "$0: L'arxiu $infile s'ha convertit a $outfile"
exit 0

