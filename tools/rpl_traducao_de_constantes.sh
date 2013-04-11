cd /home/alexsmith/miolo2/modules

for MODULE in academic accountancy basic finance institutional pupilAssistance selectiveProccess
do
    echo "Entering $MODULE..."
    for FILE in $(find $MODULE -type f | grep '\(class\|inc\)')
    do
        echo " Processing file $FILE..."
        sed 's/_M(\([A-Z][A-Z|_]*\) *, *$module *)/\1/g' $FILE > $FILE.new
        mv $FILE.new $FILE
    done
done


