#!/bin/bash

SOURCE_DIR=../../../modules
DEST_DIR=.

function addHTMLEntities() {
    FILE="$1"
    TMP_FILE="/tmp/1523tmp"

    echo " Adding HTML entities to file $FILE..."

    # acento circunflexo
    sed "s/â/\&acirc;/g" $FILE > $TMP_FILE
    mv $TMP_FILE $FILE
    sed "s/ê/\&ecirc;/g" $FILE > $TMP_FILE
    mv $TMP_FILE $FILE
    sed "s/ô/\&ocirc;/g" $FILE > $TMP_FILE
    mv $TMP_FILE $FILE
    sed "s/Â/\&Acirc;/g" $FILE > $TMP_FILE
    mv $TMP_FILE $FILE
    sed "s/Ê/\&Ecirc;/g" $FILE > $TMP_FILE
    mv $TMP_FILE $FILE
    sed "s/Ô/\&Ocirc;/g" $FILE > $TMP_FILE
    mv $TMP_FILE $FILE
    # til
    sed "s/ã/\&atilde;/g" $FILE > $TMP_FILE
    mv $TMP_FILE $FILE
    sed "s/õ/\&otilde;/g" $FILE > $TMP_FILE
    mv $TMP_FILE $FILE
    sed "s/Ã/\&Atilde;/g" $FILE > $TMP_FILE
    mv $TMP_FILE $FILE
    sed "s/Õ/\&Otilde;/g" $FILE > $TMP_FILE
    mv $TMP_FILE $FILE
    # acento agudo
    sed "s/á/\&aacute;/g" $FILE > $TMP_FILE
    mv $TMP_FILE $FILE
    sed "s/é/\&eacute;/g" $FILE > $TMP_FILE
    mv $TMP_FILE $FILE
    sed "s/í/\&iacute;/g" $FILE > $TMP_FILE
    mv $TMP_FILE $FILE
    sed "s/ó/\&oacute;/g" $FILE > $TMP_FILE
    mv $TMP_FILE $FILE
    sed "s/ú/\&uacute;/g" $FILE > $TMP_FILE
    mv $TMP_FILE $FILE
    sed "s/Á/\&Aacute;/g" $FILE > $TMP_FILE
    mv $TMP_FILE $FILE
    sed "s/É/\&Eacute;/g" $FILE > $TMP_FILE
    mv $TMP_FILE $FILE
    sed "s/Í/\&Iacute;/g" $FILE > $TMP_FILE
    mv $TMP_FILE $FILE
    sed "s/Ó/\&Oacute;/g" $FILE > $TMP_FILE
    mv $TMP_FILE $FILE
    sed "s/Ú/\&Uacute;/g" $FILE > $TMP_FILE
    mv $TMP_FILE $FILE
    # crase, cedilha e trema
    sed "s/à/\&agrave;/g" $FILE > $TMP_FILE
    mv $TMP_FILE $FILE
    sed "s/ç/\&ccedil;/g" $FILE > $TMP_FILE
    mv $TMP_FILE $FILE
    sed "s/ü/\&uuml;/g" $FILE > $TMP_FILE
    mv $TMP_FILE $FILE
    sed "s/ö/\&ouml;/g" $FILE > $TMP_FILE
    mv $TMP_FILE $FILE
    sed "s/ï/\&iuml;/g" $FILE > $TMP_FILE
    mv $TMP_FILE $FILE
    sed "s/À/\&Agrave;/g" $FILE > $TMP_FILE
    mv $TMP_FILE $FILE
    sed "s/Ç/\&Ccedil;/g" $FILE > $TMP_FILE
    mv $TMP_FILE $FILE
    sed "s/Ü/\&Uuml;/g" $FILE > $TMP_FILE
    mv $TMP_FILE $FILE
    sed "s/Ö/\&Ouml;/g" $FILE > $TMP_FILE
    mv $TMP_FILE $FILE
    sed "s/Ï/\&Iuml;/g" $FILE > $TMP_FILE
    mv $TMP_FILE $FILE

    # caracteres especiais
    sed "s/ª/\&ordf;/g" $FILE > $TMP_FILE
    mv $TMP_FILE $FILE
    sed "s/º/\&ordm;/g" $FILE > $TMP_FILE
    mv $TMP_FILE $FILE
}

