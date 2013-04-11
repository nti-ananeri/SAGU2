INSERT INTO basemail (username, datetime, ipaddress, emailid, description, "from", bcc, subject, body, server, port, mimeversion, contenttype) VALUES ('admin', '2006-08-08 17:01:28.275907-03', '127.0.0.1', 12, 'E-MAIL ENVIADO A ALUNOS NA EFETIVAÇÃO DA MATRÍCULA', 'atendimentoaoaluno@instituicao.edu.br', NULL, 'Confirmação da matrícula pela Internet $PERIODID', 'Caro(a): <B>$PERSONNAME ($PERSONID)</B><BR><BR>

<P>Sua matrícula no curso de $COURSEDESC campus $CAMPUSDESC foi efetuada com sucesso!</P>

<P>Aproveitamos para informar que você selecionou as seguintes disciplinas para o semestre $PERIODID:</P>

<BR><BR>$#CURRICULARCOMPONENTTABLE#$<BR><BR>

<P>Caso houver divisão de turma, poderá mudar o professor.</P>

<P>Confirme as salas, professores e datas de início de cada disciplina, na página http://www.instituicao.edu.br, no link atendimento ao aluno, um ou dois dias antes do início das aulas do semestre $PERIODID.</P> 

<P>A falta de pagamento da primeira parcela até dia 10/07/2006 e/ou pendências de semestres anteriores até o vencimento, bem como a falta do cumprimento de pré-requisitos da(s) disciplina(s) implicarão o trancamento automático de sua matrícula, sem comunicação posterior e sem direito à vaga</P>


O aluno que for reprovado em disciplina pré-requisito, deverá fazer a troca ou trancamento de disciplina no link de ajuste de matrícula na Internet, ou entregar uma liberação de pré-requisito assinada pelo coordenador do curso, no setor de atendimento ao aluno, informando que se trata de disciplina com pendência. Não havendo a troca, trancamento ou liberação, a disciplina que depende do referido pré-requisito será trancada na primeira semana de aula.</P>

<P>Oficinas: inscrições no Setor de Atendimento ao Aluno.</P>

Atenciosamente<BR>
UNIVERSIDADE.

SETOR DE ATENDIMENTO AO ALUNO<BR>
', 'mailserver.instituicao.edu.br', 25, '1.0', 'TEXT/HTML; CHARSET=ISO-8859-1');
INSERT INTO basemail (username, datetime, ipaddress, emailid, description, "from", bcc, subject, body, server, port, mimeversion, contenttype) VALUES ('admin', '2006-11-21 20:29:12.497271-02', '127.0.0.1', 11, 'E-MAIL ENVIADO NA CONFIRMAÇÃO DA INSCRIÇÃO DO VESTIBULAR', 'atendimentoaoaluno@instituicao.edu.br', NULL, 'Confirmação de inscrição para o vestibular $SELECTIVEPROCESSID da UNIVERSIDADE', 'Confirmação de inscrição para o vestibular <B>$SELECTIVEPROCESSID</B> da UNIVERSIDADE<BR><BR>

Caro: <B>$PERSONNAME ($PERSONID)</B>.<BR><BR><BR>


Sua inscrição para o vestibular <B>$SELECTIVEPROCESSID</B> da UNIVERSIDADE foi processada com sucesso!<BR><BR>

Suas opções foram:<BR><BR>

$#OPTIONSCOURSE#$<BR><BR>

Língua estrangeira: <B>$LANGUAGEDESC</B><BR>
Local da prova: <B>$LOCALDESC</B><BR><BR>

Caso você queira reimprimir o boleto bancário, é necessário saber o número do título gerado para sua inscrição.<BR><BR>

Número do título para sua inscrição: <B>$INVOICEID</B> <BR><BR>

Lembramos que sua inscrição somente será efetivada quando recebermos a confirmação de pagamento da taxa de inscrição. Depois que o pagamento for feito você receberá um e-mail, em no máximo 48 horas, confirmando sua inscrição. Se o pagamento não for efetivado sua inscrição não terá validade.<BR><BR>

Para reimprimir seu boleto bancário, acesse novamente a inscrição para o vestibular a partir da página da UNIVERSIDADE (http://www.instituicao.edu.br) e clique no link <b>imprimir boleto</b> e informe o número do título gerado para sua inscrição.<BR><BR>

Caso você tenha qualquer problema para pagar o boleto, deve dirigir-se à alguma agência do  banco SICREDI e pagar com os boletos avulsos que estão disponíveis nestas agências. Neste caso, você deverá enviar o comprovante de pagamento e o número do título gerado no momento da inscrição (número do título informado acima)  por fax para a UNIVERSIDADE (77 7777 7777), aos cuidados do setor financeiro.<BR><BR>

Caso você queira pagar por homebanking, utiliza o número abaixo:<BR><BR>

<B>$DOCUMENTNUMBERTOHOMEBANKING</B><BR><BR>

Coordenação do Processo de Inscrição Vestibular  SELECTIVEPROCESSID, via Internet.<BR><BR>

UNIVERSIDADE', 'mailserver.instituicao.edu.br', 25, '1.0', 'TEXT/HTML; CHARSET=ISO-8859-1');
INSERT INTO basemail (username, datetime, ipaddress, emailid, description, "from", bcc, subject, body, server, port, mimeversion, contenttype) VALUES ('admin', '2006-12-20 11:11:47.931235-02', '127.0.0.1', 2, 'E-mail enviado ao inserirmos atividades complementares para um aluno', 'atendimentoaoaluno@instituicao.edu.br', NULL, 'Atividades Complementares', 'Caro(a) <b>$PERSONNAME</b><br><br>

As atividades requeridas por você no dia $CURRENTDATE foram computadas.<br><br>

Ainda faltam $FAULTTOTOTAL horas para você concluir suas Atividades Complementares.<br><br>

As categorias cadastradas até o momento são:<br><br>

$LISTCATEGORYHOURS<br><br>

Para qualquer dúvida, consulte o manual do seu curso.', 'mailserver.instituicao.edu.br', 25, '1.0', 'TEXT/HTML; CHARSET=ISO-8859-1');

SELECT setval('seq_emailid',(SELECT max(emailid) FROM basEmail));
