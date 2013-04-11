#!/bin/bash 
SAGU="/usr/local/sagu2" 
MIOLO_SVN="/usr/local/svn/miolo2" 
SAGU_SVN="/usr/local/svn/sagu2" 
AGATA_SVN="/usr/local/svn/agata" 

rm /usr/local/svn/miolo2/html/themes 1> /dev/null 2>/dev/null
rm /usr/local/svn/miolo2/classes/core 1> /dev/null 2>/dev/null
rm /usr/local/svn/miolo2/classes/ui/themes/s* 1> /dev/null 2>/dev/null
rm /usr/local/svn/miolo2/html/images/modules/* 1> /dev/null 2>/dev/null
rm -Rf /usr/local/sagu2 1> /dev/null 2>/dev/null

mkdir -p $SAGU 2> /dev/null || exit 1

# Miolo import || exit 1
ln -s $MIOLO_SVN/classes  $SAGU || exit 1
ln -s $MIOLO_SVN/COPYING  $SAGU || exit 1
ln -s $MIOLO_SVN/html     $SAGU || exit 1
ln -s $MIOLO_SVN/INSTALL  $SAGU/INSTALL.portugues || exit 1
ln -s $MIOLO_SVN/LICENSE  $SAGU || exit 1
ln -s $MIOLO_SVN/misc     $SAGU || exit 1

mkdir $SAGU/var                    || exit 1
ln -s $MIOLO_SVN/var/db  $SAGU/var || exit 1
mkdir $SAGU/var/log                || exit 1
mkdir $SAGU/modules                || exit 1

ln -s $MIOLO_SVN/modules/admin      $SAGU/modules || exit 1
ln -s $MIOLO_SVN/modules/admin_ldap $SAGU/modules || exit 1
ln -s $MIOLO_SVN/modules/common     $SAGU/modules || exit 1
#ln -s $MIOLO_SVN/modules/hangman    $SAGU/modules || exit 1
#ln -s $MIOLO_SVN/modules/helloworld $SAGU/modules || exit 1
#ln -s $MIOLO_SVN/modules/locadora   $SAGU/modules || exit 1
#ln -s $MIOLO_SVN/modules/tutorial   $SAGU/modules || exit 1
ln -s $MIOLO_SVN/classes/ui/themes  $SAGU/html    || exit 1

ln -s $MIOLO_SVN/modules/admin/html/images      $SAGU/html/images/modules/admin      || exit 1
ln -s $MIOLO_SVN/modules/admin_ldap/html/images $SAGU/html/images/modules/admin_ldap || exit 1
ln -s $MIOLO_SVN/modules/common/html/images     $SAGU/html/images/modules/common     || exit 1

# Sagu2 import 
ln -s $SAGU_SVN/locale $SAGU || exit 1
cp $MIOLO_SVN/locale/pt_BR/LC_MESSAGES/* $SAGU/locale/pt_BR/LC_MESSAGES/ || exit 1
#cp $MIOLO_SVN/locale/es/LC_MESSAGES/* $SAGU/locale/es/LC_MESSAGES/ || exit 1
ln -s $SAGU_SVN/tools  $SAGU || exit 1
ln -s $SAGU_SVN/docs   $SAGU || exit 1
ln -s $SAGU_SVN/modules/academic         $SAGU/modules || exit 1
ln -s $SAGU_SVN/modules/accountancy      $SAGU/modules || exit 1
ln -s $SAGU_SVN/modules/basic            $SAGU/modules || exit 1
ln -s $SAGU_SVN/modules/controlCopies    $SAGU/modules || exit 1
ln -s $SAGU_SVN/modules/finance          $SAGU/modules || exit 1
ln -s $SAGU_SVN/modules/trade            $SAGU/modules || exit 1
ln -s $SAGU_SVN/modules/humanResources   $SAGU/modules || exit 1
ln -s $SAGU_SVN/modules/institutional    $SAGU/modules || exit 1
ln -s $SAGU_SVN/modules/main_menu.inc    $SAGU/modules || exit 1
ln -s $SAGU_SVN/modules/modules.inc      $SAGU/modules || exit 1
ln -s $SAGU_SVN/modules/research         $SAGU/modules || exit 1
ln -s $SAGU_SVN/modules/selectiveProcess $SAGU/modules || exit 1
ln -s $SAGU_SVN/modules/sagu2            $SAGU/modules || exit 1
ln -s $SAGU_SVN/modules/services         $SAGU/modules || exit 1
ln -s $SAGU_SVN/modules/gnuteca          $SAGU/modules || exit 1
ln -s $SAGU_SVN/modules/accountsPayable  $SAGU/modules || exit 1
cp -a $SAGU_SVN/miolo2/etc               $SAGU

ln -s $SAGU_SVN/classes/ui/themes/sagu2     $SAGU/classes/ui/themes || exit 1
ln -s $SAGU_SVN/classes/ui/themes/sblue     $SAGU/classes/ui/themes || exit 1
ln -s $SAGU_SVN/classes/ui/themes/sgrape    $SAGU/classes/ui/themes || exit 1
ln -s $SAGU_SVN/classes/ui/themes/sgray     $SAGU/classes/ui/themes || exit 1
ln -s $SAGU_SVN/classes/ui/themes/sgreen    $SAGU/classes/ui/themes || exit 1
ln -s $SAGU_SVN/classes/ui/themes/sorange   $SAGU/classes/ui/themes || exit 1
ln -s $SAGU_SVN/classes/ui/themes/sred      $SAGU/classes/ui/themes || exit 1
ln -s $SAGU_SVN/classes/ui/themes/sunece    $SAGU/classes/ui/themes || exit 1
ln -s $SAGU_SVN/classes/ui/themes/sflorence $SAGU/classes/ui/themes || exit 1
ln -s $SAGU_SVN/classes/ui/themes/isolution $SAGU/classes/ui/themes || exit 1

ln -s $SAGU_SVN/modules/academic/html/images         $SAGU/html/images/modules/academic         || exit 1
ln -s $SAGU_SVN/modules/accountancy/html/images      $SAGU/html/images/modules/accountancy      || exit 1
ln -s $SAGU_SVN/modules/basic/html/images            $SAGU/html/images/modules/basic            || exit 1
ln -s $SAGU_SVN/modules/controlCopies/html/images    $SAGU/html/images/modules/controlCopies    || exit 1
ln -s $SAGU_SVN/modules/finance/html/images          $SAGU/html/images/modules/finance          || exit 1
ln -s $SAGU_SVN/modules/trade/html/images            $SAGU/html/images/modules/trade          || exit 1
ln -s $SAGU_SVN/modules/humanResources/html/images   $SAGU/html/images/modules/humanResources   || exit 1
ln -s $SAGU_SVN/modules/institutional/html/images    $SAGU/html/images/modules/institutional    || exit 1
ln -s $SAGU_SVN/modules/research/html/images         $SAGU/html/images/modules/research         || exit 1
ln -s $SAGU_SVN/modules/selectiveProcess/html/images $SAGU/html/images/modules/selectiveProcess || exit 1
ln -s $SAGU_SVN/modules/sagu2/html/images            $SAGU/html/images/modules/sagu2            || exit 1
ln -s $SAGU_SVN/modules/services/html/images         $SAGU/html/images/modules/services         || exit 1
ln -s $SAGU_SVN/modules/gnuteca/html/images          $SAGU/html/images/modules/gnuteca          || exit 1
ln -s $SAGU_SVN/modules/accountsPayable/html/images  $SAGU/html/images/modules/accountsPayable  || exit 1

cp $SAGU_SVN/miolo2/modules/admin/sql/admin.sqlite $SAGU/modules/admin/sql || exit 1
cp $SAGU_SVN/miolo2/html/favicon.ico               $SAGU/html              || exit 1

# Agata import
ln -s $AGATA_SVN/classes/core            $SAGU/classes/ || exit 1

# Permissoes
chmod 755    $SAGU -Rf                                  || exit 1
chown root   $SAGU -Rf                                  || exit 1
chown nobody $SAGU/var/log -Rf                          || exit 1
chown nobody $SAGU/modules/admin/sql -Rf                || exit 1
chown nobody $SAGU/modules/basic/upload -Rf             || exit 1
chown nobody $SAGU/modules/basic/html/images/upload -Rf || exit 1

echo "Blz. Funcionou"
