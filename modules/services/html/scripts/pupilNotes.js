/**
 *
 * @author Alexandre Heitor Schmidt [alexsmith@solis.coop.br]
 *
 * $version: $Id$
 *
 * \b Maintainers \n
 * Alexandre Heitor Schmidt [alexsmith@solis.coop.br]
 *
 * @since
 * Class created on 13/09/2007
 *
 * \b @organization \n
 * SOLIS - Cooperativa de Soluções Livres \n
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
 * Object to store a single evaluation entry.
 *
 * Contains the evaluation id and its weight.
 */
function objEvaluation(evaluationId, weight)
{
    this.evaluationId = evaluationId
    this.weight       = weight
}

/*
 * Object to store a single degree along with its evaluations
 */
function objDegree(degreeId, weight, isSubstitutive, maxNote)
{
    this.degreeId = degreeId
    this.weight   = weight
    this.isSubstitutive = isSubstitutive
    this.maxNote    = parseFloat(maxNote)

    this.evaluations = new Array()

    /*
     * Adds a new evaluation object to the list of evaluations
     *
     * @param objEvaluation (object): an objEvaluation object
     */
    this.addEvaluation = function(objEvaluation)
    {
        this.evaluations.push(objEvaluation)
    }

}

/*
 * Contains all information related to one enroll entry
 *
 * @param enrollId(int): enroll identificator
 * @param averageWeight(float): the weight of the average used to calculate the final note
 * @param examWeight(float): the weight of the exam also used to calculate the final note
 * @param freeOfExamAverage(float): the necessary average for being free of the exam
 * @param approveAverage(float): the necessary average for being approved
 * @param disapproveWithoutExamAverage(float): the average necessary to allow student to make exam
 *
 * @return (null): nothing
 */
