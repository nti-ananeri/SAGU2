-- 2007-04-04
CREATE UNIQUE INDEX idx_unq_rshquestioncategory ON rshquestioncategory USING btree (description);
ALTER TABLE acdCertified DROP CONSTRAINT acdcertified_pkey;

-- 2007-04-18
ALTER TABLE acdCertified ADD PRIMARY KEY (certifiedid, dateissue, certifiedtypeid);
ALTER TABLE insPhysicalResource ADD FOREIGN KEY (unitId) REFERENCES basUnit (unitId);

-- 2007-04-19
ALTER TABLE basprofessorformation RENAME TO acdprofessorformation;
ALTER TABLE basprofessorcenter RENAME TO acdprofessorcenter; 

-- 2007-05-09
-- Alteracao do tipo de campo para adequacao ao tipo de dados padrao para courseid
ALTER TABLE acdcertified ALTER COLUMN courseid TYPE varchar(10);

-- Trac ticket #228
-- 2007-05-24
ALTER TABLE finInvoice ADD FOREIGN KEY (sectorId) REFERENCES basSector (sectorId);

-- 2007-06-26 by alexsmith
-- Exclusao do campo acdCurriculum.isConditionTrainingPeriod
----------------------------------------------------------------------
ALTER TABLE acdCurriculum DROP COLUMN isConditionTrainingPeriod;

-- 2007-07-02 by alexsmith
-- Correcao de tipo de dados incorreto na coluna
----------------------------------------------------------------------
ALTER TABLE acdProfessorCurricularComponent ALTER COLUMN curricularComponentId TYPE VARCHAR(10);

-- 2007-07-03 by alexsmith
-- Correcao de tipo de dados incorreto na coluna
----------------------------------------------------------------------
ALTER TABLE acdEnrollBookData ALTER COLUMN courseId TYPE VARCHAR(10);
ALTER TABLE acdEnrollBookData ALTER COLUMN prevCourseid TYPE VARCHAR(10);


-- 2007-07-09 by helio
-- Índices em consultas de pessoas utilizando TO_ASCII()
-----------------------------------------------------------------------
CREATE INDEX idx_basphysicalpersonprofessor_name ON basphysicalpersonprofessor USING btree (TO_ASCII(name));
CREATE INDEX idx_basphysicalpersonstudent_name ON basphysicalpersonstudent USING btree (TO_ASCII(name));
CREATE INDEX idx_basphysicalpersonemployee_name ON basphysicalpersonemployee USING btree (TO_ASCII(name));

DROP INDEX idx_basperson_name;
CREATE INDEX idx_basperson_name ON basperson USING btree(to_ascii(name));

-- 2007-07-17 by alexsmith
-- Retiradas as constraints de NOT NULL de campos onde isso nao se faz necessario
-- na tabela basSectorBoss.
----------------------------------------------------------------------
ALTER TABLE basSectorBoss ALTER COLUMN expirationLevel DROP NOT NULL;
ALTER TABLE basSectorBoss ALTER COLUMN level DROP NOT NULL;

-- 2007-07-17
-- Criação do campo para armazenar o currículo quanto uma disciplina
-- é utilizada como atividade complementar
-----------------------------------------------------------------------
ALTER TABLE acdcomplementaryactivities ADD COLUMN curriculumIdOld INT4;
ALTER TABLE acdcomplementaryactivities ADD FOREIGN KEY (curriculumIdOld) REFERENCES acdcurriculum(curriculumid);


--- 2007-07-26 by alexsmith
--- Criacao da tabela basPersonTitle, que armazenara dados sobre as titulacoes
--- das pessoas fisica, tais como Sr. Sra. Dr. Dra. etc.
------------------------------------------------------------------------
CREATE TABLE basPersonTitle 
(
    personTitleId                   integer, --Codigo do titulo da pessoa
    description                     varchar(15) --Descricao do titulo
) INHERITS (basLog);

COMMENT ON TABLE basPersonTitle IS 'Titulos das pessoas, como Sr. Sra. Dr. Dra. etc';
COMMENT ON COLUMN basPersonTitle.personTitleId IS 'Codigo do titulo da pessoa';
COMMENT ON COLUMN basPersonTitle.description IS 'Descricao do titulo';

CREATE SEQUENCE seq_personTitleId;
ALTER TABLE basPersonTitle ALTER COLUMN personTitleId SET DEFAULT NEXTVAL('"seq_persontitleid"');
ALTER TABLE basPersonTitle ALTER COLUMN description SET NOT NULL;

ALTER TABLE basPersonTitle ALTER COLUMN personTitleId SET NOT NULL;
ALTER TABLE basPersonTitle ADD PRIMARY KEY (personTitleId);

ALTER TABLE basPhysicalPerson ADD COLUMN personTitleId integer;
ALTER TABLE basPhysicalPerson ADD FOREIGN KEY (personTitleId) REFERENCES basPersonTitle(personTitleId);

--- 2007-08-03 by alexsmith
--- Retirada constraint NOT NULL conforme conversa com coordenacao do Gnuteca
------------------------------------------------------------------------
ALTER TABLE basPersonLink ALTER COLUMN dateValidate DROP NOT NULL;

--- 2007-08-13 by helio
--- Inclusão de campos na tabela sprInscriptionSettings que servirão
--- para armazenar as mensagens a serem mostradas nas telas de passo
--- a passo da inscrição do processo seletivo
------------------------------------------------------------------------
ALTER TABLE sprinscriptionsetting ADD COLUMN messagewelcomeinscription text;
COMMENT ON COLUMN sprinscriptionsetting.messagewelcomeinscription IS 'Mensagem exibida se está dentro do período de inscrições na primeira tela';

ALTER TABLE sprinscriptionsetting ADD COLUMN messagenotdisponibleinscription text;
COMMENT ON COLUMN sprinscriptionsetting.messagenotdisponibleinscription IS 'Mensagem exibida se as inscrições ainda não estão disponíveis para as pessoas';

ALTER TABLE sprinscriptionsetting ADD COLUMN messagefinishinscription text;
COMMENT ON COLUMN sprinscriptionsetting.messagefinishinscription IS 'Texto exibido na tela de inscrição quando estas já se encerarram';


ALTER TABLE sprinscriptionsetting ADD COLUMN messageinformationinscription text;
COMMENT ON COLUMN sprinscriptionsetting.messageinformationinscription IS 'Mensagem no segundo passo da inscrição do processo seletivo';

ALTER TABLE sprinscriptionsetting ADD COLUMN messagedocumentinscription text;
COMMENT ON COLUMN sprinscriptionsetting.messagedocumentinscription IS 'Mensagem na tela de solicitação dos documentos das pessoas';

ALTER TABLE sprinscriptionsetting ADD COLUMN messagehighschoolconcluedinscription text;
COMMENT ON COLUMN sprinscriptionsetting.messagehighschoolconcluedinscription IS 'Declaração que os alunos concluíram o ensino médio';

--- 2007-08-14 by helio
--- Alteração do campo de nota máxima da ocorrência de prova para aceitar valores com casas decimais
------------------------------------------------------------------------
ALTER TABLE sprexamoccurrence ALTER COLUMN maximumpoints TYPE float;

--- 2007-08-17 by helio
--- Inclusão de campos na tabela sprInscriptionSettings que servirão
--- para armazenar as mensagens a serem mostradas nas telas de passo
--- a passo da inscrição do processo seletivo
------------------------------------------------------------------------
ALTER TABLE sprinscriptionsetting ADD COLUMN messageconcluedinscription text;
COMMENT ON COLUMN sprinscriptionsetting.messageconcluedinscription IS 'Mensagem exibida na conclusão da inscrição';

ALTER TABLE sprinscriptionsetting ADD COLUMN messageOfInvoice text;
COMMENT ON COLUMN sprinscriptionsetting.messageOfInvoice IS 'Mensagem exibida na geração de boleto na conclusão da inscrição';

--- 2007-08-17 by alexsmith
--- Alteracoes para utilizacao da tabela acdExploitation
------------------------------------------------------------------------
ALTER TABLE acdEnroll ALTER COLUMN groupId DROP NOT NULL;
ALTER TABLE acdEnroll ADD COLUMN isExploitation boolean NOT NULL DEFAULT FALSE;
COMMENT ON COLUMN acdEnroll.isExploitation IS 'Indica se o registro atual eh (TRUE) ou nao (FALSE) um aproveitamento, isto eh, possui registros na acdExploitation.';
ALTER TABLE acdEnroll ADD COLUMN learningPeriodId integer REFERENCES acdLearningPeriod(learningPeriodId);
COMMENT ON COLUMN acdEnroll.learningPeriodId IS 'Informa o periodo letivo ao qual o aproveitamento pertence. Nos registros que nao forem aproveitamento, este campo eh nulo.';

--- 2007-08-17 by helio
--- Retirada da obrigatoriedade do campo valor de inscrição
--- da tabela de registro de eventos
-----------------------------------------------------------------------
ALTER TABLE acdEvent ALTER COLUMN inscriptionfee DROP NOT NULL;


--- 2007-08-23
--- Retirada da obrigatoriedade do campo protocolId
-----------------------------------------------------------------------
ALTER TABLE acdDiploma ALTER COLUMN protocolId DROP NOT NULL;

--- 2007-09-04
--- Descricao do campo de frequencia minima
-----------------------------------------------------------------------
COMMENT ON COLUMN acdLearningPeriod.minimumFrequency IS 'Frequencia minima para aprovacao, indicado em percentual (0 a 100)';

--- 2007-09-05 by taffa
--- Criação dos campos peso para média e exame na tabela de período letivo
-----------------------------------------------------------------------
ALTER TABLE acdLearningPeriod ADD COLUMN averageWeight float NOT NULL DEFAULT 1;
COMMENT ON COLUMN acdLearningPeriod.averageWeight IS 'Campo que define o peso da nota. Esse peso sera utilizado posteriormente para calculo da media final juntamente com o peso do exame.';
ALTER TABLE acdLearningPeriod ADD COLUMN examWeight float NOT NULL DEFAULT 1;
COMMENT ON COLUMN acdLearningPeriod.examWeight IS 'Campo que define o peso do exame. Esse campo sera utilizado para calculo da media final juntamente com o peso da nota.';
--- Criação do campo peso na tabela de graus
ALTER TABLE acdDegree ADD COLUMN weight float NOT NULL DEFAULT 1;
COMMENT ON COLUMN acddegree.weight IS 'Campo que define o peso do grau que e usado para calculo da media';
--- Definição de campo peso da avaliação como NOT NULL
ALTER TABLE acdEvaluation ALTER weight SET DEFAULT 1;
ALTER TABLE acdEvaluation ALTER weight SET NOT NULL;

--- 2007-09-10 by helio
--- Criação de campo para registro do número de opções obrigatórias na inscrição
--- do processo seletivo
----------------------------------------------------------------------------
ALTER TABLE sprSelectiveProcess ADD COLUMN optionsnumberrequired int4;
--- Seta todas os registros já cadastrados para o número de opções obrigatórias ser 
--- igual ao número já cadastrado de opções.
UPDATE sprSelectiveProcess SET optionsnumberrequired = optionsNumber WHERE optionsnumberrequired IS NULL;
--- Seta o campo para ser not null
ALTER TABLE sprSelectiveProcess ALTER COLUMN optionsnumberrequired SET NOT NULL;
COMMENT ON COLUMN sprSelectiveProcess.optionsnumberrequired IS 'Número de opções obrigatórias na inscrição do candidato';


--- 2007-09-19 by helio
--- Criação de campo para registrar o vínculo de um local de processo
--- seletivo com uma pessoa jurídica
---------------------------------------------------------------------
ALTER TABLE sprplace ADD COLUMN personid int4 NOT NULL; 
ALTER TABLE sprplace ADD FOREIGN KEY (personid) REFERENCES baslegalperson(personid);
COMMENT ON COLUMN sprplace.personid IS 'Código da pessoa jurídica referente ao local especificado';

--- 2007-10-04 by gmurilo
--- Criação do campo miolousername para integração do MIOLO2 ao SAGU2
-----------------------------------------------------------------------
ALTER TABLE basperson ADD COLUMN miolousername varchar(25);

--- 2007-10-04 by gmurilo
--- Criação de tabela para retorno bancario
-----------------------------------------------------------------------
CREATE TABLE finbankreturn ( 
    bankreturnid integer,
    description varchar(80) NOT NULL UNIQUE,
    bankid varchar(3) NOT NULL REFERENCES finbank(bankid),
    cnabtype varchar(8) NOT NULL,
    segmentposition integer NOT NULL,
    validcaracters text NOT NULL,
    hasheader bool NOT NULL DEFAULT true,
    returnfilemask text
) 
INHERITS (baslog);
CREATE SEQUENCE seq_bankreturnid;
ALTER TABLE finbankreturn ALTER COLUMN bankreturnid SET DEFAULT NEXTVAL('seq_bankreturnid');
ALTER TABLE finbankreturn ADD PRIMARY KEY (bankreturnid);
COMMENT ON COLUMN finbankreturn.cnabtype IS 'Tipo do CNAB a ser usado.';
COMMENT ON COLUMN finbankreturn.segmentposition IS 'Posicao do Segmento.';
COMMENT ON COLUMN finbankreturn.validcaracters IS 'Caracteres validos.'; 
COMMENT ON COLUMN finbankreturn.hasheader IS 'Verifica se possui cabecalho no retorno.';
COMMENT ON COLUMN finbankreturn.returnfilemask IS 'Mascara do arquivo de retorno.';
COMMENT ON COLUMN finbankreturn.description IS 'Descricao do Retorno Bancario';

CREATE TABLE finbankreturntypefield ( 
    typefieldreturnid integer,
    description text NOT NULL
) 
INHERITS (baslog);
ALTER TABLE finbankreturntypefield ADD PRIMARY KEY (typefieldreturnid);
CREATE SEQUENCE seq_typefieldreturnid;
ALTER TABLE finbankreturntypefield ALTER COLUMN typefieldreturnid SET DEFAULT NEXTVAL('seq_typefieldreturnid');
COMMENT ON COLUMN finbankreturntypefield.typefieldreturnid IS 'Codigo do tipo do retorno.';
COMMENT ON COLUMN finbankreturntypefield.description IS 'Descricao do tipo do retorno.';


CREATE TABLE finbankreturnconfig ( 
    bankreturnid integer  REFERENCES finbankreturn(bankreturnid),
    typefieldreturnid integer NOT NULL,
    position integer NOT NULL,
    size integer NOT NULL,
    segment char(1) NULL
) 
INHERITS (baslog);
ALTER TABLE finbankreturnconfig ADD PRIMARY KEY (bankreturnid,typefieldreturnid);
ALTER TABLE finbankreturnconfig ADD FOREIGN KEY (typefieldreturnid) REFERENCES finbankreturntypefield(typefieldreturnid);
COMMENT ON COLUMN finbankreturnconfig.typefieldreturnid IS 'Codigo do Tipo de Campo do Retorno.';
COMMENT ON COLUMN finbankreturnconfig.position IS 'Posicao Inicial do Campo no Arquivo de Retorno.';
COMMENT ON COLUMN finbankreturnconfig.size IS 'Tamanho do Campo no Arquivo de Retorno.'; 
COMMENT ON COLUMN finbankreturnconfig.segment IS 'Tipo do segmento no arquivo de retorno (Usado apenas no CNAB240).';


CREATE TABLE finbankreturnmessage ( 
    bankreturnid integer,
    messagetype integer NOT NULL,
    messagecod integer NOT NULL,
    message text NOT NULL
) 
INHERITS (baslog);
ALTER TABLE finbankreturnmessage ADD PRIMARY KEY (bankreturnid,messagetype,messagecod);
ALTER TABLE finbankreturnmessage ADD FOREIGN KEY (bankreturnid) REFERENCES finbankreturn(bankreturnid);

COMMENT ON COLUMN finbankreturnmessage.messagetype IS 'Codigo do tipo da mensagem.';
COMMENT ON COLUMN finbankreturnmessage.messagecod IS 'Codigo da mensagem.';
COMMENT ON COLUMN finbankreturnmessage.message IS 'Mensagem.';

-- --
-- Tabela com as mensagens trocadas entre alunos e professores
-- 2007-08-13
-- --
CREATE SEQUENCE seq_messageid;

CREATE TABLE basMessage (
messageId    int primary key default nextval('seq_messageid'),
fromPersonId int not null references basphysicalperson(personid),
toPersonId   int not null references basphysicalperson(personid),
title        text not null,
message      text,
messageDate  date not null default date(now())
) INHERITS (baslog);

COMMENT ON TABLE basMessage IS 'Tabela com as mensagens trocadas entre alunos e professores';
COMMENT ON COLUMN basMessage.fromPersonId IS 'Origem da mensagem (pessoa)';
COMMENT ON COLUMN basMessage.toPersonId IS 'Destino da mensagem (pessoa)';
COMMENT ON COLUMN basMessage.title IS 'Titulo da mensagem';
COMMENT ON COLUMN basMessage.message IS 'Corpo da mensagem';
COMMENT ON COLUMN basMessage.messageDate IS 'Data de envio da mensagem';


-- --
-- Campo para informar o conteudo programatico da aula na pauta eletronica
-- 2007-08-13
-- --
ALTER TABLE acdFrequenceEnroll ADD "content" text;
COMMENT ON COLUMN acdFrequenceEnroll."content" IS 'Campo para registrar o conteudo programatico';

-- --
-- Campo para informar o conteudo programatico da aula na pauta eletronica
-- 2007-08-21
-- --

CREATE TABLE basReligion (
            religionId integer, -- Sequencia para identificar religiao (chave primaria)
            description text -- Descrição da religiao
) INHERITS (basLog);

COMMENT ON TABLE basReligion IS 'Dados da religiao';
COMMENT ON COLUMN basReligion.religionId IS 'Sequencia para identificar religiao (chave primaria)';

CREATE SEQUENCE seq_religionId;
ALTER TABLE basReligion ALTER COLUMN religionId SET DEFAULT NEXTVAL('seq_religionId');
ALTER TABLE basReligion ALTER COLUMN religionId SET NOT NULL;
ALTER TABLE basReligion ALTER COLUMN description SET NOT NULL;

ALTER TABLE basReligion ADD PRIMARY KEY (religionId);

ALTER TABLE basPhysicalPerson ADD COLUMN religionId INT;
ALTER TABLE basPhysicalPerson ADD FOREIGN KEY (religionId) REFERENCES basReligion (religionId);

-- --
-- Adicionada a opção pra exibir as cidades no processo seletivo
-- 2007-10-02
-- --
alter table basCity add showInSelectiveProcess boolean;
update basCity set showInSelectiveProcess = false;
alter table basCity alter showInSelectiveProcess set not null;
comment ON COLUMN bascity.showInSelectiveProcess is 'Campo usado para identificar as cidades que deverão aparecer na pesquisa por cidades do processo seletivo';

-- --
-- alterado o tipo do campo senha da tabela de pssoas para poder armazenar
-- valores maiores que 10 (tamanho antigo)
-- 2007-10-08
-- --
alter table basperson ALTER "password" type text;

------
-- incluido campos para funcionamento de arquivos de retorno
-- 2007-09-10
------


CREATE TABLE finBankReturnLineType ( lineTypeId integer NOT NULL, description varchar(80) NOT NULL UNIQUE) INHERITS (baslog);
ALTER TABLE finBankReturnLineType ADD PRIMARY KEY (lineTypeId);
CREATE SEQUENCE seq_lineTypeId;
ALTER TABLE finBankReturnLineType ALTER COLUMN lineTypeId SET DEFAULT nextval('seq_lineTypeId');
COMMENT ON COLUMN finBankReturnLineType.lineTypeId IS 'Codigo do tipo da linha de retorno';
COMMENT ON COLUMN finBankReturnLineType.description IS 'Descricao da linha de retorno (DETALHE, HEADER, TRAILLER...)';

ALTER TABLE finBankReturnConfig ADD COLUMN lineTypeId integer NOT NULL REFERENCES finBankReturnLineType(lineTypeId);
COMMENT ON COLUMN finBankReturnConfig.lineTypeId IS 'Informa o Id do tipo da linha de retorno';

ALTER TABLE finBankReturnConfig DROP CONSTRAINT finbankreturnconfig_pkey;
ALTER TABLE finBankReturnConfig ADD COLUMN bankReturnConfigId integer NOT NULL;
COMMENT ON COLUMN finBankReturnConfig.bankReturnConfigId IS 'Informa o Id de configuracao do Retorno Bancario.';
CREATE SEQUENCE seq_bankReturnConfigId;

ALTER TABLE finBankReturnConfig ALTER COLUMN bankReturnConfigId SET DEFAULT nextval('seq_bankReturnConfigId');
ALTER TABLE finBankReturnConfig ADD PRIMARY KEY (bankReturnConfigId);
ALTER TABLE finBankReturnConfig ADD UNIQUE (bankReturnId,typeFieldReturnId,position,segment,lineTypeId);

CREATE TABLE finBankReturnShare ( returnShareId integer NOT NULL, description varchar(80) NOT NULL UNIQUE) INHERITS (baslog);
CREATE SEQUENCE seq_returnShareId;
ALTER TABLE finBankReturnShare ALTER COLUMN returnShareId SET DEFAULT nextval('seq_returnShareId');
ALTER TABLE finBankReturnShare ADD PRIMARY KEY (returnShareId);
COMMENT ON COLUMN finBankReturnShare.returnShareId IS 'Codigo do Lote';
COMMENT ON COLUMN finBankReturnShare.description IS 'Descricao do Lote';

CREATE TABLE finBankReturnShareSegment ( returnShareId integer NOT NULL,segment char(1) NOT NULL , required bool NOT NULL DEFAULT FALSE, ord integer) INHERITS (baslog);
ALTER TABLE finBankReturnShareSegment ADD FOREIGN KEY (returnShareId) REFERENCES finBankReturnShare (returnShareId);
ALTER TABLE finBankReturnShareSegment ADD COLUMN bankAccountId integer NOT NULL REFERENCES finBankAccount (bankAccountId);
ALTER TABLE finBankReturnShareSegment ADD PRIMARY KEY (bankAccountId,returnShareId,segment);
COMMENT ON COLUMN finBankReturnShareSegment.bankAccountId IS 'Codigo da conta bancaria no SAGU';
COMMENT ON COLUMN finBankReturnShareSegment.returnShareId IS 'Codigo do Lote';
COMMENT ON COLUMN finBankReturnShareSegment.segment IS 'Segmento';
COMMENT ON COLUMN finBankReturnShareSegment.required IS 'Segmento requerido';
COMMENT ON COLUMN finBankReturnShareSegment.ord IS 'Ordem do segmento.';

-- --
-- Alterações para cadastro de perguntas tipo texto
-- Incluso também repostas para questões sem proprietário
-- 2007-10-26
-- --

CREATE SEQUENCE seq_answerid2;
CREATE TABLE rshanswer_nologin (
    answerId integer NOT NULL,
    personId integer,
    questionId integer NOT NULL,
    optionId integer,
    optionText text
) INHERITS (basLog);

ALTER TABLE rshanswer_nologin ALTER COLUMN answerId SET DEFAULT nextval('seq_answerid2');
ALTER TABLE rshanswer_nologin ADD PRIMARY KEY (answerId);

ALTER TABLE rshanswer ADD COLUMN optionText text;

ALTER TABLE rshQuestion ADD COLUMN texttype boolean;
ALTER TABLE rshQuestion ALTER COLUMN texttype SET DEFAULT false;

CREATE VIEW rshresult AS
    SELECT r.formid, r.formname, r.questionid, r.question, r.optionid, r."option", r.answers, r.tanswers, (((100)::double precision / (r.tanswers)::double precision) * (r.answers)::double precision) AS answerpercent FROM (SELECT q.formid, f.description AS formname, q.questionid, q.description AS question, o.optionid, CASE WHEN (q.texttype = false) THEN o.description ELSE rshanswer_nologin.optiontext END AS "option", count(q.questionid) AS answers, (SELECT count(*) AS count FROM rshanswer_nologin a1 WHERE (a1.questionid = q.questionid) GROUP BY a1.questionid) AS tanswers FROM (((rshanswer_nologin JOIN rshquestion q USING (questionid)) LEFT JOIN rshoption o USING (optionid)) JOIN rshform f USING (formid)) GROUP BY q.questionid, o.optionid, q.description, o.description, q.formid, f.description, q.texttype, rshanswer_nologin.optiontext) r;

-- --
-- Alteracao no tipo do campo da frequencia
-- 2007-10-26
-- --
alter table acdfrequenceenroll alter frequency TYPE float;
alter table baslink add level int;
update baslink set level = 1;

-- -- 
-- Inclusao de campo de valor de matricula
-- 2007-10-29
-- --
ALTER TABLE finPrice ADD COLUMN enrollValue numeric(14,4) DEFAULT 0.00; 

-- --
-- Tabela forma motivos de pagamentos
-- 2007-10-30
-- --
CREATE SEQUENCE seq_payabletypeid;
CREATE TABLE finPayableType (
    payableTypeId int default nextval('seq_payabletypeid'),
    description text
) INHERITS (basLog);
ALTER TABLE finPayableType ADD PRIMARY KEY (payableTypeId);
COMMENT ON TABLE finPayableType IS 'Formas de pagamentos utilizadas nas contas a pagar. Ex: A vista, a prazo';
INSERT INTO finPayableType (userName, ipAddress, description) VALUES ('sagu2', '127.0.0.1', 'À VISTA');
INSERT INTO finPayableType (userName, ipAddress, description) VALUES ('sagu2', '127.0.0.1', 'À PRAZO');

-- --
-- Tabela para as formas de pagamento (a vista, a prazo)
-- 2007-10-30
-- --
CREATE SEQUENCE seq_finreasonid;
CREATE TABLE finReason (
    reasonId int default nextval('seq_finreasonid'),
    description text
) INHERITS (basLog);
ALTER TABLE finReason ADD PRIMARY KEY (reasonId);
COMMENT ON TABLE finReason IS 'Tabela para os motivos e historicos de pagamentos: Pagamento ao fornecedor, Pagamento de luz';
INSERT INTO finReason (userName, ipAddress, description) VALUES ('sagu2', '127.0.0.1', 'PAGAMENTO DE LUZ');

-- --
-- Alteracao na tabela de títulos a pagar mudando a data de recebimento para pagamento.
-- Contas a pagar
-- 2007-10-30
-- --

alter table finInvoice add speciesId int references finspecies(speciesId);
COMMENT ON COLUMN finInvoice.speciesId IS 'Moeda de pagamento: Dinnheiro ou Cheque por exemplo';

alter table finPayableInvoice rename receiveDate TO payableDate;
COMMENT ON COLUMN finPayableInvoice.payableDate IS 'Data de pagamento do título';

COMMENT ON COLUMN finInvoice.bankAccountId IS 'Codigo da conta corrente (finBankAccount) que recebera o dinheiro de um pagamento ou de onde sairá o dinheiro para um pagamento';

alter table finPayableInvoice add reasonId int references finreason(reasonId);
COMMENT ON COLUMN finPayableInvoice.reasonid IS 'Motivo e historico de pagamento';

alter table finPayableInvoice add invoiceNumber varchar(20);
COMMENT ON COLUMN finPayableInvoice.invoiceNumber IS 'Numero da nota fiscal recebida';

