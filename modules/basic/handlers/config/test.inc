<?php

$MIOLO->trace('file:' . $_SERVER['SCRIPT_NAME']);
$business  = $MIOLO->getBusiness('basic','BusConfig');
$constants = $business->getModuleValues('basic');
if ( count($constants)>0 )
{
    foreach ( $constants as $cnt )
    {
        define($cnt[0],$cnt[1], true);
    }
}

$constants = $business->getModuleValues('academic');
if ( count($constants)>0 )
{
    foreach ( $constants as $cnt )
    {
        define(trim($cnt[0]),trim($cnt[1]), true);
    }
}
$constants = $business->getModuleValues('finance');
if ( count($constants)>0 )
{
    foreach ( $constants as $cnt )
    {
        define(trim($cnt[0]),trim($cnt[1]), true);
    }
}
$constants = $business->getModuleValues('selectiveProcess');

if ( count($constants)>0 )
{
    foreach ( $constants as $cnt )
    {
        define(trim($cnt[0]),trim($cnt[1]), true);
    }
}

$class = MIOLO::_request('fileTest');
$MIOLO->getClass('basic',$class);
$a = new $class();
?>
