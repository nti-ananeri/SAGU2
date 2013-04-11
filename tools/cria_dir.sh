#!/bin/bash

#Uso: cria_dir.sh <instalacao> <banco> <tema>
#Ex: cria_dir.sh saguananeri saguananeri orange
SAGU=/home/walter/www/ananeri/installs/$1
SAGU_SVN=/home/walter/www/ananeri/sources/sagu2
MIOLO_SVN=/home/walter/www/ananeri/sources/miolo2
AGATA_SVN=/home/walter/www/ananeri/sources/agata
USER=walter

DIR="academic accountancy basic controlCopies finance humanResources institutional research sagu2 selectiveProcess services"
rm -Rf $SAGU
mkdir -p $SAGU > /dev/null || exit 1
mkdir -p $SAGU/modules > /dev/null || exit 1
mkdir -p $SAGU/classes > /dev/null || exit 1
mkdir -p $SAGU/classes/ui > /dev/null || exit 1
mkdir -p $SAGU/html > /dev/null || exit 1
mkdir -p $SAGU/html/images > /dev/null || exit 1
mkdir -p $SAGU/html/images/modules > /dev/null || exit 1
mkdir -p $SAGU/classes/security > /dev/null || exit 1
ln -s $SAGU_SVN/classes/* $SAGU/classes/
ln -s $SAGU_SVN/classes/ui/* $SAGU/classes/ui/
ln -s $MIOLO_SVN/classes/* $SAGU/classes/
ln -s $MIOLO_SVN/classes/ui/* $SAGU/classes/ui/
ln -s $SAGU_SVN/miolo2/classes/security/* $SAGU/classes/security/
ln -s $MIOLO_SVN/classes/security/* $SAGU/classes/security/
rm $SAGU/classes/core
ln -s $AGATA_SVN/classes/* $SAGU/classes/
ln -s $MIOLO_SVN/html/* $SAGU/html/
ln -s $MIOLO_SVN/html/images/* $SAGU/html/images/
ln -s $MIOLO_SVN/misc $SAGU/
ln -s $SAGU_SVN/docs $SAGU/
ln -s $SAGU_SVN/tools $SAGU/
ln -s $SAGU_SVN/locale $SAGU/
rm $SAGU/html/themes
ln -s $SAGU/classes/ui/themes $SAGU/html/
cp -a $SAGU_SVN/miolo2/etc $SAGU/
if [ $1 ]; then
    SAGUDIR="${SAGU//\//\\/}"
    LOCATE=`egrep '<miolo>[^>]*</miolo>' $SAGU/etc/miolo.conf`
    LOCATE="${LOCATE//\ /}"
    CHARS=`echo $LOCATE | wc -m`
    CHARS=$(($CHARS-16))
    LOCATE="${LOCATE:7:$CHARS}"
    LOCATE="${LOCATE//\//\\/}"

    URL=`egrep '<url>[^>]*</url>' $SAGU/etc/miolo.conf`
    URL="${URL//\ /}"
    CHARS=`echo $URL | wc -m`
    CHARS=$(($CHARS-12))
    URL="${URL:5:$CHARS}"
    URL="${URL//\//\\/}"

    sed -i "s/$LOCATE/$SAGUDIR/g"  $SAGU/etc/miolo.conf
    sed -i "s/$URL/http:\/\/$1/g"  $SAGU/etc/miolo.conf
fi
if [ $2 ]; then
    sed -n -e "/\<name>*\</p" $SAGU/etc/miolo.conf | while read linha;
    do
        linha="${linha//\//\\/}"
        sed -i "s/$linha/<name>$2<\/name>/" $SAGU/etc/miolo.conf
    done
fi
if [ $3 ]; then
    sed -n -e "/\<lookup>*\</p" $SAGU/etc/miolo.conf | while read linha;
    do
        linha="${linha//\//\\/}"
        sed -i "s/$linha/<lookup>$3<\/lookup>/" $SAGU/etc/miolo.conf
    done
    
    sed -n -e "/\<main>*\</p" $SAGU/etc/miolo.conf | while read linha;
    do
        linha="${linha//\//\\/}"
        sed -i "s/$linha/<main>$3<\/main>/" $SAGU/etc/miolo.conf
    done
fi
ln -s $SAGU_SVN/modules/modules.inc $SAGU/modules/

for DIRS in $DIR
do
    mkdir -p $SAGU/modules/$DIRS  > /dev/null || exit 1
    mkdir -p $SAGU/modules/$DIRS/etc  > /dev/null || exit 1
    mkdir -p $SAGU/modules/$DIRS/html  > /dev/null || exit 1
    ln -s $SAGU_SVN/modules/$DIRS/* $SAGU/modules/$DIRS/
    ln -s $SAGU_SVN/modules/$DIRS/html/* $SAGU/modules/$DIRS/html/
    ln -s $SAGU/etc/module.conf $SAGU/modules/$DIRS/etc/
    ln -s $SAGU/modules/$DIRS/html/images $SAGU/html/images/modules/$DIRS
done
ln -s $SAGU/modules/sagu2/handlers/menu.inc $SAGU/modules/main_menu.inc

DIR="admin common admin_ldap"
for DIRS in $DIR
do
    mkdir -p $SAGU/modules/$DIRS  > /dev/null || exit 1
    mkdir -p $SAGU/modules/$DIRS/etc  > /dev/null || exit 1
    mkdir -p $SAGU/modules/$DIRS/html  > /dev/null || exit 1
    ln -s $MIOLO_SVN/modules/$DIRS/* $SAGU/modules/$DIRS/
    ln -s $MIOLO_SVN/modules/$DIRS/html/* $SAGU/modules/$DIRS/html/
    ln -s $SAGU/etc/module.conf $SAGU/modules/$DIRS/etc/
    ln -s $MIOLO_SVN/modules/$DIRS/html/images $SAGU/html/images/modules/$DIRS
done
mkdir -p $SAGU/var > /dev/null || exit 1
mkdir -p $SAGU/var/log > /dev/null || exit 1

chmod 755 -R $SAGU 
chown root -R $SAGU                                    || exit 1
chown $USER -R $SAGU/var                               || exit 1
chown $USER -R $SAGU/modules/admin/sql                 || exit 1
chown $USER -R $SAGU/modules/basic/upload              || exit 1
chown $USER -R $SAGU/modules/basic/html/images/upload  || exit 1

#end