alter table finPayableInvoice add invoiceValue numeric(14,4);
COMMENT ON COLUMN finPayableInvoice.invoiceValue IS 'É o valor que aparece na nota fiscal';

alter table finPayableInvoice add invoiceRealValue numeric(14,4);
COMMENT ON COLUMN finPayableInvoice.invoiceRealValue IS 'É o valor real sobre a nota fiscal junto com os cálculos de juros e abatimentos';

alter table finPayableInvoice add invoicePayableNumber varchar(20);
COMMENT ON COLUMN finPayableInvoice.invoicePayableNumber IS 'Numero do boleto a pagar';

alter table finPayableInvoice add accountedDate date;
COMMENT ON COLUMN finPayableInvoice.accountedDate IS 'Data que o título a pagar de fato foi contabilizado. Ex: Pode ser que os títulos sejam contabilizados dia 25, mas mesmo após isso seja feito um pagamento. Assim, no próximo mês, aqueles que não tiverem a data contábil e que são do mês anterior tb deverão ser contabilizados.';

alter table finPayableInvoice add payableTypeId integer not null;
COMMENT ON COLUMN finPayableInvoice.payableTypeId IS 'Forma de pagamento. Ex: a vista, a prazo etc';

-- --
-- Caixas, adicionado a impressora
-- 2007-10-30
-- --
ALTER TABLE finCounter ADD printerName text;

-- --
-- Campo que faltava no cadastro de locais para o vestibular
-- 2007-11-01
-- dah
-- --
alter table sprplace add personid int not null references baslegalperson(personid);
update sprplace set personid = 4200358;

-- --
-- Apenas um user do miolo por pessoa
-- 2007-11-06
-- dah
-- --
create unique index idx_unique_miolo_username ON basperson (miolousername );

-- --
-- Correcao de chaves estrangeis nas movimentacoes dos caixas e caixas
-- 2007-11-07
-- dah
-- --
ALTER TABLE fincountermovement DROP CONSTRAINT fincountermovement_operatorid_fkey;
ALTER TABLE fincounter DROP CONSTRAINT fincounter_responsableid_fkey;
ALTER TABLE fincounter DROP CONSTRAINT fincounter_responsableid_fkey1;
ALTER TABLE fincountermovement ADD FOREIGN KEY (operatorId) REFERENCES basphysicalpersonemployee(personid);
ALTER TABLE fincounter ADD FOREIGN KEY (responsableid) REFERENCES basphysicalpersonemployee(personid);

-- --
-- Correcao de chave estrangeira na basdocument
-- 2007-11-11
-- gmurilo
-- --

ALTER TABLE basdocument DROP CONSTRAINT basdocument_personid_fkey;
ALTER TABLE basdocument ADD CONSTRAINT basdocument_personid_fkey FOREIGN KEY (personid) REFERENCES basPerson (personid);

-- --
-- Definicao de campos not null nas tabela que vincula os cheques aos titulos
-- 2007-11-13
-- dah
-- --
ALTER TABLE fincheckinvoice ALTER checkid set not null;
ALTER TABLE fincheckinvoice ALTER invoiceid set not null;

-- --
-- O campo specieId saiu títulos e criação de uma parâmetro para a espécie padrão
-- 2007-11-16
-- dah
-- --
ALTER TABLE finInvoice DROP speciesId;

-- --
-- Campos para os valores parciais das disciplinas
-- 2007-11-27
-- dah
-- --
ALTER TABLE finPrice ADD minimumCurricularComponent int;
COMMENT ON COLUMN finPrice.minimumCurricularComponent IS 'Mínimo de disciplinas para utilização do preço integral (somente para regime seriado)';
ALTER TABLE finPrice ADD curricularComponentPrice numeric(14,4);
COMMENT ON COLUMN finPrice.curricularComponentPrice IS 'Valor por disciplina caso a matricula seje em menos disciplinas que o mínimo para o preço integral (somente para regime seriado)';

-- --
-- campos para a operação padrão de taxa de matrícula
-- 2007-11-27
-- dah
-- --


-- --
-- desabilitei uma trigger que nao é mais utilizada
-- 2007-12-04
-- dah
-- --
ALTER TABLE finprice DISABLE TRIGGER finprice_validatedate;

-- --
-- Alteração no acdCourse e acdLearningPeriod para ter a política e conta bancária
-- padrão desse curso
-- 2007-12-10
-- dah
-- --
ALTER TABLE acdCourse ADD policyId int references finPolicy(policyId);
ALTER TABLE acdCourse ADD bankAccountId int references finBankAccount(bankAccountId);
COMMENT ON COLUMN acdCourse.policyId IS 'Politica padrao utilizada caso nao seje informado a mesma no periodo letivo';
COMMENT ON COLUMN acdCourse.bankAccountId IS 'Conta bancária padrao utilizada caso nao seje informado a mesma no periodo letivo';
ALTER TABLE acdLearningPeriod ADD bankAccountId int references finBankAccount(bankAccountId);
COMMENT ON COLUMN acdLearningPeriod.bankAccountId IS 'Conta bancária padrao para esse periodo letivo';

-- --
-- Coloquei as chaves estrangeiras que faltavam nas frequencias
-- 2007-12-19
-- dah
-- --
ALTER TABLE acdFrequenceEnroll ADD FOREIGN KEY (enrollId) REFERENCES acdEnroll(enrollId);
ALTER TABLE acdFrequenceEnroll ADD FOREIGN KEY (scheduleId) REFERENCES acdSchedule(scheduleId);
ALTER TABLE acdFrequenceContent ADD FOREIGN KEY (scheduleId) REFERENCES acdSchedule(scheduleId);

 -----------------------------------------------------------------------
-- --
-- Purpose: campo para definição de juros compostos ou simples no
--          cadastro de políticas
-- 2007-12-20
-- dah
-- -- 
-----------------------------------------------------------------------

-----------------------------------------------------------------------
-- --
-- Purpose: campo para inclusao de horas praticas da disciplina
-- 2007-12-21
-- gmurilo
-- -- 
-----------------------------------------------------------------------
ALTER TABLE acdCurricularComponent ADD COLUMN practiceHours float not null default '0.00';
COMMENT ON COLUMN acdCurricularComponent.practiceHours IS 'Especifica o numero de horas praticas da disciplina, por padrao pega 0';

-----------------------------------------------------------------------
-- --
-- Purpose: Campos de endereço para o campus e alteração do tipo de
--          campo para text no endereço do cadastro de pessoas
-- 2007-12-24
-- dah
-- -- 
-----------------------------------------------------------------------
ALTER TABLE basUnit ADD COLUMN zipCode varchar(9);
COMMENT ON COLUMN basUnit.zipCode IS 'Cep do endereço do campus';
ALTER TABLE basUnit ADD COLUMN location text;
COMMENT ON COLUMN basUnit.location IS 'Endereço do campus';
ALTER TABLE basUnit ADD COLUMN "number" varchar(10);
COMMENT ON COLUMN basUnit."number" IS 'Número de endereço do campus';
ALTER TABLE basUnit ADD COLUMN complement varchar(60);
COMMENT ON COLUMN basUnit.complement IS 'Complemento de endereço do campus';
ALTER TABLE basUnit ADD COLUMN neighborhood text;
COMMENT ON COLUMN basUnit.neighborhood IS 'Bairro de endereço do campus';
alter table basperson ALTER location type text;

-----------------------------------------------------------------------
-- --
-- Purpose: Tabela de cadastro de assinatura digital
--          utilizada para validação de contratos através da web, pelos servicos
-- 2007-12-24
-- gmurilo
-- -- 
-----------------------------------------------------------------------
CREATE TABLE basDigitalPassword 
(
    personId integer NOT NULL REFERENCES basPhysicalPerson (personId),
    password varchar(128) NOT NULL,
    passwordResponsable varchar(128) NOT NULL,
    inclusionDate timestamp NOT NULL DEFAULT now(),
    exclusionDate timestamp,
    retryErrors integer NOT NULL DEFAULT 0
)
INHERITS (baslog);
ALTER TABLE basDigitalPassword ADD PRIMARY KEY (personId);
COMMENT ON COLUMN basDigitalPassword.password IS 'Senha Digital do Aluno';
COMMENT ON COLUMN basDigitalPassword.passwordResponsable IS 'Senha Digital do Responsável do Aluno';
COMMENT ON COLUMN basDigitalPassword.inclusionDate IS 'Data de cadastro da senha';
COMMENT ON COLUMN basDigitalPassword.exclusionDate IS 'Data de desativação da senha';
COMMENT ON COLUMN basDigitalPassword.retryErrors IS 'Número de erros da senha';

-----------------------------------------------------------------------
-- --
-- Purpose: Inclusao de nome do local do trabalho
-- 2007-12-26
-- gmurilo
-- -- 
-----------------------------------------------------------------------
ALTER TABLE basPhysicalPerson ADD COLUMN workName varchar(100);
COMMENT ON COLUMN basPhysicalPerson.workName IS 'Nome do trabalho da pessoa';

-----------------------------------------------------------------------
-- --
-- Purpose: Possibilidade de envio de mensagens dos funcionários para
--          alunos ou professores com data de exibição inicial e final.
--          Também alter as chaves estrangeiras das pessoas para poder
--          aceitar tb pessoas jurídicas.
-- 2007-12-26
-- dah
-- -- 
-----------------------------------------------------------------------
ALTER TABLE basMessage ADD COLUMN beginDate date;
COMMENT ON COLUMN basMessage.beginDate IS 'Data inicial de exibição dos lembretes dos funcionários para alunos e professores';
ALTER TABLE basMessage ADD COLUMN endDate date;
COMMENT ON COLUMN basMessage.endDate IS 'Data final de exibição dos lembretes dos funcionários para alunos e professores';
ALTER TABLE basMessage ADD COLUMN toPersonType char not null default 'S';
COMMENT ON COLUMN basMessage.toPersonType IS 'Define o tipo de pessoa para qual será enviada uma mensagem. P = professor, S = Estudante e E = funcionário';
ALTER TABLE basMessage drop CONSTRAINT basmessage_topersonid_fkey;
ALTER TABLE basMessage drop CONSTRAINT basmessage_frompersonid_fkey;
ALTER TABLE basMessage ADD CONSTRAINT basmessage_topersonid_fkey FOREIGN KEY (toPersonId) REFERENCES basPerson (personid);
ALTER TABLE basMessage ADD CONSTRAINT basmessage_frompersonid_fkey FOREIGN KEY (fromPersonId) REFERENCES basPerson (personid);

-----------------------------------------------------------------------
-- --
-- Purpose: Alteracoes para funcionando do convenio, baseado em politic
--          a, curso, periodo letivo, operacao
-- 2007-12-27
-- gmurilo
-- -- 
-----------------------------------------------------------------------
ALTER TABLE finInvoice ADD COLUMN entryId integer REFERENCES finEntry (entryId);
COMMENT ON COLUMN finInvoice.entryId IS 'Define a entrada inicial para ser utilizada com o titulo, para que o mesmo possa pegar o convenio baseado na operacao padrao';

DROP TRIGGER IF EXISTS verifyAccordOnOperation ON finOperation;
DROP FUNCTION IF EXISTS verifyAccordOnOperation();

CREATE FUNCTION verifyAccordOnOperation()
RETURNS TRIGGER AS  $$
DECLARE lastval_ text;
BEGIN 
    IF TG_OP = 'INSERT' OR TG_OP = 'UPDATE' THEN
        IF NEW.operationTypeId = 'C' AND NOT NEW.bankAccountAccordId IS NULL THEN 
            SELECT INTO lastval_ (
                SELECT setval('seq_operationid',max(operationid)) 
                    FROM finoperation where not operationid = NEW.operationid 
                                 );
            RAISE EXCEPTION 'operationTypeId can not be a \'Credit\' operation for use bank accord';
        END IF;
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE 'plpgsql';

CREATE TRIGGER verifyAccordOnOperation AFTER UPDATE OR INSERT 
    ON finOperation FOR EACH ROW 
    EXECUTE PROCEDURE verifyAccordOnOperation();
DROP TRIGGER IF EXISTS verifyDefaultEntryId ON finEntry;
DROP FUNCTION IF EXISTS verifyDefaultEntryId();
CREATE OR REPLACE FUNCTION verifyDefaultEntryId() RETURNS TRIGGER AS $$
DECLARE finOperationType RECORD;
BEGIN
    IF (TG_OP = 'DELETE') THEN
        SELECT INTO finOperationType entryId FROM finInvoice WHERE invoiceId = OLD.invoiceId;
        IF finOperationType.entryId = OLD.entryId THEN 
            UPDATE finInvoice SET entryId = NULL WHERE invoiceId = OLD.invoiceId;
        END IF;
        RETURN OLD;
    ELSIF (TG_OP = 'INSERT' OR TG_OP = 'UPDATE') THEN
        SELECT INTO finOperationType entryId,bankAccountId,bankContractId,operationTypeId 
            FROM finEntry INNER JOIN finOperation USING(operationId) WHERE entryId = NEW.entryId;
        IF (NOT finOperationType.bankAccountId IS NULL OR NOT finOperationType.bankContractId IS NULL ) AND finOperationType.operationTypeId = 'D' THEN
            UPDATE finInvoice SET entryId = finOperationType.entryId WHERE invoiceId = NEW.invoiceId;
        END IF;
        RETURN NEW;
    END IF;
END;
$$ LANGUAGE 'plpgsql';

CREATE TRIGGER verifyDefaultEntryId AFTER UPDATE OR INSERT
    ON finEntry FOR EACH ROW
    EXECUTE PROCEDURE verifyDefaultEntryId();
    
CREATE TRIGGER verifyDefaultEntryIdDelete BEFORE DELETE
    ON finEntry FOR EACH ROW
    EXECUTE PROCEDURE verifyDefaultEntryId();

-----------------------------------------------------------------------
-- --
-- Purpose: Funcao que retorna se é pessoa física ou jurídica 
-- 1 - pessoas física , 9 - pessoa juridica
-- 2008-01-07
-- gmurilo
-- -- 
-----------------------------------------------------------------------
CREATE OR REPLACE FUNCTION getPersonType(integer) RETURNS integer AS $$
SELECT (CASE 
            WHEN ( SELECT count(*) FROM basPhysicalPerson WHERE personId = $1 ) > 0 THEN 1 
            WHEN (SELECT count(*) FROM basLegalPerson WHERE personId = $1) > 0 THEN 9
            ELSE 0
        END);
$$ LANGUAGE 'sql';
------------------------------------------------------------
-- --
-- Purpose: retorna apesas os numeros de um texto 
-- 2008-01-07
-- gmurilo
-- --
------------------------------------------------------------
DROP FUNCTION IF EXISTS returntextasinteger(text) CASCADE;
CREATE FUNCTION returntextasinteger(text) RETURNS text AS $_$ 
    SELECT regexp_replace($1,'[^0123456789]','','g')  
$_$ LANGUAGE 'sql';

------------------------------------------------------------
-- --
-- Purpose: Alteração para tabela de bancos, inclusao do li
--          mite da sequencia
-- 2008-01-07
-- gmurilo
-- --
------------------------------------------------------------
ALTER TABLE finBank ADD COLUMN seqLimit integer;
COMMENT ON COLUMN finBank.seqLimit IS 'Numero maximo de casas no valor Ex: 2 = 99, 3 = 999';

------------------------------------------------------------
-- --
-- Purpose: Alteração para tabela de titulos, inclusao do a
--          numero da remessa
-- 2008-01-07
-- gmurilo
-- --
------------------------------------------------------------
ALTER TABLE finReceivableInvoice ADD COLUMN remittanceField integer;
COMMENT ON COLUMN finReceivableInvoice.remittanceField IS 'Numero da remessa do titulo';

------------------------------------------------------------
-- --
-- Purpose: Obriguei o preenchimento do campo seqLimit dos bancos
-- 2008-01-09
-- dah
-- --
------------------------------------------------------------
UPDATE finBank SET seqLimit = 6 WHERE seqLimit IS NULL;
ALTER TABLE finBank ALTER seqLimit set NOT NULL;


CREATE OR REPLACE FUNCTION saldoCheque (int) RETURNS numeric AS $$ 
    SELECT (CASE 
--                WHEN sum(C.totalvalue) IS NULL THEN 0 ELSE sum(C.totalvalue) 
                WHEN sum(D.value) IS NULL THEN 0 ELSE sum(D.value) 
            END)  
            FROM finCheck C 
      INNER JOIN finCheckInvoice D
              ON ( C.checkId = D.checkId )
           WHERE D.invoiceId = $1
             AND C.status = 'C'
             AND C.downDate IS NULL
$$ LANGUAGE 'sql';

------------------------------------------------------------
-- --
-- Purpose: Função que atualiza o turno das frequencias
--          caso o turno seja alterado na schedule
-- 2008-01-16
-- dah
-- --
------------------------------------------------------------
CREATE OR REPLACE FUNCTION setFrequencyTurn() RETURNS OPAQUE AS $$
DECLARE data RECORD;
BEGIN
    IF (TG_OP = 'UPDATE') THEN

        SELECT INTO data B.turnId 
               FROM acdSchedule A
         INNER JOIN acdScheduleLearningPeriod B
                 ON ( A.scheduleLearningPeriodId = B.scheduleLearningPeriodId)
              WHERE scheduleId = NEW.scheduleId;

        UPDATE acdFrequenceEnroll SET turnId = data.turnId WHERE scheduleId = NEW.scheduleId;
        UPDATE acdFrequenceContent SET turnId = data.turnId WHERE scheduleId = NEW.scheduleId;

        RETURN NEW;

    END IF;
END;
$$ LANGUAGE 'plpgsql';

                   CREATE TRIGGER setFrequencyTurn
                  AFTER UPDATE ON acdSchedule
   FOR EACH ROW EXECUTE PROCEDURE setFrequencyTurn();


------------------------------------------------------------
-- --
-- Purpose: Apaga índice único para contratos no mesmo curso
-- 2008-01-18
-- gmurilo
-- --
------------------------------------------------------------
DROP INDEX idx_unique_contract;

------------------------------------------------------------
-- --
-- Purpose: Nova tabela de contratos bancários
-- 2008-01-22
-- gmurilo
-- --
------------------------------------------------------------
CREATE TABLE finBankAccountContract
(
    bankContractId integer NOT NULL,
    bankAccountId integer REFERENCES finBankAccount (bankAccountId) NOT NULL,
    description text,
    accord varchar(10),
    wallet varchar(4),
    collection varchar(4),
    collectionTypeId integer REFERENCES finCollectionType(collectionTypeId),
    collectionBranch varchar(5),
    variation varchar(4),
    remittanceSequence integer NOT NULL DEFAULT 0,
    remittanceSequenceReset integer NOT NULL DEFAULT 0,
    returnSequence integer NOT NULL DEFAULT 0,
    returnSequenceReset integer NOT NULL DEFAULT 0,
    invoiceSequence integer NOT NULL DEFAULT 0,
    invoiceSequenceReset integer NOT NULL DEFAULT 0
) INHERITS (basLog);
COMMENT ON TABLE finBankAccountContract IS 'Contratos bancários da instituição com o banco';
COMMENT ON COLUMN finBankAccountContract.bankAccountId IS 'Código da conta bancária';
COMMENT ON COLUMN finBankAccountContract.bankContractId IS 'Numero do contrato';
COMMENT ON COLUMN finBankAccountContract.description IS 'Descricao do contrato (Ex: Convenio para recebimento de taxa de vestibular)';
COMMENT ON COLUMN finBankAccountContract.accord IS 'Convênio aplicado ao contrato';
COMMENT ON COLUMN finBankAccountContract.wallet IS 'Carteira a ser usada pelo contrato';
COMMENT ON COLUMN finBankAccountContract.collection IS 'Código da cobrança a ser utilizada pelo contrato';
COMMENT ON COLUMN finBankAccountContract.collectionTypeId IS 'Código do tipo da cobrança a ser utilizada pelo contrato';
COMMENT ON COLUMN finBankAccountContract.collectionBranch IS 'Código da agencia de cobranca';
COMMENT ON COLUMN finBankAccountContract.variation IS 'Variação';
COMMENT ON COLUMN finBankAccountContract.remittanceSequence IS 'Sequencia de remessa';
COMMENT ON COLUMN finBankAccountContract.remittanceSequenceReset IS 'Quantas vezes já foi reiniciado a sequencia da remessa';
COMMENT ON COLUMN finBankAccountContract.returnSequence IS 'Sequencia do retorno';
COMMENT ON COLUMN finBankAccountContract.returnSequenceReset IS 'Quantas vezes já foi reiniciado a sequencia do retorno';
COMMENT ON COLUMN finBankAccountContract.invoiceSequence IS 'Sequencia do titulo';
COMMENT ON COLUMN finBankAccountContract.invoiceSequenceReset IS 'Quantas vezes já foi reiniciado a sequencia dos tí­tulos';
ALTER TABLE finBankAccountContract ADD PRIMARY KEY (bankAccountId,bankContractId);
CREATE INDEX idx_finBankAccountContract_accord ON finBankAccountContract(accord);

------------------------------------------------------------
-- --
-- Purpose: Modifica os relacionamentos para a tabela de 
--          contratos e apaga as tabelas que não são mais usadas
-- 2008-01-22
-- gmurilo
-- --
------------------------------------------------------------
ALTER TABLE acdCourse ADD bankContractId integer;
ALTER TABLE acdLearningPeriod ADD bankContractId integer;

alter TABLE acdcourse DROP CONSTRAINT acdcourse_bankaccountid_fkey;
alter TABLE acdLearningPeriod DROP CONSTRAINT acdlearningperiod_bankaccountid_fkey;

ALTER TABLE acdCourse ADD FOREIGN KEY (bankAccountId, bankContractId) REFERENCES finBankAccountContract (bankAccountId, bankContractId);
ALTER TABLE acdLearningPeriod ADD FOREIGN KEY (bankAccountId, bankContractId) REFERENCES finBankAccountContract (bankAccountId, bankContractId);

ALTER TABLE finInvoice ADD bankContractId integer;

ALTER TABLE finInvoice ADD FOREIGN KEY (bankAccountId, bankContractId) REFERENCES finBankAccountContract (bankAccountId, bankContractId);

drop function verifyaccordonoperation() cascade;

------------------------------------------------------------
-- --
-- Purpose: Atualizacoes de funcoes para contrato
-- 2008-01-22
-- gmurilo
-- --
------------------------------------------------------------

DROP TRIGGER IF EXISTS verifyContractOperation ON finOperation;
DROP FUNCTION IF EXISTS verifyContractOnOperation();
CREATE FUNCTION verifyContractOnOperation()
RETURNS TRIGGER AS  $$
DECLARE lastval_ text;
BEGIN 
    IF TG_OP = 'INSERT' OR TG_OP = 'UPDATE' THEN
        IF NEW.operationTypeId = 'C' AND ( NOT NEW.bankContractId IS NULL OR NOT NEW.bankAccountId IS NULL ) THEN 
            SELECT INTO lastval_ (
                SELECT setval('seq_operationid',max(operationid)) 
                    FROM finoperation where not operationid = NEW.operationid 
                                 );
            RAISE EXCEPTION 'operationTypeId can not be a \'Credit\' operation for use bank contract';
        END IF;
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE 'plpgsql';
CREATE TRIGGER verifyContractOperation AFTER UPDATE OR INSERT
	ON finOperation FOR EACH ROW 
	EXECUTE PROCEDURE verifyContractOnOperation();

DROP TRIGGER verifyDefaultEntryIdDelete ON finEntry;
DROP TRIGGER verifyDefaultEntryId ON finEntry;
DROP FUNCTION IF EXISTS verifyDefaultEntryId();
CREATE OR REPLACE FUNCTION verifyDefaultEntryId() RETURNS TRIGGER AS $$
DECLARE finOperationType RECORD;
BEGIN
    IF (TG_OP = 'DELETE') THEN
        SELECT INTO finOperationType entryId FROM finInvoice WHERE invoiceId = OLD.invoiceId;
        IF finOperationType.entryId = OLD.entryId THEN 
            UPDATE finInvoice SET entryId = NULL WHERE invoiceId = OLD.invoiceId;
        END IF;
        RETURN OLD;
    ELSIF (TG_OP = 'INSERT' OR TG_OP = 'UPDATE') THEN
        SELECT INTO finOperationType entryId,bankAccountId,bankContractId,operationTypeId 
            FROM finEntry INNER JOIN finOperation USING(operationId) WHERE entryId = NEW.entryId;
        IF (NOT finOperationType.bankAccountId IS NULL OR NOT finOperationType.bankContractId IS NULL ) AND finOperationType.operationTypeId = 'D' THEN
            UPDATE finInvoice SET entryId = finOperationType.entryId WHERE invoiceId = NEW.invoiceId;
        END IF;
        RETURN NEW;
    END IF;
END;
$$ LANGUAGE 'plpgsql';
CREATE TRIGGER verifyDefaultEntryId AFTER UPDATE OR INSERT
    ON finEntry FOR EACH ROW
    EXECUTE PROCEDURE verifyDefaultEntryId();
CREATE TRIGGER verifyDefaultEntryIdDelete BEFORE DELETE
    ON finEntry FOR EACH ROW
    EXECUTE PROCEDURE verifyDefaultEntryId();

------------------------------------------------------------
-- --
-- Purpose: Inclusao de campo de mensagem aleatória no titul
--          o
-- 2008-01-23
-- gmurilo
-- --
------------------------------------------------------------
ALTER TABLE finInvoice ADD COLUMN messageInvoice varchar(255);
COMMENT ON COLUMN finInvoice.messageInvoice IS 'Mensagem aleatória aplicada ao título';

------------------------------------------------------------
-- --
-- Purpose: Funcao e trigger para fazer inclusao automatica
--          do incremento na finBankAccountContract
-- 2008-01-23
-- gmurilo
-- --
------------------------------------------------------------
ALTER TABLE finBank DROP COLUMN seqLimit;
ALTER TABLE finBankAccountContract ADD COLUMN seqLimit integer NOT NULL DEFAULT 5;
COMMENT ON COLUMN finBankAccountContract.seqLimit IS 'Tamanho maximo aceito do numero do titulo em quantidade de caracteres Ex: 2= 99, 3= 999';
CREATE OR REPLACE FUNCTION updateInvoiceSeq() RETURNS TRIGGER AS $$
DECLARE finBankAccountContract_ RECORD;
BEGIN
    IF (TG_OP = 'INSERT') OR ( TG_OP = 'UPDATE') THEN
        IF (TG_OP = 'UPDATE') THEN
            IF (NEW.bankContractId = OLD.bankContractId AND NEW.bankAccountId = OLD.bankAccountId) THEN
                RETURN NEW;
            END IF;
        END IF;
        SELECT INTO finBankAccountContract_ seqLimit,length(invoiceSequence+1) as sizeSeq, count(*) as sizeB
            FROM finBankAccountContract WHERE bankAccountId = NEW.bankAccountId AND bankContractId = NEW.bankContractId GROUP BY invoiceSequence,seqLimit;
        IF finBankAccountContract_.sizeSeq > finBankAccountContract_.seqLimit THEN
            UPDATE finBankAccountContract SET invoiceSequence = 1, invoiceSequenceReset = invoiceSequenceReset+1 WHERE bankAccountId = NEW.bankAccountId AND bankContractId = NEW.bankContractId;
        ELSE
            UPDATE finBankAccountContract SET invoiceSequence = invoiceSequence+1 WHERE bankAccountId = NEW.bankAccountId AND bankContractId = NEW.bankContractId;
        END IF;
        SELECT INTO finBankAccountContract_ invoiceSequence FROM finBankAccountContract WHERE bankAccountId = NEW.bankAccountId AND bankContractId = NEW.bankContractId;
        NEW.bankInvoiceId := finBankAccountContract_.invoiceSequence;
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE 'plpgsql';
CREATE OR REPLACE FUNCTION updateInvoiceSeq2() RETURNS TRIGGER AS $$
DECLARE bankInvoiceId_ varchar(30);
BEGIN
    IF (TG_OP = 'INSERT') THEN
		UPDATE finReceivableInvoice SET bankInvoiceId = ( SELECT bankInvoiceId FROM ONLY finInvoice WHERE invoiceId = NEW.invoiceId ) WHERE invoiceId = NEW.invoiceId;
	END IF;
	RETURN NEW;
