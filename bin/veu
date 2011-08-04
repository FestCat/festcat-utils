#!/bin/sh
# Ús: bash $0 arxiu.txt [autor [pista]]
# Escrit per Paco Rivière http://pacoriviere.cat - Juny 2008 - Per a Ubuntu Hardy 8.04 - Llicència GNU\GPL
# 
# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; version 2 of the License.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU Library General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.

function ajuda {
echo "Ús: bash $0 arxiu.txt [autor [pista]]"
echo
}

function llegir () {
echo "cat $1 | festival --tts"
cat $1 | festival --tts
}

function canvia {
	echo "Trieu una opció"
	echo "1 - Català (Ona)"
	echo "2 - Català (Pau)"
	echo "3 - Castellà"
	echo "4 - Anglés"
	read opcio
case $opcio in 
	1 ) printf "(set! voice_default 'voice_upc_ca_ona_hts)\n" > ~/.festivalrc ;;
	2 ) printf "(set! voice_default 'voice_upc_ca_pau_hts)\n" > ~/.festivalrc ;;
	3 ) printf "(set! voice_default 'voice_festvox-ellpc11k)\n" > ~/.festivalrc ;;
	4 ) printf "(set! voice_default 'voice_kal_diphone)" > ~/.festivalrc ;;
esac
# Alternatives per la veu de Linex
#	3 ) printf "(set! voice_default 'voice_JuntaDeAndalucia_es_pa_diphone)"\n > ~/.festivalrc ;;
#	3 ) printf "(set! voice_default 'voice_festvox-kdlpc16k)\n" > ~/.festivalrc ;;
}

# Extensions admissibles
ext=".[tT][xX][tT]"
#Constants
ANY=`date +%Y`
COMENT="`festival -v`"

# Comprovem que s'ha indicat l'arxiu a convertir
  if [ -z $1 ]; then
	echo $0: "Cal indicar un arxiu de text! (codificat amb latin-1!)"
	ajuda ; exit 2
  else
# Comprovem que l'arxiu té extensió .txt
	if [ $1 != ${1%$ext}.txt ]; then
		echo $0: "Cal que l'extensió de l' arxiu de text sigui txt"
		ajuda ; exit 2
	fi
  fi

# Menu i bucle principal
while true ;
do
	echo "Trieu una opció"
	echo "0 - Sortir"
	echo "1 - Llegir en veu ara"
	echo "2 - Convertir a ogg"
	echo "3 - Convertir a mp3"
	echo "4 - Crear un audiollibre"
	echo "5 - Canviar la llengua"
	echo "6 - Ajuda"
	read Opcio
	case "$Opcio" in
	  0 ) exit 1 ;;
	  1 ) llegir $1 $2 ;;
	  2 ) bash text2ogg.sh $1 $2 ;;
	  3 ) bash text2mp3.sh $1 $2 ;;
	  4 ) bash audiollibre.sh $1 $2 ;;
	  5 ) canvia ;;
	  6 ) ajuda ;;
	esac
done
