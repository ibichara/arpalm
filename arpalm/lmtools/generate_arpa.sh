BASEDIR=$(dirname "$0")
text_file=$1
wfreq_file="$text_file".wfreq
vocab_file="$text_file".vocab
idngram_file="$text_file".idngram
arpa_file="$text_file".arpa

if [ ! -d /usr/tmp ]; then
	echo "criando diretorio tmp"
	sudo mkdir /usr/tmp
	sudo chown <ROOT_USER>:<ROOT_USER> /usr/tmp
fi

echo "Gerando arquivo de frequencias..."
$BASEDIR/text2wfreq < $text_file > $wfreq_file
echo "Gerando arquivo de vocabulario..."
$BASEDIR/wfreq2vocab -top 60000 < $wfreq_file > $vocab_file
echo "Gerando arquivo idngram..."
$BASEDIR/text2idngram -vocab $vocab_file < $text_file > $idngram_file
echo "Gerando arquivo arpa..."
$BASEDIR/idngram2lm -idngram $idngram_file -vocab $vocab_file -arpa $arpa_file -witten_bell
echo "Gerando...ops...acabou. :)"