END;
$$ LANGUAGE 'plpgsql';

CREATE TRIGGER updateBankInvoiceId BEFORE INSERT OR UPDATE
    ON finInvoice FOR EACH ROW
	    EXECUTE PROCEDURE updateInvoiceSeq();

CREATE TRIGGER updateBankInvoiceId AFTER INSERT
    ON finReceivableInvoice FOR EACH ROW
	    EXECUTE PROCEDURE updateInvoiceSeq2();
	    
------------------------------------------------------------
-- --
-- Purpose: obrigatoriedade do campo na fininvoice
-- 2008-01-25
-- dah
-- --
------------------------------------------------------------
alter table fininvoice alter bankcontractid set not null;


------------------------------------------------------------
-- --
-- Purpose: apaguei campo desnecessário nos bancos
-- 2008-01-25
-- dah
-- --
------------------------------------------------------------
alter TABLE finbank DROP COLUMN accordcode;

------------------------------------------------------------
-- Purpose: inclusao da politica no contrato  
-- 2008-01-26
-- gmurilo
-- --
------------------------------------------------------------
ALTER TABLE acdContract ADD COLUMN policyId INTEGER REFERENCES finPolicy (policyId);

------------------------------------------------------------
-- Purpose: Campo na finPolicy para calculo das multas e
--          juros
-- 2008-01-30
-- dah
-- --
------------------------------------------------------------
------------------------------------------------------------
-- Purpose: Campo para cnpj no cadastro de cheques
-- 2008-02-07
-- dah
-- --
------------------------------------------------------------
alter table finCheck add issuingCNPJ text;
COMMENT ON COLUMN finCheck.issuingCNPJ IS 'Campo reservado para preencher com o CNPJ da pessoa que lançar o cheque';

------------------------------------------------------------
-- Purpose: Campo para cnpj no cadastro de cheques
-- 2008-02-07
-- dah
-- --
------------------------------------------------------------
alter table finCheckInvoice add value numeric(14,4);
COMMENT ON COLUMN finCheckInvoice.value IS 'campo para ter os valores parciais dos cheques';
update fincheckinvoice set value = (select totalvalue / (select count(*) from fincheckinvoice where checkid = fincheckinvoice.checkid) from fincheck where checkid = fincheckinvoice.checkid);
alter table finCheckInvoice alter value set not null;


------------------------------------------------------------
-- Purpose: Descrição dos parametros da basconfig
-- 2008-02-18
-- dah
-- --
------------------------------------------------------------
delete from basconfig where parameter ilike 'PAYMENT_OPERATIONS';
update basConfig set description = 'Grupo de operações para pagamento referente a tudo que é recebido pela instituição. É do tipo CREDITO. Não entram extornos, incentivos, descontos etc, somente o que foi realmente pago' where parameter = 'PAYMENT_OPERATION_GROUP_ID';
update basConfig set description = 'Operações utilizadas para os pagamentos realizados pelos alunos' where parameter = 'PUPIL_PAYMENT_OPERATIONS';
update basConfig set parameter = 'DISCOUNT_OPRATION_GROUP_ID', description = 'Grupo de operações para descontos que foram aplicados ao aluno. É do tipo CREDITO. Não inclui incentivos.' where parameter = 'OPERATION_GROUP_ID_DISCOUNT';
INSERT INTO basConfig (username, ipaddress, moduleconfig, parameter, value, description, type, isvaluechangeable) VALUES ('sagu2', '127.0.0.1', 'BASIC', 'RECEIVABLE_OPERATION_GROUP_ID', 'N', 'Grupo de operações referente a tudo que é emitido pela instituição. É do tipo DÉBITO.', 'INT', false);

------------------------------------------------------------
-- Purpose: Alterações na tabela de operações padrão
-- 2008-02-18
-- dah
-- --
------------------------------------------------------------

------------------------------------------------------------
-- Purpose: Política padrão para acordos e origem
-- 2008-02-22
-- dah
-- --
------------------------------------------------------------
INSERT INTO basConfig (username, ipaddress, moduleconfig, parameter, value, description, type, isvaluechangeable) VALUES ('sagu2', '127.0.0.1', 'BASIC', 'DEFAULT_AGREEMENT_POLICY_ID', '3', 'Política padrão para os acordos.', 'INT', false);
UPDATE basConfig set value = '35' where parameter = 'AGREEMENT_INCOME_SOURCE_ID';


------------------------------------------------------------
-- Purpose: Parâmetros que indicam se devem ser gerado 
--          financeiro nos acréscimos e cancelamentos
-- 2008-03-03
-- dah
-- --
------------------------------------------------------------
INSERT INTO basConfig (username, ipaddress, moduleconfig, parameter, value, description, type, isvaluechangeable) VALUES ('sagu2', '127.0.0.1', 'ACADEMIC', 'GENERATE_INC_FORECAST_ON_ENROLL_ADDITION', 'YES', 'Define se serão geradas previsões financeiras no ato do acréscimo da disciplina. Os valores são YES e NO.', 'VARCHAR', true);
INSERT INTO basConfig (username, ipaddress, moduleconfig, parameter, value, description, type, isvaluechangeable) VALUES ('sagu2', '127.0.0.1', 'ACADEMIC', 'GENERATE_INC_FORECAST_ON_ENROLL_CANCELLATION', 'YES', 'Define se serão geradas previsões financeiras no ato do cancelamento da disciplina. Os valores são YES e NO.', 'VARCHAR', true);
INSERT INTO basConfig (username, ipaddress, moduleconfig, parameter, value, description, type, isvaluechangeable) VALUES ('sagu2', '127.0.0.1', 'ACADEMIC', 'GENERATE_INVOICE_ON_ENROLL_ADDITION', 'YES', 'Define se serão gerados títulos a receber no ato do acréscimo da disciplina. Os valores são YES e NO.', 'VARCHAR', true);
INSERT INTO basConfig (username, ipaddress, moduleconfig, parameter, value, description, type, isvaluechangeable) VALUES ('sagu2', '127.0.0.1', 'ACADEMIC', 'GENERATE_INVOICE_ON_ENROLL_CANCELLATION', 'YES', 'Define se serão gerados títulos a receber no ato do cancelamento da disciplina. Os valores são YES e NO.', 'VARCHAR', true);
------------------------------------------------------------
-- --
-- Purpose: Funcao para fazer inclusao ou atualizacao do 
--			bankInvoiceId na finBankAccountContract
-- 2008-02-23
-- gmurilo
-- --
------------------------------------------------------------
CREATE OR REPLACE FUNCTION updateBankInvoiceId(integer) RETURNS boolean AS $$
DECLARE finBankAccountContract_ RECORD;
DECLARE finBankInvoice_ RECORD;
BEGIN
	SELECT INTO finBankInvoice_ bankContractId, bankAccountId, invoiceId, bankInvoiceId FROM ONLY finInvoice WHERE invoiceId = $1;
	IF length(finBankInvoice_.bankInvoiceId::varchar) > 0 OR finBankInvoice_.invoiceId IS NULL THEN 
		RETURN FALSE;
	END IF;
    SELECT INTO finBankAccountContract_ seqLimit,length((invoiceSequence+1)::text) as sizeSeq, count(*) as sizeB
		FROM finBankAccountContract 
	WHERE bankAccountId = finBankInvoice_.bankAccountId AND bankContractId = finBankInvoice_.bankContractId 
	GROUP BY invoiceSequence,seqLimit;
    IF finBankAccountContract_.sizeSeq > finBankAccountContract_.seqLimit THEN
		UPDATE finBankAccountContract SET invoiceSequence = 1, invoiceSequenceReset = invoiceSequenceReset+1 WHERE bankAccountId = finBankInvoice_.bankAccountId AND bankContractId = finBankInvoice_.bankContractId;
    ELSE
        UPDATE finBankAccountContract SET invoiceSequence = invoiceSequence+1 WHERE bankAccountId = finBankInvoice_.bankAccountId AND bankContractId = finBankInvoice_.bankContractId;
    END IF;
    SELECT INTO finBankAccountContract_ invoiceSequence FROM finBankAccountContract WHERE bankAccountId = finBankInvoice_.bankAccountId AND bankContractId = finBankInvoice_.bankContractId;
	UPDATE finInvoice SET bankInvoiceId = finBankAccountContract_.invoiceSequence WHERE invoiceId = $1;
	RETURN TRUE;
END;
$$ LANGUAGE 'plpgsql';

------------------------------------------------------------
-- --
-- Purpose: Exclusao da trigger que inclui automaticamente
--			o numero do titulo
-- 2008-02-29
-- gmurilo
-- --
------------------------------------------------------------
DROP TRIGGER IF EXISTS updateBankInvoiceId ON finInvoice;
DROP TRIGGER IF EXISTS updateBankInvoiceId On finReceivableInvoice;
DROP FUNCTION IF EXISTS updateInvoiceSeq();

------------------------------------------------------------
-- --
-- Purpose: Atualizacao do parametro basico de grupo de des
--			conto
-- 2008-02-07
-- gmurilo
-- --
-----------------------------------------------------------
UPDATE basconfig SET parameter = 'DISCOUNT_OPERATION_GROUP_ID'  WHERE parameter ILIKE 'DISCOUNT_OPRATION_GROUP_ID';

------------------------------------------------------------
-- --
-- Purpose: Atualizacao das funcoes para pegar o status de
--          entrada
-- 2008-03-10
-- dah
-- --
-----------------------------------------------------------
DROP FUNCTION getContractActivationStateContract(_contractId int);
CREATE OR REPLACE FUNCTION getContractActivationStateContract(_contractId int) RETURNS acdMovementContract.stateContractId%TYPE AS $end$

DECLARE
    result acdMovementContract.stateContractId%TYPE;

BEGIN

    SELECT INTO result A.stateContractId
           FROM acdMovementContract A,
                acdStateContract B 
          WHERE A.contractId = _contractId
            AND A.stateContractId = B.stateContractId 
            AND B.inouttransition = 'I'
       ORDER BY A.stateTime
          LIMIT 1;

    RETURN result;
END;
$end$
LANGUAGE 'plpgsql' STABLE;

DROP FUNCTION getContractActivationDate(_contractId int);
CREATE OR REPLACE FUNCTION getContractActivationDate(_contractId acdContract.contractId%TYPE) RETURNS acdMovementContract.stateTime%TYPE AS $end$

DECLARE
    result acdMovementContract.stateTime%TYPE;

BEGIN

    SELECT INTO result A.stateTime
           FROM acdMovementContract A,
                acdStateContract B 
          WHERE A.contractId = _contractId
            AND A.stateContractId = B.stateContractId 
            AND B.inouttransition = 'I'
       ORDER BY A.stateTime
          LIMIT 1;

    RETURN result;
END;
$end$
LANGUAGE 'plpgsql' STABLE;

------------------------------------------------------------
-- --
-- Purpose: Inclusão de status no título, C = ESTORNADO
--			D = EXCLUIDO
-- 2008-03-11
-- gmurilo
-- --
-----------------------------------------------------------
ALTER TABLE finInvoice ADD COLUMN status CHAR(1) NULL;
COMMENT ON COLUMN finInvoice.status IS 'Informa o status do título, C = ESTORNADO, D = Excluido';
INSERT INTO basConfig (parameter, value, description, type, moduleconfig ) VALUES ('CHARGEBACK_INVOICE_STATUS', 'C', 'VALOR PARA TÍTULOS ESTORNADOS', 'VARCHAR', 'FINANCE');
INSERT INTO basConfig (parameter, value, description, type, moduleconfig ) VALUES ('DELETE_INVOICE_STATUS', 'D', 'VALOR PARA TÍTULOS EXCLUIDOS', 'VARCHAR', 'FINANCE');

------------------------------------------------------------
-- --
-- Purpose: Funcao para pegar o periodo anterior
-- 2008-03-13
-- dah
-- --
-----------------------------------------------------------
CREATE OR REPLACE FUNCTION getLastPeriod("periodId" VARCHAR) RETURNS VARCHAR AS '
  SELECT periodid 
    FROM acdLearningPeriod 
   WHERE learningPeriodId IN ( SELECT previousLearningPeriodId
                                 FROM acdLearningPeriod
                                WHERE periodId = $1 )
GROUP BY periodId,
         endDate 
ORDER BY endDate desc
   LIMIT 1
' LANGUAGE 'sql';

------------------------------------------------------------
-- --
-- Purpose: Redefine o modulo de um parametro
-- 2008-03-14
-- dah
-- --
-----------------------------------------------------------
UPDATE basConfig set moduleConfig = 'BASIC' where parameter = 'DEFAULT_QUERY_RULE';

------------------------------------------------------------
-- --
-- Purpose: inclusao de parametros basicos
-- 2008-03-14
-- gmurilo
-- --
-----------------------------------------------------------
INSERT INTO basConfig (username, ipaddress, moduleconfig, parameter, value, description, type, isvaluechangeable) VALUES ('sagu2', '127.0.0.1', 'ACADEMIC', 'DEFAULT_MATURITYDAY', '10', 'Define o dia padrao para a geraçao dos contratos.', 'INT', true);

INSERT INTO basConfig (username, ipaddress, moduleconfig, parameter, value, description, type, isvaluechangeable) VALUES ('sagu2', '127.0.0.1', 'ACADEMIC', 'DEFAULT_CONTRACT_PARCELSNUMBER', '5', 'Define a quantidade padrao de parcelas.', 'INT', true);

INSERT INTO basConfig (username, ipaddress, moduleconfig, parameter, value, description, type, isvaluechangeable) VALUES ('sagu2', '127.0.0.1', 'ACADEMIC', 'CHECKFINANCE_ON_CONTRACT_CANCELATION', 'TRUE', 'Informa se o será verificado ou não o financeiro do aluno para o cancelamento de matricula.', 'INT', true);

------------------------------------------------------------
-- --
-- Purpose: Adicionei o campo scheduleid nos ajustes de ca-
--          lendário acadêmico
-- 2008-03-24
-- dah
-- --
-----------------------------------------------------------
ALTER TABLE acdAcademicCalendarAdjustments ADD scheduleId INT NOT NULL REFERENCES acdSchedule(scheduleId);
COMMENT ON COLUMN acdAcademicCalendarAdjustments.scheduleId IS 'campo para inidicaro turno e horário da aula ajustada';

------------------------------------------------------------
-- --
-- Purpose: Adicionei o campo de comentário para as respos-
--          tas dos questionários
-- 2008-03-31
-- dah
-- --
-----------------------------------------------------------
ALTER TABLE rshQuestion ADD allowAnswerComment boolean default false;
COMMENT ON COLUMN rshQuestion.allowAnswerComment IS 'Sefinição se as respostas poderão ter ou nãocomentários';

ALTER TABLE rshAnswer ADD optionComment text;
COMMENT ON COLUMN rshAnswer.optionComment IS 'Comentário do usuário na resposta';
ALTER TABLE rshAnswer_nologin ADD optionComment text;
COMMENT ON COLUMN rshAnswer_nologin.optionComment IS 'Comentário do usuário na resposta';

------------------------------------------------------------
-- --
-- Purpose: Tabela de feriados
-- 2008-03-31
-- gmurilo
-- --
-----------------------------------------------------------

CREATE TABLE basHoliday ( holidayDate date PRIMARY KEY, description varchar(80) NOT NULL ) inherits (basLog);
COMMENT ON COLUMN basHoliday.holidayDate  IS 'DATA DO FERIADO';
COMMENT ON COLUMN basHoliday.description  IS 'DESCRIÇÃO DO FERIADO';

------------------------------------------------------------
-- --
-- Purpose: Criação de trigger de tolerancia de feriados
-- 2008-03-31
-- gmurilo
-- --
-----------------------------------------------------------

ALTER TABLE finInvoice ADD COLUMN tolDate DATE;

CREATE OR REPLACE FUNCTION holidayValidation() RETURNS TRIGGER AS $$
DECLARE 
    holidayDate_ DATE;
    BEGIN
        holidayDate_ := NEW.maturityDate;
        IF ( SELECT date_part('dow',holidayDate_) ) = 0 THEN
            holidayDate_ :=  holidayDate_+1;
        ELSEIF ( SELECT date_part('dow',holidayDate_) ) = 6 THEN
            holidayDate_ :=  holidayDate_+2;
        END IF;
        WHILE length((SELECT holidayDate FROM basHoliday WHERE holidayDate = holidayDate_)::text) > 0 OR  (SELECT date_part('dow',holidayDate_))  in (0,6) LOOP
            holidayDate_ := holidayDate_+1;
        END LOOP;
        IF NOT holidayDate_ = NEW.maturityDate THEN
            NEW.tolDate = holidayDate_;
        END IF;
        RETURN NEW;
    END;
$$ LANGUAGE 'plpgsql';
CREATE TRIGGER finInvoice_tolDate BEFORE UPDATE OR INSERT ON finInvoice FOR EACH ROW EXECUTE PROCEDURE holidayValidation();

------------------------------------------------------------
-- --
-- Purpose: Criação de um campo específico para reprovação
--          nos períodos letivos
-- 2008-04-07
-- dah
-- --
-----------------------------------------------------------
ALTER TABLE acdLearningPeriod ADD disapprovationWithoutExam float;
COMMENT ON COLUMN acdLearningPeriod.disapprovationWithoutExam IS 'Indica a nota de reprovação sendo que o aluno não pode nem mais fazer exame';
UPDATE acdLearningPeriod SET disapprovationWithoutExam = 0;
ALTER TABLE acdLearningPeriod ALTER disapprovationWithoutExam SET NOT NULL;

-----------------------------------------------------------
-- --
-- Purpose: correção na funcao de calculo de feriado,
--          quando os feriados aconteciam durante um sabado
--          ou domingo, a data de tolerancia nao era calcul
--          ada corretamente
-- 2008-04-09
-- gmurilo
-- --
-----------------------------------------------------------

CREATE OR REPLACE FUNCTION holidayValidation() RETURNS TRIGGER AS $$
DECLARE 
    holidayDate_ DATE;
    BEGIN
        holidayDate_ := NEW.maturityDate;
        IF ( SELECT date_part('dow',holidayDate_) ) = 0 THEN
            holidayDate_ :=  holidayDate_+1;
        ELSEIF ( SELECT date_part('dow',holidayDate_) ) = 6 THEN
            holidayDate_ :=  holidayDate_+2;
        END IF;
        WHILE length((SELECT holidayDate FROM basHoliday WHERE holidayDate = holidayDate_)::text) > 0 OR  (SELECT date_part('dow',holidayDate_))  in (0,6) LOOP
            holidayDate_ := holidayDate_+1;
        END LOOP;
        IF NOT holidayDate_ = NEW.maturityDate THEN
            NEW.tolDate = holidayDate_;
        END IF;
        RETURN NEW;
    END;
$$ LANGUAGE 'plpgsql';


-----------------------------------------------------------
-- --
-- Purpose: Função que retorna o período letivo correto
--          de uma turma, caso, num período existe dois
--          períodos letivos
-- 2008-04-11
-- dah
-- --
-----------------------------------------------------------
CREATE OR REPLACE FUNCTION getLearningPeriodByClassAndPeriod("periodId" VARCHAR, "classId" VARCHAR, "learningPeriodId" INT) RETURNS integer AS $end$
DECLARE
    learningPeriodId_ INT;
    result1 RECORD;
BEGIN
    SELECT INTO learningPeriodId_ A.learningPeriodId
           FROM acdLearningPeriod A
     INNER JOIN acdClass B
             ON ( A.learningPeriodId = B.initialLearningPeriodId ) 
          WHERE A.periodId = $1
            AND B.classId = $2;
    --somente vai entrar aqui se as turmas forem d primeiro periodo
    IF learningPeriodId_ IS NOT NULL THEN
        return learningPeriodId_;
    ELSE
        IF $3 IS NULL THEN
            SELECT INTO learningPeriodId_ initialLearningPeriodId
                   FROM acdClass
                  WHERE classId = $2;
        ELSE
            learningPeriodId_ := $3;
        END IF;
        IF learningPeriodId_ IS NOT NULL THEN
            SELECT INTO result1 A.periodId, A.learningPeriodId
                   FROM acdLearningPeriod A
                  WHERE A.previousLearningPeriodId = learningPeriodId_;
            IF result1.periodId IS NOT NULL THEN
                IF $1 = result1.periodId THEN
                    return result1.learningPeriodId;
                ELSE
                    SELECT INTO learningPeriodId_ getLearningPeriodByClassAndPeriod($1, $2, result1.learningPeriodId);
                    return learningPeriodId_;
                END IF;
            ELSE
                return NULL;
            END IF;
        ELSE
            return NULL;
        END IF;
    END IF;
END;
$end$
LANGUAGE 'plpgsql' STABLE;

-----------------------------------------------------------
-- --
-- Purpose: Parâmetro para definir se o caderno de chamada
--          vai imprimir separadamente por horário, ou 
--          tudo num caderno só
-- 2008-04-16
-- dah
-- --
-----------------------------------------------------------
INSERT INTO basConfig (username, ipaddress, moduleconfig, parameter, value, description, type, isvaluechangeable) VALUES ('sagu2', '127.0.0.1', 'BASIC', 'ACADEMIC_REGISTER_LAYER_INDIVIDUAL', 'YES', 'Parâmetro para definir se o caderno de chamada vai imprimir separadamente por horário, ou tudo num caderno só. Para imprimir todos os horário no mesmo caderno digite NO no valor do parâmetro. Para imprimir cada horário num caderno individual, digite YES.', 'BOOELAN', true);

-----------------------------------------------------------
-- --
-- Purpose: Campos na acdEnroll para indicar se é adaptação
--          ou dependência
-- 2008-04-18
-- dah
-- --
-----------------------------------------------------------
ALTER TABLE acdEnroll ADD isAdaptation boolean not null default false;
ALTER TABLE acdEnroll ADD isDependence boolean not null default false;
COMMENT ON COLUMN acdEnroll.isAdaptation IS 'Campo para indicar se a matrícula será uma adaptação.';
COMMENT ON COLUMN acdEnroll.isAdaptation IS 'Campo para indicar se a matrícula será uma dependência.';

-----------------------------------------------------------
-- --
-- Purpose: Tabela para controle de remessas
-- 2008-05-06
-- gmurilo
-- --
-----------------------------------------------------------
CREATE TABLE finRemittanceFile 
             (
                bankAccountId integer references finbankaccount (bankAccountId), 
                fileName text, 
                invoiceId integer references fininvoice  (invoiceid)) 
inherits (baslog);
ALTER TABLE finRemittanceFile ADD PRIMARY KEY (bankAccountId, fileName, invoiceId);
COMMENT ON COLUMN finRemittanceFile.fileName IS 'Nome do arquivo da remessa';
COMMENT ON COLUMN finRemittanceFile.bankAccountId IS 'Conta a qual a remessa pertence';
COMMENT ON COLUMN finRemittanceFile.invoiceId  IS 'Codigo do titulo referenciado';


-----------------------------------------------------------
-- --
-- Purpose: Parametro padrao para escola padrao do exame
-- 2008-05-16
-- gmurilo
-- --
-----------------------------------------------------------
INSERT INTO basConfig (username, ipaddress, moduleconfig, parameter, value, description, type, isvaluechangeable) VALUES ('sagu2', '127.0.0.1', 'BASIC', 'DEFAULT_CITYEXAM', '251', 'Define o dia padrao para a geraçao dos contratos.', 'INT', true);

------------------------------------------------------------
-- Purpose: Parâmetro que com o código do documento de 
--          serviço militar
-- 2008-05-19
-- dah
-- --
------------------------------------------------------------
INSERT INTO basConfig (username, ipaddress, moduleconfig, parameter, value, description, type, isvaluechangeable) VALUES ('sagu2', '127.0.0.1', 'BASIC', 'DEFAULT_DOCUMENT_TYPE_ID_MILITAR_SERVICE', '6', 'Parâmetro que com o código do documento de serviço militar', 'INT', false);

------------------------------------------------------------
-- Purpose: Índice para melhorar as consultas de
--          inadimplentes do financeiro
-- 2008-05-21
-- dah
-- --
------------------------------------------------------------
CREATE INDEX idx_acdcontract_courseid ON acdContract(courseid);
CREATE INDEX idx_acdcontract_courseid_courseversion ON acdContract(courseid, courseversion);
CREATE INDEX idx_fincheckinvoice_invoiceid ON fincheckinvoice (invoiceid);
CREATE INDEX idx_fincheckinvoice_checkid ON fincheckinvoice (checkid);
CREATE INDEX idx_fincheckinvoice_invoiceid_checkid ON fincheckinvoice (invoiceid, checkid);
CREATE INDEX idx_fincheck_personid ON fincheck (personid);
CREATE INDEX idx_finoperation_operationtypeid ON finoperation(operationtypeid);
CREATE INDEX idx_finentry_operationid_invoiceid ON finentry(invoiceid, operationid);

------------------------------------------------------------
-- Purpose: Tabela de configuração dos questionários
-- 2008-05-23
-- dah
-- --
------------------------------------------------------------
CREATE SEQUENCE seq_formsettingid;

CREATE TABLE rshFormSetting
(
    formSettingId int, --Código do formulário
    formId        int, --Código do formulário
    beginDate     date, --Data inicial da exibição do questionário
    endDate       date, --Data final da exibição do questionário
    beginHour     time, --Hora inicial da exibição do questionário
    endHour       time --Hora final da exibição do questionário
) INHERITS (basLog);

COMMENT ON TABLE rshFormSetting IS 'Configurações de exibição dos questionários';
COMMENT ON COLUMN rshFormSetting.formSettingId IS 'Chave primária sequencial da tabela';
COMMENT ON COLUMN rshFormSetting.formId IS 'Código do formulário';
COMMENT ON COLUMN rshFormSetting.beginDate IS 'Data inicial da exibição do questionário';
COMMENT ON COLUMN rshFormSetting.endDate IS 'Data final da exibição do questionário';
COMMENT ON COLUMN rshFormSetting.beginHour IS 'Hora inicial da exibição do questionário';
COMMENT ON COLUMN rshFormSetting.endHour IS 'Hora final da exibição do questionário';

ALTER TABLE rshFormSetting ALTER COLUMN formId SET NOT NULL;
ALTER TABLE rshFormSetting ALTER COLUMN beginDate SET NOT NULL;
ALTER TABLE rshFormSetting ALTER COLUMN endDate SET NOT NULL;
ALTER TABLE rshFormSetting ALTER COLUMN beginHour SET NOT NULL;
ALTER TABLE rshFormSetting ALTER COLUMN endHour SET NOT NULL;

