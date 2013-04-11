INSERT INTO basemail (username, datetime, ipaddress, emailid, description, "from", bcc, subject, body, server, port, mimeversion, contenttype) VALUES ('admin', '2006-08-08 17:01:28.275907-03', '127.0.0.1', 12, 'E-MAIL ENVIADO A ALUNOS NA EFETIVA��O DA MATR�CULA', 'atendimentoaoaluno@instituicao.edu.br', NULL, 'Confirma��o da matr�cula pela Internet $PERIODID', 'Caro(a): <B>$PERSONNAME ($PERSONID)</B><BR><BR>

<P>Sua matr�cula no curso de $COURSEDESC campus $CAMPUSDESC foi efetuada com sucesso!</P>

<P>Aproveitamos para informar que voc� selecionou as seguintes disciplinas para o semestre $PERIODID:</P>

<BR><BR>$#CURRICULARCOMPONENTTABLE#$<BR><BR>

<P>Caso houver divis�o de turma, poder� mudar o professor.</P>

<P>Confirme as salas, professores e datas de in�cio de cada disciplina, na p�gina http://www.instituicao.edu.br, no link atendimento ao aluno, um ou dois dias antes do in�cio das aulas do semestre $PERIODID.</P> 

<P>A falta de pagamento da primeira parcela at� dia 10/07/2006 e/ou pend�ncias de semestres anteriores at� o vencimento, bem como a falta do cumprimento de pr�-requisitos da(s) disciplina(s) implicar�o o trancamento autom�tico de sua matr�cula, sem comunica��o posterior e sem direito � vaga</P>


O aluno que for reprovado em disciplina pr�-requisito, dever� fazer a troca ou trancamento de disciplina no link de ajuste de matr�cula na Internet, ou entregar uma libera��o de pr�-requisito assinada pelo coordenador do curso, no setor de atendimento ao aluno, informando que se trata de disciplina com pend�ncia. N�o havendo a troca, trancamento ou libera��o, a disciplina que depende do referido pr�-requisito ser� trancada na primeira semana de aula.</P>

<P>Oficinas: inscri��es no Setor de Atendimento ao Aluno.</P>

Atenciosamente<BR>
UNIVERSIDADE.

SETOR DE ATENDIMENTO AO ALUNO<BR>
', 'mailserver.instituicao.edu.br', 25, '1.0', 'TEXT/HTML; CHARSET=ISO-8859-1');
INSERT INTO basemail (username, datetime, ipaddress, emailid, description, "from", bcc, subject, body, server, port, mimeversion, contenttype) VALUES ('admin', '2006-11-21 20:29:12.497271-02', '127.0.0.1', 11, 'E-MAIL ENVIADO NA CONFIRMA��O DA INSCRI��O DO VESTIBULAR', 'atendimentoaoaluno@instituicao.edu.br', NULL, 'Confirma��o de inscri��o para o vestibular $SELECTIVEPROCESSID da UNIVERSIDADE', 'Confirma��o de inscri��o para o vestibular <B>$SELECTIVEPROCESSID</B> da UNIVERSIDADE<BR><BR>

Caro: <B>$PERSONNAME ($PERSONID)</B>.<BR><BR><BR>


Sua inscri��o para o vestibular <B>$SELECTIVEPROCESSID</B> da UNIVERSIDADE foi processada com sucesso!<BR><BR>

Suas op��es foram:<BR><BR>

$#OPTIONSCOURSE#$<BR><BR>

L�ngua estrangeira: <B>$LANGUAGEDESC</B><BR>
Local da prova: <B>$LOCALDESC</B><BR><BR>

Caso voc� queira reimprimir o boleto banc�rio, � necess�rio saber o n�mero do t�tulo gerado para sua inscri��o.<BR><BR>

N�mero do t�tulo para sua inscri��o: <B>$INVOICEID</B> <BR><BR>

Lembramos que sua inscri��o somente ser� efetivada quando recebermos a confirma��o de pagamento da taxa de inscri��o. Depois que o pagamento for feito voc� receber� um e-mail, em no m�ximo 48 horas, confirmando sua inscri��o. Se o pagamento n�o for efetivado sua inscri��o n�o ter� validade.<BR><BR>

Para reimprimir seu boleto banc�rio, acesse novamente a inscri��o para o vestibular a partir da p�gina da UNIVERSIDADE (http://www.instituicao.edu.br) e clique no link <b>imprimir boleto</b> e informe o n�mero do t�tulo gerado para sua inscri��o.<BR><BR>

Caso voc� tenha qualquer problema para pagar o boleto, deve dirigir-se � alguma ag�ncia do  banco SICREDI e pagar com os boletos avulsos que est�o dispon�veis nestas ag�ncias. Neste caso, voc� dever� enviar o comprovante de pagamento e o n�mero do t�tulo gerado no momento da inscri��o (n�mero do t�tulo informado acima)  por fax para a UNIVERSIDADE (77 7777 7777), aos cuidados do setor financeiro.<BR><BR>

Caso voc� queira pagar por homebanking, utiliza o n�mero abaixo:<BR><BR>

<B>$DOCUMENTNUMBERTOHOMEBANKING</B><BR><BR>

Coordena��o do Processo de Inscri��o Vestibular  SELECTIVEPROCESSID, via Internet.<BR><BR>

UNIVERSIDADE', 'mailserver.instituicao.edu.br', 25, '1.0', 'TEXT/HTML; CHARSET=ISO-8859-1');
INSERT INTO basemail (username, datetime, ipaddress, emailid, description, "from", bcc, subject, body, server, port, mimeversion, contenttype) VALUES ('admin', '2006-12-20 11:11:47.931235-02', '127.0.0.1', 2, 'E-mail enviado ao inserirmos atividades complementares para um aluno', 'atendimentoaoaluno@instituicao.edu.br', NULL, 'Atividades Complementares', 'Caro(a) <b>$PERSONNAME</b><br><br>

As atividades requeridas por voc� no dia $CURRENTDATE foram computadas.<br><br>

Ainda faltam $FAULTTOTOTAL horas para voc� concluir suas Atividades Complementares.<br><br>

As categorias cadastradas at� o momento s�o:<br><br>

$LISTCATEGORYHOURS<br><br>

Para qualquer d�vida, consulte o manual do seu curso.', 'mailserver.instituicao.edu.br', 25, '1.0', 'TEXT/HTML; CHARSET=ISO-8859-1');

SELECT setval('seq_emailid',(SELECT max(emailid) FROM basEmail));
