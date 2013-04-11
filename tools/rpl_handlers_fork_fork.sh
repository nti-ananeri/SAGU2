#!/bin/bash

FILES_REGISTER=$(find handlers -name \*.inc | grep register)

for file in $FILES_REGISTER
do
	if cat $file | grep 'Frm.*Search' > /dev/null
	then
		echo "$file-----------------------------"
		sed  -i "s|.*access::insert.*|&\n\$data->home = \$home;|;s|\(.*\)\('Frm.*Search[^']*'\)\(.*\)|\1\2, \$data\3|" $file
	fi
done

FILES_OTHER=$(find handlers -name \*.inc | grep -v register)

for file in $FILES_OTHER
do
        if cat $file | grep 'Frm' > /dev/null
	then
		echo "$file-----------------------------"
		sed  -i "s|.*access::insert.*|&\n\$data->home = \$home;|;s|\(.*\)\('Frm[^']*'\)\(.*\)|\1\2, \$data\3|" $file
	fi
done