ALTER TABLE rshFormSetting ADD PRIMARY KEY (formSettingId);
ALTER TABLE rshFormSetting ALTER formSettingId SET DEFAULT NEXTVAL('seq_formsettingid');
ALTER TABLE rshFormSetting ADD FOREIGN KEY (formId) REFERENCES rshForm(formId);

------------------------------------------------------------
-- Purpose: Parâmetro que inidica se o módulo de
--          questionários está instalado ou não
-- 2008-05-23
-- dah
-- --
------------------------------------------------------------
INSERT INTO basConfig (username, ipaddress, moduleconfig, parameter, value, description, type, isvaluechangeable) VALUES ('sagu2', '127.0.0.1', 'BASIC', 'MODULE_RESEARCH_INSTALLED', 'YES', 'YES se o módulo de questionários está instalado. Ao contrário NO.', 'BOOLEAN', true);


------------------------------------------------------------
-- --
-- Purpose: Recriação da tabela de quem responde os forms
-- 2008-05-24
-- dah
-- --
-----------------------------------------------------------
DROP TABLE rshwho;

------------------------------------------------------------
-- Purpose: Alterações na tabela de configuração dos
--          questionários
-- 2008-05-24
-- dah
-- --
------------------------------------------------------------
ALTER TABLE rshFormSetting add isStudent boolean;
ALTER TABLE rshFormSetting add isProfessor boolean;
ALTER TABLE rshFormSetting add isEmployee boolean;
ALTER TABLE rshFormSetting ALTER COLUMN isStudent SET NOT NULL;
ALTER TABLE rshFormSetting ALTER COLUMN isProfessor SET NOT NULL;
ALTER TABLE rshFormSetting ALTER COLUMN isEmployee SET NOT NULL;
ALTER TABLE rshFormSetting ALTER COLUMN isStudent SET DEFAULT TRUE;
ALTER TABLE rshFormSetting ALTER COLUMN isProfessor SET DEFAULT TRUE;
ALTER TABLE rshFormSetting ALTER COLUMN isEmployee SET DEFAULT TRUE;
COMMENT ON COLUMN rshFormSetting.isStudent IS 'Se é para um aluno';
COMMENT ON COLUMN rshFormSetting.isProfessor IS 'Se é para um professor';
COMMENT ON COLUMN rshFormSetting.isEmployee IS 'Se é para um funcionário';
ALTER TABLE rshForm DROP isrestricted;

------------------------------------------------------------
-- Purpose: Alterações nas views dos questionários
-- 2008-05-26
-- dah
-- --
------------------------------------------------------------
DROP VIEW rshresult;

CREATE VIEW rshresult_noLogin AS
    SELECT r.formid, r.formname, r.questionid, r.question, r.optionid, r."option", r.answers, r.tanswers, (((100)::double precision / (r.tanswers)::double precision) * (r.answers)::double precision) AS answerpercent FROM (SELECT q.formid, f.description AS formname, q.questionid, q.description AS question, o.optionid, CASE WHEN (q.texttype = false) THEN o.description ELSE rshanswer_nologin.optiontext END AS "option", count(q.questionid) AS answers, (SELECT count(*) AS count FROM rshanswer_nologin a1 WHERE (a1.questionid = q.questionid) GROUP BY a1.questionid) AS tanswers FROM (((rshanswer_nologin JOIN rshquestion q USING (questionid)) LEFT JOIN rshoption o USING (optionid)) JOIN rshform f USING (formid)) GROUP BY q.questionid, o.optionid, q.description, o.description, q.formid, f.description, q.texttype, rshanswer_nologin.optiontext) r;

CREATE VIEW rshresult AS
    SELECT r.formid, r.formname, r.questionid, r.question, r.optionid, r."option", r.answers, r.tanswers, (((100)::double precision / (r.tanswers)::double precision) * (r.answers)::double precision) AS answerpercent FROM (SELECT q.formid, f.description AS formname, q.questionid, q.description AS question, o.optionid, CASE WHEN (q.texttype = false) THEN o.description ELSE rshanswer.optiontext END AS "option", count(q.questionid) AS answers, (SELECT count(*) AS count FROM rshanswer a1 WHERE (a1.questionid = q.questionid) GROUP BY a1.questionid) AS tanswers FROM (((rshanswer JOIN rshquestion q USING (questionid)) LEFT JOIN rshoption o USING (optionid)) JOIN rshform f USING (formid)) GROUP BY q.questionid, o.optionid, q.description, o.description, q.formid, f.description, q.texttype, rshanswer.optiontext) r;

------------------------------------------------------------
-- Purpose: Tirei a obrigatoriedade de um campo dos questionarios
-- 2008-05-27
-- dah
-- --
------------------------------------------------------------
alter TABLE rshanswer ALTER optionid DROP NOT NULL;

------------------------------------------------------------
-- Purpose: Criacao de índice pra otimizar a funcao balance
-- 2008-06-23
-- dah
-- --
------------------------------------------------------------
create index idx_finpayableinvoice_personid on finpayableinvoice(personid);

------------------------------------------------------------
-- Purpose: Tabela para a carteirinha dos alunos
-- 2008-06-25
-- gmurilo (incluído por dah no changes)
-- --
------------------------------------------------------------
CREATE TABLE acdsemturlist (
    contractid integer,
    periodid character varying(20),
    listagem text
)
INHERITS (baslog);
ALTER TABLE ONLY acdsemturlist
    ADD CONSTRAINT acdsemturlist_contractid_fkey FOREIGN KEY (contractid) REFERENCES acdcontract(contractid);
ALTER TABLE ONLY acdsemturlist
    ADD CONSTRAINT acdsemturlist_periodid_fkey FOREIGN KEY (periodid) REFERENCES acdperiod(periodid);


----------------------------------------------------------------------
-- --
-- Purpose: Função que retorna a última movimentação contratual
-- 2008-06-25
-- dah
-- --
----------------------------------------------------------------------
CREATE OR REPLACE FUNCTION getLastContractualMovement(INT) RETURNS INTEGER AS '
   SELECT stateContractId
     FROM acdMovementContract
    WHERE contractId = $1
 ORDER BY stateTime DESC
    LIMIT 1
' LANGUAGE 'sql';


----------------------------------------------------------------------
-- --
-- Purpose: Funcao para retornar o período e período letivo anterior
-- 2008-07-01
-- dah
-- --
----------------------------------------------------------------------
CREATE OR REPLACE FUNCTION getPreviousPeriodId(VARCHAR, INTEGER, INTEGER, INTEGER, VARCHAR) RETURNS VARCHAR AS '
SELECT A.periodId
  FROM acdLearningPeriod A,
       acdPeriod B
 WHERE A.periodId = B.periodId
   AND A.learningPeriodId = ( SELECT previousLearningPeriodId
                              FROM acdLearningPeriod
                             WHERE courseId = $1
                               AND courseVersion = $2
                               AND turnId = $3
                               AND unitId = $4
                               AND periodId = $5
                             LIMIT 1 );
' LANGUAGE 'sql';

CREATE OR REPLACE FUNCTION getPreviousLearningPeriodId(VARCHAR, INTEGER, INTEGER, INTEGER, VARCHAR) RETURNS VARCHAR AS '
SELECT periodId
  FROM acdLearningPeriod
 WHERE learningPeriodId = ( SELECT previousLearningPeriodId
                              FROM acdLearningPeriod
                             WHERE courseId = $1
                               AND courseVersion = $2
                               AND turnId = $3
                               AND unitId = $4
                               AND periodId = $5
                             LIMIT 1 );
' LANGUAGE 'sql';

----------------------------------------------------------------------
-- --
-- Purpose: Alteracao na tabela de ocorrencia de cursos para definir
--          quantas disciplinas em dependência o aluno pode ter para 
--          avançar nos semestres
-- 2008-07-01
-- dah
-- --
----------------------------------------------------------------------
ALTER TABLE acdCourseOccurrence ADD maximumDependent INT;
COMMENT ON COLUMN acdCourseOccurrence.maximumDependent IS 'Numero máximo de dependências que o aluno pode ter para avançar para o próximo período';
update acdCourseOccurrence set maximumDependent = 3;

----------------------------------------------------------------------
-- --
-- Purpose: Parametro da IEM do processo seletivo
-- 2008-07-07
-- dah
-- --
----------------------------------------------------------------------
INSERT INTO basConfig (moduleconfig, parameter, value, description, type, isvaluechangeable) VALUES ('BASIC', 'DEFAULT_SELECTIVE_PROCESS_INSTITUTIONIDHS', '3', 'Parametro da IEM do processo seletivo', 'int', true);

----------------------------------------------------------------------
-- --
-- Purpose: Parametro da cidade do processo seletivo
-- 2008-07-09
-- dah
-- --
----------------------------------------------------------------------
INSERT INTO basConfig (moduleconfig, parameter, value, description, type, isvaluechangeable) VALUES ('BASIC', 'DEFAULT_SELECTIVE_PROCESS_CITYIDHS', '19564', 'Parametro da cidade do processo seletivo', 'int',  true);

----------------------------------------------------------------------
-- --
-- Purpose: Alterei o formulário para quando ele for para um aluno,
--          que seja possível informar uma turma, curso ou período
--          letivo
-- 2008-07-28
-- dah
-- --
----------------------------------------------------------------------
ALTER TABLE rshFormSetting ADD classId varchar(20);
ALTER TABLE rshFormSetting ADD courseId varchar(20);
ALTER TABLE rshFormSetting ADD courseVersion INT;
ALTER TABLE rshFormSetting ADD unitId INT;
ALTER TABLE rshFormSetting ADD turnId INT;

COMMENT ON COLUMN rshFormSetting.classId IS 'Caso seja um formulario para uma turma específica, a mesma pode ser especificada aqui.';
COMMENT ON COLUMN rshFormSetting.courseId IS 'Caso seja um formulario para um curso específico, o mesma pode ser especificada aqui.';
COMMENT ON COLUMN rshFormSetting.courseVersion IS 'Caso seja um formulario para um curso específico, o mesma pode ser especificada aqui.';
COMMENT ON COLUMN rshFormSetting.turnId IS 'Caso seja um formulario para um curso específico, o mesma pode ser especificada aqui.';
COMMENT ON COLUMN rshFormSetting.unitId IS 'Caso seja um formulario para um curso específico, o mesma pode ser especificada aqui.';

ALTER TABLE rshFormSetting ADD FOREIGN KEY (classId) REFERENCES acdClass(classId);
ALTER TABLE rshFormSetting ADD FOREIGN KEY (courseid, courseversion, unitid, turnid) REFERENCES acdCourseOccurrence(courseid, courseversion, unitid, turnid);

----------------------------------------------------------------------
-- --
-- Purpose: Índice para não repetir alunos na tabela de turmas
-- 2008-07-30
-- dah
-- --
----------------------------------------------------------------------
CREATE UNIQUE INDEX idx_unique_class_pupil ON acdClassPupil(classId, contractId);

----------------------------------------------------------------------
-- --
-- Purpose: Tabela para processamento dos retornos
-- 2008-08-08
-- gmurilo
-- --
----------------------------------------------------------------------
CREATE TABLE finProcessedInfos (fileId integer NOT NULL REFERENCES finFile (fileId), invoiceId integer REFERENCES finReceivableInvoice (invoiceId), bankInvoiceId varchar(30), paymentDate date, maturityDate date, tolDate date, payedValue numeric(14,4), value numeric(14,4), discount numeric(14,4), occurrence varchar(100)) INHERITS (basLog);

COMMENT ON COLUMN finProcessedInfos.fileId IS 'Referencia de arquivo processado';
COMMENT ON COLUMN finProcessedInfos.invoiceId IS 'Codigo do titulo na tabela finReceivableInvoice';
COMMENT ON COLUMN finProcessedInfos.bankInvoiceId IS 'Codigo do titulo no banco';
COMMENT ON COLUMN finProcessedInfos.paymentDate IS 'Data que foi pago o titulo';
COMMENT ON COLUMN finProcessedInfos.payedValue IS 'Valor que foi pago';
COMMENT ON COLUMN finProcessedInfos.maturityDate IS 'Data de vencimento do titulo';
COMMENT ON COLUMN finProcessedInfos.tolDate IS 'Data de tolerancia para pagamento do titulo';
COMMENT ON COLUMN finProcessedInfos.value IS 'Valor do titulo';
COMMENT ON COLUMN finProcessedInfos.discount IS 'Desconto aplicado no titulo';
COMMENT ON COLUMN finProcessedInfos.occurrence IS 'Tipo da ocorrencia';

----------------------------------------------------------------------
-- --
-- Purpose: Tabela para criacao dos historicos das negociacoes
-- 2008-08-18
-- gmurilo
-- --
----------------------------------------------------------------------
CREATE SEQUENCE seq_agreementId;
CREATE TABLE finAgreementHistory
(agreementId INTEGER NOT NULL DEFAULT nextval('seq_agreementId') PRIMARY KEY,
 discount numeric(14,2),
 balance numeric(14,2),
 balanceWithPolicies numeric(14,2),
 parcelsNumber integer,
 inputValue numeric(14,2),
 maturityDateInput date) INHERITS (basLog);
COMMENT ON COLUMN finAgreementHistory.agreementId IS 'Chave primaria do historico, identifica o numero da negociacao';
COMMENT ON COLUMN finAgreementHistory.discount IS 'Desconto dado a negociacao';
COMMENT ON COLUMN finAgreementHistory.balance  IS 'Valor total da negociacao, sem juros/multas/descontos';
COMMENT ON COLUMN finAgreementHistory.balanceWithPolicies IS 'Valor total da negociacao, com juros/multas/descontos';
COMMENT ON COLUMN finAgreementHistory.parcelsNumber IS 'Numero de parcelas da negociacao';
COMMENT ON COLUMN finAgreementHistory.inputValue IS 'Valor da entrada da negociacao';
COMMENT ON COLUMN finAgreementHistory.maturityDateInput IS 'Data da entrada da negociacao';

----------------------------------------------------------------------
-- --
-- Purpose: Tabela para criacao dos historicos das parcelas das negoc.
-- 2008-08-19
-- gmurilo
-- --
----------------------------------------------------------------------

CREATE TABLE finAgreementHistoryParcels
(agreementId INTEGER NOT NULL REFERENCES finAgreementHistory(agreementId),
 invoiceId INTEGER NOT NULL REFERENCES finInvoice (invoiceId),
 invoiceType char(1)) INHERITS (basLog);
COMMENT ON COLUMN finAgreementHistoryParcels.agreementId IS 'Referencia do codigo da negociacao';
COMMENT ON COLUMN finAgreementHistoryParcels.invoiceId IS 'Codigo do titulo da negociacao';
COMMENT ON COLUMN finAgreementHistoryParcels.invoiceType IS 'Tipo do titulo I-Input, O-Output';

----------------------------------------------------------------------
-- --
-- Purpose: Funcao para retornar as parcelas das negociacoes.
-- 2008-08-20
-- gmurilo
-- --
----------------------------------------------------------------------
CREATE OR REPLACE FUNCTION public.getAgreementParcels(int4) RETURNS varchar AS
$_$
DECLARE
    results record;
    parcelasNegociadas varchar;
BEGIN
 
    parcelasNegociadas := '';

    FOR results IN 
      
        SELECT
          B.invoiceId || ',' as invoiceId
        FROM 
	  finAgreementHistory A LEFT JOIN
          finAgreementHistoryParcels B USING (agreementId)
	  INNER JOIN ONLY finInvoice C ON (C.invoiceId = B.invoiceId AND C.parcelNumber  > (CASE WHEN A.inputValue > 0 THEN 1 ELSE  0 END))
        WHERE 
          A.agreementId = $1
	  AND 
	  B.invoiceType = 'I'
        ORDER BY 1
    LOOP
        parcelasNegociadas := parcelasNegociadas || results.invoiceId;  
    END LOOP;
    IF ( LENGTH(parcelasNegociadas) > 0 ) THEN
    	RETURN substr(parcelasNegociadas,1,length(parcelasNegociadas)-1);
    END IF;
    RETURN NULL;
END;
$_$
LANGUAGE 'plpgsql';

CREATE OR REPLACE FUNCTION public.getAgreementParcelsValue(int4) RETURNS varchar AS
$_$
DECLARE
    results record;
    valoresDasParcelas varchar;
BEGIN
    valoresDasParcelas := '';
    FOR results IN 
        SELECT
          '(' || parcelNumber || ') R$' || ROUND(value, (SELECT (CASE WHEN value::integer IS NULL THEN 2 ELSE value::integer END) FROM basConfig WHERE parameter = 'REAL_ROUND_VALUE')) || ', '  as parcelValue
        FROM 
	  finAgreementHistory A LEFT JOIN
          finAgreementHistoryParcels B USING (agreementId)
	  INNER JOIN ONLY finInvoice C ON (C.invoiceId = B.invoiceId AND C.parcelNumber  > (CASE WHEN A.inputValue > 0 THEN 1 ELSE  0 END))
        WHERE 
          agreementId = $1
	  AND 
	  invoiceType = 'O'
        ORDER BY 1
    LOOP

        valoresDasParcelas := valoresDasParcelas || results.parcelValue;  
       
    END LOOP;
    IF ( LENGTH(valoresDasParcelas) > 1 ) THEN
    	RETURN substr(valoresDasParcelas,1,length(valoresDasParcelas)-2);
    END IF;
    RETURN NULL;

END;
$_$
LANGUAGE 'plpgsql';
----------------------------------------------------------------------
-- --
-- Purpose: Tabela que une as disciplinas oferecidas do professor.
-- 2008-08-26
-- gmurilo
-- --
----------------------------------------------------------------------

CREATE TABLE acdScheduleProfessorUnion ( 
	primaryScheduleProfessorId INTEGER NOT NULL REFERENCES acdScheduleProfessor(scheduleProfessorId),
	secondaryScheduleProfessorId INTEGER NOT NULL REFERENCES acdScheduleProfessor(scheduleProfessorId) ) 
INHERITS (basLog);

CREATE OR REPLACE FUNCTION noRepeatStructure() RETURNS TRIGGER AS $$
DECLARE acdScheduleProfessorUnion_ RECORD;

BEGIN
    SELECT INTO acdScheduleProfessorUnion_ primaryScheduleProfessorId,secondaryScheduleProfessorId FROM acdScheduleProfessorUnion WHERE ( primaryScheduleProfessorId = NEW.primaryScheduleProfessorId AND secondaryScheduleProfessorId = NEW.secondaryScheduleProfessorId ) OR ( primaryScheduleProfessorId = NEW.secondaryScheduleProfessorId AND secondaryScheduleProfessorId = NEW.primaryScheduleProfessorId ) ;
    IF NOT acdScheduleProfessorUnion_.primaryScheduleProfessorId  IS NULL THEN
	RETURN OLD;
    ELSIF (TG_OP = 'INSERT' OR TG_OP = 'UPDATE') AND NEW.primaryScheduleProfessorId = NEW.secondaryScheduleProfessorId THEN
        --RAISE EXCEPTION 'References most be diferents';
	RETURN OLD;
    ELSE
	RETURN NEW;
    END IF;
END;
$$ LANGUAGE 'plpgsql';

CREATE TRIGGER verityRepeatStructure BEFORE UPDATE OR INSERT
    ON acdScheduleProfessorUnion FOR EACH ROW
    EXECUTE PROCEDURE noRepeatStructure();
ALTER TABLE acdScheduleProfessorUnion ADD PRIMARY KEY (primaryScheduleProfessorId, secondaryScheduleProfessorId);

----------------------------------------------------------------------
-- --
-- Purpose: criacao de tabela de borda para saldos.
-- 2008-08-26
-- gmurilo
-- --
----------------------------------------------------------------------


CREATE TABLE finInvoiceBalance (invoiceId integer NOT NULL UNIQUE REFERENCES finInvoice (invoiceId), balance Numeric(14,4), balanceWithChecks Numeric(14,4)) INHERITS (basLog);

CREATE TRIGGER updateFinInvoiceBalance AFTER UPDATE OR INSERT OR DELETE
    ON finEntry FOR EACH ROW
    EXECUTE PROCEDURE updateFinInvoiceBalance();
    
INSERT INTO finInvoiceBalance (balance, balanceWithChecks, invoiceId) SELECT DISTINCT SUM(CASE WHEN B.operationTypeId = 'D' THEN A.value ELSE (-1*A.value) END) as vl, balance(invoiceId, true), A.invoiceId FROM finEntry A INNER JOIN finOperation B USING (operationId) GROUP BY invoiceId;


----------------------------------------------------------------------
-- --
-- Purpose: alteracoes para exclusão de títulos
-- 2008-09-02
-- gmurilo
-- --
----------------------------------------------------------------------

ALTER TABLE finInvoiceBalance DROP CONSTRAINT fininvoicebalance_invoiceid_fkey;

ALTER TABLE finInvoiceBalance ADD CONSTRAINT fininvoicebalance_invoiceid_fkey FOREIGN KEY (invoiceId) REFERENCES finInvoice(invoiceId) ON DELETE CASCADE;

----------------------------------------------------------------------
-- --
-- Purpose: funcao para pegar estado ultimo estado do contrato no per.
-- 2008-09-03
-- gmurilo
-- --
----------------------------------------------------------------------
CREATE OR REPLACE FUNCTION getContractState ( contractId_ INTEGER, periodId_ varchar(30) ) RETURNS INTEGER AS $$
    DECLARE 
        result_ RECORD;
    BEGIN
        SELECT INTO result_  DISTINCT stateContractId, contractId, periodId, stateTime  
                FROM acdMovementContract 
                INNER JOIN acdContract A USING (contractId)      
                INNER JOIN acdLearningPeriod B ON (B.endDate <= 
                        (SELECT max(endDate) 
                                FROM acdLearningPeriod 
                                WHERE 
                                    courseId =  A.courseId AND 
                                    turnId = A.turnId AND 
                                    unitId = A.unitId AND 
                                    courseVersion = A.courseVersion AND
                                    periodId = $2 ) 
                        AND B.courseId =  A.courseId AND 
                            B.turnId = A.turnId AND 
                            B.unitId = A.unitId AND 
                            B.courseVersion = A.courseVersion)
                WHERE contractId = $1
                ORDER BY stateTime DESC LIMIT 1 ;
        RETURN result_.stateContractId;
    END;
$$ LANGUAGE 'plpgsql';

----------------------------------------------------------------------
-- --
-- Purpose: alteracoes para exclusão de títulos negociados
-- 2008-09-09
-- gmurilo
-- --
----------------------------------------------------------------------

ALTER TABLE finAgreementHistoryParcels DROP CONSTRAINT finagreementhistoryparcels_invoiceid_fkey;

ALTER TABLE finAgreementHistoryParcels ADD CONSTRAINT finagreementhistoryparcels_invoiceid_fkey FOREIGN KEY (invoiceId) REFERENCES finInvoice(invoiceId) ON DELETE CASCADE;


----------------------------------------------------------------------
-- --
-- Purpose: adicionei a mantenedora em cada unidade
-- 2008-09-22
-- dah
-- --
----------------------------------------------------------------------
ALTER TABLE basUnit ADD companyId INTEGER REFERENCES basCompanyConf(companyId);
UPDATE basUnit set companyId = (SELECT value::INT FROM basConfig WHERE parameter LIKE 'DEFAULT_COMPANY_CONF');
COMMENT ON COLUMN basUnit.companyId IS 'Mantenedora da unidade. Caso nãi exista é utilizado o parâmetro DEFAULT_COMPANY_CONF como mantenedora padrão';
ALTER TABLE basUnit ALTER COLUMN companyId SET NOT NULL;

----------------------------------------------------------------------
-- --
-- Purpose: Inclusão da data completa da conclusão do segundo grau
--          ou graduacao
-- 2008-09-23
-- gmurilo
-- --
----------------------------------------------------------------------
ALTER TABLE basPhysicalPersonStudent ADD COLUMN conclusionDateHs DATE;

----------------------------------------------------------------------
-- --
-- Purpose: Inclusão de numero de telefones do setor e descricao de 
--          localizacao
-- 2008-09-24
-- gmurilo
-- --
----------------------------------------------------------------------
ALTER TABLE basSector ADD COLUMN place varchar(100);
ALTER TABLE basSector ADD COLUMN phone varchar(50);
ALTER TABLE basSector ADD COLUMN fax varchar(50);

COMMENT ON COLUMN basSector.place IS 'Descrição de onde é localizado o setor';
COMMENT ON COLUMN basSector.phone IS 'Telefone(s) do setor';
COMMENT ON COLUMN basSector.fax IS 'Fax do setor';

----------------------------------------------------------------------
-- --
-- Purpose: Inclusão de parametro basico de onde está localizad o 
--          setor de negociacao
-- 2008-09-24
-- gmurilo
-- --
----------------------------------------------------------------------

INSERT INTO basConfig (username, ipaddress, moduleconfig, parameter, value, description, type, isvaluechangeable) VALUES ('sagu2', '127.0.0.1', 'FINANCE', 'AGREEMENT_SECTOR_ID', '10', 'Define qual é o setor responsável pela central de negociação.', 'INT', true);

----------------------------------------------------------------------
-- --
-- Purpose: Inclusão do codigo da escola para carteira de estudante
-- 2008-09-26
-- gmurilo
-- --
----------------------------------------------------------------------
ALTER TABLE basLegalPerson ADD COLUMN schoolStudentCardId varchar(15);

COMMENT ON COLUMN basLegalPerson.schoolStudentCardId IS 'Codigo da escola para carteira de estudante';

UPDATE basLegalPerson SET schoolStudentCardId = '7601';

CREATE OR REPLACE FUNCTION getSchoolStudentCardIdFromUnit(integer) RETURNS varchar AS $$
    SELECT 
        schoolStudentCardId  
    FROM 
        basLegalPerson INNER JOIN 
        basCompanyConf USING (personId) INNER JOIN 
        basUnit USING (companyId) 
    WHERE unitId = $1;
$$ LANGUAGE 'sql';

----------------------------------------------------------------------
-- --
-- Purpose: Inclusão do campo que define se o questionário é de 
--          é avaliação institucional
-- 2008-10-27
-- dah
-- --
----------------------------------------------------------------------
ALTER TABLE rshFormSetting ADD COLUMN isInstitutionalEvaluation boolean not null default false;
COMMENT ON COLUMN rshFormSetting.isInstitutionalEvaluation IS 'Campo que define se o questionário é de é avaliação institucional';

----------------------------------------------------------------------
-- --
-- Purpose: Criação de uma tabela nova para gravar os dados da avalia-
--          ção institucional
-- 2008-10-28
-- dah
-- --
----------------------------------------------------------------------
CREATE SEQUENCE seq_answerid3;
CREATE TABLE rshanswer_institutionalEvaluation (
    answerId integer NOT NULL,
    personId integer,
    enrollId integer,
    questionId integer NOT NULL,
    optionId integer,
    optionText text,
    optionComment text
) INHERITS (basLog);
COMMENT ON TABLE rshanswer_institutionalEvaluation IS 'Tabela nova para gravar os dados da avaliação institucional';
ALTER TABLE rshanswer_institutionalEvaluation ALTER COLUMN answerId SET DEFAULT nextval('seq_answerid3');
ALTER TABLE rshanswer_institutionalEvaluation ADD PRIMARY KEY (answerId);
CREATE UNIQUE INDEX idx_rshanswer_institutionalevaluation_personId_enrollId_questionid on rshanswer_institutionalEvaluation(personid, enrollid, questionid);
ALTER TABLE rshanswer_institutionalEvaluation ADD FOREIGN KEY (questionId) REFERENCES rshQuestion (questionId);
ALTER TABLE rshanswer_institutionalEvaluation ADD FOREIGN KEY (optionId) REFERENCES rshOption (optionId);

