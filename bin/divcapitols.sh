#!/bin/bash
# divcapitols.sh: Separa un fitxer.txt en els seu capítols
# Escrit per Paco Rivière http://pacoriviere.cat - Juny 2008 - Per a Ubuntu Hardy 8.04 - Llicència GNU\GPL
# Modificat per Sergio Oller sergioller@gmail.com - Agost 2011
# Referències:
# http://www.ncsa.uiuc.edu/UserInfo/Resources/Hardware/IBMp690/IBM/usr/share/man/info/en_US/a_doc_lib/cmds/aixcmds1/csplit.htm
# http://www.opengroup.org/onlinepubs/000095399/utilities/csplit.html
# http://gnosis.cx/publish/programming/text_utils.html
# Nombres romans: http://regexlib.com/REDetails.aspx?regexp_id=128

. docfunctions.sh
usage=usage_divcapitols
infile=
regex="/Capítol /"
while getopts "hm:c:" option;
do
   case "$option" in
      h) 
         $usage
         exit 0
         ;;
      m) 
         setregex_divcapitols "$OPTARG" ;;
      c) regex="$OPTARG";;
      [?]) $usage
           exit ;;
   esac
done
shift $(($OPTIND - 1)) 

if [ $# = 0 ]; then
   echo "$0: Cal indicar un fitxer de text."
   $usage
   exit 1
fi
infile="$1"


# Comprovem que s'ha indicat el fitxer a convertir 
mime=$( file -ib "$infile" )
if [[ ! "$mime" =~ "text" ]]; then
   echo "$0: Cal indicar un fitxer de text."
   echo "    S'ha trobat un fitxer de tipus $mime"
   $usage
   exit 1
fi

#Creem un directori per desar els fitxers
outdir=${infile%.*}.dir
mkdir ${outdir}

# Separem els capítols
  csplit -s -b "%02d.txt" -f "${outdir}//${infile%.*}_-_Capítol_" ${infile} ${regex} "{*}"

# Afegim l'extensió .txt
#  for fitxer in ${outdir}/${infile%.*}"_-_"* ;
#  do
#	mv "$fitxer" "$fitxer.txt";
#  done

# Informem del resultat
if [ $? == 0 ]; then 
   echo "S'han creat els fitxers dels capítols"
   exit 0
else
   echo "S'ha trobat un error inesperat"
   exit 1
fi

