#!/bin/bash

FILES_REGISTER=$(find handlers -name \*.inc)

LINE1="        //favoritos"
LINE2="        \$enabledImage  = \$MIOLO->getUI()->GetImageTheme(\$MIOLO->theme->id, 'bookmark-20x20.png');"
LINE3="        \$disabledImage = \$MIOLO->getUI()->GetImageTheme(\$MIOLO->theme->id, 'bookmark-disabled-20x20.png');"
LINE4="        \$url           = \$MIOLO->getActionURL(\$module, \$this->home, null, array('function' => 'search', 'event' => 'bookmark'));"
LINE5="        \$toolBar->addButton('tbBtnBookmark', _M('Bookmarks', 'basic'), \$url, null, true, \$enabledImage, \$disabledImage);"
LINE6=""
LINE7="        if ( MIOLO::_request('event') == 'bookmark' )"
LINE8="        {"
LINE9="            \$MIOLO->getClass('basic', 'access');"
LINE11="        }"
LINE12="        //fim favoritos"


for file in $FILES_REGISTER
do
	if cat $file | grep 'access::insert' > /dev/null 
	then
		if cat $file | grep -v '//' | grep 'Frm.*Search' > /dev/null
		then
			FORM=$(echo $(cat $file | grep -v '//' | grep -o "Frm.*Search" | head -1).class)
			STRING=$(cat $file | sed -n '/addOption/p' | sed "s|.*_M.\(.[^']*.\).*|\1|")
			ICON=$(echo \'$(echo $file | rev | cut -f1 -d/ | rev | cut -f1 -d.)-16x16.png\')
			LINE10="            access::insert($STRING, \$this->home, $ICON, true);"
			if ! cat forms/$FORM | grep 'access::insert' > /dev/null && cat forms/$FORM | grep 'toolBar' > /dev/null
			then
				sed -i "s|    function __construct()|    function __construct(\$data)|" forms/$FORM
				sed -i "s|^{|&\n    private \$home;|" forms/$FORM
				sed -i "s|.*parent::__construct.*|        \$this->home   = \$data->home;\n\n&|" forms/$FORM
				sed -i "s|.*\$fields\[\] = \$toolBar.*|\n$LINE1\n$LINE2\n$LINE3\n$LINE4\n$LINE5\n$LINE6\n$LINE7\n$LINE8\n$LINE9\n$LINE10\n$LINE11\n$LINE12\n\n&|" forms/$FORM
				echo ". . . . . . . . $FORM"
			fi
		else
			if cat $file | grep 'Frm' > /dev/null
			then
				FORM=$(echo $(cat $file | grep -v '//' | grep -o "Frm[^']*" | head -1).class)
				echo ". . . . . . . . $FORM"
				STRING=$(cat $file | sed -n '/addOption/p' | sed "s|.*_M.\(.[^']*.\).*|\1|")
				ICON=$(echo \'$(echo $file | rev | cut -f1 -d/ | rev | cut -f1 -d.)-16x16.png\')
				LINE10="            access::insert($STRING, \$this->home, $ICON, true);"
				if ! cat forms/$FORM | grep 'access::insert' > /dev/null && cat forms/$FORM | grep 'toolBar' > /dev/null
				then
					sed -i "s|    function __construct()|    function __construct(\$data)|" forms/$FORM
					sed -i "s|^{|&\n    private \$home;|" forms/$FORM
					sed -i "s|.*parent::__construct.*|        \$this->home   = \$data->home;\n\n&|" forms/$FORM
					sed -i "s|.*\$fields\[\] = \$toolBar.*|\n$LINE1\n$LINE2\n$LINE3\n$LINE4\n$LINE5\n$LINE6\n$LINE7\n$LINE8\n$LINE9\n$LINE10\n$LINE11\n$LINE12\n\n&|" forms/$FORM
				fi
			fi
		fi
	fi
done
