#!/bin/bash

# Nome do novo cadastro a ser criado
# Ex.: externalCourse
NEW=RAFAotherListings
NEW_MODULE=selectiveProcess
# Nome do cadastro que sera utilizado como modelo
TEMPLATE=inscriptionReport
TEMPLATE_MODULE=selectiveProcess

echo
echo "   About to generate files needed by '$NEW' in module '$NEW_MODULE'"
echo "   based on '$TEMPLATE' from module '$TEMPLATE_MODULE'."
echo
echo "   WARNING: Every file with the same name of the module"
echo "            being created will be replaced and there is"
echo "            no way back."
echo
echo -n "   Are you sure ('yes' to proceed)? "
read ANSWER

if [ "$ANSWER" != "yes" ]
then
    echo "Aborted."
else
    # Nomes com primeira em maiúscula
    NEW2=$(echo $NEW | sed "s/\(^.\)/\U\1/g")
    NEW_MODULE2=$(echo $NEW_MODULE | sed "s/\(^.\)/\U\1/g")
    TEMPLATE2=$(echo $TEMPLATE | sed "s/\(^.\)/\U\1/g")
    TEMPLATE_MODULE2=$(echo $TEMPLATE_MODULE | sed "s/\(^.\)/\U\1/g")

    # Criar arquivos
    cp "$TEMPLATE_MODULE"/handlers/register/"$TEMPLATE".inc "$NEW_MODULE"/handlers/register/"$NEW".inc~
    cp "$TEMPLATE_MODULE"/forms/Frm"$TEMPLATE2"Search.class "$NEW_MODULE"/forms/Frm"$NEW2"Search.class~
    cp "$TEMPLATE_MODULE"/forms/Frm"$TEMPLATE2".class "$NEW_MODULE"/forms/Frm"$NEW2".class~
    cp "$TEMPLATE_MODULE"/grids/Grd"$TEMPLATE2"Search.class "$NEW_MODULE"/grids/Grd"$NEW2"Search.class~
    cp "$TEMPLATE_MODULE"/db/Bus"$TEMPLATE2".class "$NEW_MODULE"/db/Bus"$NEW2".class~

    # Criar ícone para o cadastro
    cp "$TEMPLATE_MODULE"/html/images/"$TEMPLATE"-16x16.png "$NEW_MODULE"/html/images/"$NEW"-16x16.png

    # data atual para cabeçalho do arquivo
    DATE=$(date '+%d\/%m\/%Y')

    # Expressao regular que será usada nos arquivos novos gerados
    RE="s/$TEMPLATE/$NEW/g;s/$TEMPLATE2/$NEW2/g;s/\( \* Class created on \).*/\1$DATE/g"

    # Substituicoes automaticas... Que nem sempre funcionam... :-)
    sed "$RE" "$NEW_MODULE"/handlers/register/"$NEW".inc~ > "$NEW_MODULE"/handlers/register/"$NEW".inc
    sed "$RE" "$NEW_MODULE"/forms/Frm"$NEW2"Search.class~ > "$NEW_MODULE"/forms/Frm"$NEW2"Search.class
    sed "$RE" "$NEW_MODULE"/forms/Frm"$NEW2".class~ > "$NEW_MODULE"/forms/Frm"$NEW2".class
    sed "$RE" "$NEW_MODULE"/grids/Grd"$NEW2"Search.class~ > "$NEW_MODULE"/grids/Grd"$NEW2"Search.class
    sed "$RE" "$NEW_MODULE"/db/Bus"$NEW2".class~ > "$NEW_MODULE"/db/Bus"$NEW2".class

    echo "All done. Good luck."
fi
