/*
 * Carrega as imagens para presencas
 */
var src0hImage;
var src1hImage;
var src2hImage;
var src3hImage;
var src4hImage;
var src5hImage;
var src6hImage;
var src7hImage;
var src8hImage;
var src9hImage;
var src10hImage;
var src24hImage;
var srcAddOnImage;
var srcAddOffImage;

var scheduleObj   = new Array();
var frequencyObj  = new Array();
var enrolls       = new Array()
var countSchedule = 0
var turnedAddButtonOff     = new Array();

function setImageSources(   urlAddOn, 
                            urlAddOff,
                            src0h,
                            src1h, 
                            src2h, 
                            src3h, 
                            src4h, 
                            src5h, 
                            src6h, 
                            src7h, 
                            src8h, 
                            src9h,
                            src10h ) 
{
    this.src0hImage             = src0h;
    this.src1hImage             = src1h;
    this.src2hImage             = src2h;
    this.src3hImage             = src3h;
    this.src4hImage             = src4h;
    this.src5hImage             = src5h;
    this.src6hImage             = src6h;
    this.src7hImage             = src7h;
    this.src8hImage             = src8h;
    this.src9hImage             = src9h;
    this.src10hImage            = src10h;
    this.srcAddOnImage          = urlAddOn;
    this.srcAddOffImage         = urlAddOff;
}

function objFrequency(frequencyDate, frequency)
{
    this.frequencyDate      = frequencyDate
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

function setSchedulesNumber(number)
{
    if ( isNaN(number) )
    {
        number = 0 ;
    }
    this.countSchedule = number
}

function setData(enrollId, frequencyDate, numberHours, firstTime)
{
    var idX = "imgFreq[" + enrollId + "][" + frequencyDate + "]";
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
         parseInt(numberHours) != 8 && parseInt(numberHours) != 9 && 
         parseInt(numberHours) != 10 
         )
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
        if ( this.enrolls[positionEnroll].frequencies[x].frequencyDate == frequencyDate )
        {
            positionFrequency = x
        }
    }

    if ( positionFrequency == -1 )
    {
        this.enrolls[positionEnroll].frequencies.push(new objFrequency(frequencyDate, numberHours))
        positionFrequency = this.enrolls[positionEnroll].frequencies.length-1
    }
    else
    {
        this.enrolls[positionEnroll].frequencies[positionFrequency].setFrequency(numberHours)
    }
    
    if ( firstTime == true )
    {
        this.enrolls[positionEnroll].presenceHours =  parseFloat(this.enrolls[positionEnroll].presenceHours);
        this.enrolls[positionEnroll].presenceHours = this.enrolls[positionEnroll].presenceHours + parseFloat(numberHours);
    }
    else
    {
        this.enrolls[positionEnroll].presenceHours = this.enrolls[positionEnroll].presenceHours - 1;
    }
    document.getElementById('lbPres_' + enrollId).innerHTML = this.enrolls[positionEnroll].presenceHours
    var percentPresence = Math.round((this.enrolls[positionEnroll].presenceHours/(( this.countSchedule )))*100)
    document.getElementById('lbPercentPres_' + enrollId).innerHTML = '(' + percentPresence + '%)'

    this.enrolls[positionEnroll].absenceHours = ((this.countSchedule ) - this.enrolls[positionEnroll].presenceHours )
    document.getElementById('lbAbs_' + enrollId).innerHTML=this.enrolls[positionEnroll].absenceHours
    
    var percentAbsence = 100 - percentPresence
    document.getElementById('lbPercentAbs_' + enrollId).innerHTML='(' + percentAbsence + '%)'
}
    
function turnOffAddButton(frequencyDate)
{
    var inarray = false;
    for ( x in turnedAddButtonOff )
    {
        if ( turnedAddButtonOff[x] == frequencyDate )
        {
            inarray = true;
        }
    }
    if ( inarray == false )
    {
        turnedAddButtonOff.push(frequencyDate);
        var idX ='imgAdd_' + frequencyDate;
        var element = document.getElementById(idX);
        if(!element)
        {
            return false;
        }
        // element.onclick = null;
        element.src     = this.srcAddOffImage;
    }
}

function setPresence(frequencyDate, lessonNumberHours)
{
    var inarray = false;
    for ( x in turnedAddButtonOff )
    {
        if ( turnedAddButtonOff[x] == frequencyDate )
        {
            inarray = true;
        }
    }

    if ( inarray == false )
    {
        this.countSchedule += parseFloat ( lessonNumberHours )
        for (x in this.enrolls)
        {
            setData(this.enrolls[x].enrollId, frequencyDate, lessonNumberHours, true)
        }
        turnOffAddButton(frequencyDate)
    }
    else
    {
        for (x in this.enrolls)
        {
            updateFrequency(frequencyDate, this.enrolls[x].enrollId, lessonNumberHours)
        }

    }

}

function updateFrequency(frequencyDate, enrollId, numberHours)
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
        if ( this.enrolls[positionEnroll].frequencies[x].frequencyDate == frequencyDate )
        {
            positionFrequency = x
        }
    }

    if ( this.enrolls[positionEnroll].frequencies[positionFrequency].frequency == 0 )
    {
        setData(enrollId, frequencyDate, numberHours, true)
    }
    else
    {
        setData(enrollId, frequencyDate, -(this.enrolls[positionEnroll].frequencies[positionFrequency].frequency-1), false)
    }

    document.getElementById('divContent').innerHTML = ""
}

function setPresenceAll(numberHours)
{
	var positionEnroll = -1
    for ( positionEnroll in this.enrolls )
    {
      for ( x in this.enrolls[positionEnroll].frequencies )
      {
    	//alert(this.enrolls[positionEnroll].frequencies[x].frequencyDate);  
        setPresence(this.enrolls[positionEnroll].frequencies[x].frequencyDate, numberHours);
      }	
    }
}