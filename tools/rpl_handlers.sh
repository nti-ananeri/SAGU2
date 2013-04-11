#!/bin/bash

FILES=$(find handlers -name \*.inc)

for file in $FILES
do
	if cat $file | grep function > /dev/null
	then
		STRING=$(cat $file | sed -n '/addOption/p' | sed "s|.*_M.\(.[^']*.\).*|\1|")
		ICON=$(echo \'$(echo $file | rev | cut -f1 -d/ | rev | cut -f1 -d.)-16x16.png\')
		RPL1=$(echo "\$MIOLO->getClass('basic', 'access');")
		RPL2=$(echo "access::insert($STRING, \$home, $ICON);")
		sed -i "s/.*addOption.*/&\n\n$RPL1\n$RPL2/" $file
		echo "$file - OK"
	fi
done
