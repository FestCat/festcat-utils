#!/bin/sh
# divcapitols.sh: Separa un arxiu.txt en els seu capítols
# Ús: bash divcapitols arxiu.txt
# Escrit per Paco Rivière http://pacoriviere.cat - Juny 2008 - Per a Ubuntu Hardy 8.04 - Llicència GNU\GPL
# Referències:
# http://www.ncsa.uiuc.edu/UserInfo/Resources/Hardware/IBMp690/IBM/usr/share/man/info/en_US/a_doc_lib/cmds/aixcmds1/csplit.htm
# http://www.opengroup.org/onlinepubs/000095399/utilities/csplit.html
# http://gnosis.cx/publish/programming/text_utils.html
# Nombres romans: http://regexlib.com/REDetails.aspx?regexp_id=128

# Paràmeters
# $1 Arxiu de text a convertir

# Configuració
# ============
# Treieu una de les següents expresions, segons la numeració dels capítols del llibre, per al tercer paràmetre de l'ordre csplit de la secció "Separem els capítols"
# '"/Capítol /"' # Capítols que comencen així: "Capítol 1"
# '"/^[0-9]*[0-9]*[0-9]*[0-9]$/"' # Només nombres: "1"
# '"/^Capítol [IVX]*[IVX]*[IVX]*[IVX]*[IVX]*[IVX]$/"' # Capítols que comencen així: "Capítol I" (Projecte Guremberg)
# '"/^[IVX]*[IVX]*[IVX]*[IVX]*[IVX]*[IVX]$/"' # Només nombres romans: "I" al XXXXIX (Manybooks)
# '"/^[0-9]*[0-9]*[0-9]* [A-Z]/"' # Capítols que comencen així: "1 Titol del capitol..." Manuals (Cultura Lliure)
# '"/^[0-9]*[0-9]*[0-9]\.1\. [A-Z]/"' # Capítols que comencen així: "1. Titol del capitol..." Manuals (Cultura Lliure)

# Comproven que s'ha indicat l'arxiu a convertir       
  if [ -z $1 ]; then
	echo $0: "Cal indicar un arxiu de text!"
	echo "Ús: bash $0 arxiu.txt"
	exit 1
  else
# Comprovem que l'arxiu té extensió .txt
	if [ $1 != ${1%.txt}.txt ]; then
		echo $0: "Cal que l'extensió de l' arxiu de text sigui txt"
		echo "Ús: bash $0 arxiu.txt"
		exit 2
	fi
  fi

#Creem una carpeta per desar els arxius
mkdir ${1%.txt}

# Separem els capítols
  csplit -s -f "${1%.txt}//${1%.txt}_-_Capítol_" $1 "/^[0-9]*[0-9]*[0-9]\.1\. [A-Z]/-4" "{*}"
#  csplit -s -f "${1%.txt}_-_Capítol_" $1 "/Capítol /" "{*}" #funciona bé
# Afegim l'extensió .txt
  for arxiu in ${1%.txt}/${1%.txt}"_-_"* ;
  do
	mv $arxiu $arxiu.txt;
  done

# Informem del resultat
  if [ $? == 0 ]; then 
		echo "S'han creat els arxius dels capítols" ; exit 0
	else
		echo "S'ha trobat un error inesperat"
  fi