function objEnroll(enrollId, averageWeight, examWeight, freeOfExamAverage, approveAverage, disapproveWithoutExamAverage, minimumFrequency, maxNote)
{
    // enroll identificator
    this.enrollId = enrollId
    // weight of the average for calculating the final note
    this.averageWeight = averageWeight
    // weight of the exam for calculating the final note
    this.examWeight = examWeight
    // minimum note for being free of the exam
    this.freeOfExamAverage = freeOfExamAverage
    // minimum note for being approved
    this.approveAverage = approveAverage
    // minimum note to make exam
    this.disapproveWithoutExamAverage = disapproveWithoutExamAverage
    // an array containing all degrees associated with this enroll
    this.degrees = new Array()
    // boolean indicating this pupil is free of exam
    this.isFreeOfExam = false
    // boolean indicating this pupil is approved
    this.isApproved = false
    // boolean indicatinf if canot make exam
    this.isDisapproveWithoutExamAverage = false
    // minimum frequency
    this.minimumFrequency = minimumFrequency
    // max note
    this.maxNote = parseFloat(maxNote)

    /*
     * Adds a new degree to this enroll object
     *
     * @param objDegree (object): a degree object
     */
    this.addDegree = function(objDegree)
    {
        this.degrees.push(objDegree)
    }

    /*
     * Find a degree in the local list of degrees, querying by degreeId
     *
     * @param degreeId (int): the degree identificator
     *
     * @return (objDegree): the degree object or null if not found
     */
    this.getDegree = function(degreeId)
    {
        var i
        var retVal = null
        for ( i=0; i<this.degrees.length; i++ )
        {
            if ( this.degrees[i].degreeId == degreeId )
            {
                retVal = this.degrees[i]
                break
            }
        }
        return retVal
    }

    /*
     * Calculate the average of the informed degree by iterating through all evaluations
     * associated with the degree
     *
     * @param degreeId (int): the degree identificator
     */
    this.updateDegree = function(degreeId, evaluationId)
    {
        var i
        var noteField
        var weight
        var noteSum = 0
        var weightSum = 0
        var allFieldsValid = true
        var atualNote = 0
        var atualWeight = 0

        //troca a virgula por ponto no grau do aluno
        var temp1 = document.getElementById('evaluation[' + this.enrollId + '][' + degreeId + '][' + evaluationId + ']').value.toString()
        document.getElementById('evaluation[' + this.enrollId + '][' + degreeId + '][' + evaluationId + ']').value = temp1.replace(',', '.')
        var temp2 = document.getElementById('evaluation[' + this.enrollId + '][' + degreeId + '][' + evaluationId + ']').value
        document.getElementById('evaluation[' + this.enrollId + '][' + degreeId + '][' + evaluationId + ']').value = this.roundNumber(temp2, 2)

        for ( i=0; i<this.getDegree(degreeId).evaluations.length && allFieldsValid; i++ )
        {
            noteField = document.getElementById('evaluation[' + this.enrollId + '][' + degreeId + '][' + this.getDegree(degreeId).evaluations[i].evaluationId + ']')
            weight = this.getDegree(degreeId).evaluations[i].weight
            allFieldsValid = (! isNaN(parseFloat(noteField.value)))

            if ( this.getDegree(degreeId).isSubstitutive == 'f' )
            {
                atualWeight = weight
                atualNote = parseFloat(noteField.value) * weight
            }
            noteSum += atualNote
            weightSum += atualWeight
        }

        if ( allFieldsValid )
        {
            // set the note of this degree
            document.getElementById('degree[' + this.enrollId + '][' + degreeId + ']').value = this.roundNumber((noteSum / weightSum), 2)

            // as the degree has changed, average must also change
            this.updateAverage()
        }
    }

    /*
     * Calculate the average of all degrees by iterating through them
     */
    this.updateAverage = function(field)
    {
        var i
        var noteField
        var weight
        var noteSum = 0
        var weightSum = 0
        var allFieldsValid = true
        var atualNote = 0
        var atualWeight = 0
        var weight2 = 0
        var noteField2
        var minimumNote = 11
        var minimumWeight = 11

        //troca a virgula por ponto no grau do aluno
        if ( (document.getElementById(field).value.toString() != '--') && document.getElementById(field).value.indexOf(',') != -1)
        {
            var temp1 = document.getElementById(field).value.toString()
            document.getElementById(field).value = temp1.replace(',', '.')
        }
        //Se for um valor numérico ou o valor de isencao --
        if ( document.getElementById(field).value.length > 0 && ( !isNaN(document.getElementById(field).value.toString()) || document.getElementById(field).value == '--') )
        {
            //Se for nao valor de isencao --
           if(document.getElementById(field).value != '--')
            {
                var temp2 = document.getElementById(field).value
                document.getElementById(field).value = this.roundNumber(temp2, 2)
            }
            //Verifica todos os graus
            for ( i=0; i<this.degrees.length && allFieldsValid; i++ )
            {
                //Preenche os dados da nota
                noteField = document.getElementById('degree[' + this.enrollId + '][' + this.degrees[i].degreeId + ']')
                //Verifica se o conteudo da nota nao é nulo
                if (noteField.value.length > 0 )
                {
                    weight = this.degrees[i].weight
                    //Verifica se é uma nota ou isencao da nota
                    allFieldsValid = ( !isNaN(noteField.value) || (noteField.value == '--') )
                    //Verifica se é uma nota normal
                    if ( this.degrees[i].isSubstitutive == 'f' )
                    {
                        atualWeight = weight
                        noteFieldValue = noteField.value == '--' ? 0 : noteField.value 
                        atualNote = parseFloat(noteFieldValue);
//                        * weight
                    }
                    if ( atualNote/atualWeight > this.degrees[i].maxNote ) 
                    { 
                        atualNote = this.degrees[i].maxNote
                        atualWeight = 1
                        noteField.value = this.roundNumber(parseFloat(atualNote),2)
                    }
                    noteSum += atualNote
                    //weightSum += atualWeight
                    weightSum = 1;
                }
                else
                {
                    allFieldsValid = false
                }
            }
            //Se todos os campos permaneceram validos
            if ( allFieldsValid )
            {
                // set the average field value
                if ( !isNaN(parseFloat(noteSum)) )
                {
                    weightSum =    averageWeight;
		    weightSum = this.degrees.length/2;
 
                    document.getElementById('average[' + this.enrollId + ']').value = this.roundNumber((noteSum / weightSum),2)
                }
                else
                {
                    document.getElementById('average[' + this.enrollId + ']').value = ''
                }
                document.getElementById('exam[' + this.enrollId + ']').disabled = false
                // as average has changed, final note will also change
                this.updateFinalNote()
            }
            else
            {
                document.getElementById('average[' + this.enrollId + ']').value = ''
                document.getElementById('finalNote[' + this.enrollId + ']').value = ''
                document.getElementById('exam[' + this.enrollId + ']').disabled = true
            }
        }
        else
        {
            document.getElementById(field).value = ''
            document.getElementById('average[' + this.enrollId + ']').value = ''
            document.getElementById('finalNote[' + this.enrollId + ']').value = ''
        }
    }

    /*
     * Calculate the final note based on average and exam notes
     */
    this.updateFinalNote = function()
    {
        var averageField = document.getElementById('average[' + this.enrollId + ']')
        var examField    = document.getElementById('exam[' + this.enrollId + ']')
        var finalNote    = document.getElementById('finalNote[' + this.enrollId + ']')
        //Verifica todos os graus
        for ( i=0; i<this.degrees.length; i++ )
        {
            if ( this.degrees[i].isSubstitutive == 'f' )
            {
                //Preenche os dados da nota
                noteField = document.getElementById('degree[' + this.enrollId + '][' + this.degrees[i].degreeId + ']')
                //Verifica se o conteudo da nota nao é nulo
                if (noteField.value.length == 0  ||  ( isNaN(noteField.value) && noteField.value != '--') )
                {
                    examField.disabled = true
                    finalNote.value = ''
                    examField.value = ''
                    return true;
                }
            }
        }
 
        //troca a virgula por ponto na media final
        averageField.value   = averageField.value.replace(',', '.')
        var averageField_aux = averageField.value
        averageField.value   = this.roundNumber(averageField_aux, 2)

        //troca a virgula por ponto no exame
        if ( examField.value.indexOf(',') != -1 )
        {
            var examField_aux   = examField.value.replace(',', '.')
            examField.value = examField_aux;
        }

        if ( !isNaN(examField.value) && examField.value.length > 0 )
        {
            examField.value   = this.roundNumber(examField.value, 2)
            if( parseFloat(examField.value) > this.maxNote )
            {
                examField.value = this.roundNumber(parseFloat(this.maxNote), 2)
            }
        }
        else if ( examField.value != '--' )
        {
            examField.value = '';
        }
        //troca a virgula por ponto na nota final
        finalNote.value   = finalNote.value.replace(',', '.')
        var finalNote_aux = finalNote.value
        finalNote.value   = this.roundNumber(finalNote_aux, 2)

        document.getElementById('exam[' + this.enrollId + ']').disabled = false

        var allFieldsValid = ((!isNaN(parseFloat(averageField.value))) || (!isNaN(parseFloat(examField.value)) || examField.value == '--' ))

        //se a nota for menor que a nota mínima para poder fazer o exame
        this.isDisapproveWithoutExamAverage = (parseFloat(averageField.value) < this.disapproveWithoutExamAverage)
        //se a nota for maior ou igual a nota para obrigação do exame
        this.isFreeOfExam = (parseFloat(averageField.value) >= this.freeOfExamAverage)
        

        if ( this.isDisapproveWithoutExamAverage )
        {
            finalNote = averageField.value
            document.getElementById('exam[' + this.enrollId + ']').disabled = true
            document.getElementById('exam[' + this.enrollId + ']').value = ''
            document.getElementById('finalNote[' + this.enrollId + ']').value = document.getElementById('average[' + this.enrollId + ']').value;
            examField.value = ''
        }
        else
        {
            if ( this.isFreeOfExam )
            {
                finalNote = averageField.value
                document.getElementById('exam[' + this.enrollId + ']').disabled = true
                document.getElementById('exam[' + this.enrollId + ']').value = ''
                examField.value = ''
            }
            else
            {
                document.getElementById('exam[' + this.enrollId + ']').disabled = false
                if ( examField.value != '--' )
                {
                //    var noteSum = parseFloat(averageField.value) * this.averageWeight + parseFloat(examField.value) * this.examWeight
                //    var weightSum = this.averageWeight + this.examWeight
                    var noteSum = (parseFloat(averageField.value)) + (parseFloat(examField.value) * this.examWeight)
                    var weightSum = 1 + this.examWeight
                }
                else
                {
                    var noteSum = parseFloat(averageField.value)
                    var weightSum = 1
                }
                finalNote = (noteSum / weightSum)
            }

            //se a nota final não tiver um valor definido
            if ( allFieldsValid )
            {
                // se as duas notas estiverem definidas (médina final e nota do exame)
//                if (! (isNaN(parseFloat(averageField.value)) || isNaN(parseFloat(examField.value))))
                if ( !isNaN(parseFloat(averageField.value)) && (!isNaN(parseFloat(examField.value)) || examField.value == '--' ))
                {
                    document.getElementById('finalNote[' + this.enrollId + ']').value = this.roundNumber(finalNote, 2)
                }
                else
                {
                    if ( !isNaN(parseFloat(averageField.value)) && ( this.isFreeOfExam || this.isDisapproveWithoutExamAverage ) )
                    {
                        document.getElementById('finalNote[' + this.enrollId + ']').value = this.roundNumber(finalNote, 2)
                    }
                    else
                    {
                        document.getElementById('exam[' + this.enrollId + ']').disabled = false
                        document.getElementById('finalNote[' + this.enrollId + ']').value = ''
                        document.getElementById('status[' + this.enrollId + ']').src = reprovedImage
                        document.getElementById('status[' + this.enrollId + ']').title = reprovedText
                    }
                }
            }

            this.updateApprovalStatus()
        }
    }

    this.updateApprovalStatus = function()
    {
        // set final note field
        var finalNote = document.getElementById('finalNote[' + this.enrollId + ']')
        var examNote  = document.getElementById('exam[' + this.enrollId + ']')
        var frequency = document.getElementById('frequency[' + this.enrollId + ']')

        //troca a virgula por ponto na nota final
        finalNote.value   = finalNote.value.replace(',', '.')
        var finalNote_aux = finalNote.value
        finalNote.value   = this.roundNumber(finalNote_aux, 2)
        
        if ( ! isNaN(parseFloat(finalNote.value)) )
        {
            if ( examNote.value == '--' || examNote.value.legth == 0  )
            {
                this.isApproved = (parseFloat(finalNote.value) >= this.freeOfExamAverage)                
            }
            else
            {
                this.isApproved = (parseFloat(finalNote.value) >= this.approveAverage)
            }

            if(frequency)
            {
                this.isApproved = ((parseFloat(frequency.value) >= this.minimumFrequency) && this.isApproved)
            }

            // control the pupil approval status
            if ( this.isApproved )
            {
                document.getElementById('status[' + this.enrollId + ']').src = approvedImage
                document.getElementById('status[' + this.enrollId + ']').title = approvedText
            }
            else
            {
                document.getElementById('status[' + this.enrollId + ']').src = reprovedImage
                document.getElementById('status[' + this.enrollId + ']').title = reprovedText
            }
        }
    }
    
    this.roundNumber = function(num, dec)
    {
	    var temp1 = Math.round(num*Math.pow(10,dec))/Math.pow(10,dec)
	    if ( temp1.toString().substr(temp1.toString().length-3, 1) == '.' )
	    {
	        return temp1
	    }
	    else
	    {
    	    if ( temp1.toString().substr(temp1.toString().length-2, 1) == '.' )
	        {
	            return (temp1 + '0')
    	    }
    	    else
    	    {
    	        if ( temp1.toString().substr(temp1.toString().length-1, 1) != '.' )
	            {
	                return (temp1 + '.00')
        	    }
    	    }
	    }
	    return temp1
    }
}

