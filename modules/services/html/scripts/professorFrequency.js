/**
 *
 * @author Armando Taffarel Neto [taffarel@solis.coop.br]
 *
 * $version: $Id$
 *
 * \b Maintainers \n
 * Armando Taffarel Neto [taffarel@solis.coop.br]
 *
 * @since
 * Class created on 10/09/2007
 *
 * \b @organization \n
 * SOLIS - Cooperativa de Soluções Livres \n
 *
 * \b Copyleft \n
 * Copyleft (L) 2007 - SOLIS - Cooperativa de Soluções Livres \n
 *
 * \b License \n
 * Licensed under GPL (for further details read the COPYING file or http://www.gnu.org/copyleft/gpl.html )
 *
 * \b History \n
 * This function select and retun a value correctly from document javascript form 
 */

var src0hImage
var src1hImage
var src2hImage
var src3hImage
var src4hImage
var src5hImage
var src6hImage
var src7hImage
var src8hImage
var src9hImage
var srcAddOnImage
var srcAddOffImage

var enrolls = new Array()

var countSchedule = 0

var numberHours
var allowHalfPresence


function objFrequency(academicCalendarId, scheduleId, frequencyDate, turnId, frequency)
{
    this.academicCalendarId = academicCalendarId
    this.scheduleId         = scheduleId
    this.frequencyDate      = frequencyDate
    this.turnId             = turnId
    this.frequency          = frequency

    this.setFrequency = function(frequency)
    {
        this.frequency = frequency
    }

}

function objEnroll(enrollId)
{
    this.enrollId = enrollId
    
    this.presenceHours = 0
    this.absenceHours  = 0
    
    this.frequencies = new Array()

    this.addFrequency = function(objFrequency)
    {
        this.frequencies.push(objFrequency)
    } 
    
    this.setPresenceHours = function(presenceHours)
    {
        this.presenceHours = presenceHours
    }

    this.setAbsenceHours = function(absenceHours)
    {
        this.absenceHours = absenceHours
    }
}

function setImageSources(src0h, src1h, src2h, src3h, src4h, src5h, src6h, src7h, src8h, src9h, urlAddOn, urlAddOff)
{
    this.src0hImage           = src0h
    this.src1hImage           = src1h
    this.src2hImage           = src2h
    this.src3hImage           = src3h
    this.src4hImage           = src4h
    this.src5hImage           = src5h
    this.src6hImage           = src6h
    this.src7hImage           = src7h
    this.src8hImage           = src8h
    this.src9hImage           = src9h
    this.srcAddOnImage        = urlAddOn
    this.srcAddOffImage       = urlAddOff
}

function setNumberHours(numberHours, allowHalfPresence)
{
    this.numberHours       = numberHours
    this.allowHalfPresence = allowHalfPresence
}

function setSchedulesNumber(number)
{
    this.countSchedule = number
}

