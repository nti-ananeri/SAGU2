cd /home/alexsmith/miolo2/modules

for MODULE in academic accountancy basic finance institutional pupilAssistance selectiveProccess
do
    echo "Entering $MODULE..."
    for FILE in $(find $MODULE/forms -name 'Frm*.class' | grep -v "Search\.class")
    do
        echo " Processing file $FILE..."
        sed 's/            $goto[ ]*=[ ]*\($MIOLO->getActionURL(.*);\).*/            $goto = SAGU::getStackBackUrl() ? SAGU::getStackBackUrl() : \1/g;s/        $gotoNo[ ]*=[ ]*\($MIOLO->getActionURL(.*);\).*/        $gotoNo = SAGU::getStackBackUrl() ? SAGU::getStackBackUrl() : \1/g' $FILE > $FILE.new
        mv $FILE.new $FILE
    done
done


