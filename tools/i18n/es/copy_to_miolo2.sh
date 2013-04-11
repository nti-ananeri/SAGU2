#!/bin/bash

LOCALE_DIR="../../../locale/es/LC_MESSAGES"
DIR="academic basic finance institutional selectiveProcess accountancy controlCopies humanResources research protocol gnuteca sagu2 services miolo"
if [ $1 ]
then
        DIR=$1
fi
for DIRS in $DIR
do
    echo "Processing $DIRS.po..."
    echo " Copying file $DIRS.po to $LOCALE_DIR/$DIRS.po..."
    cp $DIRS.po $LOCALE_DIR/$DIRS.po
    echo " Generating $LOCALE_DIR/$DIRS.mo file from $LOCALE_DIR/$DIRS.po..."
    msgfmt -f $LOCALE_DIR/$DIRS.po -o $LOCALE_DIR/$DIRS.mo
done
echo "###############################################################################"
echo "# Don't forget to restart your apache server for the settings to take effect. #"
echo "###############################################################################"