function setData(academicCalendarId, scheduleId, enrollId, frequencyDate, turnId, numberHours, firstTime)
{
    var idX = "imgFreq_" + academicCalendarId + "_" + scheduleId + "_" + enrollId;
    var element = document.getElementById(idX);
    if(!element)
    {
        return false;
    }

    if ( numberHours < 0 )
    {
        numberHours = numberHours * (-1);
    }

    if ( parseInt(numberHours) != 0 && parseInt(numberHours) != 1 && 
         parseInt(numberHours) != 2 && parseInt(numberHours) != 3 &&
         parseInt(numberHours) != 4 && parseInt(numberHours) != 5 &&
         parseInt(numberHours) != 6 && parseInt(numberHours) != 7 &&
         parseInt(numberHours) != 8 && parseInt(numberHours) != 9  )
    {
        var el = "this.src0hImage";
    }
    else
    {
        var el = "this.src" + parseInt(numberHours) + "hImage";
    }
    eval("element.src = " + el + ";");

    var positionEnroll = -1
    for ( x in this.enrolls )
    {
        if ( this.enrolls[x].enrollId == enrollId)
        {
            positionEnroll = x
        }
    }
    
    if ( positionEnroll == -1 )
    {
        this.enrolls.push(new objEnroll(enrollId))
        positionEnroll = this.enrolls.length-1
    }

    var positionFrequency = -1
    for ( x in this.enrolls[positionEnroll].frequencies )
    {
        if ( this.enrolls[positionEnroll].frequencies[x].scheduleId         == scheduleId &&
             this.enrolls[positionEnroll].frequencies[x].academicCalendarId == academicCalendarId )
        {
            positionFrequency = x
        }
    }

    if ( positionFrequency == -1 )
    {
        this.enrolls[positionEnroll].frequencies.push(new objFrequency(academicCalendarId, scheduleId, frequencyDate, turnId, numberHours))
        positionFrequency = this.enrolls[positionEnroll].frequencies.length-1
    }
    else
    {
        this.enrolls[positionEnroll].frequencies[positionFrequency].setFrequency(numberHours)
    }
    
//    this.enrolls[positionEnroll].presenceHours = this.enrolls[positionEnroll].presenceHours + numberHours
    if ( firstTime == true )
    {
        this.enrolls[positionEnroll].presenceHours = this.enrolls[positionEnroll].presenceHours + numberHours;
    }
    else
    {
        this.enrolls[positionEnroll].presenceHours = this.enrolls[positionEnroll].presenceHours - 1;
    }
    document.getElementById('lbPres_' + enrollId).innerHTML=this.enrolls[positionEnroll].presenceHours

    var percentPresence = Math.round((this.enrolls[positionEnroll].presenceHours/(this.countSchedule * this.numberHours))*100)
    document.getElementById('lbPercentPres_' + enrollId).innerHTML='(' + percentPresence + '%)'

    this.enrolls[positionEnroll].absenceHours = (this.countSchedule * this.numberHours) - this.enrolls[positionEnroll].presenceHours
    document.getElementById('lbAbs_' + enrollId).innerHTML=this.enrolls[positionEnroll].absenceHours
    
    var percentAbsence = 100 - percentPresence
    document.getElementById('lbPercentAbs_' + enrollId).innerHTML='(' + percentAbsence + '%)'
}
    
function turnOffAddButton(academicCalendarId, scheduleId)
{
    var idX ='imgAdd_'+ academicCalendarId + '_' + scheduleId;
    var element = document.getElementById(idX);
    if(!element)
    {
        return false;
    }
    element.onclick = null;
    element.src     = this.srcAddOffImage;
}

/*
 * Function to populate frequencies with presences
 */
function setPresence(academicCalendarId, scheduleId, frequencyDate, turnId)
{
    this.countSchedule = this.countSchedule + 1
    
    for (x in this.enrolls)
    {
        setData(academicCalendarId, scheduleId, this.enrolls[x].enrollId, frequencyDate, turnId, this.numberHours, true)
    }

    turnOffAddButton(academicCalendarId, scheduleId)
}

function updateFrequency(academicCalendarId, scheduleId, enrollId)
{
    var positionEnroll = -1
    for ( x in this.enrolls )
    {
        if ( this.enrolls[x].enrollId == enrollId)
        {
            positionEnroll = x
        }
    }

    var positionFrequency = -1
    for ( x in this.enrolls[positionEnroll].frequencies )
    {
        if ( this.enrolls[positionEnroll].frequencies[x].scheduleId         == scheduleId &&
             this.enrolls[positionEnroll].frequencies[x].academicCalendarId == academicCalendarId )
        {
            positionFrequency = x
        }
    }

    if ( this.enrolls[positionEnroll].frequencies[positionFrequency].frequency == 0 )
    {
        setData(academicCalendarId, scheduleId, enrollId, null, null, this.numberHours, true)
    }
    else
    {
        setData(academicCalendarId, scheduleId, enrollId, null, null, -(this.enrolls[positionEnroll].frequencies[positionFrequency].frequency-1), false)
    }

    document.getElementById('divContent').innerHTML = ""
}