----------------------------------------------------------------------
-- --
-- Purpose: Tabela de grupo de produtos e produtos
-- 2008-11-06
-- dah
-- --
----------------------------------------------------------------------
CREATE SEQUENCE seq_productgroupid;
CREATE TABLE basProductGroup (
    productGroupId integer NOT NULL,
    name text NOT NULL,
    description text
) INHERITS (basLog);
COMMENT ON TABLE basProductGroup IS 'Tabela de grupo de produtos';
ALTER TABLE basProductGroup ALTER COLUMN productGroupId SET DEFAULT nextval('seq_productgroupid');
ALTER TABLE basProductGroup ADD PRIMARY KEY (productGroupId);

CREATE SEQUENCE seq_productid;
CREATE TABLE basProduct (
    productId integer NOT NULL,
    productGroupId integer NOT NULL,
    name text NOT NULL,
    shortName text,
    description text,
    barCode text
) INHERITS (basLog);
COMMENT ON TABLE basProduct IS 'Tabela de produtos';
ALTER TABLE basProduct ALTER COLUMN productId SET DEFAULT nextval('seq_productid');
ALTER TABLE basProduct ADD PRIMARY KEY (productId);
ALTER TABLE basProduct ADD FOREIGN KEY (productGroupId) REFERENCES basProductGroup (productGroupId);

----------------------------------------------------------------------
-- --
-- Purpose: Tabelas de notas fiscais do módulo de comércio
-- 2008-11-06
-- dah
-- --
----------------------------------------------------------------------
CREATE SEQUENCE seq_trdinvoiceid;
CREATE TABLE trdInvoice (
    invoiceId integer NOT NULL,
    number text NOT NULL
) INHERITS (basLog);
COMMENT ON TABLE trdInvoice IS 'Tabela de notas fiscais do módulo de comércio';
ALTER TABLE trdInvoice ALTER COLUMN invoiceId SET DEFAULT nextval('seq_trdinvoiceid');
ALTER TABLE trdInvoice ADD PRIMARY KEY (invoiceId);

CREATE TABLE trdPurchasingInvoice (
) INHERITS (trdInvoice);
COMMENT ON TABLE trdPurchasingInvoice IS 'Tabela de notas fiscais de entrada';
ALTER TABLE trdPurchasingInvoice ADD PRIMARY KEY (invoiceId);

CREATE TABLE trdDeliveryInvoice (
) INHERITS (trdInvoice);
COMMENT ON TABLE trdDeliveryInvoice IS 'Tabela de notas fiscais de saida';
ALTER TABLE trdDeliveryInvoice ADD PRIMARY KEY (invoiceId);

CREATE SEQUENCE seq_trdinvoiceitemid;
CREATE TABLE trdInvoiceItem (
    invoiceItemId integer NOT NULL,
    invoiceId integer NOT NULL,
    productId integer NOT NULL
) INHERITS (basLog);
COMMENT ON TABLE trdInvoiceItem IS 'Tabela de ítens de notas fiscais do módulo de comércio';
ALTER TABLE trdInvoiceItem ALTER COLUMN invoiceItemId SET DEFAULT nextval('seq_trdinvoiceitemid');
ALTER TABLE trdInvoiceItem ADD PRIMARY KEY (invoiceItemId);
ALTER TABLE trdInvoiceItem ADD FOREIGN KEY (invoiceId) REFERENCES trdInvoice (invoiceId);
ALTER TABLE trdInvoiceItem ADD FOREIGN KEY (productId) REFERENCES basProduct (productId);

----------------------------------------------------------------------
-- --
-- Purpose: Tabela de operações com indicação se é uma operação do
--          contas a receber ou contas a pagar
-- 2008-11-07
-- dah
-- --
----------------------------------------------------------------------
DROP TRIGGER verifyContractOperation ON finOperation;
UPDATE finOperation SET receivableOrPayable = 'R';
ALTER TABLE finOperation ALTER COLUMN receivableOrPayable SET NOT NULL;
CREATE TRIGGER verifyContractOperation AFTER UPDATE OR INSERT
	ON finOperation FOR EACH ROW 
	EXECUTE PROCEDURE verifyContractOnOperation();

----------------------------------------------------------------------
-- --
-- Purpose: Tabela que indica o tipo de nota fiscal: entrada ou saida
-- 2008-11-11
-- dah
-- --
----------------------------------------------------------------------
CREATE SEQUENCE seq_trdinvoicetypeid;
CREATE TABLE trdInvoiceType
(
    invoiceTypeId integer,
    description text
) INHERITS (basLog);
COMMENT ON TABLE trdInvoiceType IS 'Tabela de tipo de nota fiscal: entrada ou saida';
ALTER TABLE trdInvoiceType ALTER COLUMN invoiceTypeId SET DEFAULT nextval('seq_trdinvoicetypeid');
ALTER TABLE trdInvoiceType ADD PRIMARY KEY (invoiceTypeId);
INSERT INTO trdInvoiceType (invoiceTypeId, description) VALUES (nextval('seq_trdinvoicetypeid'), 'ENTRADA');
INSERT INTO trdInvoiceType (invoiceTypeId, description) VALUES (nextval('seq_trdinvoicetypeid'), 'SAÍDA');

------------------------------------------------------------
-- Purpose: Parâmetro que indica qual o código do tipo de
--          nota de entrada (compra) ou saída (venda)
-- 2008-11-11
-- dah
-- --
------------------------------------------------------------
INSERT INTO basConfig (username, ipaddress, moduleconfig, parameter, value, description, type, isvaluechangeable) VALUES ('sagu2', '127.0.0.1', 'TRADE', 'BUY_INVOICE_TYPE', '1', 'Parãmetro que indica qual o código do tipo de nota de entrada (compra)', 'INT', true);
INSERT INTO basConfig (username, ipaddress, moduleconfig, parameter, value, description, type, isvaluechangeable) VALUES ('sagu2', '127.0.0.1', 'TRADE', 'SELL_INVOICE_TYPE', '2', 'Parãmetro que indica qual o código do tipo de nota de saída (venda)', 'INT', true);

----------------------------------------------------------------------
-- --
-- Purpose: Tabela que indica a série de nota fiscal
-- 2008-11-11
-- dah
-- --
----------------------------------------------------------------------
CREATE TABLE trdInvoiceSeries
(
    invoiceSeriesId char,
    description text
) INHERITS (basLog);
COMMENT ON TABLE trdInvoiceSeries IS 'Tabela de série de nota fiscal';
ALTER TABLE trdInvoiceSeries ADD PRIMARY KEY (invoiceSeriesId);

----------------------------------------------------------------------
-- --
-- Purpose: Questões de avaliação institucional do módulo de questões
--          podem ser por disciplina ou individuais
-- 2008-11-25
-- dah
-- --
----------------------------------------------------------------------
ALTER TABLE rshQuestion ADD isByCurricularComponent BOOLEAN DEFAULT FALSE;
UPDATE rshQuestion SET isByCurricularComponent = FALSE;
ALTER TABLE rshQuestion ALTER isByCurricularComponent SET NOT NULL;
COMMENT ON COLUMN rshQuestion.isByCurricularComponent IS 'Questoes de avaliacao institucional do modulo de questionario podem ser por disciplina ou individuais';

----------------------------------------------------------------------
-- --
-- Purpose: cria novo vestibular, mudando data, baseado em um 
--          vestibular anterior. 
-- 2008-11-27
-- gmurilo
-- --
----------------------------------------------------------------------
CREATE OR REPLACE FUNCTION newSelectiveProcess( varchar(10), varchar(10),  text,  integer,  date) RETURNS BOOLEAN AS $$
    DECLARE 
        periodId_ varchar(10);
        description_ text;
        beginDate_  date;
        selectiveprocessid_ varchar(10);
        sNumber  integer;
        valid_ BOOLEAN;
        results RECORD;
    BEGIN
        valid_              := true;
        selectiveProcessId_ := $1;
        periodId_           := $2;
        description_        := $3;
        sNumber             := $4;
        beginDate_          := $5;
        
        INSERT INTO sprSelectiveProcess (selectiveProcessId, 
                                         companyId,
                                         institutionId,
                                         periodId,
                                         description,
                                         beginDate,
                                         optionsNumber,
                                         isLanguage,
                                         isHighSchool,
                                         minimumPoints,
                                         maximumPoints,
                                         optionsNumberRequired)
        SELECT 
            periodId_||'.'||sNumber::varchar, 
            companyId, 
            institutionId, 
            periodId_,
            description_,
            beginDate_,
            optionsNumber,
            isLanguage,
            isHighSchool,
            minimumPoints,
            maximumPoints,
            optionsNumberRequired
       FROM sprSelectiveProcess WHERE selectiveProcessId = selectiveProcessId_;

    INSERT INTO sprinscriptionsetting 
        (selectiveprocessid, 
        begindate,
        enddate,
        beginhour,
        endhour,
        fee,
        emailadmin,
        issocialeconomic,
        messagewelcomeinscription,
        messagenotdisponibleinscription,
        messagefinishinscription,
        messageinformationinscription,
        messagedocumentinscription,
        messagehighschoolconcluedinscription,
        messageconcluedinscription,
        messageofinvoice)   
    SELECT DISTINCT 
        periodId_||'.'||sNumber::varchar, 
        now()::date,
        beginDate_,
        now()::time,
        endhour,
        fee,
        emailadmin,
        issocialeconomic,
        messagewelcomeinscription,
        messagenotdisponibleinscription,
        messagefinishinscription,
        messageinformationinscription,
        messagedocumentinscription,
        messagehighschoolconcluedinscription,
        messageconcluedinscription,
        'TAXA DO PROCESSO SELETIVO '|| periodId_||'.'||sNumber::varchar
    FROM sprinscriptionsetting WHERE selectiveProcessId = selectiveProcessId_; 
    INSERT INTO sprselectiveprocessoccurrence ( selectiveprocesstypeid, selectiveprocessid, ismain, priority )
    SELECT DISTINCT selectiveprocesstypeid, periodId_||'.'||sNumber::varchar, ismain, priority FROM sprselectiveprocessoccurrence WHERE selectiveProcessId = selectiveProcessId_; 
    INSERT INTO sprcoursevacant (selectiveProcessId, vacant, description ) SELECT DISTINCT periodId_||'.'||sNumber::varchar, vacant, description FROM sprcoursevacant  WHERE selectiveProcessId = selectiveProcessId_; 

    INSERT INTO sprCourseOccurrence (courseVacantId, courseId, courseVersion, turnId, unitId, isavailable) 
        SELECT DISTINCT A2.coursevacantId, A.courseId, A.courseVersion, A.turnId, A.unitId, A.isavailable FROM sprCourseOccurrence A INNER JOIN sprCourseVacant B USING (courseVacantId) INNER JOIN sprCourseVacant A2 ON (A2.selectiveProcessId = periodId_||'.'||sNumber::varchar AND A2.description = B.description AND A2.vacant = B.vacant )  WHERE B.selectiveProcessId = selectiveProcessId_;
    
    INSERT INTO sprexamOccurrence (selectiveprocessid, selectiveprocesstypeid, examid, numberquestions, weightquestion, numberorder, examdatetime, isanswersheet, maximumpoints ) SELECT DISTINCT periodId_||'.'||sNumber::varchar, selectiveprocesstypeid, examid, numberquestions, weightquestion, numberorder, TO_DATE(B.endDate||B.endhour,'yyyymmddHH24:MI'), isanswersheet, maximumpoints FROM sprexamOccurrence A,sprinscriptionsetting B WHERE A.selectiveProcessId = selectiveProcessId_ AND B.selectiveProcessId = periodId_||'.'||sNumber::varchar;
     
    INSERT INTO sprCourseExamBalance (courseVacantId, weight, minimumnote, examoccurrenceid) 
        SELECT DISTINCT coursevacantId, 1, 2.5, examOccurrenceId FROM sprexamOccurrence INNER JOIN sprCourseVacant USING (selectiveProcessId) WHERE selectiveProcessId = periodId_||'.'||sNumber::varchar;
    INSERT INTO sprPlaceOccurrence ( selectiveProcessId, placeId ) SELECT periodId_||'.'||sNumber::varchar, placeId FROM sprPlaceOccurrence WHERE selectiveProcessId = selectiveProcessId_;
    RETURN valid_;    
    END;
$$ LANGUAGE 'plpgsql';        

----------------------------------------------------------------------
-- --
-- Purpose: Tabela para gravar as entregas das notas dos professores
-- 2008-11-28
-- dah
-- --
----------------------------------------------------------------------
CREATE SEQUENCE seq_groupreleaseid;
CREATE TABLE acdGroupRelease
(
    groupReleaseId INT DEFAULT NEXTVAL('seq_groupreleaseid'),
    groupId INT NOT NULL REFERENCES acdGroup(groupId),
    degreeId INT NOT NULL REFERENCES acdDegree(degreeId),
    releaseDate TIMESTAMP NOT NULL DEFAULT now()
) INHERITS (basLog);
COMMENT ON TABLE acdGroupRelease IS 'Tabela para gravar as entregas das notas dos professoresl';
ALTER TABLE acdGroupRelease ADD PRIMARY KEY (groupReleaseId);
CREATE UNIQUE INDEX idxGroupDegree on acdGroupRelease(groupId, degreeId);

----------------------------------------------------------------------
-- --
-- Purpose: Alteração na tebale de mensagens para poder marcar as
--          não lidas
-- 2008-12-10
-- dah
-- --
----------------------------------------------------------------------
ALTER TABLE basMessage ADD isMarked BOOLEAN DEFAULT TRUE;
ALTER TABLE basMessage ALTER isMarked SET NOT NULL;
COMMENT ON COLUMN basMessage.isMarked IS 'Campo que indica se a mensagem já foi lida';

----------------------------------------------------------------------
-- --
-- Purpose: Alteração nos graus para definição da data de fim do bi-
--          mestre e data limite de entrega de notas e frequências
-- 2008-12-18
-- dah
-- --
----------------------------------------------------------------------
ALTER TABLE acdDegree ADD finalDate DATE;
UPDATE acdDegree SET finalDate = limitdate WHERE degreeId = degreeId;
--ALTER TABLE acdDegree ALTER finalDate SET NOT NULL;
--ALTER TABLE acdDegree ALTER limitDate SET NOT NULL;
COMMENT ON COLUMN acdDegree.finalDate IS 'Campo com a data final do grau/nota/bimestre';
COMMENT ON COLUMN acdDegree.limitDate IS 'Data limite para a entrega do grau/nota/bimestre';

----------------------------------------------------------------------
-- --
-- Purpose: Criação de índice para otimizar relatório da avaliação
--          institucional
-- 2009-01-20
-- dah
-- --
----------------------------------------------------------------------
CREATE INDEX idx_rshanwer_instit_evaluati on rshanswer_institutionalevaluation(questionid, optionid);


----------------------------------------------------------------------
-- --
-- Purpose: Criação do estado contratual de ABANDONO
-- 2009-02-05
-- dah
-- --
----------------------------------------------------------------------


----------------------------------------------------------------------
-- --
-- Purpose: Código padrão do país no processo seletivo
-- 2009-03-10
-- dah
-- --
----------------------------------------------------------------------
INSERT INTO basConfig (username, ipaddress, moduleconfig, parameter, value, description, type, isvaluechangeable) VALUES ('sagu2', '127.0.0.1', 'BASIC', 'SPR_DEFAULT_COUNTRY', '1', 'Código padrão do país no processo seletivo', 'INT', false);

----------------------------------------------------------------------
-- --
-- Purpose: Inclusao de novos status das disciplinas, aprovado 
--          e reprovado em final
-- 2009-03-13
-- gmurilo
-- --
----------------------------------------------------------------------

SELECT setval('seq_statusId', max(statusid)) from acdenrollstatus;
insert into acdenrollstatus (username, datetime, ipaddress, statusid, description) values ('admin', now(), '127.0.0.1', nextval('seq_statusId'), 'APROVADO EM FINAL');
insert into basconfig (username, datetime, ipaddress, moduleconfig, parameter, value, description, type, isvaluechangeable) select 'admin', now(), '127.0.0.1', 'ACADEMIC', 'ENROLL_STATUS_APPROVED_INEXAM', max(statusId)::varchar, 'Valor do statusid quando aprovado em exame final', 'INT', FALSE FROM acdEnrollStatus ;

insert into acdenrollstatus (username, datetime, ipaddress, statusid, description) values ('admin', now(), '127.0.0.1', nextval('seq_statusId'), 'REPROVADO EM FINAL');
insert into basconfig (username, datetime, ipaddress, moduleconfig, parameter, value, description, type, isvaluechangeable) select 'admin', now(), '127.0.0.1', 'ACADEMIC', 'ENROLL_STATUS_DISAPPROVED_INEXAM', max(statusId)::varchar, 'Valor do statusid quando reprovado em exame final', 'INT', FALSE FROM acdEnrollStatus ;

----------------------------------------------------------------------
-- --
-- Purpose: Obtem a turma inicial ativa do aluno
-- 2009-03-14
-- gmurilo
-- --
----------------------------------------------------------------------

CREATE OR REPLACE FUNCTION getClassId(contractId_ integer) RETURNS varchar AS $$
SELECT 
    classId 
FROM 
    acdClassPupil A INNER JOIN 
    ( SELECT 
        min(D.begindate) as beginDate, 
        A.contractId 
      FROM 
        acdContract A INNER JOIN 
        acdlearningperiod B USING (courseid, courseversion, turnid, unitid) LEFT JOIN 
        acdClass C ON (C.initialLearningPeriodId = B.learningPeriodId) INNER JOIN 
        acdClassPupil D ON (D.classId = C.classId AND A.contractId = D.contractId) 
      WHERE 
        A.contractId = $1 AND D.endDate IS NULL 
      GROUP BY A.contractid ) B ON (A.beginDate = B.beginDate AND A.Contractid = B.contractid) 
LIMIT 1 $$ LANGUAGE 'sql';

----------------------------------------------------------------------
-- --
-- Purpose: Campo que indica se a turma é de dependência ou não
-- 2009-03-14
-- dah
-- --
----------------------------------------------------------------------
ALTER TABLE acdClass ADD isDependence boolean DEFAULT false;
update acdClass set isDependence = false;
ALTER TABLE acdClass ALTER isDependence SET NOT NULL;
COMMENT ON COLUMN acdClass.isDependence IS 'Indica se será uma turma de dependência ou não';

----------------------------------------------------------------------
-- --
-- Purpose: Inclusao da cidade onde é feriado
-- 2009-03-20
-- gmurilo
-- --
----------------------------------------------------------------------
ALTER TABLE basHoliday ADD COLUMN cityId INTEGER;
CREATE INDEX idx_basholiday_cityid ON basHoliday(cityId);

----------------------------------------------------------------------
-- --
-- Purpose: Inclusao de parametro na basconfig para instituicoes publ
-- 2009-03-20
-- gmurilo
-- --
----------------------------------------------------------------------
INSERT INTO baslegalpersontype (legalpersontypeid,description) values(3,'INSTITUICAO PUBLICA'); 
SELECT setval('seq_legalpersontypeid', max(legalpersontypeid)) from baslegalpersontype; 
UPDATE baslegalpersontype set description = 'INSTITUICAO PRIVADA' WHERE legalpersontypeid = 2;
UPDATE baslegalpersontype set description = 'INSTITUICAO PUBLICA' WHERE legalpersontypeid = 3;
UPDATE basconfig set value = '2,3' WHERE parameter = 'LEGAL_PERSON_TYPE_INSTITUTIONS';
INSERT INTO basConfig(moduleconfig, parameter, value, description, type) VALUES ('BASIC', 'LEGAL_PERSON_TYPE_FOR_PUBLIC_INSTITUTIONS', '3', 'Codigo de tipo de pessoa juridica para instituicoes publicas', 'INT');

----------------------------------------------------------------------
-- --
-- Purpose: Padronizacao dos codigos de formationlevelid na basconfig
-- 2009-03-22
-- gmurilo
-- --
----------------------------------------------------------------------
UPDATE basConfig SET parameter = 'TECHNICAL_FORMATION_LEVEL_ID' WHERE parameter = 'TECHNICIAN_FORMATION_LEVEL';
UPDATE basConfig SET parameter = 'GRADUATE_FORMATION_LEVEL_ID' WHERE parameter = 'ACD_AFTER_GRADUATION_FORMATION_LEVEL_ID';
UPDATE basConfig SET parameter = 'EXTENSION_FORMATION_LEVEL_ID' WHERE parameter = 'ACD_EXTENSION_FORMATION_LEVEL_ID';
UPDATE basConfig SET parameter = 'MASTER_FORMATION_LEVEL_ID' WHERE parameter = 'ACD_MASTER_FORMATION_LEVEL_ID';
UPDATE basConfig SET parameter = 'GRADUATION_FORMATION_LEVEL_ID' WHERE parameter = 'COURSE_FORMATIONLEVELID_GRADUATE';

----------------------------------------------------------------------
-- --
-- Purpose: Campo indexado para saber o numero atual da carteira de 
--          estudante, numero da remessa
-- 2009-03-22
-- gmurilo
-- --
----------------------------------------------------------------------
ALTER TABLE acdSemturList ADD COLUMN listagemid integer not null;
CREATE INDEX idx_acdsemturlist_listagemId ON acdSemturList (listagemid);

----------------------------------------------------------------------
-- --
-- Purpose: Criacao de campo para grau substitutivo
-- 2009-03-22
-- gmurilo
-- --
----------------------------------------------------------------------

ALTER TABLE acddegree ADD COLUMN isSubstitutive BOOLEAN NOT NULL DEFAULT FALSE;

----------------------------------------------------------------------
-- --
-- Purpose: Campo para uso de nota maxima
-- 2009-03-24
-- gmurilo
-- --
----------------------------------------------------------------------
ALTER TABLE acdLearningPeriod ADD COLUMN maxNote FLOAT NOT NULL DEFAULT 10;

----------------------------------------------------------------------
-- --
-- Purpose: Campos para o diario de frequencia
-- 2009-03-24
-- gmurilo
-- --
----------------------------------------------------------------------

INSERT INTO basConfig(moduleconfig, parameter, value, description, type) VALUES ('ACADEMIC', 'ATTENDANCE_DESCRIBEDAYS_TEXT', '', 'Texto para exibicao quando nao estiver sendo exibido o descritivo das notas, apenas numeral, para exibicao no diário de frequencia', 'VARCHAR');

INSERT INTO basConfig(moduleconfig, parameter, value, description, type) VALUES ('ACADEMIC', 'ATTENDANCE_SUBSTITUTIVE_TEXT', '', 'Texto da nota substitutiva, para exibicao no diário de frequencia', 'VARCHAR');

INSERT INTO basConfig(moduleconfig, parameter, value, description, type) VALUES ('ACADEMIC', 'ATTENDANCE_PRESENCE_CHAR', '', 'Caracter a ser informada na presenca do aluno no diário de frequencia', 'CHAR');

INSERT INTO basConfig(moduleconfig, parameter, value, description, type) VALUES ('ACADEMIC', 'ATTENDANCE_ABSENCE_CHAR', '', 'Caracter a ser informada na ausencia do aluno no diário de frequencia', 'CHAR');

----------------------------------------------------------------------
-- --
-- Purpose: Campo para uso de nota maxima do degree
-- 2009-03-24
-- gmurilo
-- --
----------------------------------------------------------------------
ALTER TABLE acdDegree ADD COLUMN maxNote FLOAT NOT NULL DEFAULT 10;

----------------------------------------------------------------------
-- --
-- Purpose: Campo para desconto no final do mês, rodar a balance.sql
-- 2009-04-16
-- gmurilo
-- --
----------------------------------------------------------------------
ALTER TABLE finPolicy ADD COLUMN isDiscountAtLastMonthDay BOOLEAN DEFAULT FALSE;

----------------------------------------------------------------------
-- --
-- Purpose: Campo para indicar se o aluno não recebeu um grau
-- 2009-06-13
-- dah
-- --
----------------------------------------------------------------------
ALTER TABLE acdDegreeEnroll ADD isNotPresent boolean DEFAULT false;
COMMENT ON COLUMN acdDegreeEnroll.isNotPresent IS 'Campo para indicar se o aluno nao recebeu um grau';

----------------------------------------------------------------------
-- --
-- Purpose: Operação padrão para abono de multa e operação de abono
-- 2009-06-13
-- dah
-- --
----------------------------------------------------------------------
INSERT INTO finoperation VALUES ('sagu2', '2009-06-13 15:59:39.280252-03', NULL, 16, 'ABONO DE MULTA DA BIBLIOTECA', 'C', false, true, 'P', NULL, NULL, 'R');
ALTER TABLE finDefaultOperations ADD libraryFineAllowanceOperation INT REFERENCES finOperation(operationId);
COMMENT ON COLUMN finDefaultOperations.libraryFineAllowanceOperation IS 'Campo para operação de abono de multa da biblioteca';
UPDATE finDefaultOperations SET libraryFineAllowanceOperation = 16;
ALTER TABLE finDefaultOperations ALTER libraryFineAllowanceOperation SET NOT NULL;

----------------------------------------------------------------------
-- --
-- Purpose: Origem padrao da politica
-- 2009-06-18
-- gmurilo
-- --
----------------------------------------------------------------------
ALTER TABLE finPolicy ADD incomeSourceId INT REFERENCES finIncomeSource(incomeSourceId);

----------------------------------------------------------------------
-- --
-- Purpose: Exclusao da obrigatoriedade da operacao na politica
-- 2009-06-18
-- gmurilo
-- --
----------------------------------------------------------------------
ALTER TABLE finPolicy ALTER COLUMN operationId DROP NOT NULL;

----------------------------------------------------------------------
-- --
-- Purpose: Cricao de campos de contrato e periodo na tabela de titulos
-- 2009-06-21
-- gmurilo
-- --
----------------------------------------------------------------------
ALTER TABLE finReceivableInvoice ADD COLUMN contractId INT REFERENCES acdContract (contractId);
UPDATE finReceivableInvoice A SET contractId = B.contractId FROM acdContract B WHERE A.personId = B.personId AND A.courseId = B.courseId AND A.unitId = B.unitId;

ALTER TABLE finInvoice ADD COLUMN periodId varchar(10) REFERENCES acdPeriod (periodId);
UPDATE finInvoice A SET periodId = B.periodId FROM acdLearningPeriod B WHERE A.maturityDate BETWEEN B.beginDate AND B.endDate AND A.courseId = B.courseId AND A.unitId = B.unitId AND A.courseVersion = B.courseVersion;

ALTER TABLE acdPeriodEnrollDate ADD COLUMN isAcademic BOOL NOT NULL DEFAULT TRUE;
ALTER TABLE acdPeriodEnrollDate ADD COLUMN isFinance BOOL NOT NULL DEFAULT TRUE;

----------------------------------------------------------------------
-- --
-- Purpose: Tabela temporadia para atualizacao de dados de matricula 
-- 2009-06-21
-- gmurilo
-- --
----------------------------------------------------------------------