function removeHTMLEntities() {
    FILE="$1"
    TMP_FILE="/tmp/1523tmp"

    echo " Removing HTML entities from file $FILE..."

    # acento circunflexo
    sed "s/\&acirc;/â/g" $FILE > $TMP_FILE
    mv $TMP_FILE $FILE
    sed "s/\&ecirc;/ê/g" $FILE > $TMP_FILE
    mv $TMP_FILE $FILE
    sed "s/\&ocirc;/ô/g" $FILE > $TMP_FILE
    mv $TMP_FILE $FILE
    sed "s/\&Acirc;/Â/g" $FILE > $TMP_FILE
    mv $TMP_FILE $FILE
    sed "s/\&Ecirc;/Ê/g" $FILE > $TMP_FILE
    mv $TMP_FILE $FILE
    sed "s/\&Ocirc;/Ô/g" $FILE > $TMP_FILE
    mv $TMP_FILE $FILE
    # til
    sed "s/\&atilde;/ã/g" $FILE > $TMP_FILE
    mv $TMP_FILE $FILE
    sed "s/\&otilde;/õ/g" $FILE > $TMP_FILE
    mv $TMP_FILE $FILE
    sed "s/\&Atilde;/Ã/g" $FILE > $TMP_FILE
    mv $TMP_FILE $FILE
    sed "s/\&Otilde;/Õ/g" $FILE > $TMP_FILE
    mv $TMP_FILE $FILE
    # acento agudo
    sed "s/\&aacute;/á/g" $FILE > $TMP_FILE
    mv $TMP_FILE $FILE
    sed "s/\&eacute;/é/g" $FILE > $TMP_FILE
    mv $TMP_FILE $FILE
    sed "s/\&iacute;/í/g" $FILE > $TMP_FILE
    mv $TMP_FILE $FILE
    sed "s/\&oacute;/ó/g" $FILE > $TMP_FILE
    mv $TMP_FILE $FILE
    sed "s/\&uacute;/ú/g" $FILE > $TMP_FILE
    mv $TMP_FILE $FILE
    sed "s/\&Aacute;/Á/g" $FILE > $TMP_FILE
    mv $TMP_FILE $FILE
    sed "s/\&Eacute;/É/g" $FILE > $TMP_FILE
    mv $TMP_FILE $FILE
    sed "s/\&Iacute;/Í/g" $FILE > $TMP_FILE
    mv $TMP_FILE $FILE
    sed "s/\&Oacute;/Ó/g" $FILE > $TMP_FILE
    mv $TMP_FILE $FILE
    sed "s/\&Uacute;/Ú/g" $FILE > $TMP_FILE
    mv $TMP_FILE $FILE
    # crase, cedilha e trema
    sed "s/\&agrave;/à/g" $FILE > $TMP_FILE
    mv $TMP_FILE $FILE
    sed "s/\&ccedil;/ç/g" $FILE > $TMP_FILE
    mv $TMP_FILE $FILE
    sed "s/\&uuml;/ü/g" $FILE > $TMP_FILE
    mv $TMP_FILE $FILE
    sed "s/\&ouml;/ö/g" $FILE > $TMP_FILE
    mv $TMP_FILE $FILE
    sed "s/\&iuml;/ï/g" $FILE > $TMP_FILE
    mv $TMP_FILE $FILE
    sed "s/\&Agrave;/À/g" $FILE > $TMP_FILE
    mv $TMP_FILE $FILE
    sed "s/\&Ccedil;/Ç/g" $FILE > $TMP_FILE
    mv $TMP_FILE $FILE
    sed "s/\&Uuml;/Ü/g" $FILE > $TMP_FILE
    mv $TMP_FILE $FILE
    sed "s/\&Ouml;/Ö/g" $FILE > $TMP_FILE
    mv $TMP_FILE $FILE
    sed "s/\&Iuml;/Ï/g" $FILE > $TMP_FILE
    mv $TMP_FILE $FILE

    # caracteres especiais
    sed "s/\&ordf;/ª/g" $FILE > $TMP_FILE
    mv $TMP_FILE $FILE
    sed "s/\&ordm;/º/g" $FILE > $TMP_FILE
    mv $TMP_FILE $FILE

}

DIR="academic basic finance institutional selectiveProcess accountancy controlCopies humanResources research protocol gnuteca sagu2 services"

if [ $1 ]
then
	DIR=$1
fi
for DIRS in $DIR
do
    find $SOURCE_DIR/$DIRS -type f | grep ".class$\|.inc$" > $DEST_DIR/files.txt

    OUT=$DEST_DIR/$DIRS.po
    echo "Generating $OUT..."
    if [ ! -f $DEST_DIR/$OUT ]
    then
        echo " Creating file $DEST_DIR/$OUT..."
        touch $DEST_DIR/$OUT
        unset OMIT_HEADER
    else
        OMIT_HEADER="--omit-header"
    fi

    echo " Removing comments to regenerate them again..."
    grep -v "^#: " $DEST_DIR/$OUT > /tmp/45633tmpfile
    mv /tmp/45633tmpfile $DEST_DIR/$OUT
    
    addHTMLEntities $DEST_DIR/$OUT
    echo " Extracting additional strings from files..."
    xgettext --from-code=ISO-8859-1 $OMIT_HEADER --no-wrap -j -s --keyword='_M:1' -Lphp -f $DEST_DIR/files.txt -o $DEST_DIR/$OUT
    removeHTMLEntities $DEST_DIR/$OUT

    rm $DEST_DIR/files.txt
done

