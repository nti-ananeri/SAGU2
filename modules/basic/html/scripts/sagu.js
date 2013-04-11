/**
 *
 * @author William Prigol Lopes [william@solis.coop.br]
 *
 * $version: $Id$
 *
 * \b Maintainers \n
 * William Prigol Lopes     [william@solis.coop.br]
 * Eduardo Beal Miglioransa [eduardo@solis.coop.br]
 *
 * @since
 * Class created on 05/06/2006
 *
 * \b @organization \n
 * SOLIS - Cooperativa de SoluÃ§Ãµes Livres \n
 *
 * \b Copyleft \n
 * Copyleft (L) 2005 - SOLIS - Cooperativa de Soluções Livres \n
 *
 * \b License \n
 * Licensed under GPL (for further details read the COPYING file or http://www.gnu.org/copyleft/gpl.html )
 *
 * \b History \n
 * This function select and retun a value correctly from document javascript form 
 */

/*
 * Function to show or hide a specific element data
 */
function showElements( elementName, elementToThreat )
{
    var fields = document.getElementsByName( elementName );
    for (var i = 0; i<fields.length; i++)
    {
        if (fields[i].checked)
        {
            value = fields[i].value;
        }
    }
    document.getElementById( 'm_' + elementToThreat ).style.display = value == 'true' ? '' : 'none';
} 

/*
 * Function close window and reload te opener page
 */
function closeAndReload()
{
    window.close();
    window.opener.location.reload();
}

/*
 * Function to redirect the opener for a specific place and optionally close the main window
 */ 
function openGoAndExit(url, goClose)
{
   window.opener.frames["content"].location=url;
}
 