CREATE TABLE 
    srvEnrollPhysicalPersonStudent 
    (   
    personId INT references basPhysicalPersonStudent (personId),
        periodId varchar(10) references acdPeriod (periodId),
        zipCode varchar(9),
        cityId  INT references basCity (cityId),
        location text,
        number varchar(10),
        complement varchar(60),
        neighborhood text,
        email varchar(60),
        emailAlternative varchar(60),
        sex char(1),
        maritalStatusId char(1),
        dateBirth date,
        residentialPhone varchar(50),
        workPhone varchar(50),
        cellPhone varchar(50),
        messagePhone varchar(50),
        messageContact varchar(50),
        religionId INT references basReligion (religionId),
        ethnicOriginId INT references basEthnicorigin (ethnicoriginid),
        specialNecessityId INT references basSpecialNecessity (specialNecessityId),
        specialNecessityDescription text,
        contentCPF varchar(11),
        contentRG varchar(20),
        organRG varchar(12),
        dateExpeditionRG date,
        carPlate varchar(40),
        PRIMARY KEY (personId, periodId)
    ) inherits (basLog);
----------------------------------------------------------------------
-- --
-- Purpose: Tabela para politica de matricula
-- 2009-06-23
-- gmurilo
-- --
----------------------------------------------------------------------
CREATE TABLE 
    finPolicyEnroll (contractId INT REFERENCES acdContract (contractId),
                     policyId INT REFERENCES finPolicy (policyId),
                     PRIMARY KEY (contractId, policyId ) ) INHERITS (basLog);
----------------------------------------------------------------------
-- --
-- Purpose: Mensagem padrao para rematrícula no canal do aluno
-- 2009-06-24
-- gmurilo
-- --
----------------------------------------------------------------------

INSERT INTO basConfig (username, ipaddress, moduleconfig, parameter, value, description, type, isvaluechangeable) VALUES ('sagu2', '127.0.0.1', 'BASIC', 'PUPIL_ENROLL_MESSAGE', 'Caro Aluno,<br><br>Bem vindo ao processo de rematrícula on-line para o período letivo CURRENT_PERIOD_ID<br><br> Aqui você pode efetuar a sua rematricula no legalPerson->name com toda comodidade.<br><br>Para estar rematriculado, é preciso que você:<br> 1º Passo: Atualização dos dados cadastrais. <br>2º Passo: Não tenha nenhuma pendência financeira / biblioteca.<br> 3º Passo: Tenha o contrato CURRENT_PERIOD_ID devidamente impresso e assinado por você e seu FIADOR. <br>4º Passo: Efetue o pagamento da taxa de rematricula para CURRENT_PERIOD_ID <br>5º Passo: Efetue a ENTREGA, na SECAD, a documentação listada a seguir: <br>* 2 vias de contrato de prestação de serviço; <br>* Ficha de protocolo em anexo; <br>* Caso haja mudança de fiador, procure a SECAD para atualização do cadastro, portando: comprovante de renda, residência e cópias do CPF e RG do fiador; <br><br>Você só será considerado rematriculado para o período letivo CURRENT_PERIOD_ID se os 05 passos acima forem concluídos! <br><br>Este sistema o conduzirá neste processo. <br><br>Obs: 1. Alunos com isenção não precisam pagar a taxa de rematrícula, mas devem cumprir o restante do processo. <br>2. Ao término do processo, você receberá um comprovante de rematrícula. <br><br>Dúvidas, ligue: legalPerson->phone', 'Mensagem do canal do aluno para rematrícula','VARCHAR', true);

----------------------------------------------------------------------
-- --
-- Purpose: Cricao de campos para saber quem atualizou a tabela com os
--          Dados dos alunos
-- 2009-06-27
-- gmurilo
-- --
----------------------------------------------------------------------
ALTER TABLE srvEnrollPhysicalPersonStudent ADD COLUMN updated BOOL DEFAULT FALSE;
ALTER TABLE srvEnrollPhysicalPersonStudent ADD COLUMN updatedUserName varchar(20);
ALTER TABLE srvEnrollPhysicalPersonStudent ADD COLUMN updatedDateTime timestamp with time zone;

----------------------------------------------------------------------
-- --
-- Purpose: Cricao de campos para especificar a data de vencimento dos
--          titulos na tabela de periodo de matricula
-- 2009-07-12
-- gmurilo
-- --
----------------------------------------------------------------------
ALTER TABLE acdPeriodEnrollDate ADD COLUMN maturityDate DATE;
UPDATE acdPeriodEnrollDate SET maturityDate = COALESCE(endDate, now()::date);
ALTER TABLE acdPeriodEnrollDate ALTER COLUMN maturityDate SET NOT NULL;

----------------------------------------------------------------------
-- --
-- Purpose: Cricao de campo de referencia da tabela de movimentacao de
--          caixa
-- 2009-07-14
-- gmurilo
-- --
----------------------------------------------------------------------
ALTER TABLE finCounterMovement ADD COLUMN entryId INTEGER REFERENCES finEntry(entryId);

UPDATE finCounterMovement A set entryid = B.entryid FROM finEntry B WHERE TO_CHAR(A.datetime, 'dd-mm-yyyy hh24:mi:ss') = TO_CHAR(B.datetime, 'dd-mm-yyyy hh24:mi:ss') and A.username = B.username;

----------------------------------------------------------------------
-- --
-- Purpose: Cricao de campo para informacao da descricao da movimenta
--          cao, quando a mesma for de debito ou credito sem ser paga
--          mento de boleto
-- 2009-07-17
-- gmurilo
-- --
----------------------------------------------------------------------
ALTER TABLE finCounterMovement ADD COLUMN description text;


----------------------------------------------------------------------
-- --
-- Purpose: Alteração de status de aprovação para incluir a aprova-
--          ção em final
-- 2009-08-19
-- dah
-- --
----------------------------------------------------------------------
UPDATE basconfig set value = '2,7,10' where parameter = 'ENROLL_STATUS_APPR_OR_EXC';

----------------------------------------------------------------------
-- --
-- Purpose: Inclusao da tabela para cricao de taxas
--          
-- 2009-09-19
-- gmurilo
-- --
----------------------------------------------------------------------
CREATE SEQUENCE seq_taxId;
CREATE TABLE finTax 
(
    taxId integer default nextval('seq_taxId') primary key,
    description varchar(255) NOT NULL UNIQUE,
    policyId integer NOT NULL REFERENCES finPolicy ( policyId ),
    incomeSourceId integer NOT NULL REFERENCES finIncomeSource ( incomeSourceId ),
    operationId integer NOT NULL REFERENCES finOperation ( operationId ),
    costCenterId varchar(30) NOT NULL REFERENCES accCostCEnter ( costCenterId ),
    accountSchemeId varchar(30) NOT NULL REFERENCES accAccountScheme ( accountSchemeId ),
    bankAccountId integer NOT NULL,
    bankContractId integer NOT NULL,
    value numeric(14,2) NOT NULL
 ) INHERITS (basLog);

----------------------------------------------------------------------
-- --
-- Purpose: Campos usados para o calenario academico
--          
-- 2009-09-23
-- dah
-- --
----------------------------------------------------------------------
ALTER TABLE acdAcademicCalendarAdjustments ADD useLearningPeriodDateReference boolean default true;
ALTER TABLE acdAcademicCalendarAdjustments ADD useCalendarDateReference boolean default true;

----------------------------------------------------------------------
-- --
-- Purpose: Campo para o professor informar as observações dele na
--          pauta eletrônica
--          
-- 2009-09-28
-- dah
-- --
----------------------------------------------------------------------
ALTER TABLE acdGroup ADD professorObservation text;
COMMENT ON COLUMN acdGroup.professorObservation IS 'Campo para o professor informar as observações dele na pauta eletrônica';

----------------------------------------------------------------------
-- --
-- Purpose: View para puxar os aproveitamentos internos e externos
--          
-- 2009-09-28
-- dah
-- --
----------------------------------------------------------------------
CREATE OR REPLACE FUNCTION getClassPupil ( contractId_ integer ) RETURNS varchar AS '
DECLARE
    classIds varchar;
    tupla RECORD;
