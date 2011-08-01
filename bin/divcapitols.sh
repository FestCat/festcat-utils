#!/bin/bash
# divcapitols.sh: Separa un fitxer.txt en els seu capítols
# Ús: bash divcapitols fitxer.txt
# Escrit per Paco Rivière http://pacoriviere.cat - Juny 2008 - Per a Ubuntu Hardy 8.04 - Llicència GNU\GPL
# Referències:
# http://www.ncsa.uiuc.edu/UserInfo/Resources/Hardware/IBMp690/IBM/usr/share/man/info/en_US/a_doc_lib/cmds/aixcmds1/csplit.htm
# http://www.opengroup.org/onlinepubs/000095399/utilities/csplit.html
# http://gnosis.cx/publish/programming/text_utils.html
# Nombres romans: http://regexlib.com/REDetails.aspx?regexp_id=128

# Paràmeters
# $1 Fitxer de text a convertir

# Configuració
# ============
# Treieu una de les següents expresions, segons la numeració dels capítols del llibre, per al tercer paràmetre de l'ordre csplit de la secció "Separem els capítols"
# '"/Capítol /"' # Capítols que comencen així: "Capítol 1"
# '"/^[0-9]*[0-9]*[0-9]*[0-9]$/"' # Només nombres: "1"
# '"/^Capítol [IVX]*[IVX]*[IVX]*[IVX]*[IVX]*[IVX]$/"' # Capítols que comencen així: "Capítol I" (Projecte Gutemberg)
# '"/^[IVX]*[IVX]*[IVX]*[IVX]*[IVX]*[IVX]$/"' # Només nombres romans: "I" al XXXXIX (Manybooks)
# '"/^[0-9]*[0-9]*[0-9]* [A-Z]/"' # Capítols que comencen així: "1 Titol del capitol..." Manuals (Cultura Lliure)
# '"/^[0-9]*[0-9]*[0-9]\.1\. [A-Z]/"' # Capítols que comencen així: "1. Titol del capitol..." Manuals (Cultura Lliure)

function usage()
{
cat << EOF
Aquest script separa un fitxer de text en diversos fitxers.
Està pensat per dividir un llibre en capítols.

Ús:
$0 [ ( -m 1|2|3|4 ) | ( -c REGEX ) ] fitxer.txt

Paràmetres:
 -m: Determina com es reconeixen els títols de capítols
    1: Els capítols comencen amb: "Capítol 1" (mode predefinit)
    2: Els capítols comencen només amb el nombre: "1"
    3: Format Projecte Gutemberg: "Capítol I"
    4: Format Manybooks: "I"
    5: Manuals (a): "1 Títol del capítol..." o "1. Títol del capítol..."

 -c: Especifica una expressió regular personalitzada per identificar l'inici dels capítols.

 fitxer.txt: Nom del fitxer de text a separar en capítols.
EOF
}

infile=
regex="/Capítol /"
while getopts "hm:c:" option;
do
   case "$option" in
      h) usage
         exit 0
         ;;
      m) 
         case "$OPTARG" in
            1) 
               regex="/Capítol /";;
            2) 
               regex="/^[0-9]+$/";;
            3) 
               regex="/^Capítol M{0,4}(CM|CD|D?C{0,4})(XC|XL|L?X{0,4})(IX|IV|V?I{0,4})$/";;
            4) 
               regex= "/^M{0,4}(CM|CD|D?C{0,4})(XC|XL|L?X{0,4})(IX|IV|V?I{0,4})$/";; # el {0,4} admet nombres com XXXX (tot i que no són correctes realment)
            5) 
               regex="/^[0-9]+\.?\s?[A-Za-z0-9]/";;
            [?])
               echo "Aquest mode no està definit. Usant $regex";;
         esac
         ;;
      c) regex="$OPTARG";;
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


# Comprovem que s'ha indicat el fitxer a convertir 
mime=$( file -ib "$infile" )
if [[ ! "$mime" =~ "text" ]]; then
   echo "$0: Cal indicar un fitxer de text."
   echo "    S'ha trobat un fitxer de tipus $mime"
   usage
   exit 1
fi

#Creem un directori per desar els fitxers
outdir=${infile%.*}.tmp
mkdir ${outdir}

# Separem els capítols
  csplit -s -f "${outdir}//${infile%.*}_-_Capítol_" ${infile} ${regex} "{*}"

# Afegim l'extensió .txt
  for fitxer in ${outdir}/${infile%.*}"_-_"* ;
  do
	mv "$fitxer" "$fitxer.txt";
  done

# Informem del resultat
  if [ $? == 0 ]; then 
		echo "S'han creat els fitxers dels capítols" ; exit 0
	else
		echo "S'ha trobat un error inesperat"
  fi

