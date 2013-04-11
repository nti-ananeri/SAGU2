<?php
 /**
 * dbdownload handler.
 * Contains the menus to access turn registers
 *
 * @author Alexandre Heitor Schmidt [alexsmith@solis.coop.br]
 *
 * @version $Id$
 *
 * \b Maintainers: \n
 * Alexandre Heitor Schmidt [alexsmith@solis.coop.br]
 *
 * @since
 * Class created on 30/08/2007
 *
 * \b Organization: \n
 * SOLIS - Cooperativa de Solucoes Livres \n
 * The SAGU2 Development Team
 *
 * \b CopyLeft: \n
 * CopyLeft (L) 2005 SOLIS - Cooperativa de Solucoes Livres \n
 *
 * \b License: \n
 * Licensed under GPL (for further details read the COPYING file or http://www.gnu.org/copyleft/gpl.html )
 *
 * \b History: \n
 * See history in CVS repository: http://sagu.solis.coop.br
 *
 **/
     
$MIOLO->checkAccess($module, BAS_ACCESS, true, true);

$dbName = $MIOLO->getConf('db.basic.name');
$dbUser = $MIOLO->getConf('db.basic.user');
$dbHost = $MIOLO->getConf('db.basic.host');
$dbPort = $MIOLO->getConf('db.basic.port');
$dbPass = $MIOLO->getConf('db.basic.password');

$which = "which pg_dump";
exec($which, $retData, $retVal);
if ( strlen($retData[0]) == 0 )
{
    $MIOLO->error($which . ': ' . $retVal);
}
else
{
    $bin = $retData[0];
    $tmpDir = sys_get_temp_dir();
    $tmpFile = 'dump-' . date('YmdHis') . '.sql.gz';
    putenv("PGPASSWORD=$dbPass");
    $pg_dump = "$bin $dbName -h $dbHost -p $dbPort -U$dbUser -f $tmpDir/$tmpFile -Z 9";
    exec($pg_dump, $retData, $retVal);
    if ( $retVal != 0 )
    {
        $MIOLO->error($pg_dump . ': ' . $retVal);
    }
    else
    {
        header('Content-Type: application/x-compressed-tar');
        header('Content-Length: ' . filesize("$tmpDir/$tmpFile"));
        header('Content-disposition: inline; filename="db' . $tmpFile . '"');
        passthru("cat $tmpDir/$tmpFile");
        exec("rm $tmpDir/$tmpFile", $retData, $retVal);
    }
}

exit;

?>
