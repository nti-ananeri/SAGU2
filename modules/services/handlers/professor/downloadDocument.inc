<?php

/**
 * Sagu2 professor manual handler.
 *
 * @author Giovani Murilo D. Correa [gmurilo@gmail.com]
 *
 * @version $Id$
 *
 * \b Maintainers: \n
 * Daniel Afonso Heisler [daniel@isolution.inf.br]
 *
 * @since
 * Class created on 15/06/2009
 *
 **/

$home = 'main:professor:downloadDocument';
$navbar->addOption(_M('Download', $module), $module, $home);

$ui   = $MIOLO->getUI();
$file = $MIOLO->getModulePath('services', '/documents/Manual_Canal_do_Professor.pdf');

if ( file_exists($file) )
{
    if ( $parse = file_get_contents($file) )
    {
        $file = explode('/',$file);

        header("Cache-Control: public, must-revalidate");
        header("Pragma: hack");
        header("Content-Type: application/pdf");   
        header("Content-Type: application/force-download");
        header("Content-Type: application/octet-stream");
        header("Content-Type: application/download");
        header("Content-Description: File Transfer");
        header("Content-Length: " .(string)(strlen($parse)) );
        header('Content-Disposition: attachment; filename="' . $file[count($file)-1] . '"');
        header("Content-Transfer-Encoding: binary\n");
        print $parse;
    }
}
else
{
	echo _M('File not found').'!!!';
}

?>