BEGIN
    classIds := '''';
    FOR tupla IN SELECT A.classId FROM acdClassPupil A INNER JOIN acdContract B ON ( A.contractId = B.contractId ) INNER JOIN acdClass C ON ( C.classId = A.classId ) INNER JOIN acdLearningPeriod D ON ( D.learningPeriodId = C.initialLearningPeriodId  AND D.courseId = B.courseId AND D.turnId = B.turnId AND D.unitId = B.unitId ) WHERE A.contractId = contractId_ AND A.endDate IS NULL
    LOOP
        IF LENGTH(classIds) > 0 THEN
            classIds := classIds || '', '' || tupla.classId;
        ELSE
            classIds := tupla.classId;
        END IF;
    END LOOP;
    RETURN classIds;
END;
'
LANGUAGE 'plpgsql';
DROP VIEW viewExploitations ;
CREATE OR REPLACE VIEW viewExploitations AS
SELECT
    CASE    
        WHEN A.exploitationType = 'I' THEN 'Internal'
        WHEN A.exploitationType = 'E' THEN 'External'
    END as exploitationType,
    B.contractId,
    H.periodId,
    getPersonName(A.institutionId) as institutionName,
    D.personId,
    getPersonName(D.personId) as personName,
    F.name as courseName,
    COALESCE(A.courseName, M.name ) as exploitationCourseName,
    COALESCE(A.curricularComponentName, K.name) as exploitationCurricularComponent,
    COALESCE(A.period, J.semester::text) as exploitationSerie,
    COALESCE(A.finalNote, I.finalNote::text) as exploitationFinalNote,
    COALESCE(A.numberhours, K.lessonNUmberHours) as exploitationCurricularComponentNumberHours,
    A.exploitationnumberhours,
    C.semester as serie,
    E.name as curricularComponent,
    E.lessonNumberHours,
    getClassPupil(B.contractId) as class,
    getTurnDescription(D.turnId) as turn,
    D.turnId,
    D.unitId,
    D.courseId,
    E.curricularComponentId,
    E.curricularComponentVersion
FROM
    acdExploitation A INNER JOIN
    acdEnroll B ON ( B.enrollId = A.enrollId ) INNER JOIN
    acdCurriculum C ON ( C.curriculumId = B.curriculumId ) INNER JOIN
    acdContract D ON ( D.contractId = B.contractId ) INNER JOIN
    acdCurricularComponent E ON ( E.curricularComponentId = C.curricularComponentId AND E.curricularComponentVersion = C.curricularComponentVersion ) INNER JOIN
    acdCourse F ON ( F.courseId = D.courseId ) LEFT JOIN
    acdLearningPeriod H ON ( B.learningPeriodId = H.learningPeriodId ) LEFT JOIN
    acdEnroll I ON ( I.enrollId = A.exploitationenrollid )  LEFT JOIN
    acdCurriculum J ON ( J.curriculumId = I.curriculumId ) LEFT JOIN
    acdCurricularComponent K ON ( K.curricularComponentId = J.curricularComponentId AND K.curricularComponentVersion = J.curricularComponentVersion ) LEFT JOIN
    acdContract L ON ( L.contractId = I.contractId ) LEFT JOIN
    acdCourse M ON ( M.courseId = L.courseId )
GROUP BY
    1,
    2,
    3,
    4,
    5,
    6,
    7,
    8,
    9,
    10,
    11,
    12,
    13,
    14,
    15,
    16,
    17,
    18,
    19,
    20,
    21,
    22,
    23;

----------------------------------------------------------------------
-- --
-- Purpose: índice para melhorar o desempenho da avaliação institucional
--          
-- 2009-11-15
-- dah
-- --
----------------------------------------------------------------------
CREATE INDEX idx_questionid_optionid on rshoption(questionid, optionid);

----------------------------------------------------------------------
-- --
-- Purpose: Novo parametro que define como vai ser exibida a digitacao
--          do conteudo programatico do professor
--
-- 2009-11-20
-- gmurilo
-- --
----------------------------------------------------------------------
insert into basconfig ( username, datetime, ipaddress, moduleconfig, parameter, value, description, type, isvaluechangeable )
    values ('sagu2', now(), '127.0.0.1'::inet, 'BASIC', 'PROFESSOR_SCHEDULE_CONTENT_GROUPED', 't', 'EXIBE A TELA DE CONTEÚDO AGRUPADA', 'BOOLEAN', true);


----------------------------------------------------------------------
-- --
-- Purpose: Origem de matrícula, disciplina isolada e readmissão
--
-- 2010-03-01
-- dah
-- --
----------------------------------------------------------------------
insert into basconfig ( username, datetime, ipaddress, moduleconfig, parameter, value, description, type, isvaluechangeable )
    values ('sagu2', now(), '127.0.0.1'::inet, 'FINANCE', 'ENROLL_ADDITTION_INCOME_SOURCE_ID', '3', 'Parâmetro que define a origem financeira para o acréscimo de disciplina', 'INT', true);
insert into basconfig ( username, datetime, ipaddress, moduleconfig, parameter, value, description, type, isvaluechangeable )
    values ('sagu2', now(), '127.0.0.1'::inet, 'FINANCE', 'ENROLL_READMISSION_INCOME_SOURCE_ID', '19', 'Parâmetro que define a origem financeira para o acréscimo de disciplina', 'INT', true);

----------------------------------------------------------------------
-- --
-- Purpose: texto da declaracao de imposto de renda
--
-- 2010-03-11
-- gmurilo
-- --
----------------------------------------------------------------------
INSERT INTO basconfig VALUES ('sagu2', '2010-03-11 11:03:54.194331-03', '200.249.81.152', 'FINANCE', 'INCOME_TAX_TEXT', 'Declaramos para os devidos fins, que o(a) aluno(a) $PERSONNAME, CPF $PERSONCPF, código $PERSONID efetuou os pagamentos referentes ao ano letivo de $YEAR na forma abaixo especificada.', 'TEXTO QUE SERÁ EXIBIDO NA DECLARAÇÃO DE IMPOSTO DE RENDA SEM FIADOR.', 'VARCHAR', true);
INSERT INTO basconfig VALUES ('sagu2', '2010-03-11 11:03:54.194331-03', '200.249.81.152', 'FINANCE', 'INCOME_TAX_TEXT_RESPONSABLE', 'Declaramos para os devidos fins, que $RESPONSABLENAME, CPF nº $RESPONSABLECPF é fiador da aluna $PERSONNAME, CPF $PERSONCPF, código $PERSONID, e efetuou os pagamentos referentes ao ano letivo de $YEAR na forma abaixo especificada.', 'TEXTO QUE SERÁ EXIBIDO NA DECLARAÇÃO DE IMPOSTO DE RENDA.', 'VARCHAR', true);

----------------------------------------------------------------------
-- --
-- Purpose: Campo para código INEP do MEC na tabela de países
--
-- 2010-03-25
-- dah
-- --
----------------------------------------------------------------------
ALTER TABLE basCountry ADD COLUMN inep varchar(3);
COMMENT ON COLUMN basCountry.inep IS 'Campo para código INEP do MEC';
UPDATE basCountry SET inep = '';
ALTER TABLE basCountry ALTER COLUMN inep SET NOT NULL;
\i mec/Tabela_Pais.sql

----------------------------------------------------------------------
-- --
-- Purpose: Campo para código INEP do MEC na tabela de estados
--
-- 2010-03-25
-- dah
-- --
----------------------------------------------------------------------
ALTER TABLE basState ADD COLUMN inep varchar(2);
COMMENT ON COLUMN basState.inep IS 'Campo para código INEP do MEC';
UPDATE basState SET inep = '';
ALTER TABLE basState ALTER COLUMN inep SET NOT NULL;
\i mec/Tabela_UF.sql

----------------------------------------------------------------------
-- --
-- Purpose: Campo para código INEP do MEC na tabela de cidades
--
-- 2010-03-25
-- dah
-- --
----------------------------------------------------------------------
ALTER TABLE basCity ADD COLUMN inep varchar(7);
COMMENT ON COLUMN basCity.inep IS 'Campo para código INEP do MEC';
UPDATE basCity SET inep = '';
ALTER TABLE basCity ALTER COLUMN inep SET NOT NULL;
\i mec/Tabela_Municipio.sql

----------------------------------------------------------------------
-- --
-- Purpose: Campo para código INEP do MEC na tabela de unidades
--
-- 2010-03-25
-- dah
-- --
----------------------------------------------------------------------
ALTER TABLE basUnit ADD COLUMN inep varchar(5);
COMMENT ON COLUMN basUnit.inep IS 'Campo para código INEP do MEC';
UPDATE basUnit SET inep = '';
ALTER TABLE basUnit ALTER COLUMN inep SET NOT NULL;

----------------------------------------------------------------------
-- --
-- Purpose: Campo para código INEP do MEC na tabela de empresas
--
-- 2010-03-25
-- dah
-- --
----------------------------------------------------------------------
ALTER TABLE basCompanyConf ADD COLUMN inep varchar(4);
COMMENT ON COLUMN basCompanyConf.inep IS 'Campo para código INEP do MEC';
UPDATE basCompanyConf SET inep = '';
ALTER TABLE basCompanyConf ALTER COLUMN inep SET NOT NULL;

----------------------------------------------------------------------
-- --
-- Purpose: Campo para código INEP do MEC na tabela de pessoas juridi
--          cas para o caso da mantenedora
-- 2010-03-26
-- gmurilo
-- --
----------------------------------------------------------------------
ALTER TABLE basLegalPerson ADD COLUMN inep integer;
COMMENT ON COLUMN basLegalPerson.inep IS 'Campo para código INEP do MEC';

----------------------------------------------------------------------
-- --
-- Purpose: Campo para código INEP do MEC na tabela de cursos
--
-- 2010-03-26
-- gmurilo
-- --
----------------------------------------------------------------------
ALTER TABLE acdCourse ADD COLUMN inep integer;
COMMENT ON COLUMN acdCourse.inep IS 'Campo para código INEP do MEC';

----------------------------------------------------------------------
-- --
-- Purpose: Cadastro de parâmetros básicos para alguns tipos de defici
--          ências
--
-- 2010-03-26
-- gmurilo
-- --
----------------------------------------------------------------------
INSERT INTO basConfig ( moduleconfig, parameter, value, description, type, isvaluechangeable ) VALUES ('BASIC', 'DEAF_SPECIAL_NECESSITY_ID', 1, 'Código para informar que a pessoa tem problemas auditivos. Corresponde na basSpecialNecessity', 'INT', false );
INSERT INTO basConfig ( moduleconfig, parameter, value, description, type, isvaluechangeable ) VALUES ('BASIC', 'CRIPPLE_SPECIAL_NECESSITY_ID', 2, 'Código para informar que a pessoa tem problemas físicos. Corresponde na basSpecialNecessity', 'INT', false );
INSERT INTO basConfig ( moduleconfig, parameter, value, description, type, isvaluechangeable ) VALUES ('BASIC', 'MULTIPLY_SPECIAL_NECESSITY_ID', 3, 'Código para informar que a pessoa tem problemas múltiplos. Corresponde na basSpecialNecessity', 'INT', false );
INSERT INTO basConfig ( moduleconfig, parameter, value, description, type, isvaluechangeable ) VALUES ('BASIC', 'INTELECTUAL_SPECIAL_NECESSITY_ID', 4, 'Código para informar que a pessoa tem problemas deficiência intelectual(mental). Corresponde na basSpecialNecessity', 'INT', false );
INSERT INTO basConfig ( moduleconfig, parameter, value, description, type, isvaluechangeable ) VALUES ('BASIC', 'BLIND_SPECIAL_NECESSITY_ID', 5, 'Código para informar que a pessoa tem problemas deficiência baixa visão. Corresponde na basSpecialNecessity', 'INT', false );

-- --
-- Purpose: Deficiências que faltavam segundo a tabela do censo do MEC
--
-- 2010-03-27
-- dah
-- --
----------------------------------------------------------------------
UPDATE basSpecialNecessity SET description = 'BAIXA VISÃO' WHERE specialnecessityid = 5;
UPDATE basConfig set description = 'Código para informar que a pessoa tem problemas deficiência baixa visão. Corresponde na basSpecialNecessity' where parameter = 'BLIND_SPECIAL_NECESSITY_ID';
INSERT INTO basspecialnecessity (username, datetime, ipaddress, specialnecessityid, description, easyaccess, accompanimentneeds, ispermanent, howmuchweeks, begindate) VALUES ('admin', date(now()), '127.0.0.1', 8, 'CEGUEIRA', false, false, false, NULL, NULL);
INSERT INTO basspecialnecessity (username, datetime, ipaddress, specialnecessityid, description, easyaccess, accompanimentneeds, ispermanent, howmuchweeks, begindate) VALUES ('admin', date(now()), '127.0.0.1', 9, 'SURDEZ', false, false, false, NULL, NULL);
INSERT INTO basspecialnecessity (username, datetime, ipaddress, specialnecessityid, description, easyaccess, accompanimentneeds, ispermanent, howmuchweeks, begindate) VALUES ('admin', date(now()), '127.0.0.1', 10, 'SURDOCEGUEIRA', false, false, false, NULL, NULL);
SELECT setval('seq_specialnecessityid',(SELECT max(specialnecessityid) FROM basSpecialNecessity));
INSERT INTO basConfig ( moduleconfig, parameter, value, description, type, isvaluechangeable ) VALUES ('BASIC', 'COMPLETE_BLIND_SPECIAL_NECESSITY_ID', 8, 'Código para informar que a pessoa tem problemas deficiência cegueira. Corresponde na basSpecialNecessity', 'INT', false );
INSERT INTO basConfig ( moduleconfig, parameter, value, description, type, isvaluechangeable ) VALUES ('BASIC', 'COMPLETE_DEAF_SPECIAL_NECESSITY_ID', 9, 'Código para informar que a pessoa tem problemas surdez . Corresponde na basSpecialNecessity', 'INT', false );
INSERT INTO basConfig ( moduleconfig, parameter, value, description, type, isvaluechangeable ) VALUES ('BASIC', 'BLIND_DEAF_SPECIAL_NECESSITY_ID', 10, 'Código para informar que a pessoa tem problemas surdocegueira . Corresponde na basSpecialNecessity', 'INT', false );

-- --
-- Purpose: Define a nacionalidade conforme a cidade caso esse campo
--          não esteja definido
--
-- 2010-03-27
-- dah
-- --
----------------------------------------------------------------------
UPDATE basPhysicalPerson 
   SET countryIdBirth = ( SELECT basCountry.countryId 
                            FROM basCountry 
                      INNER JOIN basState
                              ON ( basCountry.countryId = basState.countryId )
                      INNER JOIN basCity
                              ON (     basCity.stateId = basState.stateId 
                                   AND basCity.countryId = basCountry.countryId )
                           WHERE basCity.cityId = basPhysicalPerson.cityId )
 WHERE countryIdBirth IS NULL;

----------------------------------------------------------------------
-- --
-- Purpose: Cadastro de parâmetros básicos
--          
--
-- 2010-03-30
-- gmurilo
-- --
----------------------------------------------------------------------

INSERT INTO basConfig (username, datetime, ipaddress, moduleconfig, parameter, value, description,type, isvaluechangeable) values ('admin', now(), '127.0.0.1'::inet, 'ACADEMIC',   'STATE_CONTRACT_ID_PROUNI', 17, 'Código que caracteriza o status de entrada de um prouni',  'INT', false);

CREATE OR REPLACE FUNCTION inContractState(in contractId_ integer) RETURNS RECORD AS
$BODY$
    DECLARE result1 RECORD;
BEGIN
    SELECT INTO result1 contractId, TO_CHAR(stateTime,trim((SELECT value FROM basConfig WHERE parameter = 'MASK_DATE_TIME'))), stateContractId FROM acdmovementcontract WHERE stateContractID IN (  SELECT stateContractID FROM acdStateContract WHERE inouttransition = 'I' ) AND contractId = contractId_ ORDER BY stateTime DESC LIMIT 1;
    RETURN result1;
END;
$BODY$
LANGUAGE 'plpgsql' STABLE;

INSERT INTO basConfig (username, datetime, ipaddress, moduleconfig, parameter, value, description,type, isvaluechangeable) values ('admin', now(), '127.0.0.1'::inet, 'FINANCE',    'INCENTIVE_TYPE_ID_PROUNI', 5, 'Código para o tipo de incentivo prouni',    'INT', false);
INSERT INTO basConfig (username, datetime, ipaddress, moduleconfig, parameter, value, description,type, isvaluechangeable) values ('admin', now(), '127.0.0.1'::inet, 'FINANCE',    'INCENTIVE_TYPE_ID_FIES', 12, 'Código para o tipo de incentivo prouni integral', 'INT', false);
INSERT INTO basconfig (username, datetime, ipaddress, moduleconfig, parameter, value, description, type, isvaluechangeable) values ('admin', now(), '127.0.0.1'::inet, 'BASIC', 'ENROLL_INCOME_SOURCE_ID', '5', 'Parametro para definir a origem financeira de matricula', 'INT', false);
INSERT INTO basConfig (username, datetime, ipaddress, moduleconfig, parameter, value, description,type, isvaluechangeable) values ('admin', now(), '127.0.0.1'::inet, 'FINANCE',    'INCENTIVE_TYPE_ID_PROUNI_PARTIAL', 25, 'Código para o tipo de incentivo prouni parcial',    'INT', false);
INSERT INTO basConfig (username, datetime, ipaddress, moduleconfig, parameter, value, description,type, isvaluechangeable) values ('admin', now(), '127.0.0.1'::inet, 'BASIC',    'INCENTIVE_TYPE_ID_EMPLOYEE', 1, 'Código para o tipo de incentivo bolsa de trabalho','INT', false);

----------------------------------------------------------------------
-- --
-- Purpose: inclusao de columas que controlam a entrada e saida do pro
--          fessor
-- 2010-04-05
-- gmurilo
-- --
----------------------------------------------------------------------

ALTER TABLE acdScheduleProfessor ADD COLUMN beginDate date;
ALTER TABLE acdScheduleProfessor ADD COLUMN endDate date;
COMMENT ON COLUMN acdScheduleProfessor.beginDate IS 'Informa a data que o professor comecou a lecionar aquela disciplina, quando nulo significa que o mesmo inicio a disciplina';
COMMENT ON COLUMN acdScheduleProfessor.endDate IS 'Informa a data que o professor deixou a lecionar aquela disciplina, quando nulo significa que o mesmo ainda leciona a disciplina';

----------------------------------------------------------------------
-- --
-- Purpose: Funcoes corrigidas para unificacao das frequencias
--          
-- 2010-04-05
-- gmurilo
-- --
----------------------------------------------------------------------

DROP FUNCTION IF EXISTS getoccurrencedates ( int );

CREATE OR REPLACE FUNCTION public.getoccurrencedates (groupid_ int4) RETURNS SETOF RECORD AS
'
SELECT 
    occurrencedate,
    groupId,
    schedulelearningperiodId,
    learningPeriodId,
    sum(numberhourslessons) as numberhourslessons,
    lessonNumberHours,
    academicNumberHours,
    practiceHours,
    curriculumId,
    scheduleId,
    weekDayId,
    professorId
FROM 
(
    SELECT 
        A.occurrencedate,
        D.groupId,
        B.schedulelearningperiodId,
        B.learningPeriodId,
        B.numberhourslessons,
        F.lessonNumberHours,
        F.academicNumberHours,
        F.practiceHours,
        E.curriculumId,
        C.scheduleId,
        C.weekDayId,
        H.professorId
    FROM
        acdacademiccalendar A INNER JOIN
        acdScheduleLearningPeriod B ON ( A.learningPeriodId = B.learningPeriodId ) INNER JOIN
        acdSchedule C ON ( C.scheduleLearningPeriodId = B.scheduleLearningPeriodId AND 
                           A.weekdayid = C.weekdayid ) INNER JOIN
        acdGroup D ON ( C.groupId = D.groupId ) INNER JOIN
        acdCurriculum E ON ( D.curriculumId = E.curriculumId )  INNER JOIN
        acdCurricularComponent F ON ( F.curricularComponentId = E.curricularComponentId AND
                                      F.curricularComponentVersion = E.curricularComponentVersion ) INNER JOIN
        acdLearningPeriod G ON ( G.learningPeriodId = B.learningPeriodId ) LEFT JOIN
        acdScheduleProfessor H ON ( H.scheduleId = C.scheduleId ) LEFT JOIN
        acdAcademicCalendarAdjustments I ON ( I.scheduleId = H.scheduleId AND 
                                              I.professorId = H.professorId AND 
                                              I.occurrenceDate = A.occurrencedate AND
                                              I.inout = FALSE AND 
                                              I.weekDayId = A.weekDayId )
    WHERE
        A.occurrencedate BETWEEN B.beginDate AND B.endDate AND 
        A.occurrencedate BETWEEN G.beginDate AND G.endDate
        AND D.groupId = $1
        AND I.occurrenceDate IS NULL
    GROUP BY
        A.occurrencedate,
        B.schedulelearningperiodId,
        B.numberhourslessons,
        F.lessonNumberHours,
        F.academicNumberHours,
        F.practiceHours,
        E.curriculumId,
        D.groupId,
        B.learningPeriodId,
        C.scheduleId,
        C.weekDayId,
        H.professorId
    UNION

    SELECT 
        A.occurrencedate,
        C.groupId,
        C.schedulelearningperiodId,
        E.learningPeriodId,
        SUM(D.numberhourslessons) as numberhourslessons,
        I.lessonNumberHours,
        I.academicNumberHours,
        I.practiceHours,
        H.curriculumId,
        A.scheduleId,
        A.weekDayId,
        B.professorId
    FROM 
        acdAcademicCalendarAdjustments A INNER JOIN 
        acdScheduleProfessor B ON ( B.professorId = A.professorId 
                                    AND B.scheduleId = A.scheduleId ) INNER JOIN
        acdSchedule C ON ( C.scheduleId = B.scheduleId AND C.weekDayId = A.weekDayId ) INNER JOIN
        acdScheduleLearningPeriod D ON ( D.scheduleLearningPeriodId = C.scheduleLearningPeriodId ) INNER JOIN
        acdLearningPeriod E ON ( E.learningPeriodId = D.learningPeriodId )  LEFT JOIN
        acdAcademicCalendar F ON ( F.occurrenceDate = A.occurrenceDate 
                                   AND F.learningPeriodId = E.learningPeriodId ) LEFT JOIN
        acdGroup G ON ( G.groupId = C.groupId ) LEFT JOIN
        acdCurriculum H ON ( H.curriculumId = G.curriculumId )  LEFT JOIN
        acdCurricularComponent I ON ( I.curricularComponentId = H.curricularComponentId AND
                                      I.curricularComponentVersion = H.curricularComponentVersion )
    WHERE
        C.groupId = $1
        AND A.inout
    GROUP BY
        A.occurrenceDate,
        C.groupId,
        C.schedulelearningperiodId,
        E.learningPeriodId,
        I.lessonNumberHours,
        I.academicNumberHours,
        I.practiceHours,
        H.curriculumId,
        A.scheduleId,
        A.weekDayId,
        B.professorId,
        A.uselearningperioddatereference,
        A.useCalendarDateReference,
        E.beginDate,
        E.endDate,
        D.beginDate,
        D.endDate
    HAVING 
        CASE 
            WHEN A.uselearningperioddatereference THEN
                A.occurrenceDate BETWEEN E.beginDate AND E.endDate
            ELSE 
                1 = 1
        END AND
        CASE 
            WHEN A.useCalendarDateReference THEN
                A.occurrenceDate BETWEEN D.beginDate AND D.endDate
            ELSE 
                1 = 1
        END 
) A
GROUP BY         
    occurrencedate,
    groupId,
    schedulelearningperiodId,
    learningPeriodId,
    lessonNumberHours,
    academicNumberHours,
    practiceHours,
    curriculumId,
    scheduleId,
    weekDayId,
    professorId
ORDER BY
    A.occurrenceDate
'
LANGUAGE 'sql';

DROP FUNCTION IF EXISTS getoccurrencedatesgroupbygroup ( int );

CREATE OR REPLACE FUNCTION public.getoccurrencedatesgroupbygroup (groupid_ int4) RETURNS SETOF RECORD AS
'
SELECT 
    occurrencedate,
    groupId,
    learningPeriodId,
    sum(numberhourslessons) as numberhourslessons,
    lessonNumberHours,
    academicNumberHours,
    practiceHours,
    curriculumId,
    weekDayId
FROM 
    getOccurrenceDates ( $1 ) as (
        occurrencedate date,
        groupId integer ,
        schedulelearningperiodId integer,
        learningPeriodId integer,
        numberhourslessons float,
        lessonNumberHours float,
        academicNumberHours float,
        practiceHours float,
        curriculumId integer,
        scheduleId integer,
        weekDayId integer,
        professorId integer)
GROUP BY         
    occurrencedate,
    groupId,
    learningPeriodId,
    lessonNumberHours,
    academicNumberHours,
    practiceHours,
    curriculumId,
    weekDayId
ORDER BY
    occurrenceDate
'
LANGUAGE 'sql';

DROP FUNCTION IF EXISTS getoccurrencedatesprofessor ( int, int );
CREATE OR REPLACE FUNCTION public.getoccurrencedatesprofessor (groupid_ int4, professorid_ int4) RETURNS SETOF RECORD AS
'
SELECT 
    A.*
FROM 
    getOccurrenceDates($1) AS
        A ( occurrencedate date,
        groupId integer,
        schedulelearningperiodId integer,
        learningPeriodId integer,
        numberhourslessons float,
        lessonNumberHours float,
        academicNumberHours float,
        practiceHours float,
        curriculumId integer,
        scheduleId integer,
        weekDayId integer,
        professorId integer ) INNER JOIN 
        acdScheduleProfessor B ON ( A.scheduleId = B.scheduleId AND 
                                    A.professorId = B.professorId AND 
                                    ( A.occurrenceDate >= B.beginDate OR B.beginDate IS NULL ) AND 
                                    ( A.occurrenceDate <= B.endDate OR B.endDate IS NULL ) )
WHERE 
    A.professorId = $2
ORDER BY A.occurrenceDate;
'
LANGUAGE 'sql';


DROP FUNCTION IF EXISTS verifyenrollabsence ( int );
CREATE OR REPLACE FUNCTION public.verifyenrollabsence (enrollid_ int4) RETURNS int4 AS
'
DECLARE 
    tuplaGroup RECORD;
    tuplaOccurrenceDates RECORD;
    tuplaEnrollFrequence RECORD;
    absence integer;
BEGIN
    absence := 0;
    SELECT INTO tuplaGroup
        A.* 
    FROM
        acdGroup A INNER JOIN
        acdEnroll B USING ( groupId )
    WHERE
        B.enrollId = enrollId_;
    FOR tuplaOccurrenceDates IN 
        SELECT 
            *
        FROM 
            getoccurrencedatesgroupbygroup ( tuplaGroup.groupId ) AS 
            A ( occurrencedate date,
              groupId integer ,
              learningPeriodId integer,
              numberhourslessons float,
              lessonNumberHours float,
              academicNumberHours float,
              practiceHours float,
              curriculumId integer,
              weekDayId integer ) 
    LOOP
        SELECT INTO tuplaEnrollFrequence SUM(frequency) as frequency FROM acdFrequenceEnroll WHERE frequencyDate = tuplaOccurrenceDates.occurrenceDate AND enrollId = enrollId_;
        absence := absence + (tuplaOccurrenceDates.numberhourslessons - tuplaEnrollFrequence.frequency);
    END LOOP;
    RETURN absence;
END;
'
LANGUAGE 'plpgsql';


DROP FUNCTION IF EXISTS insertfrequencies ( int, float8, varchar, inet );

CREATE OR REPLACE FUNCTION public.insertfrequencies (enrollid_ int4, frequence_ float8, username_ varchar, ipaddress_ inet) RETURNS int4 AS
'
DECLARE
    retorno INT;
    tuplaFrequence RECORD;
    groupId_ INT;
    retornoNulo RECORD;
    currenteFrequence INT;
BEGIN
    currenteFrequence := frequence_ ;
    retorno := 0;
    SELECT INTO groupId_ groupId FROM acdEnroll WHERE enrollId = enrollId_;
    IF ( frequence_ = 0 ) THEN
        RETURN retorno;
    ELSE
        FOR tuplaFrequence IN 
        SELECT 
            *,
            (SELECT professorId FROM ONLY acdScheduleProfessor INNER JOIN acdSchedule USING (scheduleId) WHERE groupId = A.groupId AND ( A.occurrencedate BETWEEN beginDate AND endDate OR  ( beginDate IS NULL AND endDate IS NULL ) OR ( NOT beginDate IS NULL AND A.occurrenceDate >= beginDate AND endDate IS NULL ) OR ( NOT endDate IS NULL AND A.occurrenceDate <= endDate AND beginDate IS NULL ) ) ORDER BY acdScheduleProfessor.dateTime LIMIT 1) as professorId
        FROM 
            getoccurrencedatesgroupbygroup ( groupId_ ) AS 
            A ( occurrencedate date,
              groupId integer ,
              learningPeriodId integer,
              numberhourslessons float,
              lessonNumberHours float,
              academicNumberHours float,
              practiceHours float,
              curriculumId integer,
              weekDayId integer ) 
        ORDER BY A.occurrenceDate
        LOOP
            IF ( currenteFrequence > 0 ) THEN
                IF ( currenteFrequence - tuplaFrequence.numberhourslessons  ) >= 0 THEN
                    currenteFrequence := currenteFrequence - tuplaFrequence.numberhourslessons ;
                    retorno := retorno+tuplaFrequence.numberhourslessons;
                    SELECT INTO retornoNulo insertfrequence ( username_, ipaddress_, enrollid_, tuplaFrequence.occurrenceDate, tuplaFrequence.numberhourslessons, tuplaFrequence.professorid);                    
                ELSE
                    retorno := retorno+currenteFrequence;
                    SELECT INTO retornoNulo insertfrequence ( username_ , ipaddress_ , enrollid_ , tuplaFrequence.occurrenceDate, currenteFrequence, tuplaFrequence.professorid);
                    currenteFrequence := 0;
                END IF;
            ELSE
                SELECT INTO retornoNulo insertfrequence ( username_ , ipaddress_ , enrollid_ , tuplaFrequence.occurrenceDate, 0, tuplaFrequence.professorid);
            END IF;
        END LOOP;
        IF ( retorno IS null ) THEN
            retorno := 0;
        END IF;
    END IF;
    RETURN retorno;
END;
'
LANGUAGE 'plpgsql';

CREATE OR REPLACE FUNCTION getdegreefromgroupdate ( groupid_ integer, frequencydate_ date ) returns integer as 
'
 DECLARE
    retorno INT;                                        
 BEGIN                                                   
    SELECT INTO retorno                                 
        min(degreeNumber)                               
    FROM                                                
        acdGroup A INNER JOIN                           
        acdSchedule B ON ( B.groupId = A.groupId ) INNER JOIN
        acdScheduleLearningPeriod C ON ( C.scheduleLearningPeriodId = B.scheduleLearningPeriodId ) INNER JOIN
        acdDegree D ON ( D.learningPeriodId = C.learningPeriodId)
    WHERE                                               
        A.groupId = groupId_                            
        AND frequencyDate_ BETWEEN C.beginDate AND D.finalDate;
    RETURN retorno;                                     
 END;
' LANGUAGE 'plpgsql';

----------------------------------------------------------------------
-- --
-- Purpose: Funcoes para o retorno do conteudo para o groupid
--          
-- 2010-04-06
-- gmurilo
-- --
----------------------------------------------------------------------

CREATE OR REPLACE FUNCTION getFrequenceContent ( groupId_ integer, occurrenceDate_ date ) RETURNS text AS
$BODY$
DECLARE
    tuplaContent    RECORD;
    content         text;
BEGIN
    content := '';
    FOR tuplaContent IN
    select 
        C.content 
    from 
        acdgroup A inner join 
        acdschedule B using ( groupId ) inner join
        acdFrequenceContent C ON ( C.scheduleId  =  B.scheduleId AND C.occurrenceDate = occurrenceDate_)
    WHERE
        A.groupId = groupId_
    LOOP
        content := content || (tuplaContent.content) || '\n';
    END LOOP;
    RETURN content;
END;
$BODY$
LANGUAGE 'plpgsql';

----------------------------------------------------------------------
-- --
-- Purpose: Criacao de Parametro Basico que vai na ficha cadastral do 
--          aluno
-- 2010-04-07
-- gmurilo
-- --
----------------------------------------------------------------------

INSERT INTO
    basConfig ( username,  
                moduleconfig, 
                parameter, 
                value, 
                description, 
                type, 
                isvaluechangeable ) 
    VALUES
              ('sagu2',
               'ACADEMIC',
               'STATEMENT_OF_RESPONSIBILITY_TEXT',
               'RESPONZABILIZO-ME PELA EXATID�O DAS INFORMA��ES PRESTADAS, A VISTA DOS ORIGINAIS DOS DOCUMENTOS DE IDENTIDADE, CPF E OUTROS COMPROBAT�RIOS DOS DEMAIS ELEMENTOS DE INFORMA��O APRESENTADOS, SOB PENA DE APLICA��O DO DISPOSTO NO ART. 64 DA LEI N� 8.383, DE 30/12/1991.',
               'TEXTO QUE � EXIBIDO NA �REA DO TERMO DE RESPONSABILIDADE DE FICHA CADASTRAL.',
               'VARCHAR',
               true);

----------------------------------------------------------------------
-- --
-- Purpose: Correcao da funcao que obtem o calendario pra ela verifica
--          r os professor
-- 2010-04-08
-- gmurilo
-- --
----------------------------------------------------------------------


CREATE OR REPLACE FUNCTION public.getoccurrencedates (in groupid_ int4) RETURNS SETOF record AS
$BODY$
SELECT 
    occurrencedate,
    groupId,
    schedulelearningperiodId,
    learningPeriodId,
    sum(numberhourslessons) as numberhourslessons,
    lessonNumberHours,
    academicNumberHours,
    practiceHours,
    curriculumId,
    scheduleId,
    weekDayId,
    professorId,
    weight
FROM 
(
    SELECT 
        A.occurrencedate,
        D.groupId,
        B.schedulelearningperiodId,
        B.learningPeriodId,
        B.numberhourslessons,
        F.lessonNumberHours,
        F.academicNumberHours,
        F.practiceHours,
        E.curriculumId,
        C.scheduleId,
        C.weekDayId,
        H.professorId,
        COALESCE(H.weight,1) as weight
    FROM
        acdacademiccalendar A INNER JOIN
        acdScheduleLearningPeriod B ON ( A.learningPeriodId = B.learningPeriodId ) INNER JOIN
        acdSchedule C ON ( C.scheduleLearningPeriodId = B.scheduleLearningPeriodId AND 
                           A.weekdayid = C.weekdayid ) INNER JOIN
        acdGroup D ON ( C.groupId = D.groupId ) INNER JOIN
        acdCurriculum E ON ( D.curriculumId = E.curriculumId )  INNER JOIN
        acdCurricularComponent F ON ( F.curricularComponentId = E.curricularComponentId AND
                                      F.curricularComponentVersion = E.curricularComponentVersion ) INNER JOIN
        acdLearningPeriod G ON ( G.learningPeriodId = B.learningPeriodId ) LEFT JOIN
        acdScheduleProfessor H ON ( H.scheduleId = C.scheduleId ) LEFT JOIN
        acdAcademicCalendarAdjustments I ON ( I.scheduleId = H.scheduleId AND 
                                              I.professorId = H.professorId AND 
                                              I.occurrenceDate = A.occurrencedate AND
                                              I.inout = FALSE AND 
                                              I.weekDayId = A.weekDayId )
    WHERE
        A.occurrencedate BETWEEN B.beginDate AND B.endDate AND 
        A.occurrencedate BETWEEN G.beginDate AND G.endDate
        AND D.groupId = $1
        AND I.occurrenceDate IS NULL
    GROUP BY
        A.occurrencedate,
        B.schedulelearningperiodId,
        B.numberhourslessons,
        F.lessonNumberHours,
        F.academicNumberHours,
        F.practiceHours,
        E.curriculumId,
        D.groupId,
        B.learningPeriodId,
        C.scheduleId,
        C.weekDayId,
        H.professorId,
        H.beginDate,
        H.endDate,
        H.weight
    HAVING
        CASE WHEN NOT H.beginDate IS NULL THEN A.occurrenceDate >= H.beginDate ELSE 1 = 1 END AND
        CASE WHEN NOT H.endDate IS NULL THEN A.occurrenceDate <= H.endDate ELSE 1 = 1 END 
    UNION

    SELECT 
        A.occurrencedate,
        C.groupId,
        C.schedulelearningperiodId,
        E.learningPeriodId,
        SUM(D.numberhourslessons) as numberhourslessons,
        I.lessonNumberHours,
        I.academicNumberHours,
        I.practiceHours,
        H.curriculumId,
        A.scheduleId,
        A.weekDayId,
        B.professorId,
        COALESCE(B.weight,1) as weight
    FROM 
        acdAcademicCalendarAdjustments A INNER JOIN 
        acdScheduleProfessor B ON ( B.professorId = A.professorId 
                                    AND B.scheduleId = A.scheduleId ) INNER JOIN
        acdSchedule C ON ( C.scheduleId = B.scheduleId AND C.weekDayId = A.weekDayId ) INNER JOIN
        acdScheduleLearningPeriod D ON ( D.scheduleLearningPeriodId = C.scheduleLearningPeriodId ) INNER JOIN
        acdLearningPeriod E ON ( E.learningPeriodId = D.learningPeriodId )  LEFT JOIN
        acdAcademicCalendar F ON ( F.occurrenceDate = A.occurrenceDate 
                                   AND F.learningPeriodId = E.learningPeriodId ) LEFT JOIN
        acdGroup G ON ( G.groupId = C.groupId ) LEFT JOIN
        acdCurriculum H ON ( H.curriculumId = G.curriculumId )  LEFT JOIN
        acdCurricularComponent I ON ( I.curricularComponentId = H.curricularComponentId AND
                                      I.curricularComponentVersion = H.curricularComponentVersion )
    WHERE
        C.groupId = $1
        AND A.inout
    GROUP BY
        A.occurrenceDate,
        C.groupId,
        C.schedulelearningperiodId,
        E.learningPeriodId,
        I.lessonNumberHours,
        I.academicNumberHours,
        I.practiceHours,
        H.curriculumId,
        A.scheduleId,
        A.weekDayId,
        B.professorId,
        A.uselearningperioddatereference,
        A.useCalendarDateReference,
        E.beginDate,
        E.endDate,
        D.beginDate,
        D.endDate,
        B.weight
    HAVING 
        CASE 
            WHEN A.uselearningperioddatereference THEN
                A.occurrenceDate BETWEEN E.beginDate AND E.endDate
            ELSE 
                1 = 1
        END AND
        CASE 
            WHEN A.useCalendarDateReference THEN
                A.occurrenceDate BETWEEN D.beginDate AND D.endDate
            ELSE 
                1 = 1
        END 
) A
GROUP BY         
    occurrencedate,
    groupId,
    schedulelearningperiodId,
    learningPeriodId,
    lessonNumberHours,
    academicNumberHours,
    practiceHours,
    curriculumId,
    scheduleId,
    weekDayId,
    professorId,
    weight
ORDER BY
    A.occurrenceDate
$BODY$
LANGUAGE 'sql';

CREATE OR REPLACE FUNCTION public.getgroupofferedhours (in groupid_ int4) RETURNS float8 AS
$BODY$
select 
    sum(numberhourslessons)  
FROM (
    SELECT 
        sum(numberhourslessons)/sum(weight) as numberhourslessons,
        occurrenceDate,
        scheduleId
    FROM 
        getOccurrenceDates($1) AS
            ( occurrencedate date,
            groupId integer,
            schedulelearningperiodId integer,
            learningPeriodId integer,
            numberhourslessons float,
            lessonNumberHours float,
            academicNumberHours float,
            practiceHours float,
            curriculumId integer,
            scheduleId integer,
            weekDayId integer,
            professorId integer,
            weight float) 
    GROUP BY 
        groupId,
        scheduleId,
        occurrenceDate 
) A 
$BODY$
LANGUAGE 'sql';

CREATE OR REPLACE FUNCTION public.getoccurrencedatesgroupbygroup (in groupid_ int4) RETURNS SETOF record AS
$BODY$
SELECT 
    occurrencedate,
    groupId,
    learningPeriodId,
    sum(numberhourslessons)*(count(distinct scheduleid)/sum(weight)) as numberhourslessons,
    lessonNumberHours,
    academicNumberHours,
    practiceHours,
    curriculumId,
    weekDayId
FROM 
    getOccurrenceDates ( $1 ) as (
        occurrencedate date,
        groupId integer ,
        schedulelearningperiodId integer,
        learningPeriodId integer,
        numberhourslessons float,
        lessonNumberHours float,
        academicNumberHours float,
        practiceHours float,
        curriculumId integer,
        scheduleId integer,
        weekDayId integer,
        professorId integer,
        weight float)
GROUP BY         
    occurrencedate,
    groupId,
    learningPeriodId,
    lessonNumberHours,
    academicNumberHours,
    practiceHours,
    curriculumId,
    weekDayId
ORDER BY
    occurrenceDate
$BODY$
LANGUAGE 'sql';

CREATE OR REPLACE FUNCTION public.getoccurrencedatesprofessor (in groupid_ int4, in professorid_ int4) RETURNS SETOF record AS
$BODY$
SELECT 
    A.*
FROM 
    getOccurrenceDates($1) AS
        A ( occurrencedate date,
        groupId integer,
        schedulelearningperiodId integer,
        learningPeriodId integer,
        numberhourslessons float,
        lessonNumberHours float,
        academicNumberHours float,
        practiceHours float,
        curriculumId integer,
        scheduleId integer,
        weekDayId integer,
        professorId integer,
        weight float ) INNER JOIN 
        acdScheduleProfessor B ON ( A.scheduleId = B.scheduleId AND 
                                    A.professorId = B.professorId AND 
                                    ( A.occurrenceDate >= B.beginDate OR B.beginDate IS NULL ) AND 
                                    ( A.occurrenceDate <= B.endDate OR B.endDate IS NULL ) )
WHERE 
    A.professorId = $2
ORDER BY A.occurrenceDate;
$BODY$
LANGUAGE 'sql';

----------------------------------------------------------------------
-- --
-- Purpose: Criacao de Parametro Basico que vai definir se o professor 
--          pode digitar o conte�do pros dias inativos
-- 2010-04-13
-- gmurilo
-- --
----------------------------------------------------------------------

INSERT INTO
    basConfig ( username,  
                moduleconfig, 
                parameter, 
                value, 
                description, 
                type, 
                isvaluechangeable ) 
    VALUES
              ('sagu2',
               'ACADEMIC',
               'ALLOW_CONTENT_TYPING_WITH_NOAVALIABLE_DATE',
               't',
               'HABILITA O CONTE�DO DO PROFESSOR, MESMO COM A DATA INDISPO�VEL.',
               'BOOLEAN',
               true);

----------------------------------------------------------------------
-- --
-- purpose: criacao de parametro basico para definir o texto que vai
--          na lista de presen�a de prova
--          
-- 2010-04-15
-- gmurilo
-- --
----------------------------------------------------------------------

INSERT INTO
    basConfig ( username,  
                moduleconfig, 
                parameter, 
                value, 
                description, 
                type, 
                isvaluechangeable ) 
    VALUES
              ('sagu2',
               'BASIC',
               'SIGNATURE_LIST_TEXT',
               'Aos ___________ dias do m�s de ___________________ do ano de _______, foi realizada a prova referente ao $DEGREENUMBER � bimestre da disciplina $CURRICULARCOMPONENT, da turma $CLASSID sob a dire��o do(a) Professor(a) $PROFESSOR, conforme assinatura de presen�a abaixo.',
               'Texto exibido na lista de presen�a de prova',
               'VARCHAR',
               true);

----------------------------------------------------------------------
-- --
-- purpose: criacao de parametro basico para definir o texto que vai
--          na lista de presen�a de prova
--          
-- 2010-04-15
-- gmurilo
-- --
----------------------------------------------------------------------

INSERT INTO
    basConfig ( username,  
                moduleconfig, 
                parameter, 
                value, 
                description, 
                type, 
                isvaluechangeable ) 
    VALUES
              ('sagu2',
               'BASIC',
               'GRADES_AND_ABSENCES_TEXT',
               'Aos ___________ dias do m�s de ___________________ do ano de _______, foi entregue a prova e publicadas as notas/faltas referentes ao $DEGREENUMBER � bimestre da disciplina $CURRICULARCOMPONENT, da turma $CLASSID sob a dire��o do(a) Professor(a) $PROFESSOR, conforme assinatura de presen�a abaixo.',
               'Texto exibido na lista de presen�a de prova',
               'VARCHAR',
               true);

----------------------------------------------------------------------
-- --
-- purpose: inclusao de funcoes que daniel falou q estao faltando para
--          transferencia interna
--          
-- 2010-04-15
-- gmurilo
-- --
----------------------------------------------------------------------

CREATE OR REPLACE FUNCTION public.verifyequivalentcurriculum (in contractid_ int4, in curriculumid_ int4) RETURNS int4 AS
$BODY$
DECLARE 
    tuplaContract RECORD;
    tuplaCurriculum RECORD;
    retry BOOL;
    retrynumber integer;
    curriculumIdEquivalent integer;
    learningPeriodId_ integer;

    BEGIN

    retrynumber := 1;
    retry := true;

    SELECT INTO tuplaCurriculum
        curriculumId,
        curricularComponentId, 
        curricularComponentVersion,
        TO_ASCII(acdCurricularComponent.name) as name,
        curriculumId,
        lessonnumberhours
    FROM 
        acdCurriculum INNER JOIN
        acdCurricularComponent USING ( curricularComponentId, curricularComponentVersion )
    WHERE curriculumId = curriculumId_;
    
    IF tuplaCurriculum.curriculumId IS NULL THEN
        RETURN 0;
    END IF;  
    
    SELECT INTO tuplaContract courseId, courseVersion, turnId, unitId FROM acdContract WHERE contractId = $1;

    WHILE curriculumIdEquivalent IS NULL AND retry IS TRUE LOOP
        IF retrynumber = 1 THEN
                        SELECT INTO curriculumIdEquivalent
                curriculumId 
            FROM 
                acdCurriculum 
            WHERE 
                courseId = tuplaContract.courseId AND
                courseVersion = tuplaContract.courseVersion AND
                turnId = tuplaContract.turnId AND
                unitId = tuplaContract.unitId AND
                curriculumId = tuplaCurriculum.curriculumId;
        ELSEIF retrynumber = 2 THEN
                        SELECT INTO curriculumIdEquivalent
                curriculumId 
            FROM 
                acdCurriculum 
            WHERE 
                courseId = tuplaContract.courseId AND
                courseVersion = tuplaContract.courseVersion AND
                turnId = tuplaContract.turnId AND
                unitId = tuplaContract.unitId AND
                curricularComponentId = tuplaCurriculum.curricularComponentId AND
                curricularComponentVersion = tuplaCurriculum.curricularComponentVersion;
        ELSEIF retrynumber = 3 THEN
                        SELECT INTO curriculumIdEquivalent
                curriculumId 
            FROM 
                acdCurriculum INNER JOIN
                acdCurricularComponent USING ( curricularComponentId, curricularComponentVersion )
            WHERE 
                courseId = tuplaContract.courseId AND
                courseVersion = tuplaContract.courseVersion AND
                turnId = tuplaContract.turnId AND
                unitId = tuplaContract.unitId AND
                curricularComponentId = tuplaCurriculum.curricularComponentId AND
                ( (lessonNumberHours*0.75) <= tuplaCurriculum.lessonNumberHours OR 
                  (lessonNumberHours*0.75) >= tuplaCurriculum.lessonNumberHours ) ;
        ELSEIF retrynumber = 4 THEN        
                        SELECT INTO curriculumIdEquivalent
                A.curriculumId 
            FROM 
                acdCurriculum A INNER JOIN
                acdCurriculumLink B ON ( A.curriculumId = B.curriculumLinkId )
            WHERE 
                A.courseId = tuplaContract.courseId AND
                A.courseVersion = tuplaContract.courseVersion AND
                A.turnId = tuplaContract.turnId AND
                A.unitId = tuplaContract.unitId AND
                B.curriculumId = tuplaCurriculum.curriculumId;
        ELSEIF retrynumber = 5 THEN        
                        SELECT INTO curriculumIdEquivalent
                A.curriculumId 
            FROM 
                acdCurriculum A INNER JOIN
                acdCurriculumLink B ON ( A.curriculumId = B.curriculumId )
            WHERE 
                A.courseId = tuplaContract.courseId AND
                A.courseVersion = tuplaContract.courseVersion AND
                A.turnId = tuplaContract.turnId AND
                A.unitId = tuplaContract.unitId AND
                B.curriculumLinkId = tuplaCurriculum.curriculumId;
        ELSE
                        retry := false;
            curriculumIdEquivalent := 0;
        END IF;
        retrynumber := retrynumber +1;
    END LOOP;
    RETURN curriculumIdEquivalent;
END;
$BODY$
LANGUAGE 'plpgsql';


CREATE OR REPLACE FUNCTION public.verifyequivalentcurriculumbygroup (in contractid_ int4, in groupid_ int4) RETURNS record AS
$BODY$
DECLARE 
    tuplaGroup RECORD;
    tuplaCurriculumGroup RECORD;
    learningPeriodId_ integer;
    curriculumId_  integer;
BEGIN
    learningPeriodId_ := 0;
    curriculumId_ := 0;
    SELECT INTO tuplaGroup 
        acdGroup.curriculumId,
        acdLearningPeriod.periodId,
        acdContract.unitId,
        acdContract.courseId,   
        acdContract.courseVersion,
        acdContract.turnId
    FROM 
        acdGroup INNER JOIN
        acdLearningPeriod ON ( acdLearningPeriod.learningPeriodId = acdGroup.learningPeriodId ) INNER JOIN
        acdContract ON ( 1 = 1 AND acdContract.contractId = contractId_ )
    WHERE groupId = groupId_;

    SELECT INTO 
        learningPeriodId_ learningPeriodId 
    FROM
        acdLearningPeriod 
    WHERE
        courseId = tuplaGroup.courseId
    AND courseVersion = tuplaGroup.courseVersion
    AND turnId = tuplaGroup.turnId
    AND unitId = tuplaGroup.unitId 
    AND periodId = tuplaGroup.periodId;
    SELECT INTO curriculumId_ verifyEquivalentCurriculum ( contractId_, tuplaGroup.curriculumId );
    IF learningPeriodId_ > 0 AND curriculumId_ > 0 THEN
        SELECT INTO tuplaCurriculumGroup learningPeriodId_, curriculumId_, contractId_, groupId_;
    ELSIF curriculumId_ > 0 THEN
        SELECT INTO tuplaCurriculumGroup learningPeriodId_, curriculumId_, contractId_, groupId_;
    ELSE 
        SELECT INTO tuplaCurriculumGroup learningPeriodId_, curriculumId_, contractId_, groupId_;
    END IF;
    RETURN tuplaCurriculumGroup  ;
END;
$BODY$
LANGUAGE 'plpgsql';

----------------------------------------------------------------------
-- --
-- purpose: criacao de parametro basico para definir o texto que vai
--          na lista de presen�a de prova final
--          
-- 2010-04-15
-- gmurilo
-- --
----------------------------------------------------------------------

INSERT INTO
    basConfig ( username,  
                moduleconfig, 
                parameter, 
                value, 
                description, 
                type, 
                isvaluechangeable ) 
    VALUES
              ('sagu2',
               'BASIC',
               'SIGNATURE_LIST_FINAL_MINUTE_TEXT',
               'Aos ___________ dias do m�s de ___________________ do ano de _______, foi realizada a prova final para disciplina $CURRICULARCOMPONENT, da turma $CLASSID sob a dire��o do(a) Professor(a) $PROFESSOR, conforme assinatura de presen�a abaixo.',
               'Texto exibido na lista de presen�a de prova final',
               'VARCHAR',
               true);

----------------------------------------------------------------------
-- --
-- purpose: criacao de campo para definir disciplina eletiva daniel,
--          tem que mandar um update para modificar a forma antiga
--          de pegar a disciplina eletiva          
--
-- 2010-04-22
-- gmurilo
-- --
----------------------------------------------------------------------

ALTER TABLE acdCurriculum ADD COLUMN masterCurriculumId integer REFERENCES acdCurriculum ( curriculumId );
COMMENT ON COLUMN acdCurriculum.masterCurriculumId IS 'Define quem � a disciplina eletiva que agrupar� as op��es';

----------------------------------------------------------------------
-- --
-- purpose: criacao de campo para inclusao da observa��o a respeito
--          do tipo de documento, sera utilizada na ficha cadastral
--
-- 2010-04-26
-- gmurilo
-- --
----------------------------------------------------------------------

ALTER TABLE basDocumentType ADD COLUMN observation text;
COMMENT ON COLUMN basDocumentType.observation IS 'Define observa��es de verifica��o e preenchimento para serem verificadas na ficha cadastral';


----------------------------------------------------------------------
-- --
-- purpose: criacao de campo de referencia de bairro
--
-- 2010-04-26
-- gmurilo
-- --
----------------------------------------------------------------------

ALTER TABLE basperson ADD COLUMN neighborhoodid INTEGER REFERENCES basNeighborhood ( neighborhoodid );
COMMENT ON COLUMN basPerson.neighborhoodid IS 'Define o c�digo do bairro do aluno';
update basperson a set neighborhoodid = c.neighborhoodid from baslocation b inner join basneighborhood c using (neighborhoodid) where b.cityid = a.cityid and c.name ilike a.neighborhood;

----------------------------------------------------------------------
-- --
-- purpose: funcao que retorna o total de faltas
--
-- 2010-05-04
-- gmurilo
-- --
----------------------------------------------------------------------

CREATE OR REPLACE FUNCTION public.verifyenrollabsence (in enrollid_ int4) RETURNS int4 AS
$BODY$
DECLARE 
    tuplaGroup RECORD;
    tuplaOccurrenceDates RECORD;
    tuplaEnrollFrequence RECORD;
    absence integer;
BEGIN
    absence := 0;
    SELECT INTO tuplaGroup
        A.* 
    FROM
        acdGroup A INNER JOIN
        acdEnroll B USING ( groupId )
    WHERE
        B.enrollId = enrollId_;
    FOR tuplaOccurrenceDates IN 
        SELECT 
            *
        FROM 
            getoccurrencedatesgroupbygroup ( tuplaGroup.groupId ) AS 
            A ( occurrencedate date,
              groupId integer ,
              learningPeriodId integer,
              numberhourslessons float,
              lessonNumberHours float,
              academicNumberHours float,
              practiceHours float,
              curriculumId integer,
              weekDayId integer ) 
    LOOP
        SELECT INTO tuplaEnrollFrequence SUM(frequency) as frequency FROM acdFrequenceEnroll WHERE frequencyDate = tuplaOccurrenceDates.occurrenceDate AND enrollId = enrollId_;
        IF ( NOT tuplaEnrollFrequence.frequency IS NULL ) THEN
            absence := absence + (tuplaOccurrenceDates.numberhourslessons - tuplaEnrollFrequence.frequency);
        END IF;
    END LOOP;
    RETURN absence;
END;
$BODY$
LANGUAGE 'plpgsql';

------------------------------------------------------------
-- Purpose: inclusao da politicas de matricula re matricula
--          no curso e ocorrencia do curso
-- 2010-05-07
-- gmurilo
-- --
------------------------------------------------------------
ALTER TABLE acdCourseOccurrence ADD COLUMN policyId INTEGER REFERENCES finPolicy (policyId);
ALTER TABLE acdCourseOccurrence ADD COLUMN policyIdForEnroll INTEGER REFERENCES finPolicy (policyId);
ALTER TABLE acdCourseOccurrence ADD COLUMN policyIdForReEnroll INTEGER REFERENCES finPolicy (policyId);
COMMENT ON COLUMN acdCourseOccurrence.policyId IS 'Define a pol�tica � ser usada para mensalidade na ocorr�ncia do curso';
COMMENT ON COLUMN acdCourseOccurrence.policyIdForEnroll IS 'Define a pol�tica � ser usada para matr�cula na ocorr�ncia do curso';
COMMENT ON COLUMN acdCourseOccurrence.policyIdForReEnroll IS 'Define a pol�tica � ser usada para re-matr�cula na ocorr�ncia do curso';

ALTER TABLE acdCourse ADD COLUMN policyIdForEnroll INTEGER REFERENCES finPolicy (policyId);
ALTER TABLE acdCourse ADD COLUMN policyIdForReEnroll INTEGER REFERENCES finPolicy (policyId);
COMMENT ON COLUMN acdCourse.policyIdForEnroll IS 'Define a pol�tica � ser usada para matr�cula no curso';
COMMENT ON COLUMN acdCourse.policyIdForReEnroll IS 'Define a pol�tica � ser usada para re-matr�cula no curso';

------------------------------------------------------------
-- Purpose: cria funcao para o novo modelo de matriz curric
--          ular
-- 2010-05-07
-- gmurilo
-- --
------------------------------------------------------------
CREATE OR REPLACE FUNCTION getCurriculumInfo ( courseId_ varchar(10), courseVersion_ int, turnId_ int, unitId_ int ) RETURNS SETOF RECORD AS
$BODY$
DECLARE
    tuplaCurriculum RECORD;
    tuplaCurriculum2 RECORD;
BEGIN
    FOR tuplaCurriculum IN 
    SELECT 
        B.curricularComponentId, 
        B.curricularComponentVersion::int, 
        B.name::varchar, 
        B.shortname::varchar,
        B.academicNumberHours::float,
        B.lessonNumberHours::float,
        B.practiceHours::float,
        A.semester,
        A.curriculumTypeId,
        A.curricularComponentTypeId,
        A.masterCurriculumId,
        A.curriculumId
    FROM
        acdCurriculum A INNER JOIN
        acdCurricularComponent B USING ( curricularComponentId, curricularComponentVersion )
    WHERE
        A.courseId = courseId_
    AND A.courseVersion = courseVersion_
    AND A.turnId = turnId_
    AND A.unitId = unitId_
    --AND NOT A.curricularComponentTypeId IN ( SELECT value::integer FROM basConfig WHERE parameter IN ('CURRICULAR_COMPONENT_TYPE_ELECTIVE', 'CURRICULAR_COMPONENT_TYPE_TRAINING') ) 
    AND A.curriculumTypeId = (SELECT value::int FROM basConfig WHERE parameter = 'ACD_CURRICULUM_TYPE_CURRICULAR_INTEGRATE' )
    ORDER BY
        A.semester, B.name, B.shortName
    LOOP
        RETURN NEXT tuplaCurriculum;
    END LOOP;

    FOR tuplaCurriculum2 IN 
    SELECT 
        A.curriculumId,
        B.curricularComponentId, 
        B.curricularComponentVersion::int, 
        B.name::varchar, 
        B.shortname::varchar,
        B.academicNumberHours::float,
        B.lessonNumberHours::float,
        B.practiceHours::float,
        A.semester,
        A.masterCurriculumId
    FROM
        acdCurriculum A INNER JOIN
        acdCurricularComponent B USING ( curricularComponentId, curricularComponentVersion )
    WHERE
        A.courseId = courseId_
    AND A.courseVersion = courseVersion_
    AND A.turnId = turnId_
    AND A.unitId = unitId_
    AND A.curricularComponentTypeId IN ( SELECT value::integer FROM basConfig WHERE parameter IN ('CURRICULAR_COMPONENT_TYPE_ELECTIVE') ) 
    AND A.curriculumTypeId = ( SELECT value::int FROM basConfig WHERE parameter = 'ACD_CURRICULUM_TYPE_CURRICULAR_INTEGRATE' )
    ORDER BY
        A.semester, B.name, B.shortName
    LOOP
        FOR tuplaCurriculum IN 
        SELECT 
            B.curricularComponentId, 
            B.curricularComponentVersion::int, 
            B.name::varchar, 
            B.shortname::varchar,
            B.academicNumberHours::float,
            B.lessonNumberHours::float,
            B.practiceHours::float,
            A.semester,
            A.curriculumTypeId,
            A.curricularComponentTypeId,
            A.masterCurriculumId,
            A.curriculumId
        FROM
            acdCurriculum A INNER JOIN
            acdCurricularComponent B USING ( curricularComponentId, curricularComponentVersion )
        WHERE
            A.courseId = courseId_
        AND A.courseVersion = courseVersion_
        AND A.turnId = turnId_
        AND A.unitId = unitId_
        AND NOT A.curricularComponentTypeId IN ( SELECT value::integer FROM basConfig WHERE parameter IN ('CURRICULAR_COMPONENT_TYPE_ELECTIVE', 'CURRICULAR_COMPONENT_TYPE_TRAINING') ) 
        AND NOT A.curriculumTypeId = (SELECT value::int FROM basConfig WHERE parameter = 'ACD_CURRICULUM_TYPE_CURRICULAR_INTEGRATE' )
        AND A.masterCurriculumId = tuplaCurriculum2.curriculumId
        ORDER BY
            A.semester, B.name, B.shortName
        LOOP
            RETURN NEXT tuplaCurriculum;
        END LOOP;
    END LOOP;
END;
$BODY$
LANGUAGE 'plpgsql';

------------------------------------------------------------
-- Purpose: funcao para obter o conteudo digitado e nao dig
--          itado para uma determinada disciplina
-- 2010-05-22
-- gmurilo
-- --
------------------------------------------------------------

CREATE OR REPLACE FUNCTION getContentSumByDegreeNumber(groupId_ int, professorId_ int, degreeNumber_ int )
RETURNS RECORD AS 
$BODY$
DECLARE 
    tupla record;
BEGIN
SELECT INTO tupla 0 as contentTyped, 0 as contentNotTyped;
SELECT INTO tupla 
   sum(case when content > 0 then 1 else 0 end) as contentTyped,
   sum(case when content = 0 then 1 else 0 end) as contentNotTyped
FROM
(
    SELECT 
        SUM(CASE WHEN acdFrequenceContent.content IS NULL THEN 0 ELSE 1 END )as content,
        getDegreeFromGroupDate(od.groupId, od.OccurrenceDate),
        od.OccurrenceDate
    FROM 
        getoccurrencedatesprofessor(groupId_, professorId_) 
        od (occurrencedate date, 
            groupId integer,
            schedulelearningperiodId integer,
            learningPeriodId integer,
            numberhourslessons float,
            lessonNumberHours float,
            academicNumberHours float,
            practiceHours float,
            curriculumId integer,
            scheduleId integer,
            weekDayId integer,
            professorId integer,
            weight float) LEFT JOIN 
        acdFrequenceContent USING ( occurrencedate, scheduleId )
    GROUP BY
        occurrenceDate,
        groupId
    HAVING 
        getDegreeFromGroupDate ( groupId_, od.occurrenceDate ) = degreeNumber_
    ORDER BY
    3 
) A;
RETURN tupla ;
END;
$BODY$
LANGUAGE 'plpgsql';

------------------------------------------------------------
-- Purpose: inclusao do campo de politica para matricula e
--          rematricula no contrato
-- 2010-05-25
-- gmurilo
-- --
------------------------------------------------------------

ALTER TABLE acdContract ADD COLUMN policyIdForEnroll integer REFERENCES finPolicy ( policyId );
ALTER TABLE acdContract ADD COLUMN policyIdForReEnroll integer REFERENCES finPolicy ( policyId );
COMMENT ON COLUMN acdContract.policyIdForEnroll IS 'Define a pol�tica � ser usada para matr�cula no contrato';
COMMENT ON COLUMN acdContract.policyIdForReEnroll IS 'Define a pol�tica � ser usada para re-matr�cula no contrato';

------------------------------------------------------------
-- Purpose: inclusao do campo comentario e monografia no con
--          trato do aluno
-- 2010-06-01
-- gmurilo
-- --
------------------------------------------------------------

ALTER TABLE acdContract ADD COLUMN comments text;
COMMENT ON COLUMN acdContract.comments IS 'Comentario para exibir no historico escolar';
ALTER TABLE acdContract ADD COLUMN monograph text;
COMMENT ON COLUMN acdContract.monograph IS 'Texto exibido no historico para monografia';


------------------------------------------------------------
-- Purpose: Altera��es na tabela de atividades 
--          complementares
-- 2010-06-11
-- dah
-- --
------------------------------------------------------------
ALTER TABLE acdcomplementaryactivities RENAME curriculumidold TO curriculumId;
ALTER TABLE acdcomplementaryactivities ALTER curriculumid SET NOT NULL;
COMMENT ON COLUMN acdcomplementaryactivities.curriculumid IS 'Disciplina da matriz curricular que � do tipo atividade complementar';
ALTER TABLE acdcomplementaryactivities ADD complementaryActivity TEXT NOT NULL;
COMMENT ON COLUMN acdcomplementaryactivities.complementaryActivity IS 'Nome da atividade complementar';
ALTER TABLE acdcomplementaryactivities DROP COLUMN enrollid;
ALTER TABLE acdcomplementaryactivities RENAME description TO observation;
ALTER TABLE acdcomplementaryactivities ALTER observation DROP NOT NULL;
COMMENT ON COLUMN acdcomplementaryactivities.observation IS 'Descricao e observacoes sobre a atividade complementar';
ALTER TABLE acdcomplementaryactivities ADD contractId INT REFERENCES acdContract ( contractId );
ALTER TABLE acdcomplementaryactivities ALTER contractId SET NOT NULL;
COMMENT ON COLUMN acdcomplementaryactivities.contractId IS 'Contrato do aluno';
ALTER TABLE acdcomplementaryactivities ADD institutionId INT REFERENCES basLegalPerson ( personId );
ALTER TABLE acdcomplementaryactivities ALTER institutionId SET NOT NULL;
COMMENT ON COLUMN acdcomplementaryactivities.institutionId IS 'Nome da instituicao onde foi realizada a atividade complementar';
ALTER TABLE acdcomplementaryactivities ALTER totalcredits DROP NOT NULL;

------------------------------------------------------------
-- Purpose: Altera��es na tabela de srvenrollphysicalperson
--          
-- 2010-06-23
-- gmurilo
-- --
------------------------------------------------------------
ALTER TABLE srvenrollphysicalpersonstudent ADD COLUMN neighborhoodId integer REFERENCES basNeighborhood (neighborhoodId);

------------------------------------------------------------
-- Purpose: Corre��o nos valores e m�dulos de par�metros da
--          pauta eletr�nica
--          
-- 2010-06-29
-- dah
-- --
------------------------------------------------------------
UPDATE basConfig SET moduleconfig = 'BASIC' WHERE parameter = 'ATTENDANCE_DESCRIBEDAYS_TEXT';
UPDATE basConfig SET moduleconfig = 'BASIC' WHERE parameter = 'ATTENDANCE_SUBSTITUTIVE_TEXT';
UPDATE basConfig SET moduleconfig = 'BASIC', value = 'P' WHERE parameter = 'ATTENDANCE_PRESENCE_CHAR';
UPDATE basConfig SET moduleconfig = 'BASIC', value = 'F' WHERE parameter = 'ATTENDANCE_ABSENCE_CHAR';
INSERT INTO basConfig(moduleconfig, parameter, value, description, type) VALUES ('BASIC', 'ATTENDANCE_WITHOUTNOTE_CHAR', 'S/N', '', 'VARCHAR');
INSERT INTO basConfig(moduleconfig, parameter, value, description, type) VALUES ('BASIC', 'ATTENDANCE_NOABSENCE_CHAR', '-', '', 'VARCHAR');

------------------------------------------------------------
-- Purpose: Tabela de registro dos est�gios supervisionados
--          
-- 2010-08-02
-- dah
-- --
------------------------------------------------------------
CREATE TABLE acdSupervisedTraining
(
    supervisedTrainingId integer,
    enrollId             integer,
    description          text,
    institutionId        integer,
    beginDate            date,
    endDate              date,
    supervisorId         integer
) INHERITS (basLog);

COMMENT ON TABLE acdSupervisedTraining IS 'Tabela para registro de est�gios supervisionados';
COMMENT ON COLUMN acdSupervisedTraining.supervisedTrainingId IS 'Codigo do est�gio supervisionado';
COMMENT ON COLUMN acdSupervisedTraining.enrollId IS 'Matr�cula na disciplina de est�gio';
COMMENT ON COLUMN acdSupervisedTraining.description IS 'Descri��o ou nome do est�gio supervisionado';
COMMENT ON COLUMN acdSupervisedTraining.institutionId IS 'Empresa onde o est�gio foi realizado';
COMMENT ON COLUMN acdSupervisedTraining.beginDate IS 'Data de in�cio do est�gio';
COMMENT ON COLUMN acdSupervisedTraining.endDate IS 'Data de fim do est�gio';
COMMENT ON COLUMN acdSupervisedTraining.supervisorId IS 'Orientador do est�gio supervisionado';

CREATE SEQUENCE seq_supervisedtrainingid;
ALTER TABLE acdSupervisedTraining ALTER COLUMN supervisedTrainingId SET DEFAULT NEXTVAL('"seq_supervisedtrainingid"');
ALTER TABLE acdSupervisedTraining ALTER COLUMN supervisedTrainingId SET NOT NULL;
ALTER TABLE acdSupervisedTraining ADD PRIMARY KEY (supervisedTrainingId);

ALTER TABLE acdSupervisedTraining ALTER COLUMN enrollId SET NOT NULL;
ALTER TABLE acdSupervisedTraining ALTER COLUMN description SET NOT NULL;
ALTER TABLE acdSupervisedTraining ALTER COLUMN institutionId SET NOT NULL;

ALTER TABLE acdSupervisedTraining ADD FOREIGN KEY (enrollId) REFERENCES acdEnroll(enrollId);
ALTER TABLE acdSupervisedTraining ADD FOREIGN KEY (supervisorId) REFERENCES basPhysicalPersonProfessor(personId);
ALTER TABLE acdSupervisedTraining ADD FOREIGN KEY (institutionId) REFERENCES basLegalPerson(personId);

------------------------------------------------------------
-- Purpose: Mudan�a do supervisor que deve ser da pr�pria
--          institui��o onde ser� feito o est�gio
--          
-- 2010-08-05
-- dah
-- --
------------------------------------------------------------
ALTER TABLE acdSupervisedTraining DROP CONSTRAINT acdsupervisedtraining_supervisorid_fkey;
ALTER TABLE acdSupervisedTraining ADD FOREIGN KEY (supervisorId) REFERENCES basPhysicalPerson(personId);

------------------------------------------------------------
-- Purpose: Mudan�a na tabela de pessoas f�sicas para
--          adicionar o local de trabalho
--          
-- 2010-08-05
-- dah
-- --
------------------------------------------------------------
ALTER TABLE basPhysicalPerson ADD workId INT;
COMMENT ON COLUMN basPhysicalPerson.workId IS 'Local de trabalho da pessoa';
ALTER TABLE basPhysicalPerson ADD FOREIGN KEY (workId) REFERENCES basLegalPerson(personId);

------------------------------------------------------------
-- Purpose: Tipo "empresa" de pessoa jur�dica
--          
-- 2010-08-05
-- dah
-- --
------------------------------------------------------------
INSERT INTO basConfig (username, ipaddress, moduleconfig, parameter, value, description, type, isvaluechangeable) VALUES ('sagu2', '127.0.0.1', 'BASIC', 'LEGAL_PERSON_TYPE_COMPANY', '1', 'Tipo "empresa" de pessoa jur�dica.', 'INT', false);

------------------------------------------------------------
-- Purpose: Tipo "empresa" de pessoa jur�dica
--          
-- 2010-08-05
-- dah
-- --
------------------------------------------------------------
CREATE UNIQUE INDEX idx_unq_acdsupervisedtraining_enrollid ON acdsupervisedtraining USING btree (enrollid);

------------------------------------------------------------
-- Purpose: Tipo "plano de sa�de" de pessoa jur�dica
--          
-- 2010-09-17
-- gmurilo
-- --
------------------------------------------------------------
INSERT INTO basConfig (username, ipaddress, moduleconfig, parameter, value, description, type, isvaluechangeable) VALUES ('sagu2', '127.0.0.1', 'BASIC', 'LEGAL_PERSON_TYPE_HEALTH_CARE', '4', 'Tipo "plano de sa�de" de pessoa jur�dica.', 'INT', false);

ALTER TABLE basPhysicalPerson ADD COLUMN healthCareId INTEGER REFERENCES basLegalPerson (personId);

------------------------------------------------------------
-- Purpose: Parametro para o per�odo corrente do gnuteca
--          
-- 2010-10-12
-- dah
-- --
------------------------------------------------------------
INSERT INTO basConfig (username, ipaddress, moduleconfig, parameter, value, description, type, isvaluechangeable) VALUES ('sagu2', '127.0.0.1', 'GNUTECA', 'CURRENT_PERIOD_ID', '2010.2', 'Per�odo corrente do gnuteca', 'VARCHAR', true);

------------------------------------------------------------
-- Purpose: Parametro para definir qual o leiaute que ser�
--          utilizado no caderno de chamda
--          1: leiaute com X, *, -
--          2: leaiute com F, P, -
--          
-- 2010-11-03
-- dah
-- --
------------------------------------------------------------
INSERT INTO basConfig (username, ipaddress, moduleconfig, parameter, value, description, type, isvaluechangeable) VALUES ('sagu2', '127.0.0.1', 'ACADEMIC', 'DEFAULT_ATTENDANCE_LIST_LAYOUT', '2', 'Parametro para definir qual o leiaute que ser� utilizado no caderno de chamda.   1: leiaute com X, *, -   2: leaiute com F, P, -', 'INT', true);

