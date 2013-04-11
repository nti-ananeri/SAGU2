----------------------------------------------------------------------
-- --
--
-- Table: baslog
-- Purpose: registros de usu�rios e data de alterac�o
--
-- --
----------------------------------------------------------------------

CREATE TABLE "baslog" 
(
    "username"     varchar(20), --Nome do usuario
    "datetime"     timestamp with time zone, --Momento da acao
    "ipaddress"    inet --IP do usuario
);

COMMENT ON TABLE "baslog" IS 'registros de usu�rios e data de alterac�o';
COMMENT ON COLUMN "baslog"."username" IS 'Nome do usuario';
COMMENT ON COLUMN "baslog"."datetime" IS 'Momento da acao';
COMMENT ON COLUMN "baslog"."ipaddress" IS 'IP do usuario';

ALTER TABLE "baslog" ALTER COLUMN "username" SET DEFAULT current_user;
ALTER TABLE "baslog" ALTER COLUMN "datetime" SET DEFAULT current_timestamp;

----------------------------------------------------------------------
-- --
--
-- Table: acdcurricularcomponentgroup
-- Purpose: grupo da disciplina
--
-- --
----------------------------------------------------------------------

CREATE TABLE "acdcurricularcomponentgroup" 
(
    "curricularcomponentgroupid"    integer, --Codigo do grupo
    "name"                          text, --Nome
    "shortname"                     varchar(100) --Nome suscinto
) INHERITS ("baslog");

COMMENT ON TABLE "acdcurricularcomponentgroup" IS 'grupo da disciplina';
COMMENT ON COLUMN "acdcurricularcomponentgroup"."curricularcomponentgroupid" IS 'Codigo do grupo';
COMMENT ON COLUMN "acdcurricularcomponentgroup"."name" IS 'Nome';
COMMENT ON COLUMN "acdcurricularcomponentgroup"."shortname" IS 'Nome suscinto';

CREATE SEQUENCE "seq_curricularcomponentgroupid";
ALTER TABLE "acdcurricularcomponentgroup" ALTER COLUMN "curricularcomponentgroupid" SET DEFAULT NEXTVAL('"seq_curricularcomponentgroupid"');
ALTER TABLE "acdcurricularcomponentgroup" ALTER COLUMN "name" SET NOT NULL;
ALTER TABLE "acdcurricularcomponentgroup" ALTER COLUMN "shortname" SET NOT NULL;

ALTER TABLE "acdcurricularcomponentgroup" ALTER COLUMN "curricularcomponentgroupid" SET NOT NULL;
ALTER TABLE "acdcurricularcomponentgroup" ADD PRIMARY KEY ("curricularcomponentgroupid");

----------------------------------------------------------------------
-- --
--
-- Table: basspecialnecessity
-- Purpose: necessidades especiais
--
-- --
----------------------------------------------------------------------

CREATE TABLE "basspecialnecessity" 
(
    "specialnecessityid"    integer, --Codigo da necessidade especial
    "description"           text, --Descricao
    "easyaccess"            boolean, --Precisa de facilidades de acesso
    "accompanimentneeds"    boolean, --Precisa de acompanhamento especial
    "ispermanent"           boolean, --E uma necessidade especial permanente
    "howmuchweeks"          integer, --Numero de semanas da necessidade especial (no caso de nao ser permanente)
    "begindate"             date --Data inicial
) INHERITS ("baslog");

COMMENT ON TABLE "basspecialnecessity" IS 'necessidades especiais';
COMMENT ON COLUMN "basspecialnecessity"."specialnecessityid" IS 'Codigo da necessidade especial';
COMMENT ON COLUMN "basspecialnecessity"."description" IS 'Descricao';
COMMENT ON COLUMN "basspecialnecessity"."easyaccess" IS 'Precisa de facilidades de acesso';
COMMENT ON COLUMN "basspecialnecessity"."accompanimentneeds" IS 'Precisa de acompanhamento especial';
COMMENT ON COLUMN "basspecialnecessity"."ispermanent" IS 'E uma necessidade especial permanente';
COMMENT ON COLUMN "basspecialnecessity"."howmuchweeks" IS 'Numero de semanas da necessidade especial (no caso de nao ser permanente)';
COMMENT ON COLUMN "basspecialnecessity"."begindate" IS 'Data inicial';

CREATE SEQUENCE "seq_specialnecessityid";
ALTER TABLE "basspecialnecessity" ALTER COLUMN "specialnecessityid" SET DEFAULT NEXTVAL('"seq_specialnecessityid"');
ALTER TABLE "basspecialnecessity" ALTER COLUMN "description" SET NOT NULL;
ALTER TABLE "basspecialnecessity" ALTER COLUMN "easyaccess" SET NOT NULL;
ALTER TABLE "basspecialnecessity" ALTER COLUMN "easyaccess" SET DEFAULT FALSE ;
ALTER TABLE "basspecialnecessity" ALTER COLUMN "accompanimentneeds" SET NOT NULL;
ALTER TABLE "basspecialnecessity" ALTER COLUMN "accompanimentneeds" SET DEFAULT FALSE ;
ALTER TABLE "basspecialnecessity" ALTER COLUMN "ispermanent" SET NOT NULL;
ALTER TABLE "basspecialnecessity" ALTER COLUMN "ispermanent" SET DEFAULT FALSE ;

ALTER TABLE "basspecialnecessity" ALTER COLUMN "specialnecessityid" SET NOT NULL;
ALTER TABLE "basspecialnecessity" ADD PRIMARY KEY ("specialnecessityid");

----------------------------------------------------------------------
-- --
--
-- Table: basneighborhood
-- Purpose: bairros
--
-- --
----------------------------------------------------------------------

CREATE TABLE "basneighborhood" 
(
    "neighborhoodid"    integer, --Codigo do bairro
    "name"              text --Nome
) INHERITS ("baslog");

COMMENT ON TABLE "basneighborhood" IS 'bairros';
COMMENT ON COLUMN "basneighborhood"."neighborhoodid" IS 'Codigo do bairro';
COMMENT ON COLUMN "basneighborhood"."name" IS 'Nome';

CREATE SEQUENCE "seq_neighborhoodid";
ALTER TABLE "basneighborhood" ALTER COLUMN "neighborhoodid" SET DEFAULT NEXTVAL('"seq_neighborhoodid"');
ALTER TABLE "basneighborhood" ALTER COLUMN "name" SET NOT NULL;

ALTER TABLE "basneighborhood" ALTER COLUMN "neighborhoodid" SET NOT NULL;
ALTER TABLE "basneighborhood" ADD PRIMARY KEY ("neighborhoodid");

----------------------------------------------------------------------
-- --
--
-- Table: insmaterial
-- Purpose: cadastro de materiais
--
-- --
----------------------------------------------------------------------

CREATE TABLE "insmaterial" 
(
    "materialid"     integer, --Codigo do material
    "description"    text, --Descricao
    "ispermanent"    boolean, --Se e permanente
    "features"       text --Caracteristicas
) INHERITS ("baslog");

COMMENT ON TABLE "insmaterial" IS 'cadastro de materiais';
COMMENT ON COLUMN "insmaterial"."materialid" IS 'Codigo do material';
COMMENT ON COLUMN "insmaterial"."description" IS 'Descricao';
COMMENT ON COLUMN "insmaterial"."ispermanent" IS 'Se e permanente';
COMMENT ON COLUMN "insmaterial"."features" IS 'Caracteristicas';

CREATE SEQUENCE "seq_materialid";
ALTER TABLE "insmaterial" ALTER COLUMN "materialid" SET DEFAULT NEXTVAL('"seq_materialid"');
ALTER TABLE "insmaterial" ALTER COLUMN "description" SET NOT NULL;
ALTER TABLE "insmaterial" ALTER COLUMN "ispermanent" SET NOT NULL;
ALTER TABLE "insmaterial" ALTER COLUMN "ispermanent" SET DEFAULT FALSE ;

ALTER TABLE "insmaterial" ALTER COLUMN "materialid" SET NOT NULL;
ALTER TABLE "insmaterial" ADD PRIMARY KEY ("materialid");

----------------------------------------------------------------------
-- --
--
-- Table: insgrouptype
-- Purpose: tabela dos grupos
--
-- --
----------------------------------------------------------------------

CREATE TABLE "insgrouptype" 
(
    "grouptypeid"    integer, --Codigo do grupo
    "description"    text --Descricao
) INHERITS ("baslog");

COMMENT ON TABLE "insgrouptype" IS 'tabela dos grupos';
COMMENT ON COLUMN "insgrouptype"."grouptypeid" IS 'Codigo do grupo';
COMMENT ON COLUMN "insgrouptype"."description" IS 'Descricao';

CREATE SEQUENCE "seq_grouptypeid";
ALTER TABLE "insgrouptype" ALTER COLUMN "grouptypeid" SET DEFAULT NEXTVAL('"seq_grouptypeid"');
ALTER TABLE "insgrouptype" ALTER COLUMN "description" SET NOT NULL;

ALTER TABLE "insgrouptype" ALTER COLUMN "grouptypeid" SET NOT NULL;
ALTER TABLE "insgrouptype" ADD PRIMARY KEY ("grouptypeid");

----------------------------------------------------------------------
-- --
--
-- Table: sprexam
-- Purpose: cadastro geral de provas
--
-- --
----------------------------------------------------------------------

CREATE TABLE "sprexam" 
(
    "examid"              integer, --Codigo da prova
    "description"         text, --Descricao
    "shortdescription"    varchar(5) --Descricao suscinta
) INHERITS ("baslog");

COMMENT ON TABLE "sprexam" IS 'cadastro geral de provas';
COMMENT ON COLUMN "sprexam"."examid" IS 'Codigo da prova';
COMMENT ON COLUMN "sprexam"."description" IS 'Descricao';
COMMENT ON COLUMN "sprexam"."shortdescription" IS 'Descricao suscinta';

CREATE SEQUENCE "seq_examid";
ALTER TABLE "sprexam" ALTER COLUMN "examid" SET DEFAULT NEXTVAL('"seq_examid"');
ALTER TABLE "sprexam" ALTER COLUMN "description" SET NOT NULL;
ALTER TABLE "sprexam" ALTER COLUMN "shortdescription" SET NOT NULL;

ALTER TABLE "sprexam" ALTER COLUMN "examid" SET NOT NULL;
ALTER TABLE "sprexam" ADD PRIMARY KEY ("examid");

----------------------------------------------------------------------
-- --
--
-- Table: sprlanguage
-- Purpose: linguas estrangeiras
--
-- --
----------------------------------------------------------------------

CREATE TABLE "sprlanguage" 
(
    "languageid"          integer, --Codigo da lingua estrangeira
    "description"         text, --Descricao
    "shortdescription"    varchar(5) --Descricao suscinta
) INHERITS ("baslog");

COMMENT ON TABLE "sprlanguage" IS 'linguas estrangeiras';
COMMENT ON COLUMN "sprlanguage"."languageid" IS 'Codigo da lingua estrangeira';
COMMENT ON COLUMN "sprlanguage"."description" IS 'Descricao';
COMMENT ON COLUMN "sprlanguage"."shortdescription" IS 'Descricao suscinta';

CREATE SEQUENCE "seq_languageid";
ALTER TABLE "sprlanguage" ALTER COLUMN "languageid" SET DEFAULT NEXTVAL('"seq_languageid"');
ALTER TABLE "sprlanguage" ALTER COLUMN "description" SET NOT NULL;
ALTER TABLE "sprlanguage" ALTER COLUMN "shortdescription" SET NOT NULL;

ALTER TABLE "sprlanguage" ALTER COLUMN "languageid" SET NOT NULL;
ALTER TABLE "sprlanguage" ADD PRIMARY KEY ("languageid");

----------------------------------------------------------------------
-- --
--
-- Table: rshform
-- Purpose: questionarios
--
-- --
----------------------------------------------------------------------

CREATE TABLE "rshform" 
(
    "formid"              integer, --Codigo do questionario
    "description"         text, --Descricao
    "shortdescription"    varchar(25), --Descricao suscinta
    "isrestricted"        boolean, --Se e restrito (exige login e senha)
    "isidentified"        boolean --Se e identificado (grava as informacoes do usuario nos questionarios)
) INHERITS ("baslog");

COMMENT ON TABLE "rshform" IS 'questionarios';
COMMENT ON COLUMN "rshform"."formid" IS 'Codigo do questionario';
COMMENT ON COLUMN "rshform"."description" IS 'Descricao';
COMMENT ON COLUMN "rshform"."shortdescription" IS 'Descricao suscinta';
COMMENT ON COLUMN "rshform"."isrestricted" IS 'Se e restrito (exige login e senha)';
COMMENT ON COLUMN "rshform"."isidentified" IS 'Se e identificado (grava as informacoes do usuario nos questionarios)';

CREATE SEQUENCE "seq_formid";
ALTER TABLE "rshform" ALTER COLUMN "formid" SET DEFAULT NEXTVAL('"seq_formid"');
ALTER TABLE "rshform" ALTER COLUMN "description" SET NOT NULL;
ALTER TABLE "rshform" ALTER COLUMN "shortdescription" SET NOT NULL;
ALTER TABLE "rshform" ALTER COLUMN "isrestricted" SET NOT NULL;
ALTER TABLE "rshform" ALTER COLUMN "isrestricted" SET DEFAULT FALSE ;
ALTER TABLE "rshform" ALTER COLUMN "isidentified" SET NOT NULL;
ALTER TABLE "rshform" ALTER COLUMN "isidentified" SET DEFAULT TRUE ;

ALTER TABLE "rshform" ALTER COLUMN "formid" SET NOT NULL;
ALTER TABLE "rshform" ADD PRIMARY KEY ("formid");

----------------------------------------------------------------------
-- --
--
-- Table: ptcsituation
-- Purpose: situacao dos protocolos
--
-- --
----------------------------------------------------------------------

CREATE TABLE "ptcsituation" 
(
    "situationid"    integer, --Codigo da situacao
    "description"    varchar(30), --Descricao
    "type"           char(1)[], --Tipo
    "policy"         char(1) --Politica
) INHERITS ("baslog");

COMMENT ON TABLE "ptcsituation" IS 'situacao dos protocolos';
COMMENT ON COLUMN "ptcsituation"."situationid" IS 'Codigo da situacao';
COMMENT ON COLUMN "ptcsituation"."description" IS 'Descricao';
COMMENT ON COLUMN "ptcsituation"."type" IS 'Tipo';
COMMENT ON COLUMN "ptcsituation"."policy" IS 'Politica';

CREATE SEQUENCE "seq_situationid";
ALTER TABLE "ptcsituation" ALTER COLUMN "situationid" SET DEFAULT NEXTVAL('"seq_situationid"');
ALTER TABLE "ptcsituation" ALTER COLUMN "description" SET NOT NULL;
ALTER TABLE "ptcsituation" ALTER COLUMN "type" SET NOT NULL;

ALTER TABLE "ptcsituation" ALTER COLUMN "situationid" SET NOT NULL;
ALTER TABLE "ptcsituation" ADD PRIMARY KEY ("situationid");

----------------------------------------------------------------------
-- --
--
-- Table: ptcrequeriment
-- Purpose: lista de requerimentos
--
-- --
----------------------------------------------------------------------

CREATE TABLE "ptcrequeriment" 
(
    "requerimentid"    integer, --Codigo do requerimento
    "description"      text, --Descricao
    "tax"              numeric(14,2), --Taxa
    "alert"            text --Recebe textos de alerta nos formularios para os requerimentos
) INHERITS ("baslog");

COMMENT ON TABLE "ptcrequeriment" IS 'lista de requerimentos';
COMMENT ON COLUMN "ptcrequeriment"."requerimentid" IS 'Codigo do requerimento';
COMMENT ON COLUMN "ptcrequeriment"."description" IS 'Descricao';
COMMENT ON COLUMN "ptcrequeriment"."tax" IS 'Taxa';
COMMENT ON COLUMN "ptcrequeriment"."alert" IS 'Recebe textos de alerta nos formularios para os requerimentos';

CREATE SEQUENCE "seq_requerimentid";
ALTER TABLE "ptcrequeriment" ALTER COLUMN "requerimentid" SET DEFAULT NEXTVAL('"seq_requerimentid"');
ALTER TABLE "ptcrequeriment" ALTER COLUMN "description" SET NOT NULL;

ALTER TABLE "ptcrequeriment" ALTER COLUMN "requerimentid" SET NOT NULL;
ALTER TABLE "ptcrequeriment" ADD PRIMARY KEY ("requerimentid");

----------------------------------------------------------------------
-- --
--
-- Table: bassector
-- Purpose: setores
--
-- --
----------------------------------------------------------------------

CREATE TABLE "bassector" 
(
    "sectorid"                integer, --Codigo do setor
    "description"             text, --Descricao
    "email"                   varchar(60), --Email do setor
    "iscoordinatorssector"    boolean --Se e um setor de coordenacao
) INHERITS ("baslog");

COMMENT ON TABLE "bassector" IS 'setores';
COMMENT ON COLUMN "bassector"."sectorid" IS 'Codigo do setor';
COMMENT ON COLUMN "bassector"."description" IS 'Descricao';
COMMENT ON COLUMN "bassector"."email" IS 'Email do setor';
COMMENT ON COLUMN "bassector"."iscoordinatorssector" IS 'Se e um setor de coordenacao';

CREATE SEQUENCE "seq_sectorid";
ALTER TABLE "bassector" ALTER COLUMN "sectorid" SET DEFAULT NEXTVAL('"seq_sectorid"');
ALTER TABLE "bassector" ALTER COLUMN "description" SET NOT NULL;
ALTER TABLE "bassector" ALTER COLUMN "email" SET NOT NULL;
ALTER TABLE "bassector" ALTER COLUMN "iscoordinatorssector" SET NOT NULL;
ALTER TABLE "bassector" ALTER COLUMN "iscoordinatorssector" SET DEFAULT FALSE ;

ALTER TABLE "bassector" ALTER COLUMN "sectorid" SET NOT NULL;
ALTER TABLE "bassector" ADD PRIMARY KEY ("sectorid");

----------------------------------------------------------------------
-- --
--
-- Table: ptcrequerimentsector
-- Purpose: setores que recebem requerimentos
--
-- --
----------------------------------------------------------------------

CREATE TABLE "ptcrequerimentsector" 
(
    "requerimentid"    integer, --Codigo do requerimento
    "sequence"         integer, --Sequencia
    "sectorid"         integer --Codigo do setor
) INHERITS ("baslog");

COMMENT ON TABLE "ptcrequerimentsector" IS 'setores que recebem requerimentos';
COMMENT ON COLUMN "ptcrequerimentsector"."requerimentid" IS 'Codigo do requerimento';
COMMENT ON COLUMN "ptcrequerimentsector"."sequence" IS 'Sequencia';
COMMENT ON COLUMN "ptcrequerimentsector"."sectorid" IS 'Codigo do setor';

ALTER TABLE "ptcrequerimentsector" ALTER COLUMN "requerimentid" SET NOT NULL;
ALTER TABLE "ptcrequerimentsector" ALTER COLUMN "sequence" SET NOT NULL;
ALTER TABLE "ptcrequerimentsector" ALTER COLUMN "sectorid" SET NOT NULL;

ALTER TABLE "ptcrequerimentsector" ALTER COLUMN "requerimentid" SET NOT NULL;
ALTER TABLE "ptcrequerimentsector" ALTER COLUMN "sequence" SET NOT NULL;
ALTER TABLE "ptcrequerimentsector" ADD PRIMARY KEY ("requerimentid","sequence");

ALTER TABLE "ptcrequerimentsector" ADD FOREIGN KEY ("requerimentid") REFERENCES "ptcrequeriment"("requerimentid");

ALTER TABLE "ptcrequerimentsector" ADD FOREIGN KEY ("sectorid") REFERENCES "bassector"("sectorid");

----------------------------------------------------------------------
-- --
--
-- Table: ptcrequerimentfield
-- Purpose: campos dos requerimentos
--
-- --
----------------------------------------------------------------------

CREATE TABLE "ptcrequerimentfield" 
(
    "requerimentfieldid"    integer, --Codigo do campo
    "description"           text, --Descricao
    "rows"                  integer, --Numero de linhas
    "columns"               integer, --Numero de colunas
    "islookup"              boolean, --Se e um campo de lookup
    "autocompleteselect"    text, --SELECT para o autocomplete
    "lookupselect"          text, --SELECT para o lookup
    "fieldvalidator"        varchar(50), --Validador para o campo
    "isrequired"            boolean --Se o campo e obrigatorio
) INHERITS ("baslog");

COMMENT ON TABLE "ptcrequerimentfield" IS 'campos dos requerimentos';
COMMENT ON COLUMN "ptcrequerimentfield"."requerimentfieldid" IS 'Codigo do campo';
COMMENT ON COLUMN "ptcrequerimentfield"."description" IS 'Descricao';
COMMENT ON COLUMN "ptcrequerimentfield"."rows" IS 'Numero de linhas';
COMMENT ON COLUMN "ptcrequerimentfield"."columns" IS 'Numero de colunas';
COMMENT ON COLUMN "ptcrequerimentfield"."islookup" IS 'Se e um campo de lookup';
COMMENT ON COLUMN "ptcrequerimentfield"."autocompleteselect" IS 'SELECT para o autocomplete';
COMMENT ON COLUMN "ptcrequerimentfield"."lookupselect" IS 'SELECT para o lookup';
COMMENT ON COLUMN "ptcrequerimentfield"."fieldvalidator" IS 'Validador para o campo';
COMMENT ON COLUMN "ptcrequerimentfield"."isrequired" IS 'Se o campo e obrigatorio';

CREATE SEQUENCE "seq_requerimentfieldid";
ALTER TABLE "ptcrequerimentfield" ALTER COLUMN "requerimentfieldid" SET DEFAULT NEXTVAL('"seq_requerimentfieldid"');
ALTER TABLE "ptcrequerimentfield" ALTER COLUMN "description" SET NOT NULL;
ALTER TABLE "ptcrequerimentfield" ALTER COLUMN "columns" SET DEFAULT 20;
ALTER TABLE "ptcrequerimentfield" ALTER COLUMN "islookup" SET NOT NULL;
ALTER TABLE "ptcrequerimentfield" ALTER COLUMN "islookup" SET DEFAULT FALSE ;
ALTER TABLE "ptcrequerimentfield" ALTER COLUMN "isrequired" SET NOT NULL;
ALTER TABLE "ptcrequerimentfield" ALTER COLUMN "isrequired" SET DEFAULT FALSE ;

ALTER TABLE "ptcrequerimentfield" ALTER COLUMN "requerimentfieldid" SET NOT NULL;
ALTER TABLE "ptcrequerimentfield" ADD PRIMARY KEY ("requerimentfieldid");

----------------------------------------------------------------------
-- --
--
-- Table: baslegalpersontype
-- Purpose: tipos de pessoa juridica
--
-- --
----------------------------------------------------------------------

CREATE TABLE "baslegalpersontype" 
(
    "legalpersontypeid"    integer, --Codigo do tipo de pessoa juridica
    "description"          text --Descricao
) INHERITS ("baslog");

COMMENT ON TABLE "baslegalpersontype" IS 'tipos de pessoa juridica';
COMMENT ON COLUMN "baslegalpersontype"."legalpersontypeid" IS 'Codigo do tipo de pessoa juridica';
COMMENT ON COLUMN "baslegalpersontype"."description" IS 'Descricao';

CREATE SEQUENCE "seq_legalpersontypeid";
ALTER TABLE "baslegalpersontype" ALTER COLUMN "legalpersontypeid" SET DEFAULT NEXTVAL('"seq_legalpersontypeid"');
ALTER TABLE "baslegalpersontype" ALTER COLUMN "description" SET NOT NULL;

ALTER TABLE "baslegalpersontype" ALTER COLUMN "legalpersontypeid" SET NOT NULL;
ALTER TABLE "baslegalpersontype" ADD PRIMARY KEY ("legalpersontypeid");

----------------------------------------------------------------------
-- --
--
-- Table: acdknowledgearea
-- Purpose: areas de conhecimento
--
-- --
----------------------------------------------------------------------

CREATE TABLE "acdknowledgearea" 
(
    "knowledgeareaid"    integer, --Codigo da area de intercambio
    "name"               text, --Nome
    "brief"              text --Sumario
) INHERITS ("baslog");

COMMENT ON TABLE "acdknowledgearea" IS 'areas de conhecimento';
COMMENT ON COLUMN "acdknowledgearea"."knowledgeareaid" IS 'Codigo da area de intercambio';
COMMENT ON COLUMN "acdknowledgearea"."name" IS 'Nome';
COMMENT ON COLUMN "acdknowledgearea"."brief" IS 'Sumario';

CREATE SEQUENCE "seq_knowledgeareaid";
ALTER TABLE "acdknowledgearea" ALTER COLUMN "knowledgeareaid" SET DEFAULT NEXTVAL('"seq_knowledgeareaid"');
ALTER TABLE "acdknowledgearea" ALTER COLUMN "name" SET NOT NULL;
ALTER TABLE "acdknowledgearea" ALTER COLUMN "brief" SET NOT NULL;

ALTER TABLE "acdknowledgearea" ALTER COLUMN "knowledgeareaid" SET NOT NULL;
ALTER TABLE "acdknowledgearea" ADD PRIMARY KEY ("knowledgeareaid");

----------------------------------------------------------------------
-- --
--
-- Table: basconfig
-- Purpose: configuracoes do sistema
--
-- --
----------------------------------------------------------------------

CREATE TABLE "basconfig" 
(
    "moduleconfig"      text, --Modulo do parametro
    "parameter"         text, --Parametro
    "value"             text, --Valor
    "description"       text, --Descricao do parametro
    "type"              varchar(50), --Tipo do parametro
    "isvaluechangeable" boolean --Define se um par�metro pode ser alterado via formul�rio
) INHERITS ("baslog");

COMMENT ON TABLE "basconfig" IS 'configuracoes do sistema';
COMMENT ON COLUMN "basconfig"."moduleconfig" IS 'Modulo do parametro';
COMMENT ON COLUMN "basconfig"."parameter" IS 'Parametro';
COMMENT ON COLUMN "basconfig"."value" IS 'Valor';
COMMENT ON COLUMN "basconfig"."description" IS 'Descricao do parametro';
COMMENT ON COLUMN "basconfig"."type" IS 'Tipo do parametro';
COMMENT ON COLUMN "basconfig"."isvaluechangeable" IS 'Define se um par�metro pode ser alterado via formul�rio';

ALTER TABLE "basconfig" ALTER COLUMN "moduleconfig" SET NOT NULL;
ALTER TABLE "basconfig" ALTER COLUMN "parameter" SET NOT NULL;
ALTER TABLE "basconfig" ALTER COLUMN "description" SET NOT NULL;
ALTER TABLE "basconfig" ALTER COLUMN "type" SET NOT NULL;
ALTER TABLE "basconfig" ALTER COLUMN "value" SET NOT NULL;
ALTER TABLE "basconfig" ALTER COLUMN "isvaluechangeable" SET NOT NULL;
ALTER TABLE "basconfig" ALTER COLUMN "isvaluechangeable" SET DEFAULT TRUE;

ALTER TABLE "basconfig" ALTER COLUMN "moduleconfig" SET NOT NULL;
ALTER TABLE "basconfig" ALTER COLUMN "parameter" SET NOT NULL;
ALTER TABLE "basconfig" ADD PRIMARY KEY ("moduleconfig","parameter");

----------------------------------------------------------------------
-- --
--
-- Table: bascvslog
-- Purpose: tabela de log de alteracoes na base atraves dos processos 
--          on-line 
--
-- --
----------------------------------------------------------------------

CREATE TABLE "bascvslog" 
(
    "cvslogid"          integer, --Codigo do log
    "tablename"         text, --Nome da tabela alterada
    "fieldname"         text, --Nome do campo alterado
    "oldvalue"          text, --Valor antigo
    "tablepkey"         text, --Chave primaria da tabela
    "tablepkeyvalue"    text --Valor da chave primaria da tabela
) INHERITS ("baslog");

COMMENT ON TABLE "bascvslog" IS 'tabela de log de alteracoes na base atraves dos processos on-line';
COMMENT ON COLUMN "bascvslog"."cvslogid" IS 'Codigo do log';
COMMENT ON COLUMN "bascvslog"."tablename" IS 'Nome da tabela alterada';
COMMENT ON COLUMN "bascvslog"."fieldname" IS 'Nome do campo alterado';
COMMENT ON COLUMN "bascvslog"."oldvalue" IS 'Valor antigo';
COMMENT ON COLUMN "bascvslog"."tablepkey" IS 'Chave primaria da tabela';
COMMENT ON COLUMN "bascvslog"."tablepkeyvalue" IS 'Valor da chave primaria da tabela';

CREATE SEQUENCE "seq_cvslogid";
ALTER TABLE "bascvslog" ALTER COLUMN "cvslogid" SET DEFAULT NEXTVAL('"seq_cvslogid"');
ALTER TABLE "bascvslog" ALTER COLUMN "tablename" SET NOT NULL;
ALTER TABLE "bascvslog" ALTER COLUMN "fieldname" SET NOT NULL;
ALTER TABLE "bascvslog" ALTER COLUMN "tablepkey" SET NOT NULL;
ALTER TABLE "bascvslog" ALTER COLUMN "tablepkeyvalue" SET NOT NULL;

ALTER TABLE "bascvslog" ALTER COLUMN "cvslogid" SET NOT NULL;
ALTER TABLE "bascvslog" ADD PRIMARY KEY ("cvslogid");

----------------------------------------------------------------------
-- --
--
-- Table: acdcurriculumtype
-- Purpose: tipos de curr�culo - m�nimo, complementar, optativa, 
--          ativid. complementar, proficiencia, ... 
--
-- --
----------------------------------------------------------------------

CREATE TABLE "acdcurriculumtype" 
(
    "curriculumtypeid"    integer, --Codigo do tipo de curriculo - antigo Grupos de Disciplinas
    "description"         text, --Descricao
    "shortdescription"    varchar(10) --Descricao suscinta
) INHERITS ("baslog");

COMMENT ON TABLE "acdcurriculumtype" IS 'tipos de curr�culo - m�nimo, complementar, optativa, ativid. complementar, proficiencia, ...';
COMMENT ON COLUMN "acdcurriculumtype"."curriculumtypeid" IS 'Codigo do tipo de curriculo - antigo Grupos de Disciplinas';
COMMENT ON COLUMN "acdcurriculumtype"."description" IS 'Descricao';
COMMENT ON COLUMN "acdcurriculumtype"."shortdescription" IS 'Descricao suscinta';

CREATE SEQUENCE "seq_curriculumtypeid";
ALTER TABLE "acdcurriculumtype" ALTER COLUMN "curriculumtypeid" SET DEFAULT NEXTVAL('"seq_curriculumtypeid"');
ALTER TABLE "acdcurriculumtype" ALTER COLUMN "description" SET NOT NULL;
ALTER TABLE "acdcurriculumtype" ALTER COLUMN "shortdescription" SET NOT NULL;

ALTER TABLE "acdcurriculumtype" ALTER COLUMN "curriculumtypeid" SET NOT NULL;
ALTER TABLE "acdcurriculumtype" ADD PRIMARY KEY ("curriculumtypeid");

----------------------------------------------------------------------
-- --
--
-- Table: basdocumenttype
-- Purpose: cadastro dos tipos de documento
--
-- --
----------------------------------------------------------------------

CREATE TABLE "basdocumenttype" 
(
    "documenttypeid"    integer, --Codigo do tipo de documento
    "name"              text, --Nome do documento
    "mask"              text, --Mascara de entrada
    "sex"               char(1), --Sexo da pessoa (M, F ou All)
    "persontype"        char(1), --Tipo da pessoa (fisica (P), juridica (L) ou todas (All))
    "minage"            integer, --Idade minima para preenchimento deste campo
    "maxage"            integer, --Idade maxima para preenchimento deste campo
    "needdeliver"       boolean, --Se vai ser necessario entregar uma copia do mesmo ou nao
    "isblockenroll"     boolean --Documentos que bloqueiam o processo de matrícula
) INHERITS ("baslog");

COMMENT ON TABLE "basdocumenttype" IS 'cadastro dos tipos de documento';
COMMENT ON COLUMN "basdocumenttype"."documenttypeid" IS 'Codigo do tipo de documento';
COMMENT ON COLUMN "basdocumenttype"."name" IS 'Nome do documento';
COMMENT ON COLUMN "basdocumenttype"."mask" IS 'Mascara de entrada';
COMMENT ON COLUMN "basdocumenttype"."sex" IS 'Sexo da pessoa (M, F ou All)';
COMMENT ON COLUMN "basdocumenttype"."persontype" IS 'Tipo da pessoa (fisica (P), juridica (L) ou todas (All))';
COMMENT ON COLUMN "basdocumenttype"."minage" IS 'Idade minima para preenchimento deste campo';
COMMENT ON COLUMN "basdocumenttype"."maxage" IS 'Idade maxima para preenchimento deste campo';
COMMENT ON COLUMN "basdocumenttype"."needdeliver" IS 'Se vai ser necessario entregar uma copia do mesmo ou nao';
COMMENT ON COLUMN "basdocumenttype"."isblockenroll" IS 'Documentos que bloqueiam o processo de matrícula';

CREATE SEQUENCE "seq_documenttypeid";
ALTER TABLE "basdocumenttype" ALTER COLUMN "documenttypeid" SET DEFAULT NEXTVAL('"seq_documenttypeid"');
ALTER TABLE "basdocumenttype" ALTER COLUMN "name" SET NOT NULL;
ALTER TABLE "basdocumenttype" ALTER COLUMN "persontype" SET NOT NULL;
ALTER TABLE "basdocumenttype" ALTER COLUMN "needdeliver" SET NOT NULL;
ALTER TABLE "basdocumenttype" ALTER COLUMN "needdeliver" SET DEFAULT TRUE ;
ALTER TABLE "basdocumenttype" ALTER COLUMN "isblockenroll" SET NOT NULL;
ALTER TABLE "basdocumenttype" ALTER COLUMN "isblockenroll" SET DEFAULT FALSE ;

ALTER TABLE "basdocumenttype" ALTER COLUMN "documenttypeid" SET NOT NULL;
ALTER TABLE "basdocumenttype" ADD PRIMARY KEY ("documenttypeid");

----------------------------------------------------------------------
-- --
--
-- Table: acdregimen
-- Purpose: regimes, ordens que regem as disciplinas - intensivo, 
--          especial, normal, ferias 
--
-- --
----------------------------------------------------------------------

CREATE TABLE "acdregimen" 
(
    "regimenid"      integer, --Codigo do regime
    "description"    text --Descricao
) INHERITS ("baslog");

COMMENT ON TABLE "acdregimen" IS 'regimes, ordens que regem as disciplinas - intensivo, especial, normal, ferias';
COMMENT ON COLUMN "acdregimen"."regimenid" IS 'Codigo do regime';
COMMENT ON COLUMN "acdregimen"."description" IS 'Descricao';

CREATE SEQUENCE "seq_regimenid";
ALTER TABLE "acdregimen" ALTER COLUMN "regimenid" SET DEFAULT NEXTVAL('"seq_regimenid"');
ALTER TABLE "acdregimen" ALTER COLUMN "description" SET NOT NULL;

ALTER TABLE "acdregimen" ALTER COLUMN "regimenid" SET NOT NULL;
ALTER TABLE "acdregimen" ADD PRIMARY KEY ("regimenid");

----------------------------------------------------------------------
-- --
--
-- Table: basweekday
-- Purpose: dias da semana
--
-- --
----------------------------------------------------------------------

CREATE TABLE "basweekday" 
(
    "weekdayid"           integer, --Codigo do dia da semana
    "description"         text, --Descricao
    "shortdescription"    varchar(3) --Descricao suscinta
) INHERITS ("baslog");

COMMENT ON TABLE "basweekday" IS 'dias da semana';
COMMENT ON COLUMN "basweekday"."weekdayid" IS 'Codigo do dia da semana';
COMMENT ON COLUMN "basweekday"."description" IS 'Descricao';
COMMENT ON COLUMN "basweekday"."shortdescription" IS 'Descricao suscinta';

ALTER TABLE "basweekday" ALTER COLUMN "weekdayid" SET NOT NULL;
ALTER TABLE "basweekday" ALTER COLUMN "description" SET NOT NULL;
ALTER TABLE "basweekday" ALTER COLUMN "shortdescription" SET NOT NULL;

ALTER TABLE "basweekday" ALTER COLUMN "weekdayid" SET NOT NULL;
ALTER TABLE "basweekday" ADD PRIMARY KEY ("weekdayid");

----------------------------------------------------------------------
-- --
--
-- Table: acdcourseversiontype
-- Purpose: tipo de curso - credito, seriado semestral, anual
--
-- --
----------------------------------------------------------------------

CREATE TABLE "acdcourseversiontype" 
(
    "courseversiontypeid"    integer, --Codigo do tipo de versao
    "description"            text --Descricao
) INHERITS ("baslog");

COMMENT ON TABLE "acdcourseversiontype" IS 'tipo de curso - credito, seriado semestral, anual';
COMMENT ON COLUMN "acdcourseversiontype"."courseversiontypeid" IS 'Codigo do tipo de versao';
COMMENT ON COLUMN "acdcourseversiontype"."description" IS 'Descricao';

CREATE SEQUENCE "seq_courseversiontypeid";
ALTER TABLE "acdcourseversiontype" ALTER COLUMN "courseversiontypeid" SET DEFAULT NEXTVAL('"seq_courseversiontypeid"');
ALTER TABLE "acdcourseversiontype" ALTER COLUMN "description" SET NOT NULL;

ALTER TABLE "acdcourseversiontype" ALTER COLUMN "courseversiontypeid" SET NOT NULL;
ALTER TABLE "acdcourseversiontype" ADD PRIMARY KEY ("courseversiontypeid");

----------------------------------------------------------------------
-- --
--
-- Table: basfile
-- Purpose: tabela que grava os arquivos de upload
--
-- --
----------------------------------------------------------------------

CREATE TABLE "basfile" 
(
    "fileid"      integer, --Codigo do arquivo
    "filename"    text --Nome do arquivo
) INHERITS ("baslog");

COMMENT ON TABLE "basfile" IS 'tabela que grava os arquivos de upload';
COMMENT ON COLUMN "basfile"."fileid" IS 'Codigo do arquivo';
COMMENT ON COLUMN "basfile"."filename" IS 'Nome do arquivo';

CREATE SEQUENCE "seq_fileid";
ALTER TABLE "basfile" ALTER COLUMN "fileid" SET DEFAULT NEXTVAL('"seq_fileid"');
ALTER TABLE "basfile" ALTER COLUMN "filename" SET NOT NULL;

ALTER TABLE "basfile" ALTER COLUMN "fileid" SET NOT NULL;
ALTER TABLE "basfile" ADD PRIMARY KEY ("fileid");

----------------------------------------------------------------------
-- --
--
-- Table: acdenrollstatus
-- Purpose: estados possiveis da matricula. matriculado, reprovado, 
--          desistente, aprovado, dispensado 
--
-- --
----------------------------------------------------------------------

CREATE TABLE "acdenrollstatus" 
(
    "statusid"       integer, --Codigo do estado
    "description"    text --Descricao
) INHERITS ("baslog");

COMMENT ON TABLE "acdenrollstatus" IS 'estados possiveis da matricula. matriculado, reprovado, desistente, aprovado, dispensado';
COMMENT ON COLUMN "acdenrollstatus"."statusid" IS 'Codigo do estado';
COMMENT ON COLUMN "acdenrollstatus"."description" IS 'Descricao';

CREATE SEQUENCE "seq_statusid";
ALTER TABLE "acdenrollstatus" ALTER COLUMN "statusid" SET DEFAULT NEXTVAL('"seq_statusid"');
ALTER TABLE "acdenrollstatus" ALTER COLUMN "description" SET NOT NULL;

ALTER TABLE "acdenrollstatus" ALTER COLUMN "statusid" SET NOT NULL;
ALTER TABLE "acdenrollstatus" ADD PRIMARY KEY ("statusid");

----------------------------------------------------------------------
-- --
--
-- Table: ptcprintermanagement
-- Purpose: configuracao das impressoras dos comprovantes
--
-- --
----------------------------------------------------------------------

CREATE TABLE "ptcprintermanagement" 
(
    "printermanagementid"    integer, --Codigo da configuracao
    "description"            text, --Descricao
    "printeraddress"         inet, --Endereco da impressora
    "port"                   integer, --Porta de acesso
    "command"                text --Comando de impressao
) INHERITS ("baslog");

COMMENT ON TABLE "ptcprintermanagement" IS 'configuracao das impressoras dos comprovantes';
COMMENT ON COLUMN "ptcprintermanagement"."printermanagementid" IS 'Codigo da configuracao';
COMMENT ON COLUMN "ptcprintermanagement"."description" IS 'Descricao';
COMMENT ON COLUMN "ptcprintermanagement"."printeraddress" IS 'Endereco da impressora';
COMMENT ON COLUMN "ptcprintermanagement"."port" IS 'Porta de acesso';
COMMENT ON COLUMN "ptcprintermanagement"."command" IS 'Comando de impressao';

CREATE SEQUENCE "seq_printermanagementid";
ALTER TABLE "ptcprintermanagement" ALTER COLUMN "printermanagementid" SET DEFAULT NEXTVAL('"seq_printermanagementid"');
ALTER TABLE "ptcprintermanagement" ALTER COLUMN "description" SET NOT NULL;
ALTER TABLE "ptcprintermanagement" ALTER COLUMN "printeraddress" SET NOT NULL;
ALTER TABLE "ptcprintermanagement" ALTER COLUMN "port" SET NOT NULL;
ALTER TABLE "ptcprintermanagement" ALTER COLUMN "command" SET NOT NULL;

ALTER TABLE "ptcprintermanagement" ALTER COLUMN "printermanagementid" SET NOT NULL;
ALTER TABLE "ptcprintermanagement" ADD PRIMARY KEY ("printermanagementid");

----------------------------------------------------------------------
-- --
--
-- Table: sprselectiveprocesstype
-- Purpose: tipos de processo seletivo
--
-- --
----------------------------------------------------------------------

CREATE TABLE "sprselectiveprocesstype" 
(
    "selectiveprocesstypeid"    integer, --Codigo do tipo de processo seletivo
    "description"               text --Descricao
) INHERITS ("baslog");

COMMENT ON TABLE "sprselectiveprocesstype" IS 'tipos de processo seletivo';
COMMENT ON COLUMN "sprselectiveprocesstype"."selectiveprocesstypeid" IS 'Codigo do tipo de processo seletivo';
COMMENT ON COLUMN "sprselectiveprocesstype"."description" IS 'Descricao';

CREATE SEQUENCE "seq_selectiveprocesstypeid";
ALTER TABLE "sprselectiveprocesstype" ALTER COLUMN "selectiveprocesstypeid" SET DEFAULT NEXTVAL('"seq_selectiveprocesstypeid"');
ALTER TABLE "sprselectiveprocesstype" ALTER COLUMN "description" SET NOT NULL;

ALTER TABLE "sprselectiveprocesstype" ALTER COLUMN "selectiveprocesstypeid" SET NOT NULL;
ALTER TABLE "sprselectiveprocesstype" ADD PRIMARY KEY ("selectiveprocesstypeid");

----------------------------------------------------------------------
-- --
--
-- Table: acdtestendcoursetype
-- Purpose: tipos de teste de final de curso (provao, enade)
--
-- --
----------------------------------------------------------------------

CREATE TABLE "acdtestendcoursetype" 
(
    "testendcoursetypeid"    integer, --Codigo do tipo de teste
    "description"            text, --Descricao
    "begindate"              date, --Data Inicial
    "enddate"                date --Data Final
) INHERITS ("baslog");

COMMENT ON TABLE "acdtestendcoursetype" IS 'tipos de teste de final de curso (provao, enade)';
COMMENT ON COLUMN "acdtestendcoursetype"."testendcoursetypeid" IS 'Codigo do tipo de teste';
COMMENT ON COLUMN "acdtestendcoursetype"."description" IS 'Descricao';
COMMENT ON COLUMN "acdtestendcoursetype"."begindate" IS 'Data Inicial';
COMMENT ON COLUMN "acdtestendcoursetype"."enddate" IS 'Data Final';

CREATE SEQUENCE "seq_testendcoursetypeid";
ALTER TABLE "acdtestendcoursetype" ALTER COLUMN "testendcoursetypeid" SET DEFAULT NEXTVAL('"seq_testendcoursetypeid"');
ALTER TABLE "acdtestendcoursetype" ALTER COLUMN "description" SET NOT NULL;

ALTER TABLE "acdtestendcoursetype" ALTER COLUMN "testendcoursetypeid" SET NOT NULL;
ALTER TABLE "acdtestendcoursetype" ADD PRIMARY KEY ("testendcoursetypeid");

----------------------------------------------------------------------
-- --
--
-- Table: acdelection
-- Purpose: elei��es
--
-- --
----------------------------------------------------------------------

CREATE TABLE "acdelection" 
(
    "electiondate"    date, --Data da eleicao
    "description"     text --Descricao
) INHERITS ("baslog");

COMMENT ON TABLE "acdelection" IS 'elei��es';
COMMENT ON COLUMN "acdelection"."electiondate" IS 'Data da eleicao';
COMMENT ON COLUMN "acdelection"."description" IS 'Descricao';

ALTER TABLE "acdelection" ALTER COLUMN "electiondate" SET NOT NULL;
ALTER TABLE "acdelection" ALTER COLUMN "description" SET NOT NULL;

ALTER TABLE "acdelection" ALTER COLUMN "electiondate" SET NOT NULL;
ALTER TABLE "acdelection" ADD PRIMARY KEY ("electiondate");

----------------------------------------------------------------------
-- --
--
-- Table: ptcoriginplace
-- Purpose: local de origem
--
-- --
----------------------------------------------------------------------

CREATE TABLE "ptcoriginplace" 
(
    "originplaceid"    integer, --Codigo do local de origem
    "description"      varchar(20) --Descricao
) INHERITS ("baslog");

COMMENT ON TABLE "ptcoriginplace" IS 'local de origem';
COMMENT ON COLUMN "ptcoriginplace"."originplaceid" IS 'Codigo do local de origem';
COMMENT ON COLUMN "ptcoriginplace"."description" IS 'Descricao';

CREATE SEQUENCE "seq_originplaceid";
ALTER TABLE "ptcoriginplace" ALTER COLUMN "originplaceid" SET DEFAULT NEXTVAL('"seq_originplaceid"');
ALTER TABLE "ptcoriginplace" ALTER COLUMN "description" SET NOT NULL;

ALTER TABLE "ptcoriginplace" ALTER COLUMN "originplaceid" SET NOT NULL;
ALTER TABLE "ptcoriginplace" ADD PRIMARY KEY ("originplaceid");

----------------------------------------------------------------------
-- --
--
-- Table: acdexternalcourse
-- Purpose: cursos externos
--
-- --
----------------------------------------------------------------------

CREATE TABLE "acdexternalcourse" 
(
    "externalcourseid"    integer, --Codigo do curso externo
    "name"                text, --Nome
    "shortname"           varchar(40), --Nome suscinto
    "obs"                 text, --Observacao
    "knowledgeareaid"     integer --Área de conhecimento - Ex: Ciencias Exatas e da Terra, Ciencias Humanas
) INHERITS ("baslog");

COMMENT ON TABLE "acdexternalcourse" IS 'cursos externos';
COMMENT ON COLUMN "acdexternalcourse"."externalcourseid" IS 'Codigo do curso externo';
COMMENT ON COLUMN "acdexternalcourse"."name" IS 'Nome';
COMMENT ON COLUMN "acdexternalcourse"."shortname" IS 'Nome suscinto';
COMMENT ON COLUMN "acdexternalcourse"."obs" IS 'Observacao';
COMMENT ON COLUMN "acdexternalcourse"."knowledgeareaid" IS 'Área de conhecimento - Ex: Ciencias Exatas e da Terra, Ciencias Humanas';

CREATE SEQUENCE "seq_externalcourseid";
ALTER TABLE "acdexternalcourse" ALTER COLUMN "externalcourseid" SET DEFAULT NEXTVAL('"seq_externalcourseid"');
ALTER TABLE "acdexternalcourse" ALTER COLUMN "name" SET NOT NULL;
ALTER TABLE "acdexternalcourse" ALTER COLUMN "shortname" SET NOT NULL;

ALTER TABLE "acdexternalcourse" ALTER COLUMN "externalcourseid" SET NOT NULL;
ALTER TABLE "acdexternalcourse" ADD PRIMARY KEY ("externalcourseid");

ALTER TABLE "acdexternalcourse" ADD FOREIGN KEY ("knowledgeareaid") REFERENCES "acdknowledgearea"("knowledgeareaid");

----------------------------------------------------------------------
-- --
--
-- Table: bascountry
-- Purpose: paises
--
-- --
----------------------------------------------------------------------

CREATE TABLE "bascountry" 
(
    "countryid"                   integer, --Codigo do pais
    "name"                        varchar(50), --Nome
    "nationality"                 varchar(30), --Nacionalidade
    "currency"                    varchar(20), --moeda no singular. Ex: REAL
    "pluralcurrency"              varchar(20), --moeda no plural. Ex: REAIS
    "decimaldescription"          varchar(20), --Como sao chamados os valores decimais no singular. Ex.: CENTAVO
    "pluraldecimaldescription"    varchar(20), --Como sao chamados os valores decimais no plural. Ex.: CENTAVOS
    "currencysymbol"              varchar(20) --Simbolo da moéda. Ex: R$
) INHERITS ("baslog");

COMMENT ON TABLE "bascountry" IS 'paises';
COMMENT ON COLUMN "bascountry"."countryid" IS 'Codigo do pais';
COMMENT ON COLUMN "bascountry"."name" IS 'Nome';
COMMENT ON COLUMN "bascountry"."nationality" IS 'Nacionalidade';
COMMENT ON COLUMN "bascountry"."currency" IS 'moeda no singular. Ex: REAL';
COMMENT ON COLUMN "bascountry"."pluralcurrency" IS 'moeda no plural. Ex: REAIS';
COMMENT ON COLUMN "bascountry"."decimaldescription" IS 'Como sao chamados os valores decimais no singular. Ex.: CENTAVO';
COMMENT ON COLUMN "bascountry"."pluraldecimaldescription" IS 'Como sao chamados os valores decimais no plural. Ex.: CENTAVOS';
COMMENT ON COLUMN "bascountry"."currencysymbol" IS 'Simbolo da moéda. Ex: R$';

CREATE SEQUENCE "seq_countryid";
ALTER TABLE "bascountry" ALTER COLUMN "countryid" SET DEFAULT NEXTVAL('"seq_countryid"');
ALTER TABLE "bascountry" ALTER COLUMN "name" SET NOT NULL;
ALTER TABLE "bascountry" ALTER COLUMN "nationality" SET NOT NULL;

ALTER TABLE "bascountry" ALTER COLUMN "countryid" SET NOT NULL;
ALTER TABLE "bascountry" ADD PRIMARY KEY ("countryid");

----------------------------------------------------------------------
-- --
--
-- Table: baslink
-- Purpose: vinculos
--
-- --
----------------------------------------------------------------------

CREATE TABLE "baslink" 
(
    "linkid"         integer, --Codigo do vinculo
    "description"    text --Descricao
) INHERITS ("baslog");

COMMENT ON TABLE "baslink" IS 'vinculos';
COMMENT ON COLUMN "baslink"."linkid" IS 'Codigo do vinculo';
COMMENT ON COLUMN "baslink"."description" IS 'Descricao';

CREATE SEQUENCE "seq_linkid";
ALTER TABLE "baslink" ALTER COLUMN "linkid" SET DEFAULT NEXTVAL('"seq_linkid"');
ALTER TABLE "baslink" ALTER COLUMN "description" SET NOT NULL;

ALTER TABLE "baslink" ALTER COLUMN "linkid" SET NOT NULL;
ALTER TABLE "baslink" ADD PRIMARY KEY ("linkid");

----------------------------------------------------------------------
-- --
--
-- Table: basethnicorigin
-- Purpose: origem etnica - ra�as
--
-- --
----------------------------------------------------------------------

CREATE TABLE "basethnicorigin" 
(
    "ethnicoriginid"    integer, --Codigo da origem etnica
    "description"       text --Descricao
) INHERITS ("baslog");

COMMENT ON TABLE "basethnicorigin" IS 'origem etnica - ra�as';
COMMENT ON COLUMN "basethnicorigin"."ethnicoriginid" IS 'Codigo da origem etnica';
COMMENT ON COLUMN "basethnicorigin"."description" IS 'Descricao';

CREATE SEQUENCE "seq_ethnicoriginid";
ALTER TABLE "basethnicorigin" ALTER COLUMN "ethnicoriginid" SET DEFAULT NEXTVAL('"seq_ethnicoriginid"');
ALTER TABLE "basethnicorigin" ALTER COLUMN "description" SET NOT NULL;

ALTER TABLE "basethnicorigin" ALTER COLUMN "ethnicoriginid" SET NOT NULL;
ALTER TABLE "basethnicorigin" ADD PRIMARY KEY ("ethnicoriginid");

----------------------------------------------------------------------
-- --
--
-- Table: basmaritalstatus
-- Purpose: estado civil
--
-- --
----------------------------------------------------------------------

CREATE TABLE "basmaritalstatus" 
(
    "maritalstatusid"    char(1), --Codigo do estado civil
    "description"        text --Descricao
) INHERITS ("baslog");

COMMENT ON TABLE "basmaritalstatus" IS 'estado civil';
COMMENT ON COLUMN "basmaritalstatus"."maritalstatusid" IS 'Codigo do estado civil';
COMMENT ON COLUMN "basmaritalstatus"."description" IS 'Descricao';

ALTER TABLE "basmaritalstatus" ALTER COLUMN "maritalstatusid" SET NOT NULL;
ALTER TABLE "basmaritalstatus" ALTER COLUMN "description" SET NOT NULL;

ALTER TABLE "basmaritalstatus" ALTER COLUMN "maritalstatusid" SET NOT NULL;
ALTER TABLE "basmaritalstatus" ADD PRIMARY KEY ("maritalstatusid");

----------------------------------------------------------------------
-- --
--
-- Table: accaccountscheme
-- Purpose: tabela de contas contabeis
--
-- --
----------------------------------------------------------------------

CREATE TABLE "accaccountscheme" 
(
    "accountschemeid"    varchar(30), --Codigo identificador da conta contabil
    "description"        text --Descricao da conta contabil
) INHERITS ("baslog");

COMMENT ON TABLE "accaccountscheme" IS 'tabela de contas contabeis';
COMMENT ON COLUMN "accaccountscheme"."accountschemeid" IS 'Codigo identificador da conta contabil';
COMMENT ON COLUMN "accaccountscheme"."description" IS 'Descricao da conta contabil';

ALTER TABLE "accaccountscheme" ALTER COLUMN "accountschemeid" SET NOT NULL;
ALTER TABLE "accaccountscheme" ALTER COLUMN "description" SET NOT NULL;

ALTER TABLE "accaccountscheme" ALTER COLUMN "accountschemeid" SET NOT NULL;
ALTER TABLE "accaccountscheme" ADD PRIMARY KEY ("accountschemeid");

----------------------------------------------------------------------
-- --
--
-- Table: accaccountbalance
-- Purpose: contem os saldos das contas contabeis em uma determinada 
--          data 
--
-- --
----------------------------------------------------------------------

CREATE TABLE "accaccountbalance" 
(
    "accountschemeid"    varchar(30), --Codigo identificador da conta contabil
    "source"             char(1), --Define se o saldo em questao tem origem nas previsoes (P) ou nos lancamentos (L)
    "balancedate"        date, --Data que define quando saldo desta conta/origem foi calculado
    "value"              numeric(14,4) --Valor do saldo.
) INHERITS ("baslog");

COMMENT ON TABLE "accaccountbalance" IS 'contem os saldos das contas contabeis em uma determinada data';
COMMENT ON COLUMN "accaccountbalance"."accountschemeid" IS 'Codigo identificador da conta contabil';
COMMENT ON COLUMN "accaccountbalance"."source" IS 'Define se o saldo em questao tem origem nas previsoes (P) ou nos lancamentos (L)';
COMMENT ON COLUMN "accaccountbalance"."balancedate" IS 'Data que define quando saldo desta conta/origem foi calculado';
COMMENT ON COLUMN "accaccountbalance"."value" IS 'Valor do saldo.';

ALTER TABLE "accaccountbalance" ALTER COLUMN "accountschemeid" SET NOT NULL;
ALTER TABLE "accaccountbalance" ALTER COLUMN "source" SET NOT NULL;
ALTER TABLE "accaccountbalance" ALTER COLUMN "balancedate" SET NOT NULL;
ALTER TABLE "accaccountbalance" ALTER COLUMN "value" SET NOT NULL;

ALTER TABLE "accaccountbalance" ALTER COLUMN "accountschemeid" SET NOT NULL;
ALTER TABLE "accaccountbalance" ALTER COLUMN "source" SET NOT NULL;
ALTER TABLE "accaccountbalance" ALTER COLUMN "balancedate" SET NOT NULL;
ALTER TABLE "accaccountbalance" ADD PRIMARY KEY ("accountschemeid","source","balancedate");

ALTER TABLE "accaccountbalance" ADD FOREIGN KEY ("accountschemeid") REFERENCES "accaccountscheme"("accountschemeid");

----------------------------------------------------------------------
-- --
--
-- Table: fincollectiontype
-- Purpose: tipos de cobrancas, podendo ser simples, com registro ou 
--          outro. 
--
-- --
----------------------------------------------------------------------

CREATE TABLE "fincollectiontype" 
(
    "collectiontypeid"    integer, --Codigo identificador do tipo de cobranca
    "description"         text --Texto descrevendo o tipo da cobranca (simples, com registro, etc).
) INHERITS ("baslog");

COMMENT ON TABLE "fincollectiontype" IS 'tipos de cobrancas, podendo ser simples, com registro ou outro.';
COMMENT ON COLUMN "fincollectiontype"."collectiontypeid" IS 'Codigo identificador do tipo de cobranca';
COMMENT ON COLUMN "fincollectiontype"."description" IS 'Texto descrevendo o tipo da cobranca (simples, com registro, etc).';

CREATE SEQUENCE "seq_collectiontypeid";
ALTER TABLE "fincollectiontype" ALTER COLUMN "collectiontypeid" SET DEFAULT NEXTVAL('"seq_collectiontypeid"');
ALTER TABLE "fincollectiontype" ALTER COLUMN "description" SET NOT NULL;

ALTER TABLE "fincollectiontype" ALTER COLUMN "collectiontypeid" SET NOT NULL;
ALTER TABLE "fincollectiontype" ADD PRIMARY KEY ("collectiontypeid");

----------------------------------------------------------------------
-- --
--
-- Table: fininvoicelog
-- Purpose: log de titulos gerados pelo processo de geracao automatica 
--          de titulos 
--
-- --
----------------------------------------------------------------------

CREATE TABLE "fininvoicelog" 
(
    "month"             integer, --Mes de geracao
    "year"              integer, --Ano de geracao
    "generationdate"    date, --Data em que o processo de geracao de titulos foi disparado
    "generationtype"    char --Indica qual o tipo de geracao do processo de titulos 
) INHERITS ("baslog");

COMMENT ON TABLE "fininvoicelog" IS 'log de titulos gerados pelo processo de geracao automatica de titulos';
COMMENT ON COLUMN "fininvoicelog"."month" IS 'Mes de geracao';
COMMENT ON COLUMN "fininvoicelog"."year" IS 'Ano de geracao';
COMMENT ON COLUMN "fininvoicelog"."generationdate" IS 'Data em que o processo de geracao de titulos foi disparado';
COMMENT ON COLUMN "fininvoicelog"."generationtype" IS 'Indica qual o tipo de geracao do processo de titulos ';

ALTER TABLE "fininvoicelog" ALTER COLUMN "month" SET NOT NULL;
ALTER TABLE "fininvoicelog" ALTER COLUMN "year" SET NOT NULL;
ALTER TABLE "fininvoicelog" ALTER COLUMN "generationdate" SET NOT NULL;

ALTER TABLE "fininvoicelog" ALTER COLUMN "month" SET NOT NULL;
ALTER TABLE "fininvoicelog" ALTER COLUMN "year" SET NOT NULL;
ALTER TABLE "fininvoicelog" ALTER COLUMN "generationtype" SET NOT NULL;
ALTER TABLE "fininvoicelog" ADD PRIMARY KEY ("month","year","generationtype");

----------------------------------------------------------------------
-- --
--
-- Table: acdformationlevel
-- Purpose: n�vel de forma��o - graduacao, tecico, pos, etc.
--
-- --
----------------------------------------------------------------------

CREATE TABLE "acdformationlevel" 
(
    "formationlevelid"    integer, --Codigo do nivel de formacao
    "description"         varchar(30), --Descrição (Graduação, Técnico, Seqüencial)
    "shortdescription"    varchar(3), --Abreviatura (Gra, Téc, Seq)
    "academicdegree"      varchar(20) --Nível acadêmico(Nível superior, Nível técnico, Nível seqüencial)
) INHERITS ("baslog");

COMMENT ON TABLE "acdformationlevel" IS 'n�vel de forma��o - graduacao, tecico, pos, etc.';
COMMENT ON COLUMN "acdformationlevel"."formationlevelid" IS 'Codigo do nivel de formacao';
COMMENT ON COLUMN "acdformationlevel"."description" IS 'Descrição (Graduação, Técnico, Seqüencial)';
COMMENT ON COLUMN "acdformationlevel"."shortdescription" IS 'Abreviatura (Gra, Téc, Seq)';
COMMENT ON COLUMN "acdformationlevel"."academicdegree" IS 'Nível acadêmico(Nível superior, Nível técnico, Nível seqüencial)';

CREATE SEQUENCE "seq_formationlevelid";
ALTER TABLE "acdformationlevel" ALTER COLUMN "formationlevelid" SET DEFAULT NEXTVAL('"seq_formationlevelid"');
ALTER TABLE "acdformationlevel" ALTER COLUMN "description" SET NOT NULL;
ALTER TABLE "acdformationlevel" ALTER COLUMN "shortdescription" SET NOT NULL;

ALTER TABLE "acdformationlevel" ALTER COLUMN "formationlevelid" SET NOT NULL;
ALTER TABLE "acdformationlevel" ADD PRIMARY KEY ("formationlevelid");

----------------------------------------------------------------------
-- --
--
-- Table: acdcurricularcomponenttype
-- Purpose: tipos de disciplina - normal, intensivo, dist�ncia, 
--          est�gio, regime especial 
--
-- --
----------------------------------------------------------------------

CREATE TABLE "acdcurricularcomponenttype" 
(
    "curricularcomponenttypeid"    integer, --Codigo do tipo de disciplina
    "description"                  text --Descricao
) INHERITS ("baslog");

COMMENT ON TABLE "acdcurricularcomponenttype" IS 'tipos de disciplina - normal, intensivo, dist�ncia, est�gio, regime especial';
COMMENT ON COLUMN "acdcurricularcomponenttype"."curricularcomponenttypeid" IS 'Codigo do tipo de disciplina';
COMMENT ON COLUMN "acdcurricularcomponenttype"."description" IS 'Descricao';

CREATE SEQUENCE "seq_curricularcomponenttypeid";
ALTER TABLE "acdcurricularcomponenttype" ALTER COLUMN "curricularcomponenttypeid" SET DEFAULT NEXTVAL('"seq_curricularcomponenttypeid"');
ALTER TABLE "acdcurricularcomponenttype" ALTER COLUMN "description" SET NOT NULL;

ALTER TABLE "acdcurricularcomponenttype" ALTER COLUMN "curricularcomponenttypeid" SET NOT NULL;
ALTER TABLE "acdcurricularcomponenttype" ADD PRIMARY KEY ("curricularcomponenttypeid");

----------------------------------------------------------------------
-- --
--
-- Table: acdeducationarea
-- Purpose: areas de ensino
--
-- --
----------------------------------------------------------------------

CREATE TABLE "acdeducationarea" 
(
    "educationareaid"    integer, --Codigo da area de ensino
    "description"        text --Descricao
) INHERITS ("baslog");

COMMENT ON TABLE "acdeducationarea" IS 'areas de ensino';
COMMENT ON COLUMN "acdeducationarea"."educationareaid" IS 'Codigo da area de ensino';
COMMENT ON COLUMN "acdeducationarea"."description" IS 'Descricao';

CREATE SEQUENCE "seq_educationareaid";
ALTER TABLE "acdeducationarea" ALTER COLUMN "educationareaid" SET DEFAULT NEXTVAL('"seq_educationareaid"');
ALTER TABLE "acdeducationarea" ALTER COLUMN "description" SET NOT NULL;

ALTER TABLE "acdeducationarea" ALTER COLUMN "educationareaid" SET NOT NULL;
ALTER TABLE "acdeducationarea" ADD PRIMARY KEY ("educationareaid");

----------------------------------------------------------------------
-- --
--
-- Table: basturn
-- Purpose: turnos
--
-- --
----------------------------------------------------------------------

CREATE TABLE "basturn" 
(
    "turnid"              integer, --Codigo do turno
    "description"         varchar(30), --Descricao
    "shortdescription"    varchar(3), --Descricao suscinta
    "beginhour"           time without time zone, --Horario de inicio
    "endhour"             time without time zone, --Horario de termino
    "charid"              char(1) --Codigo de unificacao de turnos
) INHERITS ("baslog");

COMMENT ON TABLE "basturn" IS 'turnos';
COMMENT ON COLUMN "basturn"."turnid" IS 'Codigo do turno';
COMMENT ON COLUMN "basturn"."description" IS 'Descricao';
COMMENT ON COLUMN "basturn"."shortdescription" IS 'Descricao suscinta';
COMMENT ON COLUMN "basturn"."beginhour" IS 'Horario de inicio';
COMMENT ON COLUMN "basturn"."endhour" IS 'Horario de termino';
COMMENT ON COLUMN "basturn"."charid" IS 'Codigo de unificacao de turnos';

CREATE SEQUENCE "seq_turnid";
ALTER TABLE "basturn" ALTER COLUMN "turnid" SET DEFAULT NEXTVAL('"seq_turnid"');
ALTER TABLE "basturn" ALTER COLUMN "description" SET NOT NULL;
ALTER TABLE "basturn" ALTER COLUMN "shortdescription" SET NOT NULL;
ALTER TABLE "basturn" ALTER COLUMN "charid" SET NOT NULL;

ALTER TABLE "basturn" ALTER COLUMN "turnid" SET NOT NULL;
ALTER TABLE "basturn" ADD PRIMARY KEY ("turnid");

----------------------------------------------------------------------
-- --
--
-- Table: basprofessionalactivitylinktype
-- Purpose: tipos de v�nculos nas atividades profissionais (estagio, 
--          clt) 
--
-- --
----------------------------------------------------------------------

CREATE TABLE "basprofessionalactivitylinktype" 
(
    "professionalactivitylinktypeid"    integer, --Codigo do tipo de vinculo das atividades profissionais
    "description"                       text, --Descricao
    "notifycompany"                     boolean --Notificar a empresa no caso de fim do vinculo com a IES (estagio)
) INHERITS ("baslog");

COMMENT ON TABLE "basprofessionalactivitylinktype" IS 'tipos de v�nculos nas atividades profissionais (estagio, clt)';
COMMENT ON COLUMN "basprofessionalactivitylinktype"."professionalactivitylinktypeid" IS 'Codigo do tipo de vinculo das atividades profissionais';
COMMENT ON COLUMN "basprofessionalactivitylinktype"."description" IS 'Descricao';
COMMENT ON COLUMN "basprofessionalactivitylinktype"."notifycompany" IS 'Notificar a empresa no caso de fim do vinculo com a IES (estagio)';

CREATE SEQUENCE "seq_professionalactivitylinktypeid";
ALTER TABLE "basprofessionalactivitylinktype" ALTER COLUMN "professionalactivitylinktypeid" SET DEFAULT NEXTVAL('"seq_professionalactivitylinktypeid"');
ALTER TABLE "basprofessionalactivitylinktype" ALTER COLUMN "description" SET NOT NULL;
ALTER TABLE "basprofessionalactivitylinktype" ALTER COLUMN "notifycompany" SET NOT NULL;
ALTER TABLE "basprofessionalactivitylinktype" ALTER COLUMN "notifycompany" SET DEFAULT FALSE ;

ALTER TABLE "basprofessionalactivitylinktype" ALTER COLUMN "professionalactivitylinktypeid" SET NOT NULL;
ALTER TABLE "basprofessionalactivitylinktype" ADD PRIMARY KEY ("professionalactivitylinktypeid");

----------------------------------------------------------------------
-- --
--
-- Table: basprofessionalactivityagent
-- Purpose: agente da atividade profissional - para estagios (ciee, 
--          pie, etc.) 
--
-- --
----------------------------------------------------------------------

CREATE TABLE "basprofessionalactivityagent" 
(
    "professionalactivityagentid"    integer, --Codigo do agente da atividade profissional
    "description"                    text --Descricao
) INHERITS ("baslog");

COMMENT ON TABLE "basprofessionalactivityagent" IS 'agente da atividade profissional - para estagios (ciee, pie, etc.)';
COMMENT ON COLUMN "basprofessionalactivityagent"."professionalactivityagentid" IS 'Codigo do agente da atividade profissional';
COMMENT ON COLUMN "basprofessionalactivityagent"."description" IS 'Descricao';

CREATE SEQUENCE "seq_professionalactivityagentid";
ALTER TABLE "basprofessionalactivityagent" ALTER COLUMN "professionalactivityagentid" SET DEFAULT NEXTVAL('"seq_professionalactivityagentid"');
ALTER TABLE "basprofessionalactivityagent" ALTER COLUMN "description" SET NOT NULL;

ALTER TABLE "basprofessionalactivityagent" ALTER COLUMN "professionalactivityagentid" SET NOT NULL;
ALTER TABLE "basprofessionalactivityagent" ADD PRIMARY KEY ("professionalactivityagentid");

----------------------------------------------------------------------
-- --
--
-- Table: basprofessionalactivity
-- Purpose: atividades profissionais
--
-- --
----------------------------------------------------------------------

CREATE TABLE "basprofessionalactivity" 
(
    "professionalactivityid"    integer, --Codigo da atividade profissional
    "description"               text --Descricao
) INHERITS ("baslog");

COMMENT ON TABLE "basprofessionalactivity" IS 'atividades profissionais';
COMMENT ON COLUMN "basprofessionalactivity"."professionalactivityid" IS 'Codigo da atividade profissional';
COMMENT ON COLUMN "basprofessionalactivity"."description" IS 'Descricao';

CREATE SEQUENCE "seq_professionalactivityid";
ALTER TABLE "basprofessionalactivity" ALTER COLUMN "professionalactivityid" SET DEFAULT NEXTVAL('"seq_professionalactivityid"');
ALTER TABLE "basprofessionalactivity" ALTER COLUMN "description" SET NOT NULL;

ALTER TABLE "basprofessionalactivity" ALTER COLUMN "professionalactivityid" SET NOT NULL;
ALTER TABLE "basprofessionalactivity" ADD PRIMARY KEY ("professionalactivityid");

----------------------------------------------------------------------
-- --
--
-- Table: acdcertifiedtype
-- Purpose: tipos de atestados
--
-- --
----------------------------------------------------------------------

CREATE TABLE "acdcertifiedtype" 
(
    "certifiedtypeid"    integer, --Codigo do tipo de atestado
    "description"        text, --Descricao
    "reportlink"         text --Link para relatório do Agata
) INHERITS ("baslog");

COMMENT ON TABLE "acdcertifiedtype" IS 'tipos de atestados';
COMMENT ON COLUMN "acdcertifiedtype"."certifiedtypeid" IS 'Codigo do tipo de atestado';
COMMENT ON COLUMN "acdcertifiedtype"."description" IS 'Descricao';
COMMENT ON COLUMN "acdcertifiedtype"."reportlink" IS 'Link para relatório do Agata';

CREATE SEQUENCE "seq_certifiedtypeid";
ALTER TABLE "acdcertifiedtype" ALTER COLUMN "certifiedtypeid" SET DEFAULT NEXTVAL('"seq_certifiedtypeid"');
ALTER TABLE "acdcertifiedtype" ALTER COLUMN "description" SET NOT NULL;

ALTER TABLE "acdcertifiedtype" ALTER COLUMN "certifiedtypeid" SET NOT NULL;
ALTER TABLE "acdcertifiedtype" ADD PRIMARY KEY ("certifiedtypeid");

----------------------------------------------------------------------
-- --
--
-- Table: rshquestioncategory
-- Purpose: tipos/grupos de questao - categorias
--
-- --
----------------------------------------------------------------------

CREATE TABLE "rshquestioncategory" 
(
    "questioncategoryid"    integer, --Codigo da categoria
    "description"           text --Descricao
) INHERITS ("baslog");

COMMENT ON TABLE "rshquestioncategory" IS 'tipos/grupos de questao - categorias';
COMMENT ON COLUMN "rshquestioncategory"."questioncategoryid" IS 'Codigo da categoria';
COMMENT ON COLUMN "rshquestioncategory"."description" IS 'Descricao';

CREATE SEQUENCE "seq_questioncategoryid";
ALTER TABLE "rshquestioncategory" ALTER COLUMN "questioncategoryid" SET DEFAULT NEXTVAL('"seq_questioncategoryid"');
ALTER TABLE "rshquestioncategory" ALTER COLUMN "description" SET NOT NULL;

ALTER TABLE "rshquestioncategory" ALTER COLUMN "questioncategoryid" SET NOT NULL;
ALTER TABLE "rshquestioncategory" ADD PRIMARY KEY ("questioncategoryid");

----------------------------------------------------------------------
-- --
--
-- Table: acdstatecontract
-- Purpose: estados da movimentacao contratual
--
-- --
----------------------------------------------------------------------

CREATE TABLE "acdstatecontract" 
(
    "statecontractid"    integer, --Codigo do estado
    "description"        text, --Descricao
    "inouttransition"    char(1), --Estado Inicial, final ou de transicao
    "needsreason"        boolean, --Necessita de motivo
    "isclosecontract"    boolean --Se fecha o contrato
) INHERITS ("baslog");

COMMENT ON TABLE "acdstatecontract" IS 'estados da movimentacao contratual';
COMMENT ON COLUMN "acdstatecontract"."statecontractid" IS 'Codigo do estado';
COMMENT ON COLUMN "acdstatecontract"."description" IS 'Descricao';
COMMENT ON COLUMN "acdstatecontract"."inouttransition" IS 'Estado Inicial, final ou de transicao';
COMMENT ON COLUMN "acdstatecontract"."needsreason" IS 'Necessita de motivo';
COMMENT ON COLUMN "acdstatecontract"."isclosecontract" IS 'Se fecha o contrato';

CREATE SEQUENCE "seq_statecontractid";
ALTER TABLE "acdstatecontract" ALTER COLUMN "statecontractid" SET DEFAULT NEXTVAL('"seq_statecontractid"');
ALTER TABLE "acdstatecontract" ALTER COLUMN "description" SET NOT NULL;
ALTER TABLE "acdstatecontract" ALTER COLUMN "inouttransition" SET NOT NULL;
ALTER TABLE "acdstatecontract" ALTER COLUMN "needsreason" SET NOT NULL;
ALTER TABLE "acdstatecontract" ALTER COLUMN "needsreason" SET DEFAULT FALSE ;
ALTER TABLE "acdstatecontract" ALTER COLUMN "isclosecontract" SET NOT NULL;
ALTER TABLE "acdstatecontract" ALTER COLUMN "isclosecontract" SET DEFAULT FALSE ;

ALTER TABLE "acdstatecontract" ALTER COLUMN "statecontractid" SET NOT NULL;
ALTER TABLE "acdstatecontract" ADD PRIMARY KEY ("statecontractid");

----------------------------------------------------------------------
-- --
--
-- Table: finincomesource
-- Purpose: origens de receita
--
-- --
----------------------------------------------------------------------

CREATE TABLE "finincomesource" 
(
    "incomesourceid"    integer, --Codigo identificador da origem
    "description"       text, --Descricao da origem
    "isextinct"         boolean --Define se a origem esta extinta ou nao
) INHERITS ("baslog");

COMMENT ON TABLE "finincomesource" IS 'origens de receita';
COMMENT ON COLUMN "finincomesource"."incomesourceid" IS 'Codigo identificador da origem';
COMMENT ON COLUMN "finincomesource"."description" IS 'Descricao da origem';
COMMENT ON COLUMN "finincomesource"."isextinct" IS 'Define se a origem esta extinta ou nao';

CREATE SEQUENCE "seq_incomesourceid";
ALTER TABLE "finincomesource" ALTER COLUMN "incomesourceid" SET DEFAULT NEXTVAL('"seq_incomesourceid"');
ALTER TABLE "finincomesource" ALTER COLUMN "description" SET NOT NULL;
ALTER TABLE "finincomesource" ALTER COLUMN "isextinct" SET NOT NULL;
ALTER TABLE "finincomesource" ALTER COLUMN "isextinct" SET DEFAULT FALSE ;

ALTER TABLE "finincomesource" ALTER COLUMN "incomesourceid" SET NOT NULL;
ALTER TABLE "finincomesource" ADD PRIMARY KEY ("incomesourceid");

----------------------------------------------------------------------
-- --
--
-- Table: acdreasoncancellation
-- Purpose: motivos de cancelamento de matricula
--
-- --
----------------------------------------------------------------------

CREATE TABLE "acdreasoncancellation" 
(
    "reasoncancellationid"    integer, --Codigo do motivo de cancelamento
    "description"             text --Descricao
) INHERITS ("baslog");

COMMENT ON TABLE "acdreasoncancellation" IS 'motivos de cancelamento de matricula';
COMMENT ON COLUMN "acdreasoncancellation"."reasoncancellationid" IS 'Codigo do motivo de cancelamento';
COMMENT ON COLUMN "acdreasoncancellation"."description" IS 'Descricao';

CREATE SEQUENCE "seq_reasoncancellationid";
ALTER TABLE "acdreasoncancellation" ALTER COLUMN "reasoncancellationid" SET DEFAULT NEXTVAL('"seq_reasoncancellationid"');
ALTER TABLE "acdreasoncancellation" ALTER COLUMN "description" SET NOT NULL;

ALTER TABLE "acdreasoncancellation" ALTER COLUMN "reasoncancellationid" SET NOT NULL;
ALTER TABLE "acdreasoncancellation" ADD PRIMARY KEY ("reasoncancellationid");

----------------------------------------------------------------------
-- --
--
-- Table: finbank
-- Purpose: bancos com as quais a instituicao trabalha
--
-- --
----------------------------------------------------------------------

CREATE TABLE "finbank" 
(
    "bankid"         varchar(3), --Numero do banco fornecido pelo Banco Central para manipulacao de arquivos
    "description"    text, --Nome do banco
    "bankidvd"       char(1), --Digito verificador do numero do banco.
    "accordcode"     varchar, --Codigo de convenio da empresa com o banco
    "url"            varchar(255) --URL de referencia do banco
) INHERITS ("baslog");

COMMENT ON TABLE "finbank" IS 'bancos com as quais a instituicao trabalha';
COMMENT ON COLUMN "finbank"."bankid" IS 'Numero do banco fornecido pelo Banco Central para manipulacao de arquivos';
COMMENT ON COLUMN "finbank"."description" IS 'Nome do banco';
COMMENT ON COLUMN "finbank"."bankidvd" IS 'Digito verificador do numero do banco.';
COMMENT ON COLUMN "finbank"."accordcode" IS 'Codigo de convenio da empresa com o banco';
COMMENT ON COLUMN "finbank"."url" IS 'RL de referencia do banco';

ALTER TABLE "finbank" ALTER COLUMN "bankid" SET NOT NULL;
ALTER TABLE "finbank" ALTER COLUMN "description" SET NOT NULL;

ALTER TABLE "finbank" ALTER COLUMN "bankid" SET NOT NULL;
ALTER TABLE "finbank" ADD PRIMARY KEY ("bankid");

----------------------------------------------------------------------
-- --
--
-- Table: finspecies
-- Purpose: especies monetarias ex. cheque, dinheiro
--
-- --
----------------------------------------------------------------------

CREATE TABLE "finspecies" 
(
    "speciesid"      integer, --Codigo identificador da especie
    "description"    text --Descricao da especie
) INHERITS ("baslog");

COMMENT ON TABLE "finspecies" IS 'especies monetarias ex. cheque, dinheiro';
COMMENT ON COLUMN "finspecies"."speciesid" IS 'Codigo identificador da especie';
COMMENT ON COLUMN "finspecies"."description" IS 'Descricao da especie';

CREATE SEQUENCE "seq_speciesid";
ALTER TABLE "finspecies" ALTER COLUMN "speciesid" SET DEFAULT NEXTVAL('"seq_speciesid"');
ALTER TABLE "finspecies" ALTER COLUMN "description" SET NOT NULL;

ALTER TABLE "finspecies" ALTER COLUMN "speciesid" SET NOT NULL;
ALTER TABLE "finspecies" ADD PRIMARY KEY ("speciesid");

----------------------------------------------------------------------
-- --
--
-- Table: acdcomplementaryactivitiescategory
-- Purpose: categorias das atividades complementares
--
-- --
----------------------------------------------------------------------

CREATE TABLE "acdcomplementaryactivitiescategory" 
(
    "complementaryactivitiescategoryid"    integer, --Codigo da categoria da atividade complementar
    "description"                          text --Descricao da categoria (ensino, pesquisa e extensão)
) INHERITS ("baslog");

COMMENT ON TABLE "acdcomplementaryactivitiescategory" IS 'categorias das atividades complementares';
COMMENT ON COLUMN "acdcomplementaryactivitiescategory"."complementaryactivitiescategoryid" IS 'Codigo da categoria da atividade complementar';
COMMENT ON COLUMN "acdcomplementaryactivitiescategory"."description" IS 'Descricao da categoria (ensino, pesquisa e extensão)';

CREATE SEQUENCE "seq_complementaryactivitiescategoryid";
ALTER TABLE "acdcomplementaryactivitiescategory" ALTER COLUMN "complementaryactivitiescategoryid" SET DEFAULT NEXTVAL('"seq_complementaryactivitiescategoryid"');
ALTER TABLE "acdcomplementaryactivitiescategory" ALTER COLUMN "description" SET NOT NULL;

ALTER TABLE "acdcomplementaryactivitiescategory" ALTER COLUMN "complementaryactivitiescategoryid" SET NOT NULL;
ALTER TABLE "acdcomplementaryactivitiescategory" ADD PRIMARY KEY ("complementaryactivitiescategoryid");

----------------------------------------------------------------------
-- --
--
-- Table: finfile
-- Purpose: registro de arquivos de retorno, remessa e outros arquivos 
--          que s�o processados e enviados para o servidor, como por 
--          exemplo arquivo de irrf. 
--
-- --
----------------------------------------------------------------------

CREATE TABLE "finfile" 
(
    "fileid"           integer, --Codigo Identificador do arquivo 
    "bankaccountid"    integer, --Conta bancaria a qual esta ligada o arquivo (finBankAccount)
    "filetype"         char(1), --Define o tipo de arquivo de conversacao. I = invoice(titulo), A =Automatic debit, M = Messages, T = Tax ( IRRF )
    "inputoroutput"    char(1), --(I) para INPUT - (Retorno), (O) para OUTPUT - (Remessa)
    "isprocessed"      boolean --Define se o arquivo foi processado ou nao
) INHERITS ("basfile");

COMMENT ON TABLE "finfile" IS 'registro de arquivos de retorno, remessa e outros arquivos que s�o processados e enviados para o servidor, como por exemplo arquivo de irrf.';
COMMENT ON COLUMN "finfile"."fileid" IS 'Codigo Identificador do arquivo ';
COMMENT ON COLUMN "finfile"."bankaccountid" IS 'Conta bancaria a qual esta ligada o arquivo (finBankAccount)';
COMMENT ON COLUMN "finfile"."filetype" IS 'Define o tipo de arquivo de conversacao. I = invoice(titulo), A =Automatic debit, M = Messages, T = Tax ( IRRF )';
COMMENT ON COLUMN "finfile"."inputoroutput" IS '(I) para INPUT - (Retorno), (O) para OUTPUT - (Remessa)';
COMMENT ON COLUMN "finfile"."isprocessed" IS 'Define se o arquivo foi processado ou nao';

ALTER TABLE "finfile" ALTER COLUMN "fileid" SET NOT NULL;
ALTER TABLE "finfile" ALTER COLUMN "filetype" SET NOT NULL;
ALTER TABLE "finfile" ALTER COLUMN "inputoroutput" SET NOT NULL;
ALTER TABLE "finfile" ALTER COLUMN "isprocessed" SET NOT NULL;
ALTER TABLE "finfile" ALTER COLUMN "isprocessed" SET DEFAULT false ;

ALTER TABLE "finfile" ALTER COLUMN "fileid" SET NOT NULL;
ALTER TABLE "finfile" ADD PRIMARY KEY ("fileid");

----------------------------------------------------------------------
-- --
--
-- Table: basaccess
-- Purpose: tabela que guarda os links que os usuarios acessaram
--
-- --
----------------------------------------------------------------------

CREATE TABLE "basaccess" 
(
    "login"           text, --Nome do usuario que efetuou o acesso
    "moduleaccess"    text, --Modulo que o usuario acessou
    "label"           text, --Rotulo
    "image"           text, --Imagem
    "handler"         text, --Handler acessado
    "isbookmark"      boolean --Se o registro e um registro dos favoritos do usuario
) INHERITS ("baslog");

COMMENT ON TABLE "basaccess" IS 'tabela que guarda os links que os usuarios acessaram';
COMMENT ON COLUMN "basaccess"."login" IS 'Nome do usuario que efetuou o acesso';
COMMENT ON COLUMN "basaccess"."moduleaccess" IS 'Modulo que o usuario acessou';
COMMENT ON COLUMN "basaccess"."label" IS 'Rotulo';
COMMENT ON COLUMN "basaccess"."image" IS 'Imagem';
COMMENT ON COLUMN "basaccess"."handler" IS 'Handler acessado';
COMMENT ON COLUMN "basaccess"."isbookmark" IS 'Se o registro e um registro dos favoritos do usuario';

ALTER TABLE "basaccess" ALTER COLUMN "login" SET NOT NULL;
ALTER TABLE "basaccess" ALTER COLUMN "moduleaccess" SET NOT NULL;
ALTER TABLE "basaccess" ALTER COLUMN "label" SET NOT NULL;
ALTER TABLE "basaccess" ALTER COLUMN "image" SET NOT NULL;
ALTER TABLE "basaccess" ALTER COLUMN "handler" SET NOT NULL;
ALTER TABLE "basaccess" ALTER COLUMN "isbookmark" SET NOT NULL;
ALTER TABLE "basaccess" ALTER COLUMN "isbookmark" SET DEFAULT FALSE ;

CREATE INDEX "idx_basaccess_count" ON "basaccess" ("login","moduleaccess","label","image","handler");
CREATE INDEX "idx_basaccess_login_isbookmark" ON "basaccess" ("login","isbookmark");

----------------------------------------------------------------------
-- --
--
-- Table: ccprule
-- Purpose: regras com os numeros de copias por categoria
--
-- --
----------------------------------------------------------------------

CREATE TABLE "ccprule" 
(
    "ruleid"            integer, --Codigo identificador da regra
    "isprofessor"       boolean, --Define se e professor ou nao
    "formationlevel"    integer, --Nivel de formacao
    "amount"            integer, --Quantidade
    "copiesnumber"      integer --Numero de copias
) INHERITS ("baslog");

COMMENT ON TABLE "ccprule" IS 'regras com os numeros de copias por categoria';
COMMENT ON COLUMN "ccprule"."ruleid" IS 'Codigo identificador da regra';
COMMENT ON COLUMN "ccprule"."isprofessor" IS 'Define se e professor ou nao';
COMMENT ON COLUMN "ccprule"."formationlevel" IS 'Nivel de formacao';
COMMENT ON COLUMN "ccprule"."amount" IS 'Quantidade';
COMMENT ON COLUMN "ccprule"."copiesnumber" IS 'Numero de copias';

CREATE SEQUENCE "seq_ruleid";
ALTER TABLE "ccprule" ALTER COLUMN "ruleid" SET DEFAULT NEXTVAL('"seq_ruleid"');
ALTER TABLE "ccprule" ALTER COLUMN "isprofessor" SET NOT NULL;
ALTER TABLE "ccprule" ALTER COLUMN "isprofessor" SET DEFAULT FALSE ;
ALTER TABLE "ccprule" ALTER COLUMN "formationlevel" SET NOT NULL;
ALTER TABLE "ccprule" ALTER COLUMN "amount" SET NOT NULL;
ALTER TABLE "ccprule" ALTER COLUMN "copiesnumber" SET NOT NULL;

ALTER TABLE "ccprule" ALTER COLUMN "ruleid" SET NOT NULL;
ALTER TABLE "ccprule" ADD PRIMARY KEY ("ruleid");

ALTER TABLE "ccprule" ADD FOREIGN KEY ("formationlevel") REFERENCES "acdformationlevel"("formationlevelid");

----------------------------------------------------------------------
-- --
--
-- Table: acdperiod
-- Purpose: periodos
--
-- --
----------------------------------------------------------------------

CREATE TABLE "acdperiod" 
(
    "periodid"          varchar(10), --Codigo do periodo
    "description"       text, --Descricao
    "enrollbookdate"    date --Campo para armazenar a data de geração do livro matrícula
) INHERITS ("baslog");

COMMENT ON TABLE "acdperiod" IS 'periodos';
COMMENT ON COLUMN "acdperiod"."periodid" IS 'Codigo do periodo';
COMMENT ON COLUMN "acdperiod"."description" IS 'Descricao';
COMMENT ON COLUMN "acdperiod"."enrollbookdate" IS 'Campo para armazenar a data de geração do livro matrícula';

ALTER TABLE "acdperiod" ALTER COLUMN "periodid" SET NOT NULL;
ALTER TABLE "acdperiod" ALTER COLUMN "description" SET NOT NULL;

ALTER TABLE "acdperiod" ALTER COLUMN "periodid" SET NOT NULL;
ALTER TABLE "acdperiod" ADD PRIMARY KEY ("periodid");

----------------------------------------------------------------------
-- --
--
-- Table: basemployeetype
-- Purpose: tipo de funcionario: estagiario, bolsista, funcionario
--
-- --
----------------------------------------------------------------------

CREATE TABLE "basemployeetype" 
(
    "employeetypeid"    integer, --Tipo de funcionario
    "description"       text --Descricao
) INHERITS ("baslog");

COMMENT ON TABLE "basemployeetype" IS 'tipo de funcionario: estagiario, bolsista, funcionario';
COMMENT ON COLUMN "basemployeetype"."employeetypeid" IS 'Tipo de funcionario';
COMMENT ON COLUMN "basemployeetype"."description" IS 'Descricao';

CREATE SEQUENCE "seq_employeetypeid";
ALTER TABLE "basemployeetype" ALTER COLUMN "employeetypeid" SET DEFAULT NEXTVAL('"seq_employeetypeid"');
ALTER TABLE "basemployeetype" ALTER COLUMN "description" SET NOT NULL;

ALTER TABLE "basemployeetype" ALTER COLUMN "employeetypeid" SET NOT NULL;
ALTER TABLE "basemployeetype" ADD PRIMARY KEY ("employeetypeid");

----------------------------------------------------------------------
-- --
--
-- Table: acdinterchangetype
-- Purpose: tipos de intercambio - estagio, missao, palestra, etc
--
-- --
----------------------------------------------------------------------

CREATE TABLE "acdinterchangetype" 
(
    "interchangetypeid"    integer, --Codigo do tipo de intercambio
    "description"          text --Descricao
) INHERITS ("baslog");

COMMENT ON TABLE "acdinterchangetype" IS 'tipos de intercambio - estagio, missao, palestra, etc';
COMMENT ON COLUMN "acdinterchangetype"."interchangetypeid" IS 'Codigo do tipo de intercambio';
COMMENT ON COLUMN "acdinterchangetype"."description" IS 'Descricao';

CREATE SEQUENCE "seq_interchangetypeid";
ALTER TABLE "acdinterchangetype" ALTER COLUMN "interchangetypeid" SET DEFAULT NEXTVAL('"seq_interchangetypeid"');
ALTER TABLE "acdinterchangetype" ALTER COLUMN "description" SET NOT NULL;

ALTER TABLE "acdinterchangetype" ALTER COLUMN "interchangetypeid" SET NOT NULL;
ALTER TABLE "acdinterchangetype" ADD PRIMARY KEY ("interchangetypeid");

----------------------------------------------------------------------
-- --
--
-- Table: acdstateenrollbook
-- Purpose: estados para geracao dos dados do livro matricula
--
-- --
----------------------------------------------------------------------

CREATE TABLE "acdstateenrollbook" 
(
    "stateenrollbookid"    integer, --Codigo do estado
    "description"          text, --Descricao
    "issumtototal"         boolean --Campo que informa se os alunos neste estado são considerados para o cálculo do numero total de alunos do curso.
) INHERITS ("baslog");

COMMENT ON TABLE "acdstateenrollbook" IS 'estados para geracao dos dados do livro matricula';
COMMENT ON COLUMN "acdstateenrollbook"."stateenrollbookid" IS 'Codigo do estado';
COMMENT ON COLUMN "acdstateenrollbook"."description" IS 'Descricao';
COMMENT ON COLUMN "acdstateenrollbook"."issumtototal" IS 'Campo que informa se os alunos neste estado são considerados para o cálculo do numero total de alunos do curso.';

CREATE SEQUENCE "seq_stateenrollbookid";
ALTER TABLE "acdstateenrollbook" ALTER COLUMN "stateenrollbookid" SET DEFAULT NEXTVAL('"seq_stateenrollbookid"');
ALTER TABLE "acdstateenrollbook" ALTER COLUMN "description" SET NOT NULL;
ALTER TABLE "acdstateenrollbook" ALTER COLUMN "issumtototal" SET NOT NULL;

ALTER TABLE "acdstateenrollbook" ALTER COLUMN "stateenrollbookid" SET NOT NULL;
ALTER TABLE "acdstateenrollbook" ADD PRIMARY KEY ("stateenrollbookid");

----------------------------------------------------------------------
-- --
--
-- Table: acdstateenrollbookrules
-- Purpose: regras das movimentacoes contratuais para geracao dos 
--          dados do livro matricula 
--
-- --
----------------------------------------------------------------------

CREATE TABLE "acdstateenrollbookrules" 
(
    "stateenrollbookrulesid"    integer, --Codigo da regra
    "stateenrollbookid"         integer, --Codigo do estado do livro matricula
    "stateidrules"              integer[] --Sequencia(em ordem) de estados a serem encontrados na tabela de movimentacao contratual, nos registros mais recentes
) INHERITS ("baslog");

COMMENT ON TABLE "acdstateenrollbookrules" IS 'regras das movimentacoes contratuais para geracao dos dados do livro matricula';
COMMENT ON COLUMN "acdstateenrollbookrules"."stateenrollbookrulesid" IS 'Codigo da regra';
COMMENT ON COLUMN "acdstateenrollbookrules"."stateenrollbookid" IS 'Codigo do estado do livro matricula';
COMMENT ON COLUMN "acdstateenrollbookrules"."stateidrules" IS 'Sequencia(em ordem) de estados a serem encontrados na tabela de movimentacao contratual, nos registros mais recentes';

CREATE SEQUENCE "seq_stateenrollbookrulesid";
ALTER TABLE "acdstateenrollbookrules" ALTER COLUMN "stateenrollbookrulesid" SET DEFAULT NEXTVAL('"seq_stateenrollbookrulesid"');
ALTER TABLE "acdstateenrollbookrules" ALTER COLUMN "stateenrollbookid" SET NOT NULL;
ALTER TABLE "acdstateenrollbookrules" ALTER COLUMN "stateidrules" SET NOT NULL;

ALTER TABLE "acdstateenrollbookrules" ALTER COLUMN "stateenrollbookrulesid" SET NOT NULL;
ALTER TABLE "acdstateenrollbookrules" ADD PRIMARY KEY ("stateenrollbookrulesid");

----------------------------------------------------------------------
-- --
--
-- Table: ccpservice
-- Purpose: servico
--
-- --
----------------------------------------------------------------------

CREATE TABLE "ccpservice" 
(
    "serviceid"       integer, --Codigo identificador do servico
    "description"     text, --Descricao do servico
    "unitaryvalue"    numeric(14, 4), --Valor unitario
    "unit"            text --Unidade
) INHERITS ("baslog");

COMMENT ON TABLE "ccpservice" IS 'servico';
COMMENT ON COLUMN "ccpservice"."serviceid" IS 'Codigo identificador do servico';
COMMENT ON COLUMN "ccpservice"."description" IS 'Descricao do servico';
COMMENT ON COLUMN "ccpservice"."unitaryvalue" IS 'Valor unitario';
COMMENT ON COLUMN "ccpservice"."unit" IS 'Unidade';

CREATE SEQUENCE "seq_serviceid";
ALTER TABLE "ccpservice" ALTER COLUMN "serviceid" SET DEFAULT NEXTVAL('"seq_serviceid"');

ALTER TABLE "ccpservice" ALTER COLUMN "serviceid" SET NOT NULL;
ALTER TABLE "ccpservice" ADD PRIMARY KEY ("serviceid");

----------------------------------------------------------------------
-- --
--
-- Table: acdproject
-- Purpose: projetos
--
-- --
----------------------------------------------------------------------

CREATE TABLE "acdproject" 
(
    "projectid"      integer, --Codigo do projeto
    "description"    text --Descricao
) INHERITS ("baslog");

COMMENT ON TABLE "acdproject" IS 'projetos';
COMMENT ON COLUMN "acdproject"."projectid" IS 'Codigo do projeto';
COMMENT ON COLUMN "acdproject"."description" IS 'Descricao';

CREATE SEQUENCE "seq_projectid";
ALTER TABLE "acdproject" ALTER COLUMN "projectid" SET DEFAULT NEXTVAL('"seq_projectid"');

ALTER TABLE "acdproject" ALTER COLUMN "projectid" SET NOT NULL;
ALTER TABLE "acdproject" ADD PRIMARY KEY ("projectid");

----------------------------------------------------------------------
-- --
--
-- Table: finoperationgroup
-- Purpose: defino o grupo de operacao (pagamento, incentivo, juros, 
--          descontos, normal) 
--
-- --
----------------------------------------------------------------------

CREATE TABLE "finoperationgroup" 
(
    "operationgroupid"    char, --Codigo identificador da grupo da operacao
    "description"         text --Texto descrevendo o grupo da operacao
) INHERITS ("baslog");

COMMENT ON TABLE "finoperationgroup" IS 'defino o grupo de operacao (pagamento, incentivo, juros, descontos, normal)';
COMMENT ON COLUMN "finoperationgroup"."operationgroupid" IS 'Codigo identificador da grupo da operacao';
COMMENT ON COLUMN "finoperationgroup"."description" IS 'Texto descrevendo o grupo da operacao';

ALTER TABLE "finoperationgroup" ALTER COLUMN "operationgroupid" SET NOT NULL;
ALTER TABLE "finoperationgroup" ALTER COLUMN "description" SET NOT NULL;

ALTER TABLE "finoperationgroup" ALTER COLUMN "operationgroupid" SET NOT NULL;
ALTER TABLE "finoperationgroup" ADD PRIMARY KEY ("operationgroupid");

----------------------------------------------------------------------
-- --
--
-- Table: basemail
-- Purpose: tabela que grava o template dos emails a serem enviados e 
--          suas configuracoes 
--
-- --
----------------------------------------------------------------------

CREATE TABLE "basemail" 
(
    "emailid"        integer, --Codigo do email
    "description"    text, --Descricao do que e este email
    "from"           text, --Remetente
    "bcc"            text, --Copia oculta
    "subject"        text, --Assunto do email
    "body"           text, --Corpo do email
    "server"         text, --servidor de envio do email
    "port"           int, --Porta de envio do email no servidor
    "mimeversion"    text, --MIME-version do email
    "contenttype"    text --Content-Type do email
) INHERITS ("baslog");

COMMENT ON TABLE "basemail" IS 'tabela que grava o template dos emails a serem enviados e suas configuracoes';
COMMENT ON COLUMN "basemail"."emailid" IS 'Codigo do email';
COMMENT ON COLUMN "basemail"."description" IS 'Descricao do que e este email';
COMMENT ON COLUMN "basemail"."from" IS 'Remetente';
COMMENT ON COLUMN "basemail"."bcc" IS 'Copia oculta';
COMMENT ON COLUMN "basemail"."subject" IS 'Assunto do email';
COMMENT ON COLUMN "basemail"."body" IS 'Corpo do email';
COMMENT ON COLUMN "basemail"."server" IS 'servidor de envio do email';
COMMENT ON COLUMN "basemail"."port" IS 'Porta de envio do email no servidor';
COMMENT ON COLUMN "basemail"."mimeversion" IS 'MIME-version do email';
COMMENT ON COLUMN "basemail"."contenttype" IS 'Content-Type do email';

CREATE SEQUENCE "seq_emailid";
ALTER TABLE "basemail" ALTER COLUMN "emailid" SET DEFAULT NEXTVAL('"seq_emailid"');
ALTER TABLE "basemail" ALTER COLUMN "description" SET NOT NULL;
ALTER TABLE "basemail" ALTER COLUMN "from" SET NOT NULL;
ALTER TABLE "basemail" ALTER COLUMN "subject" SET NOT NULL;
ALTER TABLE "basemail" ALTER COLUMN "body" SET NOT NULL;
ALTER TABLE "basemail" ALTER COLUMN "server" SET NOT NULL;
ALTER TABLE "basemail" ALTER COLUMN "port" SET NOT NULL;
ALTER TABLE "basemail" ALTER COLUMN "mimeversion" SET NOT NULL;
ALTER TABLE "basemail" ALTER COLUMN "mimeversion" SET DEFAULT '1.0' ;
ALTER TABLE "basemail" ALTER COLUMN "contenttype" SET NOT NULL;
ALTER TABLE "basemail" ALTER COLUMN "contenttype" SET DEFAULT 'text/plain; charset=iso-8859-1' ;

ALTER TABLE "basemail" ALTER COLUMN "emailid" SET NOT NULL;
ALTER TABLE "basemail" ADD PRIMARY KEY ("emailid");

----------------------------------------------------------------------
-- --
--
-- Table: accaccountinglimit
-- Purpose: contem os registros que controlam os limites contabeis, 
--          que definem quando os titulos e lancamentos ainda podem 
--          ser alterados 
--
-- --
----------------------------------------------------------------------

CREATE TABLE "accaccountinglimit" 
(
    "accountinglimitid"    integer, --Codigo do limite contabil
    "recorddate"           date, --Data que define que os lancamentos e titulos inferiores a essa data nao podem ser mais alterados
    "accountinguser"       varchar(40) --Usuario que grava a informacao
) INHERITS ("baslog");

COMMENT ON TABLE "accaccountinglimit" IS 'contem os registros que controlam os limites contabeis, que definem quando os titulos e lancamentos ainda podem ser alterados';
COMMENT ON COLUMN "accaccountinglimit"."accountinglimitid" IS 'Codigo do limite contabil';
COMMENT ON COLUMN "accaccountinglimit"."recorddate" IS 'Data que define que os lancamentos e titulos inferiores a essa data nao podem ser mais alterados';
COMMENT ON COLUMN "accaccountinglimit"."accountinguser" IS 'Usuario que grava a informacao';

CREATE SEQUENCE "seq_accountinglimitid";
ALTER TABLE "accaccountinglimit" ALTER COLUMN "accountinglimitid" SET DEFAULT NEXTVAL('"seq_accountinglimitid"');
ALTER TABLE "accaccountinglimit" ALTER COLUMN "recorddate" SET NOT NULL;
ALTER TABLE "accaccountinglimit" ALTER COLUMN "accountinguser" SET NOT NULL;

ALTER TABLE "accaccountinglimit" ALTER COLUMN "accountinglimitid" SET NOT NULL;
ALTER TABLE "accaccountinglimit" ADD PRIMARY KEY ("accountinglimitid");

----------------------------------------------------------------------
-- --
--
-- Table: basstate
-- Purpose: estados/provincias da federacao
--
-- --
----------------------------------------------------------------------

CREATE TABLE "basstate" 
(
    "stateid"      varchar(2), --Codigo do estado
    "countryid"    integer, --Codigo do pais
    "name"         varchar(50) --Nome
) INHERITS ("baslog");

COMMENT ON TABLE "basstate" IS 'estados/provincias da federacao';
COMMENT ON COLUMN "basstate"."stateid" IS 'Codigo do estado';
COMMENT ON COLUMN "basstate"."countryid" IS 'Codigo do pais';
COMMENT ON COLUMN "basstate"."name" IS 'Nome';

ALTER TABLE "basstate" ALTER COLUMN "stateid" SET NOT NULL;
ALTER TABLE "basstate" ALTER COLUMN "countryid" SET NOT NULL;
ALTER TABLE "basstate" ALTER COLUMN "name" SET NOT NULL;

ALTER TABLE "basstate" ALTER COLUMN "stateid" SET NOT NULL;
ALTER TABLE "basstate" ALTER COLUMN "countryid" SET NOT NULL;
ALTER TABLE "basstate" ADD PRIMARY KEY ("stateid","countryid");

ALTER TABLE "basstate" ADD FOREIGN KEY ("countryid") REFERENCES "bascountry"("countryid");

----------------------------------------------------------------------
-- --
--
-- Table: acdreason
-- Purpose: motivos
--
-- --
----------------------------------------------------------------------

CREATE TABLE "acdreason" 
(
    "reasonid"           integer, --Codigo do motivo
    "description"        text, --Descricao
    "statecontractid"    integer --Codigo do estado contratual
) INHERITS ("baslog");

COMMENT ON TABLE "acdreason" IS 'motivos';
COMMENT ON COLUMN "acdreason"."reasonid" IS 'Codigo do motivo';
COMMENT ON COLUMN "acdreason"."description" IS 'Descricao';
COMMENT ON COLUMN "acdreason"."statecontractid" IS 'Codigo do estado contratual';

CREATE SEQUENCE "seq_reasonid";
ALTER TABLE "acdreason" ALTER COLUMN "reasonid" SET DEFAULT NEXTVAL('"seq_reasonid"');
ALTER TABLE "acdreason" ALTER COLUMN "description" SET NOT NULL;
ALTER TABLE "acdreason" ALTER COLUMN "statecontractid" SET NOT NULL;

ALTER TABLE "acdreason" ALTER COLUMN "reasonid" SET NOT NULL;
ALTER TABLE "acdreason" ADD PRIMARY KEY ("reasonid");

ALTER TABLE "acdreason" ADD FOREIGN KEY ("statecontractid") REFERENCES "acdstatecontract"("statecontractid");

----------------------------------------------------------------------
-- --
--
-- Table: ptcrequerimentcompl
-- Purpose: informacoes complementares sobre os requerimentos
--
-- --
----------------------------------------------------------------------

CREATE TABLE "ptcrequerimentcompl" 
(
    "requerimentcomplid"    integer, --Codigo do complemento de requerimento
    "requerimentid"         integer, --Codigo do requerimento
    "requerimentfieldid"    integer, --Codigo do campo do requerimento
    "formorder"             integer --Ordem de exibicao do campo no formulario
) INHERITS ("baslog");

COMMENT ON TABLE "ptcrequerimentcompl" IS 'informacoes complementares sobre os requerimentos';
COMMENT ON COLUMN "ptcrequerimentcompl"."requerimentcomplid" IS 'Codigo do complemento de requerimento';
COMMENT ON COLUMN "ptcrequerimentcompl"."requerimentid" IS 'Codigo do requerimento';
COMMENT ON COLUMN "ptcrequerimentcompl"."requerimentfieldid" IS 'Codigo do campo do requerimento';
COMMENT ON COLUMN "ptcrequerimentcompl"."formorder" IS 'Ordem de exibicao do campo no formulario';

CREATE SEQUENCE "seq_requerimentcomplid";
ALTER TABLE "ptcrequerimentcompl" ALTER COLUMN "requerimentcomplid" SET DEFAULT NEXTVAL('"seq_requerimentcomplid"');
ALTER TABLE "ptcrequerimentcompl" ALTER COLUMN "requerimentid" SET NOT NULL;
ALTER TABLE "ptcrequerimentcompl" ALTER COLUMN "requerimentfieldid" SET NOT NULL;
ALTER TABLE "ptcrequerimentcompl" ALTER COLUMN "formorder" SET DEFAULT 1;

ALTER TABLE "ptcrequerimentcompl" ALTER COLUMN "requerimentcomplid" SET NOT NULL;
ALTER TABLE "ptcrequerimentcompl" ADD PRIMARY KEY ("requerimentcomplid");

ALTER TABLE "ptcrequerimentcompl" ADD FOREIGN KEY ("requerimentid") REFERENCES "ptcrequeriment"("requerimentid");

ALTER TABLE "ptcrequerimentcompl" ADD FOREIGN KEY ("requerimentfieldid") REFERENCES "ptcrequerimentfield"("requerimentfieldid");

----------------------------------------------------------------------
-- --
--
-- Table: acdstatecontractfield
-- Purpose: campos dos estados
--
-- --
----------------------------------------------------------------------

CREATE TABLE "acdstatecontractfield" 
(
    "statecontractfieldid"    integer, --Codigo do campo
    "statecontractid"         integer, --Codigo do estado
    "description"             text, --Descricao
    "rows"                    integer, --Numero de linhas
    "columns"                 integer, --Numero de colunas
    "islookup"                boolean, --Tipo de campo no formulario
    "lookupname"              text, --Nome do metodo do lookup
    "lookupmodule"            text, --Nome do modulo onde devera ser buscado o lookup
    "fieldvalidator"          varchar(50), --Validador de campos do Miolo
    "isrequired"              boolean --Se o campo e obrigatohrio
) INHERITS ("baslog");

COMMENT ON TABLE "acdstatecontractfield" IS 'campos dos estados';
COMMENT ON COLUMN "acdstatecontractfield"."statecontractfieldid" IS 'Codigo do campo';
COMMENT ON COLUMN "acdstatecontractfield"."statecontractid" IS 'Codigo do estado';
COMMENT ON COLUMN "acdstatecontractfield"."description" IS 'Descricao';
COMMENT ON COLUMN "acdstatecontractfield"."rows" IS 'Numero de linhas';
COMMENT ON COLUMN "acdstatecontractfield"."columns" IS 'Numero de colunas';
COMMENT ON COLUMN "acdstatecontractfield"."islookup" IS 'Tipo de campo no formulario';
COMMENT ON COLUMN "acdstatecontractfield"."lookupname" IS 'Nome do metodo do lookup';
COMMENT ON COLUMN "acdstatecontractfield"."lookupmodule" IS 'Nome do modulo onde devera ser buscado o lookup';
COMMENT ON COLUMN "acdstatecontractfield"."fieldvalidator" IS 'Validador de campos do Miolo';
COMMENT ON COLUMN "acdstatecontractfield"."isrequired" IS 'Se o campo e obrigatohrio';

CREATE SEQUENCE "seq_statecontractfieldid";
ALTER TABLE "acdstatecontractfield" ALTER COLUMN "statecontractfieldid" SET DEFAULT NEXTVAL('"seq_statecontractfieldid"');
ALTER TABLE "acdstatecontractfield" ALTER COLUMN "statecontractid" SET NOT NULL;
ALTER TABLE "acdstatecontractfield" ALTER COLUMN "description" SET NOT NULL;
ALTER TABLE "acdstatecontractfield" ALTER COLUMN "columns" SET DEFAULT 20;
ALTER TABLE "acdstatecontractfield" ALTER COLUMN "islookup" SET NOT NULL;
ALTER TABLE "acdstatecontractfield" ALTER COLUMN "islookup" SET DEFAULT FALSE ;
ALTER TABLE "acdstatecontractfield" ALTER COLUMN "isrequired" SET NOT NULL;
ALTER TABLE "acdstatecontractfield" ALTER COLUMN "isrequired" SET DEFAULT FALSE ;

ALTER TABLE "acdstatecontractfield" ALTER COLUMN "statecontractfieldid" SET NOT NULL;
ALTER TABLE "acdstatecontractfield" ADD PRIMARY KEY ("statecontractfieldid");

ALTER TABLE "acdstatecontractfield" ADD FOREIGN KEY ("statecontractid") REFERENCES "acdstatecontract"("statecontractid");

----------------------------------------------------------------------
-- --
--
-- Table: acdstatetransition
-- Purpose: transicao de estados
--
-- --
----------------------------------------------------------------------

CREATE TABLE "acdstatetransition" 
(
    "beginstateid"    integer, --Estado inicial
    "endstateid"      integer --Estado final
) INHERITS ("baslog");

COMMENT ON TABLE "acdstatetransition" IS 'transicao de estados';
COMMENT ON COLUMN "acdstatetransition"."beginstateid" IS 'Estado inicial';
COMMENT ON COLUMN "acdstatetransition"."endstateid" IS 'Estado final';

ALTER TABLE "acdstatetransition" ALTER COLUMN "beginstateid" SET NOT NULL;
ALTER TABLE "acdstatetransition" ALTER COLUMN "endstateid" SET NOT NULL;

ALTER TABLE "acdstatetransition" ALTER COLUMN "beginstateid" SET NOT NULL;
ALTER TABLE "acdstatetransition" ALTER COLUMN "endstateid" SET NOT NULL;
ALTER TABLE "acdstatetransition" ADD PRIMARY KEY ("beginstateid","endstateid");

ALTER TABLE "acdstatetransition" ADD FOREIGN KEY ("beginstateid") REFERENCES "acdstatecontract"("statecontractid");

ALTER TABLE "acdstatetransition" ADD FOREIGN KEY ("endstateid") REFERENCES "acdstatecontract"("statecontractid");

----------------------------------------------------------------------
-- --
--
-- Table: finoperation
-- Purpose: operacoes. identificam a natureza de um lan�amento ou 
--          previs�o (d�bito ou cr�dito) 
--
-- --
----------------------------------------------------------------------

CREATE TABLE "finoperation" 
(
    "operationid"          integer, --Codigo identificador da operacao
    "description"          text, --Texto descrevendo a operacao
    "operationtypeid"      char(1), --Debito (D) ou credito (C)
    "isextinct"            boolean, --Define se uma operacao esta extinta ou nao
    "iscountermovement"    boolean, --Se essa operacao tera ou nao movimentacao de caixa
    "operationgroupid"     char --Codigo identificador do grupo da operacao
) INHERITS ("baslog");

COMMENT ON TABLE "finoperation" IS 'operacoes. identificam a natureza de um lan�amento ou previs�o (d�bito ou cr�dito)';
COMMENT ON COLUMN "finoperation"."operationid" IS 'Codigo identificador da operacao';
COMMENT ON COLUMN "finoperation"."description" IS 'Texto descrevendo a operacao';
COMMENT ON COLUMN "finoperation"."operationtypeid" IS 'Debito (D) ou credito (C)';
COMMENT ON COLUMN "finoperation"."isextinct" IS 'Define se uma operacao esta extinta ou nao';
COMMENT ON COLUMN "finoperation"."iscountermovement" IS 'Se essa operacao tera ou nao movimentacao de caixa';
COMMENT ON COLUMN "finoperation"."operationgroupid" IS 'Codigo identificador do grupo da operacao';

CREATE SEQUENCE "seq_operationid";
ALTER TABLE "finoperation" ALTER COLUMN "operationid" SET DEFAULT NEXTVAL('"seq_operationid"');
ALTER TABLE "finoperation" ALTER COLUMN "description" SET NOT NULL;
ALTER TABLE "finoperation" ALTER COLUMN "operationtypeid" SET NOT NULL;
ALTER TABLE "finoperation" ALTER COLUMN "isextinct" SET NOT NULL;
ALTER TABLE "finoperation" ALTER COLUMN "isextinct" SET DEFAULT FALSE ;
ALTER TABLE "finoperation" ALTER COLUMN "iscountermovement" SET NOT NULL;
ALTER TABLE "finoperation" ALTER COLUMN "iscountermovement" SET DEFAULT FALSE ;
ALTER TABLE "finoperation" ALTER COLUMN "operationgroupid" SET NOT NULL;

ALTER TABLE "finoperation" ALTER COLUMN "operationid" SET NOT NULL;
ALTER TABLE "finoperation" ADD PRIMARY KEY ("operationid");
ALTER TABLE finOperation add bankAccountId integer;
ALTER TABLE finOperation add bankContractId integer;
ALTER TABLE finOperation ADD FOREIGN KEY (bankAccountId, bankContractId) REFERENCES finBankAccountContract (bankAccountId, bankContractId);
ALTER TABLE finOperation ADD receivableOrPayable CHAR;
COMMENT ON COLUMN finOperation.receivableOrPayable IS 'Campo que indica se a opera��o � para o contas a receber ou contas a pagar. Valores poss�vel R ou P';

----------------------------------------------------------------------
-- --
--
-- Table: finpolicy
-- Purpose: politicas., regras de negocio do financeiro. antiga tabela 
--          origens (sagu1). 
--
-- --
----------------------------------------------------------------------

CREATE TABLE "finpolicy" 
(
    "policyid"                  integer, --Codigo identificador da politica
    "description"               text, --Descricao da politica
    "bankoperationtypecode"     integer, --Codigo da carteira, fornecido pela agencia bancaria
    "operationid"               integer, --Codigo identificador da operacao padrao para matriculas de cursos que seguem esta politica
    "collectiontypeid"          integer, --Codigo identificador do tipo de cobranca (finCollectionType)
    "monthlyinterestpercent"    float, --Percentual de juros a serem cobrados no mes
    "finepercent"               float, --Percentual cobrado em caso de multa
    "daystointerest"            integer, --A partir de quantos dias sera cobrado juro
    "daystofine"                integer, --A partir de quantos dias sera cobrada multa
    "daystodiscount"            integer, --Dias para desconto
    "daystoprotest"             integer, --A partir de quantos dias sera protestado o titulo
    "discountpercent"           float, --Percentual de desconto
    "banktaxvalue"              numeric(14,4), --Valor da taxa bancaria
    "isextinct"                 boolean --Define se a politica esta ou nao ativa
) INHERITS ("baslog");

COMMENT ON TABLE "finpolicy" IS 'politicas., regras de negocio do financeiro. antiga tabela origens (sagu1).';
COMMENT ON COLUMN "finpolicy"."policyid" IS 'Codigo identificador da politica';
COMMENT ON COLUMN "finpolicy"."description" IS 'Descricao da politica';
COMMENT ON COLUMN "finpolicy"."bankoperationtypecode" IS 'Codigo da carteira, fornecido pela agencia bancaria';
COMMENT ON COLUMN "finpolicy"."operationid" IS 'Codigo identificador da operacao padrao para matriculas de cursos que seguem esta politica';
COMMENT ON COLUMN "finpolicy"."collectiontypeid" IS 'Codigo identificador do tipo de cobranca (finCollectionType)';
COMMENT ON COLUMN "finpolicy"."monthlyinterestpercent" IS 'Percentual de juros a serem cobrados no mes';
COMMENT ON COLUMN "finpolicy"."finepercent" IS 'Percentual cobrado em caso de multa';
COMMENT ON COLUMN "finpolicy"."daystointerest" IS 'A partir de quantos dias sera cobrado juro';
COMMENT ON COLUMN "finpolicy"."daystofine" IS 'A partir de quantos dias sera cobrada multa';
COMMENT ON COLUMN "finpolicy"."daystodiscount" IS 'Dias para desconto';
COMMENT ON COLUMN "finpolicy"."daystoprotest" IS 'A partir de quantos dias sera protestado o titulo';
COMMENT ON COLUMN "finpolicy"."discountpercent" IS 'Percentual de desconto';
COMMENT ON COLUMN "finpolicy"."banktaxvalue" IS 'Valor da taxa bancaria';
COMMENT ON COLUMN "finpolicy"."isextinct" IS 'Define se a politica esta ou nao ativa';

CREATE SEQUENCE "seq_policyid";
ALTER TABLE "finpolicy" ALTER COLUMN "policyid" SET DEFAULT NEXTVAL('"seq_policyid"');
ALTER TABLE "finpolicy" ALTER COLUMN "description" SET NOT NULL;
ALTER TABLE "finpolicy" ALTER COLUMN "bankoperationtypecode" SET NOT NULL;
ALTER TABLE "finpolicy" ALTER COLUMN "operationid" SET NOT NULL;
ALTER TABLE "finpolicy" ALTER COLUMN "collectiontypeid" SET NOT NULL;
ALTER TABLE "finpolicy" ALTER COLUMN "monthlyinterestpercent" SET NOT NULL;
ALTER TABLE "finpolicy" ALTER COLUMN "finepercent" SET NOT NULL;
ALTER TABLE "finpolicy" ALTER COLUMN "daystointerest" SET NOT NULL;
ALTER TABLE "finpolicy" ALTER COLUMN "daystofine" SET NOT NULL;
ALTER TABLE "finpolicy" ALTER COLUMN "daystodiscount" SET NOT NULL;
ALTER TABLE "finpolicy" ALTER COLUMN "daystoprotest" SET NOT NULL;
ALTER TABLE "finpolicy" ALTER COLUMN "discountpercent" SET NOT NULL;
ALTER TABLE "finpolicy" ALTER COLUMN "banktaxvalue" SET NOT NULL;
ALTER TABLE "finpolicy" ALTER COLUMN "isextinct" SET NOT NULL;
ALTER TABLE "finpolicy" ALTER COLUMN "isextinct" SET DEFAULT FALSE ;

ALTER TABLE "finpolicy" ALTER COLUMN "policyid" SET NOT NULL;
ALTER TABLE "finpolicy" ADD PRIMARY KEY ("policyid");

ALTER TABLE "finpolicy" ADD FOREIGN KEY ("operationid") REFERENCES "finoperation"("operationid");

ALTER TABLE "finpolicy" ADD FOREIGN KEY ("collectiontypeid") REFERENCES "fincollectiontype"("collectiontypeid");

ALTER TABLE finPolicy ADD COLUMN useFineCompositive boolean DEFAULT true;
ALTER TABLE finPolicy ALTER useFineCompositive SET NOT NULL;
COMMENT ON COLUMN finPolicy.useFineCompositive IS 'Se true, indica que a funcao balanceWithPolicies utilizar� juros compostos, caso contrario os juros ser�o simples';
ALTER TABLE finPolicy RENAME monthlyInterestPercent TO monthlyInterest;
ALTER TABLE finPolicy ADD isMonthlyInterestInPercent boolean DEFAULT true;
COMMENT ON COLUMN finPolicy.isMonthlyInterestInPercent IS 'Indica se a multa ao m�s ser� em percentual ou em um valor fixo';
ALTER TABLE finPolicy ALTER isMonthlyInterestInPercent set NOT NULL;

ALTER TABLE finPolicy RENAME finePercent TO fine;
ALTER TABLE finPolicy ADD isFineInPercent boolean DEFAULT true;
COMMENT ON COLUMN finPolicy.isFineInPercent IS 'Indica se ser� cobrado juros de mora em taxa (mensal) ou em valor (di�rio)';
ALTER TABLE finPolicy ALTER isFineInPercent set NOT NULL;

ALTER TABLE finPolicy RENAME discountPercent TO discount;
ALTER TABLE finPolicy ADD isDiscountInPercent boolean DEFAULT true;
COMMENT ON COLUMN finPolicy.isDiscountInPercent IS 'Indica se o desconto ser� em percentual ou em um valor fixo';
ALTER TABLE finPolicy ALTER isDiscountInPercent set NOT NULL;

ALTER TABLE finPolicy ADD isFineInOriginalValue boolean DEFAULT true;
COMMENT ON COLUMN finPolicy.isFineInOriginalValue IS 'Se true, calcula a multa pelo valor nominal do t�tulo, caso false, calcula sobre o valor corrigido';
ALTER TABLE finPolicy ALTER isFineInOriginalValue set NOT NULL;

ALTER TABLE finPolicy ADD isBankTaxValueInPercent boolean DEFAULT false;
COMMENT ON COLUMN finPolicy.isBankTaxValueInPercent IS 'Verifica se vai ser aplicado valor em porcentagem ou em valor para inclusao no titulo';
ALTER TABLE finPolicy ALTER isBankTaxValueInPercent set NOT NULL;

alter table finpolicy add calculateValueWithMaturiyDate boolean default true;
COMMENT ON COLUMN finpolicy.calculateValueWithMaturiyDate IS 'Indica se as multas e juros ser�o calculados com a data de vencimento ou a data de vencimento + os dias de jurous ou multa';


----------------------------------------------------------------------
-- --
--
-- Table: finmessage
-- Purpose: cadastro de mensagens que poderao compor os boletos 
--          bancarios, tais como "pagavel ate o dia x em qualquer 
--          agencia bancaria.". 
--
-- --
----------------------------------------------------------------------

CREATE TABLE "finmessage" 
(
    "bankid"              varchar(3), --Codigo identificador do banco (finBank)
    "policyid"            integer, --Politica que ser� aplica as mensagens
    "messageprotest"      varchar(255), --Mensagem para protesto
    "messagediscount"     varchar(255), --Mensagem para desconto
    "messagefine"         varchar(255), --Mensagem para multa ou juros
    "messagebank"         varchar(255) --Mensagem do banco ex.: "PAGAVEL PREFERENCIALMENTE NO BANCO XXX"
) INHERITS ("baslog");

COMMENT ON TABLE "finmessage" IS 'cadastro de mensagens que poderao compor os boletos bancarios, tais como "pagavel ate o dia x em qualquer agencia bancaria.".';
COMMENT ON COLUMN "finmessage"."bankid" IS 'Codigo identificador do banco (finBank)';
COMMENT ON COLUMN "finmessage"."policyid" IS 'Politica que ser� aplica as mensagens';
COMMENT ON COLUMN "finmessage"."messageprotest" IS 'Mensagem para protesto';
COMMENT ON COLUMN "finmessage"."messagediscount" IS 'Mensagem para desconto';
COMMENT ON COLUMN "finmessage"."messagefine" IS 'Mensagem para multa ou juros';
COMMENT ON COLUMN "finmessage"."messagebank" IS 'Mensagem do banco ex.: "PAGAVEL PREFERENCIALMENTE NO BANCO XXX"';

ALTER TABLE "finmessage" ALTER COLUMN "bankid" SET NOT NULL;
ALTER TABLE "finmessage" ALTER COLUMN "policyid" SET NOT NULL;

ALTER TABLE "finmessage" ADD PRIMARY KEY ("bankid","policyid");

ALTER TABLE "finmessage" ADD FOREIGN KEY ("bankid") REFERENCES "finbank"("bankid");
ALTER TABLE "finmessage" ADD FOREIGN KEY ("policyid") REFERENCES "finpolicy" ("policyid");


----------------------------------------------------------------------
-- --
--
-- Table: bascity
-- Purpose: cidades
--
-- --
----------------------------------------------------------------------

CREATE TABLE "bascity" 
(
    "cityid"       integer, --Codigo da cidade
    "name"         text, --Nome
    "zipcode"      varchar(9), --CEP
    "stateid"      varchar(2), --Codigo do estado/provincia da federacao
    "countryid"    integer --Codigo do pais
) INHERITS ("baslog");

COMMENT ON TABLE "bascity" IS 'cidades';
COMMENT ON COLUMN "bascity"."cityid" IS 'Codigo da cidade';
COMMENT ON COLUMN "bascity"."name" IS 'Nome';
COMMENT ON COLUMN "bascity"."zipcode" IS 'CEP';
COMMENT ON COLUMN "bascity"."stateid" IS 'Codigo do estado/provincia da federacao';
COMMENT ON COLUMN "bascity"."countryid" IS 'Codigo do pais';

CREATE SEQUENCE "seq_cityid";
ALTER TABLE "bascity" ALTER COLUMN "cityid" SET DEFAULT NEXTVAL('"seq_cityid"');
ALTER TABLE "bascity" ALTER COLUMN "name" SET NOT NULL;
ALTER TABLE "bascity" ALTER COLUMN "zipcode" SET NOT NULL;
ALTER TABLE "bascity" ALTER COLUMN "stateid" SET NOT NULL;
ALTER TABLE "bascity" ALTER COLUMN "countryid" SET NOT NULL;

ALTER TABLE "bascity" ALTER COLUMN "cityid" SET NOT NULL;
ALTER TABLE "bascity" ADD PRIMARY KEY ("cityid");

ALTER TABLE "bascity" ADD FOREIGN KEY ("stateid","countryid") REFERENCES "basstate"("stateid","countryid");

----------------------------------------------------------------------
-- --
--
-- Table: rshquestion
-- Purpose: questoes/topicos
--
-- --
----------------------------------------------------------------------

CREATE TABLE "rshquestion" 
(
    "questionid"            integer, --Codigo da questao
    "formid"                integer, --Codigo do questionario
    "questioncategoryid"    integer, --Codigo da categoria de questao
    "description"           text, --Descricao
    "ismulti"               boolean --Se e de multipla escolha
) INHERITS ("baslog");

COMMENT ON TABLE "rshquestion" IS 'questoes/topicos';
COMMENT ON COLUMN "rshquestion"."questionid" IS 'Codigo da questao';
COMMENT ON COLUMN "rshquestion"."formid" IS 'Codigo do questionario';
COMMENT ON COLUMN "rshquestion"."questioncategoryid" IS 'Codigo da categoria de questao';
COMMENT ON COLUMN "rshquestion"."description" IS 'Descricao';
COMMENT ON COLUMN "rshquestion"."ismulti" IS 'Se e de multipla escolha';

CREATE SEQUENCE "seq_questionid";
ALTER TABLE "rshquestion" ALTER COLUMN "questionid" SET DEFAULT NEXTVAL('"seq_questionid"');
ALTER TABLE "rshquestion" ALTER COLUMN "formid" SET NOT NULL;
ALTER TABLE "rshquestion" ALTER COLUMN "questioncategoryid" SET NOT NULL;
ALTER TABLE "rshquestion" ALTER COLUMN "description" SET NOT NULL;
ALTER TABLE "rshquestion" ALTER COLUMN "ismulti" SET NOT NULL;
ALTER TABLE "rshquestion" ALTER COLUMN "ismulti" SET DEFAULT FALSE ;

ALTER TABLE "rshquestion" ALTER COLUMN "questionid" SET NOT NULL;
ALTER TABLE "rshquestion" ADD PRIMARY KEY ("questionid");

ALTER TABLE "rshquestion" ADD FOREIGN KEY ("formid") REFERENCES "rshform"("formid");

ALTER TABLE "rshquestion" ADD FOREIGN KEY ("questioncategoryid") REFERENCES "rshquestioncategory"("questioncategoryid");

----------------------------------------------------------------------
-- --
--
-- Table: finvouchermessages
-- Purpose: mensagens para os demonstrativos financeiros, comprovantes 
--          genericos 
--
-- --
----------------------------------------------------------------------

CREATE TABLE "finvouchermessages" 
(
    "operationid"    integer, --Codigo identificador da operacao
    "title"          text, --Titulo do demostrativo
    "message"        text --Mensagem do demostrativo
) INHERITS ("baslog");

COMMENT ON TABLE "finvouchermessages" IS 'mensagens para os demonstrativos financeiros, comprovantes genericos';
COMMENT ON COLUMN "finvouchermessages"."operationid" IS 'Codigo identificador da operacao';
COMMENT ON COLUMN "finvouchermessages"."title" IS 'Titulo do demostrativo';
COMMENT ON COLUMN "finvouchermessages"."message" IS 'Mensagem do demostrativo';

ALTER TABLE "finvouchermessages" ALTER COLUMN "operationid" SET NOT NULL;
ALTER TABLE "finvouchermessages" ALTER COLUMN "title" SET NOT NULL;
ALTER TABLE "finvouchermessages" ALTER COLUMN "message" SET NOT NULL;

ALTER TABLE "finvouchermessages" ALTER COLUMN "operationid" SET NOT NULL;
ALTER TABLE "finvouchermessages" ADD PRIMARY KEY ("operationid");

ALTER TABLE "finvouchermessages" ADD FOREIGN KEY ("operationid") REFERENCES "finoperation"("operationid");

----------------------------------------------------------------------
-- --
--
-- Table: findefaultoperations
-- Purpose: operacoes padrao
--
-- --
----------------------------------------------------------------------

CREATE TABLE "findefaultoperations" 
(
    "addcurricularcomponentoperation"       integer, --Operacao para acrescimos de disciplina
    "cancelcurricularcomponentoperation"    integer, --Operacao para retirada de disciplinas (Credito)
    "protocoloperation"                     integer, --Operacao para pagamento de protocolos
    "interestoperation"                     integer, --Operacao para juros
    "discountoperation"                     integer, --Operacao para descontos
    "libraryfineoperation"                  integer, --Operacao para multas da biblioteca
    "closeincomeforecastoperation"          integer, --Operacao para fechamento de previsoes
    "enrolloperation"                       integer, --Operacao para geracao de mensalidades
    "paymentoperation"                      integer, --Operacao para pagamento de titulos (fechamento)
    "agreementoperation"                    integer, --Operacao para acordos amigaveis
    "banktaxoperation"                      integer, --Operacao para operacao de taxas bancarias.
    "selectiveprocesstaxoperation"          int, --Operacao utilizada para cobranca de processos seletivos 
    "bankclosingtaxoperation"               integer --Operacao para Fechamento de taxas bancarias.
) INHERITS ("baslog");

COMMENT ON TABLE "findefaultoperations" IS 'operacoes padrao';
COMMENT ON COLUMN "findefaultoperations"."addcurricularcomponentoperation" IS 'Operacao para acrescimos de disciplina';
COMMENT ON COLUMN "findefaultoperations"."cancelcurricularcomponentoperation" IS 'Operacao para retirada de disciplinas (Credito)';
COMMENT ON COLUMN "findefaultoperations"."protocoloperation" IS 'Operacao para pagamento de protocolos';
COMMENT ON COLUMN "findefaultoperations"."interestoperation" IS 'Operacao para juros';
COMMENT ON COLUMN "findefaultoperations"."discountoperation" IS 'Operacao para descontos';
COMMENT ON COLUMN "findefaultoperations"."libraryfineoperation" IS 'Operacao para multas da biblioteca';
COMMENT ON COLUMN "findefaultoperations"."closeincomeforecastoperation" IS 'Operacao para fechamento de previsoes';
COMMENT ON COLUMN "findefaultoperations"."enrolloperation" IS 'Operacao para geracao de mensalidades';
COMMENT ON COLUMN "findefaultoperations"."paymentoperation" IS 'Operacao para pagamento de titulos (fechamento)';
COMMENT ON COLUMN "findefaultoperations"."agreementoperation" IS 'Operacao para acordos amigaveis';
COMMENT ON COLUMN "findefaultoperations"."banktaxoperation" IS 'Operacao para operacao de taxas bancarias.';
COMMENT ON COLUMN "findefaultoperations"."selectiveprocesstaxoperation" IS 'Operacao utilizada para cobranca de processos seletivos ';
COMMENT ON COLUMN "findefaultoperations"."bankclosingtaxoperation" IS 'Operacao para Fechamento de taxas bancarias.';

ALTER TABLE "findefaultoperations" ADD FOREIGN KEY ("addcurricularcomponentoperation") REFERENCES "finoperation"("operationid");

ALTER TABLE "findefaultoperations" ADD FOREIGN KEY ("cancelcurricularcomponentoperation") REFERENCES "finoperation"("operationid");

ALTER TABLE "findefaultoperations" ADD FOREIGN KEY ("protocoloperation") REFERENCES "finoperation"("operationid");

ALTER TABLE "findefaultoperations" ADD FOREIGN KEY ("interestoperation") REFERENCES "finoperation"("operationid");

ALTER TABLE "findefaultoperations" ADD FOREIGN KEY ("discountoperation") REFERENCES "finoperation"("operationid");

ALTER TABLE "findefaultoperations" ADD FOREIGN KEY ("libraryfineoperation") REFERENCES "finoperation"("operationid");

ALTER TABLE "findefaultoperations" ADD FOREIGN KEY ("libraryfineoperation") REFERENCES "finoperation"("operationid");

ALTER TABLE "findefaultoperations" ADD FOREIGN KEY ("closeincomeforecastoperation") REFERENCES "finoperation"("operationid");

ALTER TABLE "findefaultoperations" ADD FOREIGN KEY ("enrolloperation") REFERENCES "finoperation"("operationid");

ALTER TABLE "findefaultoperations" ADD FOREIGN KEY ("paymentoperation") REFERENCES "finoperation"("operationid");

ALTER TABLE "findefaultoperations" ADD FOREIGN KEY ("agreementoperation") REFERENCES "finoperation"("operationid");

ALTER TABLE "findefaultoperations" ADD FOREIGN KEY ("banktaxoperation") REFERENCES "finoperation"("operationid");

ALTER TABLE "findefaultoperations" ADD FOREIGN KEY ("selectiveprocesstaxoperation") REFERENCES "finoperation"("operationid");

ALTER TABLE "findefaultoperations" ADD FOREIGN KEY ("bankclosingtaxoperation") REFERENCES "finoperation"("operationid");

ALTER TABLE finDefaultOperations ADD enrollTaxOperation int references finOperation(operationId);
COMMENT ON COLUMN finDefaultOperations.enrollTaxOperation IS 'Opera��o padr�o para as taxas de matr�cula';
CREATE INDEX idx_findefaultoperations_enrolltaxoperation on findefaultoperations(enrolltaxoperation);
alter table findefaultoperations add column fineOperation integer REFERENCES finOperation(operationid);
ALTER TABLE findefaultoperations ALTER fineOperation SET NOT NULL;
COMMENT ON COLUMN findefaultoperations.agreementOperation IS 'Este campo vai ter a opera��o padr�o de fechamento do t�tulo num acordo. Opera��o de CR�DITO';
ALTER TABLE finDefaultOperations ADD agreementOperationToNewInvoice integer;
COMMENT ON COLUMN findefaultoperations.agreementOperationToNewInvoice IS 'Este campo vai ter a opera��o padr�o de cria��o do t�tulo novo gerado a partir acordo. Opera��o de D�BITO';
ALTER TABLE findefaultoperations ALTER fineOperation SET NOT NULL;

----------------------------------------------------------------------
-- --
--
-- Table: finbankaccount
-- Purpose: contas bancarias da instituicao
--
-- --
----------------------------------------------------------------------

CREATE TABLE "finbankaccount" 
(
    "bankaccountid"         integer, --Codigo da conta bancaria no SAGU
    "description"           text, --Descricao da conta bancaria
    "accountnumber"         varchar(30), --Numero da conta bancaria
    "accountnumberdigit"    varchar(2), --Digito verificador do numero da conta
    "branchnumber"          varchar(30), --Numero da agencia
    "branchnumberdigit"     varchar(2), --Digito verificador da agencia
    "bankid"                varchar(3), --Codigo do banco (finBank)
    "assignorcode"          varchar(40), --Numero definido pelo banco para composicao dos boletos e arquivos de remessa
    "wallet"                varchar(3) --Carteira: utillizado na remessa de arquivos bancarios
) INHERITS ("baslog");

COMMENT ON TABLE "finbankaccount" IS 'contas bancarias da instituicao';
COMMENT ON COLUMN "finbankaccount"."bankaccountid" IS 'Codigo da conta bancaria no SAGU';
COMMENT ON COLUMN "finbankaccount"."description" IS 'Descricao da conta bancaria';
COMMENT ON COLUMN "finbankaccount"."accountnumber" IS 'Numero da conta bancaria';
COMMENT ON COLUMN "finbankaccount"."accountnumberdigit" IS 'Digito verificador do numero da conta';
COMMENT ON COLUMN "finbankaccount"."branchnumber" IS 'Numero da agencia';
COMMENT ON COLUMN "finbankaccount"."branchnumberdigit" IS 'Digito verificador da agencia';
COMMENT ON COLUMN "finbankaccount"."bankid" IS 'Codigo do banco (finBank)';
COMMENT ON COLUMN "finbankaccount"."assignorcode" IS 'Numero definido pelo banco para composicao dos boletos e arquivos de remessa';
COMMENT ON COLUMN "finbankaccount"."wallet" IS 'Carteira: utillizado na remessa de arquivos bancarios';

CREATE SEQUENCE "seq_bankaccountid";
ALTER TABLE "finbankaccount" ALTER COLUMN "bankaccountid" SET DEFAULT NEXTVAL('"seq_bankaccountid"');
ALTER TABLE "finbankaccount" ALTER COLUMN "description" SET NOT NULL;
ALTER TABLE "finbankaccount" ALTER COLUMN "accountnumber" SET NOT NULL;
ALTER TABLE "finbankaccount" ALTER COLUMN "branchnumber" SET NOT NULL;

ALTER TABLE "finbankaccount" ALTER COLUMN "bankaccountid" SET NOT NULL;
ALTER TABLE "finbankaccount" ADD PRIMARY KEY ("bankaccountid");

ALTER TABLE "finbankaccount" ADD FOREIGN KEY ("bankid") REFERENCES "finbank"("bankid");

----------------------------------------------------------------------
-- --
--
-- Table: finbankaccountmovement
-- Purpose: movimentacao das contas correntes - arquivo ofc do banco 
--          (extrato da conta) 
--
-- --
----------------------------------------------------------------------

CREATE TABLE "finbankaccountmovement" 
(
    "bankaccountid"    integer, --Codigo da conta bancaria (finBankAccount)
    "datemovement"     date, --Data de movimentacao do valor atual
    "value"            numeric(14,4), --Valor da movimentacao
    "operation"        char(1) --Credito (C) ou Debito (D)
) INHERITS ("baslog");

COMMENT ON TABLE "finbankaccountmovement" IS 'movimentacao das contas correntes - arquivo ofc do banco (extrato da conta)';
COMMENT ON COLUMN "finbankaccountmovement"."bankaccountid" IS 'Codigo da conta bancaria (finBankAccount)';
COMMENT ON COLUMN "finbankaccountmovement"."datemovement" IS 'Data de movimentacao do valor atual';
COMMENT ON COLUMN "finbankaccountmovement"."value" IS 'Valor da movimentacao';
COMMENT ON COLUMN "finbankaccountmovement"."operation" IS 'Credito (C) ou Debito (D)';

ALTER TABLE "finbankaccountmovement" ALTER COLUMN "bankaccountid" SET NOT NULL;
ALTER TABLE "finbankaccountmovement" ALTER COLUMN "datemovement" SET NOT NULL;
ALTER TABLE "finbankaccountmovement" ALTER COLUMN "value" SET NOT NULL;
ALTER TABLE "finbankaccountmovement" ALTER COLUMN "operation" SET NOT NULL;

ALTER TABLE "finbankaccountmovement" ADD FOREIGN KEY ("bankaccountid") REFERENCES "finbankaccount"("bankaccountid");

----------------------------------------------------------------------
-- --
--
-- Table: accintegration
-- Purpose: contem os registros necessarios para a integracao com o 
--          siga 
--
-- --
----------------------------------------------------------------------

CREATE TABLE "accintegration" 
(
    "accintegrationid"        integer, --Codigo identificador da integracao
    "operationid"             integer, --Codigo identificador da operacao
    "operationtypeid"         char(1), --Define se a operacao eh debito ou credito
    "debitaccount"            varchar(20), --plano de contas ou mascara para plano de contas se a operacao for debito
    "creditaccount"           varchar(20), --plano de contas ou mascara para plano de contas se a operacao for credito
    "externalentryid"         integer, --Codigo identificador do lancamento para o SIGA
    "operationdescription"    varchar(40), --Descricao da operacao para o SIGA
    "debitcostcenter"         varchar(30), --Centro de custo se a operacao for debito
    "creditcostcenter"        varchar(30) --Centro de custo se a operacao for credito
) INHERITS ("baslog");

COMMENT ON TABLE "accintegration" IS 'contem os registros necessarios para a integracao com o siga';
COMMENT ON COLUMN "accintegration"."accintegrationid" IS 'Codigo identificador da integracao';
COMMENT ON COLUMN "accintegration"."operationid" IS 'Codigo identificador da operacao';
COMMENT ON COLUMN "accintegration"."operationtypeid" IS 'Define se a operacao eh debito ou credito';
COMMENT ON COLUMN "accintegration"."debitaccount" IS 'plano de contas ou mascara para plano de contas se a operacao for debito';
COMMENT ON COLUMN "accintegration"."creditaccount" IS 'plano de contas ou mascara para plano de contas se a operacao for credito';
COMMENT ON COLUMN "accintegration"."externalentryid" IS 'Codigo identificador do lancamento para o SIGA';
COMMENT ON COLUMN "accintegration"."operationdescription" IS 'Descricao da operacao para o SIGA';
COMMENT ON COLUMN "accintegration"."debitcostcenter" IS 'Centro de custo se a operacao for debito';
COMMENT ON COLUMN "accintegration"."creditcostcenter" IS 'Centro de custo se a operacao for credito';

CREATE SEQUENCE "seq_accintegrationid";
ALTER TABLE "accintegration" ALTER COLUMN "accintegrationid" SET DEFAULT NEXTVAL('"seq_accintegrationid"');
ALTER TABLE "accintegration" ALTER COLUMN "operationid" SET NOT NULL;
ALTER TABLE "accintegration" ALTER COLUMN "operationtypeid" SET NOT NULL;
ALTER TABLE "accintegration" ALTER COLUMN "externalentryid" SET NOT NULL;

ALTER TABLE "accintegration" ALTER COLUMN "accintegrationid" SET NOT NULL;
ALTER TABLE "accintegration" ADD PRIMARY KEY ("accintegrationid");

ALTER TABLE "accintegration" ADD FOREIGN KEY ("operationid") REFERENCES "finoperation"("operationid");

----------------------------------------------------------------------
-- --
--
-- Table: accentryintegration
-- Purpose: contem os registros necessarios para a integracao de 
--          lancamentos com o siga (sagu1: integra_lancamentos). herda 
--          a accintegration 
--
-- --
----------------------------------------------------------------------

CREATE TABLE "accentryintegration" 
(
    "value"                varchar(20), --Valor
    "usercode"             text, --Campo que pode conter um codigo php pra alterar informacoes do usuario
    "debititem"            varchar(20), --Item do debito
    "credititem"           varchar(20), --Item de credito
    "reversaloperation"    varchar(40) --Descricao da operacao de estorno
) INHERITS ("accintegration");

COMMENT ON TABLE "accentryintegration" IS 'contem os registros necessarios para a integracao de lancamentos com o siga (sagu1: integra_lancamentos). herda a accintegration';
COMMENT ON COLUMN "accentryintegration"."value" IS 'Valor';
COMMENT ON COLUMN "accentryintegration"."usercode" IS 'Campo que pode conter um codigo php pra alterar informacoes do usuario';
COMMENT ON COLUMN "accentryintegration"."debititem" IS 'Item do debito';
COMMENT ON COLUMN "accentryintegration"."credititem" IS 'Item de credito';
COMMENT ON COLUMN "accentryintegration"."reversaloperation" IS 'Descricao da operacao de estorno';

ALTER TABLE "accentryintegration" ALTER COLUMN "accintegrationid" SET NOT NULL;
ALTER TABLE "accentryintegration" ADD PRIMARY KEY ("accintegrationid");

----------------------------------------------------------------------
-- --
--
-- Table: accincomeforecastintegration
-- Purpose: contem os registros necessarios para a integracao de 
--          previsoes com o siga (sagu1: integra_previsoes). herda a 
--          accintegration 
--
-- --
----------------------------------------------------------------------

CREATE TABLE "accincomeforecastintegration" 
(
    "accountitem"    varchar(20) --Intem contabil
) INHERITS ("accintegration");

COMMENT ON TABLE "accincomeforecastintegration" IS 'contem os registros necessarios para a integracao de previsoes com o siga (sagu1: integra_previsoes). herda a accintegration';
COMMENT ON COLUMN "accincomeforecastintegration"."accountitem" IS 'Intem contabil';

ALTER TABLE "accincomeforecastintegration" ALTER COLUMN "accintegrationid" SET NOT NULL;
ALTER TABLE "accincomeforecastintegration" ADD PRIMARY KEY ("accintegrationid");

----------------------------------------------------------------------
-- --
--
-- Table: finoccurrenceoperation
-- Purpose: identifica uma operacao para um determinada ocorrencia, 
--          utilizado no arquivo de retorno bancario. 
--
-- --
----------------------------------------------------------------------

CREATE TABLE "finoccurrenceoperation" 
(
    "occurrenceoperationid"    integer, --Codigo identificador da ocorrencia de operacao
    "occurrenceid"             char(2), --Codigo da ocorrencia, este dado e padrao bancario (FEBRABAN)
    "bankaccountid"            integer, --Codigo do conta bancaria (finBankAccount)
    "operationid"              integer, --Codigo identificador da operacao (finOperation)
    "levelsequenceid"          integer --Valor do nivel da sequancia, utilizado para adquirir uma determinada operacao.
) INHERITS ("baslog");

COMMENT ON TABLE "finoccurrenceoperation" IS 'identifica uma operacao para um determinada ocorrencia, utilizado no arquivo de retorno bancario.';
COMMENT ON COLUMN "finoccurrenceoperation"."occurrenceoperationid" IS 'Codigo identificador da ocorrencia de operacao';
COMMENT ON COLUMN "finoccurrenceoperation"."occurrenceid" IS 'Codigo da ocorrencia, este dado e padrao bancario (FEBRABAN)';
COMMENT ON COLUMN "finoccurrenceoperation"."bankaccountid" IS 'Codigo do conta bancaria (finBankAccount)';
COMMENT ON COLUMN "finoccurrenceoperation"."operationid" IS 'Codigo identificador da operacao (finOperation)';
COMMENT ON COLUMN "finoccurrenceoperation"."levelsequenceid" IS 'Valor do nivel da sequancia, utilizado para adquirir uma determinada operacao.';

CREATE SEQUENCE "seq_occurrenceoperationid";
ALTER TABLE "finoccurrenceoperation" ALTER COLUMN "occurrenceoperationid" SET DEFAULT NEXTVAL('"seq_occurrenceoperationid"');
ALTER TABLE "finoccurrenceoperation" ALTER COLUMN "occurrenceid" SET NOT NULL;
ALTER TABLE "finoccurrenceoperation" ALTER COLUMN "bankaccountid" SET NOT NULL;
ALTER TABLE "finoccurrenceoperation" ALTER COLUMN "operationid" SET NOT NULL;
ALTER TABLE "finoccurrenceoperation" ALTER COLUMN "levelsequenceid" SET NOT NULL;

ALTER TABLE "finoccurrenceoperation" ALTER COLUMN "occurrenceoperationid" SET NOT NULL;
ALTER TABLE "finoccurrenceoperation" ADD PRIMARY KEY ("occurrenceoperationid");

ALTER TABLE "finoccurrenceoperation" ADD FOREIGN KEY ("operationid") REFERENCES "finoperation"("operationid");

ALTER TABLE "finoccurrenceoperation" ADD FOREIGN KEY ("bankaccountid") REFERENCES "finbankaccount"("bankaccountid");

----------------------------------------------------------------------
-- --
--
-- Table: sprplace
-- Purpose: cadastro geral dos locais de prova
--
-- --
----------------------------------------------------------------------

CREATE TABLE "sprplace" 
(
    "placeid"             integer, --Codigo do local
    "description"         text, --Descricao
    "shortdescription"    varchar(5), --Descricao suscinta
    "cityid"              integer, --Codigo da cidade
    "location"            varchar(100), --Logradouro
    "complement"          varchar(20), --Complemento
    "neighborhood"        varchar(100) --Bairro
) INHERITS ("baslog");

COMMENT ON TABLE "sprplace" IS 'cadastro geral dos locais de prova';
COMMENT ON COLUMN "sprplace"."placeid" IS 'Codigo do local';
COMMENT ON COLUMN "sprplace"."description" IS 'Descricao';
COMMENT ON COLUMN "sprplace"."shortdescription" IS 'Descricao suscinta';
COMMENT ON COLUMN "sprplace"."cityid" IS 'Codigo da cidade';
COMMENT ON COLUMN "sprplace"."location" IS 'Logradouro';
COMMENT ON COLUMN "sprplace"."complement" IS 'Complemento';
COMMENT ON COLUMN "sprplace"."neighborhood" IS 'Bairro';

CREATE SEQUENCE "seq_placeid";
ALTER TABLE "sprplace" ALTER COLUMN "placeid" SET DEFAULT NEXTVAL('"seq_placeid"');
ALTER TABLE "sprplace" ALTER COLUMN "description" SET NOT NULL;
ALTER TABLE "sprplace" ALTER COLUMN "shortdescription" SET NOT NULL;
ALTER TABLE "sprplace" ALTER COLUMN "cityid" SET NOT NULL;

ALTER TABLE "sprplace" ALTER COLUMN "placeid" SET NOT NULL;
ALTER TABLE "sprplace" ADD PRIMARY KEY ("placeid");

ALTER TABLE "sprplace" ADD FOREIGN KEY ("cityid") REFERENCES "bascity"("cityid");

----------------------------------------------------------------------
-- --
--
-- Table: rshoption
-- Purpose: opcoes
--
-- --
----------------------------------------------------------------------

CREATE TABLE "rshoption" 
(
    "optionid"       integer, --Codigo da opcao
    "questionid"     integer, --Codigo da questao
    "description"    text --Descricao
) INHERITS ("baslog");

COMMENT ON TABLE "rshoption" IS 'opcoes';
COMMENT ON COLUMN "rshoption"."optionid" IS 'Codigo da opcao';
COMMENT ON COLUMN "rshoption"."questionid" IS 'Codigo da questao';
COMMENT ON COLUMN "rshoption"."description" IS 'Descricao';

CREATE SEQUENCE "seq_optionid";
ALTER TABLE "rshoption" ALTER COLUMN "optionid" SET DEFAULT NEXTVAL('"seq_optionid"');
ALTER TABLE "rshoption" ALTER COLUMN "questionid" SET NOT NULL;
ALTER TABLE "rshoption" ALTER COLUMN "description" SET NOT NULL;

ALTER TABLE "rshoption" ALTER COLUMN "optionid" SET NOT NULL;
ALTER TABLE "rshoption" ADD PRIMARY KEY ("optionid");

ALTER TABLE "rshoption" ADD FOREIGN KEY ("questionid") REFERENCES "rshquestion"("questionid");

----------------------------------------------------------------------
-- --
--
-- Table: basunit
-- Purpose: unidades (campus)
--
-- --
----------------------------------------------------------------------

CREATE TABLE "basunit" 
(
    "unitid"            integer, --Codigo da unidade
    "cityid"            integer, --Codigo da cidade onde esta localizada a unidade
    "description"       text, --Descricao
    "accountingcode"    varchar(2), --Codigo contabil
    "color"             varchar(30) --Cor que indicativa da unidade (utilizado em alguns processos/relatorios)
) INHERITS ("baslog");

COMMENT ON TABLE "basunit" IS 'unidades (campus)';
COMMENT ON COLUMN "basunit"."unitid" IS 'Codigo da unidade';
COMMENT ON COLUMN "basunit"."cityid" IS 'Codigo da cidade onde esta localizada a unidade';
COMMENT ON COLUMN "basunit"."description" IS 'Descricao';
COMMENT ON COLUMN "basunit"."accountingcode" IS 'Codigo contabil';
COMMENT ON COLUMN "basunit"."color" IS 'Cor que indicativa da unidade (utilizado em alguns processos/relatorios)';

CREATE SEQUENCE "seq_unitid";
ALTER TABLE "basunit" ALTER COLUMN "unitid" SET DEFAULT NEXTVAL('"seq_unitid"');
ALTER TABLE "basunit" ALTER COLUMN "cityid" SET NOT NULL;
ALTER TABLE "basunit" ALTER COLUMN "description" SET NOT NULL;
ALTER TABLE "basunit" ALTER COLUMN "accountingcode" SET NOT NULL;
ALTER TABLE "basunit" ALTER COLUMN "accountingcode" SET DEFAULT '00' ;
ALTER TABLE "basunit" ALTER COLUMN "color" SET NOT NULL;

ALTER TABLE "basunit" ALTER COLUMN "unitid" SET NOT NULL;
ALTER TABLE "basunit" ADD PRIMARY KEY ("unitid");

ALTER TABLE "basunit" ADD FOREIGN KEY ("cityid") REFERENCES "bascity"("cityid");

----------------------------------------------------------------------
-- --
--
-- Table: baslocation
-- Purpose: logradouros
--
-- --
----------------------------------------------------------------------

CREATE TABLE "baslocation" 
(
    "locationid"        integer, --Codigo do logradouro
    "name"              text, --Nome
    "cityid"            integer, --Codigo da cidade
    "zipcode"           varchar(9), --CEP
    "neighborhoodid"    integer --Codigo do bairro
) INHERITS ("baslog");

COMMENT ON TABLE "baslocation" IS 'logradouros';
COMMENT ON COLUMN "baslocation"."locationid" IS 'Codigo do logradouro';
COMMENT ON COLUMN "baslocation"."name" IS 'Nome';
COMMENT ON COLUMN "baslocation"."cityid" IS 'Codigo da cidade';
COMMENT ON COLUMN "baslocation"."zipcode" IS 'CEP';
COMMENT ON COLUMN "baslocation"."neighborhoodid" IS 'Codigo do bairro';

CREATE SEQUENCE "seq_locationid";
ALTER TABLE "baslocation" ALTER COLUMN "locationid" SET DEFAULT NEXTVAL('"seq_locationid"');
ALTER TABLE "baslocation" ALTER COLUMN "name" SET NOT NULL;
ALTER TABLE "baslocation" ALTER COLUMN "cityid" SET NOT NULL;
ALTER TABLE "baslocation" ALTER COLUMN "zipcode" SET NOT NULL;

ALTER TABLE "baslocation" ALTER COLUMN "locationid" SET NOT NULL;
ALTER TABLE "baslocation" ADD PRIMARY KEY ("locationid");

CREATE INDEX "idx_baslocation_zipcode" ON "baslocation" ("zipcode");
CREATE INDEX "idx_baslocation_cityid" ON "baslocation" ("cityid");

ALTER TABLE "baslocation" ADD FOREIGN KEY ("cityid") REFERENCES "bascity"("cityid");

ALTER TABLE "baslocation" ADD FOREIGN KEY ("neighborhoodid") REFERENCES "basneighborhood"("neighborhoodid");

----------------------------------------------------------------------
-- --
--
-- Table: bascitysquare
-- Purpose: pracas das cidades para o banco
--
-- --
----------------------------------------------------------------------

CREATE TABLE "bascitysquare" 
(
    "cityid"    integer, --Codigo da cidade
    "square"    varchar(6) --Praca
) INHERITS ("baslog");

COMMENT ON TABLE "bascitysquare" IS 'pracas das cidades para o banco';
COMMENT ON COLUMN "bascitysquare"."cityid" IS 'Codigo da cidade';
COMMENT ON COLUMN "bascitysquare"."square" IS 'Praca';

ALTER TABLE "bascitysquare" ALTER COLUMN "cityid" SET NOT NULL;
ALTER TABLE "bascitysquare" ALTER COLUMN "square" SET NOT NULL;

ALTER TABLE "bascitysquare" ALTER COLUMN "cityid" SET NOT NULL;
ALTER TABLE "bascitysquare" ALTER COLUMN "square" SET NOT NULL;
ALTER TABLE "bascitysquare" ADD PRIMARY KEY ("cityid","square");

ALTER TABLE "bascitysquare" ADD FOREIGN KEY ("cityid") REFERENCES "bascity"("cityid");


----------------------------------------------------------------------
-- --
--
-- Table: finincentivetype
-- Purpose: tipos de incentivos que podem ser concedidos
--
-- --
----------------------------------------------------------------------

CREATE TABLE "finincentivetype" 
(
    "incentivetypeid"            integer, --Codigo identificador do tipo de incentivo
    "description"                text, --Texto descrevendo o tipo de incentivo
    "operationid"                integer, --Codigo identificador da operacao do incentivo (finOperation)
    "needadjustauthorization"    boolean, --se o aluno precisa autorizacao da empresa pra fazer ajuste de matricula
    "sendinvoices"               boolean, --Envia ou não títulos de pessoas que possuem este tipo de incentivo. (FAE)
    "generatecredits"            boolean, --Se gera creditos na matricula ou nao (FAE nao gera, todos outros gera)
    "isextinct"                  boolean --Se um incentivo foi ou nao cancelado
) INHERITS ("baslog");

COMMENT ON TABLE "finincentivetype" IS 'tipos de incentivos que podem ser concedidos';
COMMENT ON COLUMN "finincentivetype"."incentivetypeid" IS 'Codigo identificador do tipo de incentivo';
COMMENT ON COLUMN "finincentivetype"."description" IS 'Texto descrevendo o tipo de incentivo';
COMMENT ON COLUMN "finincentivetype"."operationid" IS 'Codigo identificador da operacao do incentivo (finOperation)';
COMMENT ON COLUMN "finincentivetype"."needadjustauthorization" IS 'se o aluno precisa autorizacao da empresa pra fazer ajuste de matricula';
COMMENT ON COLUMN "finincentivetype"."sendinvoices" IS 'Envia ou não títulos de pessoas que possuem este tipo de incentivo. (FAE)';
COMMENT ON COLUMN "finincentivetype"."generatecredits" IS 'Se gera creditos na matricula ou nao (FAE nao gera, todos outros gera)';
COMMENT ON COLUMN "finincentivetype"."isextinct" IS 'Se um incentivo foi ou nao cancelado';

CREATE SEQUENCE "seq_incentivetypeid";
ALTER TABLE "finincentivetype" ALTER COLUMN "incentivetypeid" SET DEFAULT NEXTVAL('"seq_incentivetypeid"');
ALTER TABLE "finincentivetype" ALTER COLUMN "description" SET NOT NULL;
ALTER TABLE "finincentivetype" ALTER COLUMN "operationid" SET NOT NULL;
ALTER TABLE "finincentivetype" ALTER COLUMN "needadjustauthorization" SET NOT NULL;
ALTER TABLE "finincentivetype" ALTER COLUMN "needadjustauthorization" SET DEFAULT FALSE ;
ALTER TABLE "finincentivetype" ALTER COLUMN "sendinvoices" SET NOT NULL;
ALTER TABLE "finincentivetype" ALTER COLUMN "sendinvoices" SET DEFAULT TRUE ;
ALTER TABLE "finincentivetype" ALTER COLUMN "generatecredits" SET NOT NULL;
ALTER TABLE "finincentivetype" ALTER COLUMN "generatecredits" SET DEFAULT TRUE ;
ALTER TABLE "finincentivetype" ALTER COLUMN "isextinct" SET NOT NULL;
ALTER TABLE "finincentivetype" ALTER COLUMN "isextinct" SET DEFAULT FALSE ;

ALTER TABLE "finincentivetype" ALTER COLUMN "incentivetypeid" SET NOT NULL;
ALTER TABLE "finincentivetype" ADD PRIMARY KEY ("incentivetypeid");

ALTER TABLE "finincentivetype" ADD FOREIGN KEY ("operationid") REFERENCES "finoperation"("operationid");

----------------------------------------------------------------------
-- --
--
-- Table: finsupport
-- Purpose: incentivos do tipo patrocinio (empresas que custeiam os 
--          estudos dos funcionarios, por exemplo). herda a 
--          finincentivetype 
--
-- --
----------------------------------------------------------------------

CREATE TABLE "finsupport" 
(
    "accountschemeid"          varchar(30), --Codigo identificador da conta contavil a qual o patrocinio pertence
    "collectionoperationid"    integer --Operacao para a cobranca para o patrocinador
) INHERITS ("finincentivetype");

COMMENT ON TABLE "finsupport" IS 'incentivos do tipo patrocinio (empresas que custeiam os estudos dos funcionarios, por exemplo). herda a finincentivetype';
COMMENT ON COLUMN "finsupport"."accountschemeid" IS 'Codigo identificador da conta contavil a qual o patrocinio pertence';
COMMENT ON COLUMN "finsupport"."collectionoperationid" IS 'Operacao para a cobranca para o patrocinador';

ALTER TABLE "finsupport" ALTER COLUMN "accountschemeid" SET NOT NULL;
ALTER TABLE "finsupport" ALTER COLUMN "collectionoperationid" SET NOT NULL;

ALTER TABLE "finsupport" ALTER COLUMN "incentivetypeid" SET NOT NULL;
ALTER TABLE "finsupport" ADD PRIMARY KEY ("incentivetypeid");

ALTER TABLE "finsupport" ADD FOREIGN KEY ("accountschemeid") REFERENCES "accaccountscheme"("accountschemeid");

ALTER TABLE "finsupport" ADD FOREIGN KEY ("collectionoperationid") REFERENCES "finoperation"("operationid");

----------------------------------------------------------------------
-- --
--
-- Table: basperson
-- Purpose: pessoas
--
-- --
----------------------------------------------------------------------

CREATE TABLE "basperson" 
(
    "personid"               integer, --Codigo da pessoa
    "persondv"               integer, --Digito verificador da pessoa
    "personmask"             varchar(15), --Mascara para o codigo da pessoa
    "name"                   varchar(100), --Nome
    "shortname"              varchar(30), --Apelido
    "cityid"                 integer, --Codigo da cidade
    "zipcode"                varchar(9), --CEP
    "location"               varchar(100), --Logradouro
    "number"                 varchar(10), --Numero
    "complement"             varchar(60), --Complemento
    "neighborhood"           text, --Bairro
    "email"                  varchar(60), --Email
    "emailalternative"       varchar(60), --Email alternativo
    "url"                    varchar(60), --URL
    "datein"                 date, --Data de ingresso
    "password"               varchar(10), --Senha para acesso aos processo on-line
    "isallowpersonaldata"    boolean --Permite a divulgacao de dados pessoais
) INHERITS ("baslog");

COMMENT ON TABLE "basperson" IS 'pessoas';
COMMENT ON COLUMN "basperson"."personid" IS 'Codigo da pessoa';
COMMENT ON COLUMN "basperson"."persondv" IS 'Digito verificador da pessoa';
COMMENT ON COLUMN "basperson"."personmask" IS 'Mascara para o codigo da pessoa';
COMMENT ON COLUMN "basperson"."name" IS 'Nome';
COMMENT ON COLUMN "basperson"."shortname" IS 'Apelido';
COMMENT ON COLUMN "basperson"."cityid" IS 'Codigo da cidade';
COMMENT ON COLUMN "basperson"."zipcode" IS 'CEP';
COMMENT ON COLUMN "basperson"."location" IS 'Logradouro';
COMMENT ON COLUMN "basperson"."number" IS 'Numero';
COMMENT ON COLUMN "basperson"."complement" IS 'Complemento';
COMMENT ON COLUMN "basperson"."neighborhood" IS 'Bairro';
COMMENT ON COLUMN "basperson"."email" IS 'Email';
COMMENT ON COLUMN "basperson"."emailalternative" IS 'Email alternativo';
COMMENT ON COLUMN "basperson"."url" IS 'URL';
COMMENT ON COLUMN "basperson"."datein" IS 'Data de ingresso';
COMMENT ON COLUMN "basperson"."password" IS 'Senha para acesso aos processo on-line';
COMMENT ON COLUMN "basperson"."isallowpersonaldata" IS 'Permite a divulgacao de dados pessoais';

CREATE SEQUENCE "seq_personid";
ALTER TABLE "basperson" ALTER COLUMN "personid" SET DEFAULT NEXTVAL('"seq_personid"');
ALTER TABLE "basperson" ALTER COLUMN "name" SET NOT NULL;
ALTER TABLE "basperson" ALTER COLUMN "isallowpersonaldata" SET NOT NULL;
ALTER TABLE "basperson" ALTER COLUMN "isallowpersonaldata" SET DEFAULT TRUE ;

ALTER TABLE "basperson" ALTER COLUMN "personid" SET NOT NULL;
ALTER TABLE "basperson" ADD PRIMARY KEY ("personid");

CREATE INDEX "idx_basperson_name" ON "basperson" ("name");
CREATE INDEX "idx_basperson_personid" ON "basperson" ("personid");

ALTER TABLE "basperson" ADD FOREIGN KEY ("cityid") REFERENCES "bascity"("cityid");

----------------------------------------------------------------------
-- --
--
-- Table: baspersonlink
-- Purpose: vinculos das pessoas
--
-- --
----------------------------------------------------------------------

CREATE TABLE "baspersonlink" 
(
    "personid"        integer, --Codigo da pessoa
    "linkid"          integer, --Codigo do vinculo
    "datevalidate"    date --Data de validade
) INHERITS ("baslog");

COMMENT ON TABLE "baspersonlink" IS 'vinculos das pessoas';
COMMENT ON COLUMN "baspersonlink"."personid" IS 'Codigo da pessoa';
COMMENT ON COLUMN "baspersonlink"."linkid" IS 'Codigo do vinculo';
COMMENT ON COLUMN "baspersonlink"."datevalidate" IS 'Data de validade';

ALTER TABLE "baspersonlink" ALTER COLUMN "personid" SET NOT NULL;
ALTER TABLE "baspersonlink" ALTER COLUMN "linkid" SET NOT NULL;
ALTER TABLE "baspersonlink" ALTER COLUMN "datevalidate" SET NOT NULL;

ALTER TABLE "baspersonlink" ADD FOREIGN KEY ("personid") REFERENCES "basperson"("personid");

ALTER TABLE "baspersonlink" ADD FOREIGN KEY ("linkid") REFERENCES "baslink"("linkid");

----------------------------------------------------------------------
-- --
--
-- Table: finfinancialaid
-- Purpose: incentivos do tipo bolsa de estudo (2o filho, bic, 
--          professor, ciee, fapergs, aeca, etc.). herda a 
--          finincentivetype 
--
-- --
----------------------------------------------------------------------

CREATE TABLE "finfinancialaid" 
(
    "requirecostcenter"    boolean --obrigar o preenchimento de costCenter em finIncentive
) INHERITS ("finincentivetype");

COMMENT ON TABLE "finfinancialaid" IS 'incentivos do tipo bolsa de estudo (2o filho, bic, professor, ciee, fapergs, aeca, etc.). herda a finincentivetype';
COMMENT ON COLUMN "finfinancialaid"."requirecostcenter" IS 'obrigar o preenchimento de costCenter em finIncentive';

ALTER TABLE "finfinancialaid" ALTER COLUMN "requirecostcenter" SET NOT NULL;
ALTER TABLE "finfinancialaid" ALTER COLUMN "requirecostcenter" SET DEFAULT FALSE ;

ALTER TABLE "finfinancialaid" ALTER COLUMN "incentivetypeid" SET NOT NULL;
ALTER TABLE "finfinancialaid" ADD PRIMARY KEY ("incentivetypeid");

----------------------------------------------------------------------
-- --
--
-- Table: rshanswer
-- Purpose: respostas
--
-- --
----------------------------------------------------------------------

CREATE TABLE "rshanswer" 
(
    "answerid"      integer, --Codigo da resposta
    "personid"      integer, --Codigo da pessoa
    "questionid"    integer, --Codigo da questao
    "optionid"      integer --Codigo da opcao escolhida
) INHERITS ("baslog");

COMMENT ON TABLE "rshanswer" IS 'respostas';
COMMENT ON COLUMN "rshanswer"."answerid" IS 'Codigo da resposta';
COMMENT ON COLUMN "rshanswer"."personid" IS 'Codigo da pessoa';
COMMENT ON COLUMN "rshanswer"."questionid" IS 'Codigo da questao';
COMMENT ON COLUMN "rshanswer"."optionid" IS 'Codigo da opcao escolhida';

CREATE SEQUENCE "seq_answerid";
ALTER TABLE "rshanswer" ALTER COLUMN "answerid" SET DEFAULT NEXTVAL('"seq_answerid"');
ALTER TABLE "rshanswer" ALTER COLUMN "personid" SET NOT NULL;
ALTER TABLE "rshanswer" ALTER COLUMN "questionid" SET NOT NULL;
ALTER TABLE "rshanswer" ALTER COLUMN "optionid" SET NOT NULL;

ALTER TABLE "rshanswer" ALTER COLUMN "answerid" SET NOT NULL;
ALTER TABLE "rshanswer" ADD PRIMARY KEY ("answerid");

CREATE UNIQUE INDEX "idx_unq_rshanswer" ON "rshanswer" ("personid","questionid","optionid");

ALTER TABLE "rshanswer" ADD FOREIGN KEY ("questionid") REFERENCES "rshquestion"("questionid");

ALTER TABLE "rshanswer" ADD FOREIGN KEY ("optionid") REFERENCES "rshoption"("optionid");

----------------------------------------------------------------------
-- --
--
-- Table: finpersoninformation
-- Purpose: informacao financeira de pessoas fisicas e juridicas. 
--          (antigo campo obs da tabela pessoas do sagu1) 
--
-- --
----------------------------------------------------------------------

CREATE TABLE "finpersoninformation" 
(
    "personid"       int, --Codigo identificador da pessoa as quais as informacoes pertencem
    "information"    text --Informacao da pessoa
) INHERITS ("baslog");

COMMENT ON TABLE "finpersoninformation" IS 'informacao financeira de pessoas fisicas e juridicas. (antigo campo obs da tabela pessoas do sagu1)';
COMMENT ON COLUMN "finpersoninformation"."personid" IS 'Codigo identificador da pessoa as quais as informacoes pertencem';
COMMENT ON COLUMN "finpersoninformation"."information" IS 'Informacao da pessoa';

ALTER TABLE "finpersoninformation" ALTER COLUMN "personid" SET NOT NULL;
ALTER TABLE "finpersoninformation" ADD PRIMARY KEY ("personid");

ALTER TABLE "finpersoninformation" ADD FOREIGN KEY ("personid") REFERENCES "basperson"("personid");

----------------------------------------------------------------------
-- --
--
-- Table: finagreementcomments
-- Purpose: contem comentarios referentes a acordos
--
-- --
----------------------------------------------------------------------

CREATE TABLE "finagreementcomments" 
(
    "agreementcommentsid"    int, --Chave primaria da tabela
    "personid"               int, --Chave estrangeira da BasPerson
    "agreementtitle"         varchar(60), --Titulo do comentario
    "comments"               text --Comentarios sobre titulos com acordos (acessado pela tela de acordos para pessoas - personAgreements)
) INHERITS ("baslog");

COMMENT ON TABLE "finagreementcomments" IS 'contem comentarios referentes a acordos';
COMMENT ON COLUMN "finagreementcomments"."agreementcommentsid" IS 'Chave primaria da tabela';
COMMENT ON COLUMN "finagreementcomments"."personid" IS 'Chave estrangeira da BasPerson';
COMMENT ON COLUMN "finagreementcomments"."agreementtitle" IS 'Titulo do comentario';
COMMENT ON COLUMN "finagreementcomments"."comments" IS 'Comentarios sobre titulos com acordos (acessado pela tela de acordos para pessoas - personAgreements)';

CREATE SEQUENCE "seq_agreementcommentsid";
ALTER TABLE "finagreementcomments" ALTER COLUMN "agreementcommentsid" SET DEFAULT NEXTVAL('"seq_agreementcommentsid"');
ALTER TABLE "finagreementcomments" ALTER COLUMN "personid" SET not null;

ALTER TABLE "finagreementcomments" ALTER COLUMN "agreementcommentsid" SET NOT NULL;
ALTER TABLE "finagreementcomments" ADD PRIMARY KEY ("agreementcommentsid");

ALTER TABLE "finagreementcomments" ADD FOREIGN KEY ("personid") REFERENCES "basperson"("personid");

----------------------------------------------------------------------
-- --
--
-- Table: baslegalperson
-- Purpose: pessoas juridicas
--
-- --
----------------------------------------------------------------------

CREATE TABLE "baslegalperson" 
(
    "fakename"             varchar(100), --Nome fantasia
    "currentname"          varchar(100), --Nome atual
    "cnpj"                 varchar(20), --CNPJ
    "stateregistration"    varchar(20), --Inscricao estadual
    "cityregistration"     varchar(20), --Inscricao municipal
    "legalpersontypeid"    integer, --Tipo de pessoa juridica
    "phone"                varchar(50), --Telefone
    "fax"                  varchar(50) --Fax
) INHERITS ("basperson");

COMMENT ON TABLE "baslegalperson" IS 'pessoas juridicas';
COMMENT ON COLUMN "baslegalperson"."fakename" IS 'Nome fantasia';
COMMENT ON COLUMN "baslegalperson"."currentname" IS 'Nome atual';
COMMENT ON COLUMN "baslegalperson"."cnpj" IS 'CNPJ';
COMMENT ON COLUMN "baslegalperson"."stateregistration" IS 'Inscricao estadual';
COMMENT ON COLUMN "baslegalperson"."cityregistration" IS 'Inscricao municipal';
COMMENT ON COLUMN "baslegalperson"."legalpersontypeid" IS 'Tipo de pessoa juridica';
COMMENT ON COLUMN "baslegalperson"."phone" IS 'Telefone';
COMMENT ON COLUMN "baslegalperson"."fax" IS 'Fax';

ALTER TABLE "baslegalperson" ALTER COLUMN "personid" SET NOT NULL;
ALTER TABLE "baslegalperson" ADD PRIMARY KEY ("personid");

ALTER TABLE "baslegalperson" ADD FOREIGN KEY ("legalpersontypeid") REFERENCES "baslegalpersontype"("legalpersontypeid");

----------------------------------------------------------------------
-- --
--
-- Table: bascompanyconf
-- Purpose: cadastro da empresa que utiliza o sistema. pode-se 
--          cadastrar mais de uma empresa, pois o sistema e 
--          multi-empresa. 
--
-- --
----------------------------------------------------------------------

CREATE TABLE "bascompanyconf" 
(
    "companyid"                       integer, --Codigo da empresa
    "personid"                        integer, --Codigo da pessoa para buscar os dados da pessoa jurídica da Instituicão
    "name"                            text, --Nome da empresa
    "acronym"                         varchar(10), --Sigla da empresa
    "masknumberschoolregistration"    text, --Mascara para o numero de registro escolar
    "noteorconcept"                   char(1), --Se utiliza nota ou conceito
    "companytypedescription"          text, --Descrição do tipo de instituicao. Ex: Centro universitario, universidade, faculdade
    "legalresponsableid"              int4 --Responsavel legal pela instituição
) INHERITS ("baslog");

COMMENT ON TABLE "bascompanyconf" IS 'cadastro da empresa que utiliza o sistema. pode-se cadastrar mais de uma empresa, pois o sistema e multi-empresa.';
COMMENT ON COLUMN "bascompanyconf"."companyid" IS 'Codigo da empresa';
COMMENT ON COLUMN "bascompanyconf"."personid" IS 'Codigo da pessoa para buscar os dados da pessoa jurídica da Instituicão';
COMMENT ON COLUMN "bascompanyconf"."name" IS 'Nome da empresa';
COMMENT ON COLUMN "bascompanyconf"."acronym" IS 'Sigla da empresa';
COMMENT ON COLUMN "bascompanyconf"."masknumberschoolregistration" IS 'Mascara para o numero de registro escolar';
COMMENT ON COLUMN "bascompanyconf"."noteorconcept" IS 'Se utiliza nota ou conceito';
COMMENT ON COLUMN "bascompanyconf"."companytypedescription" IS 'Descrição do tipo de instituicao. Ex: Centro universitario, universidade, faculdade';
COMMENT ON COLUMN "bascompanyconf"."legalresponsableid" IS 'Responsavel legal pela instituição';

CREATE SEQUENCE "seq_companyid";
ALTER TABLE "bascompanyconf" ALTER COLUMN "companyid" SET DEFAULT NEXTVAL('"seq_companyid"');
ALTER TABLE "bascompanyconf" ALTER COLUMN "personid" SET NOT NULL;
ALTER TABLE "bascompanyconf" ALTER COLUMN "name" SET NOT NULL;
ALTER TABLE "bascompanyconf" ALTER COLUMN "acronym" SET NOT NULL;
ALTER TABLE "bascompanyconf" ALTER COLUMN "noteorconcept" SET NOT NULL;

ALTER TABLE "bascompanyconf" ALTER COLUMN "companyid" SET NOT NULL;
ALTER TABLE "bascompanyconf" ADD PRIMARY KEY ("companyid");

ALTER TABLE "bascompanyconf" ADD FOREIGN KEY ("personid") REFERENCES "baslegalperson"("personid");

----------------------------------------------------------------------
-- --
--
-- Table: basconcept
-- Purpose: conceitos utilizados pela instituicao
--
-- --
----------------------------------------------------------------------

CREATE TABLE "basconcept" 
(
    "conceptid"           integer, --Codigo do Conceito
    "companyid"           integer, --Codigo da empresa
    "concept"             varchar(15), --Conceito
    "isapproved"          boolean, --Se e um conceito de aprovacao
    "needsdescriptive"    boolean --E necessario descritivo
) INHERITS ("baslog");

COMMENT ON TABLE "basconcept" IS 'conceitos utilizados pela instituicao';
COMMENT ON COLUMN "basconcept"."conceptid" IS 'Codigo do Conceito';
COMMENT ON COLUMN "basconcept"."companyid" IS 'Codigo da empresa';
COMMENT ON COLUMN "basconcept"."concept" IS 'Conceito';
COMMENT ON COLUMN "basconcept"."isapproved" IS 'Se e um conceito de aprovacao';
COMMENT ON COLUMN "basconcept"."needsdescriptive" IS 'E necessario descritivo';

CREATE SEQUENCE "seq_conceptid";
ALTER TABLE "basconcept" ALTER COLUMN "conceptid" SET DEFAULT NEXTVAL('"seq_conceptid"');
ALTER TABLE "basconcept" ALTER COLUMN "companyid" SET NOT NULL;
ALTER TABLE "basconcept" ALTER COLUMN "concept" SET NOT NULL;
ALTER TABLE "basconcept" ALTER COLUMN "isapproved" SET NOT NULL;
ALTER TABLE "basconcept" ALTER COLUMN "isapproved" SET DEFAULT FALSE ;
ALTER TABLE "basconcept" ALTER COLUMN "needsdescriptive" SET NOT NULL;
ALTER TABLE "basconcept" ALTER COLUMN "needsdescriptive" SET DEFAULT FALSE ;

ALTER TABLE "basconcept" ALTER COLUMN "conceptid" SET NOT NULL;
ALTER TABLE "basconcept" ALTER COLUMN "companyid" SET NOT NULL;
ALTER TABLE "basconcept" ADD PRIMARY KEY ("conceptid","companyid");

ALTER TABLE "basconcept" ADD FOREIGN KEY ("companyid") REFERENCES "bascompanyconf"("companyid");

----------------------------------------------------------------------
-- --
--
-- Table: basphysicalperson
-- Purpose: pessoa fisica
--
-- --
----------------------------------------------------------------------

CREATE TABLE "basphysicalperson" 
(
    "sex"                            char(1), --Sexo
    "maritalstatusid"                char(1), --Estado civil
    "residentialphone"               varchar(50), --Telefone residencial
    "workphone"                      varchar(50), --Telefone comercial
    "cellphone"                      varchar(50), --Telefone celular
    "messagephone"                   varchar(50), --Telefone para recados
    "messagecontact"                 varchar(50), --Contato para recados
    "datebirth"                      date, --Data de nascimento
    "cityidbirth"                    integer, --Cidade de nascimento
    "countryidbirth"                 integer, --Pais de nascimento
    "fatherid"                       integer, --Pai
    "motherid"                       integer, --Mae
    "responsablelegalid"             integer, --Responsavel legal
    "carplate"                       varchar(40), --Placa do carro
    "specialnecessityid"             integer, --Necessidade especial
    "specialnecessitydescription"    text, --Descritivo da necessidade especial
    "cityidwork"                     integer, --Cidade do local de trabalho
    "zipcodework"                    varchar(9), --CEP do local de trabalho
    "locationwork"                   varchar(100), --Logradouro do local de trabalho
    "complementwork"                 varchar(40), --Complemento do local de trabalho
    "neighborhoodwork"               varchar(100), --Bairro do local do trabalho
    "ethnicoriginid"                 integer, --Origem etnica
    "datedeath"                      date --Data de obito do aluno
) INHERITS ("basperson");

COMMENT ON TABLE "basphysicalperson" IS 'pessoa fisica';
COMMENT ON COLUMN "basphysicalperson"."sex" IS 'Sexo';
COMMENT ON COLUMN "basphysicalperson"."maritalstatusid" IS 'Estado civil';
COMMENT ON COLUMN "basphysicalperson"."residentialphone" IS 'Telefone residencial';
COMMENT ON COLUMN "basphysicalperson"."workphone" IS 'Telefone comercial';
COMMENT ON COLUMN "basphysicalperson"."cellphone" IS 'Telefone celular';
COMMENT ON COLUMN "basphysicalperson"."messagephone" IS 'Telefone para recados';
COMMENT ON COLUMN "basphysicalperson"."messagecontact" IS 'Contato para recados';
COMMENT ON COLUMN "basphysicalperson"."datebirth" IS 'Data de nascimento';
COMMENT ON COLUMN "basphysicalperson"."cityidbirth" IS 'Cidade de nascimento';
COMMENT ON COLUMN "basphysicalperson"."countryidbirth" IS 'Pais de nascimento';
COMMENT ON COLUMN "basphysicalperson"."fatherid" IS 'Pai';
COMMENT ON COLUMN "basphysicalperson"."motherid" IS 'Mae';
COMMENT ON COLUMN "basphysicalperson"."responsablelegalid" IS 'Responsavel legal';
COMMENT ON COLUMN "basphysicalperson"."carplate" IS 'Placa do carro';
COMMENT ON COLUMN "basphysicalperson"."specialnecessityid" IS 'Necessidade especial';
COMMENT ON COLUMN "basphysicalperson"."specialnecessitydescription" IS 'Descritivo da necessidade especial';
COMMENT ON COLUMN "basphysicalperson"."cityidwork" IS 'Cidade do local de trabalho';
COMMENT ON COLUMN "basphysicalperson"."zipcodework" IS 'CEP do local de trabalho';
COMMENT ON COLUMN "basphysicalperson"."locationwork" IS 'Logradouro do local de trabalho';
COMMENT ON COLUMN "basphysicalperson"."complementwork" IS 'Complemento do local de trabalho';
COMMENT ON COLUMN "basphysicalperson"."neighborhoodwork" IS 'Bairro do local do trabalho';
COMMENT ON COLUMN "basphysicalperson"."ethnicoriginid" IS 'Origem etnica';
COMMENT ON COLUMN "basphysicalperson"."datedeath" IS 'Data de obito do aluno';

ALTER TABLE "basphysicalperson" ALTER COLUMN "sex" SET NOT NULL;

CREATE INDEX "idx_basphysicalperson_name" ON "basphysicalperson" ("name");

ALTER TABLE "basphysicalperson" ALTER COLUMN "personid" SET NOT NULL;
ALTER TABLE "basphysicalperson" ADD PRIMARY KEY ("personid");

ALTER TABLE "basphysicalperson" ADD FOREIGN KEY ("specialnecessityid") REFERENCES "basspecialnecessity"("specialnecessityid");

ALTER TABLE "basphysicalperson" ADD FOREIGN KEY ("cityidbirth") REFERENCES "bascity"("cityid");

ALTER TABLE "basphysicalperson" ADD FOREIGN KEY ("fatherid") REFERENCES "basperson"("personid");

ALTER TABLE "basphysicalperson" ADD FOREIGN KEY ("motherid") REFERENCES "basperson"("personid");

ALTER TABLE "basphysicalperson" ADD FOREIGN KEY ("responsablelegalid") REFERENCES "basperson"("personid");

ALTER TABLE "basphysicalperson" ADD FOREIGN KEY ("countryidbirth") REFERENCES "bascountry"("countryid");

ALTER TABLE "basphysicalperson" ADD FOREIGN KEY ("maritalstatusid") REFERENCES "basmaritalstatus"("maritalstatusid");

ALTER TABLE "basphysicalperson" ADD FOREIGN KEY ("ethnicoriginid") REFERENCES "basethnicorigin"("ethnicoriginid");

----------------------------------------------------------------------
-- --
--
-- Table: accpersonbalance
-- Purpose: contem os saldos por conta, origem e pessoa em determinada 
--          data. 
--
-- --
----------------------------------------------------------------------

CREATE TABLE "accpersonbalance" 
(
    "personbalanceid"    integer,
    "accountschemeid"    varchar(30), --Codigo identificador da conta. Obtido da tabela fin_plano_conta.
    "personid"           integer, --Codigo identificador da pessoa. Obtido da tabela basPerson.
    "source"             char(1), --Define se o saldo em questao tem origem nas previsoes (P) ou nos lancamentos (L).
    "balancedate"        date, --Data identificando quando o saldo desta conta/origem/pessoa era esse.
    "courseid"           varchar(10), --informacoes que nao precisam ser obrigatorias
    "courseversion"      integer,
    "unitid"             integer, --informacoes que nao precisam ser obrigatorias
    "value"              numeric(14,4) --Valor do saldo.
) INHERITS ("baslog");

COMMENT ON TABLE "accpersonbalance" IS 'contem os saldos por conta, origem e pessoa em determinada data.';
COMMENT ON COLUMN "accpersonbalance"."accountschemeid" IS 'Codigo identificador da conta. Obtido da tabela fin_plano_conta.';
COMMENT ON COLUMN "accpersonbalance"."personid" IS 'Codigo identificador da pessoa. Obtido da tabela basPerson.';
COMMENT ON COLUMN "accpersonbalance"."source" IS 'Define se o saldo em questao tem origem nas previsoes (P) ou nos lancamentos (L).';
COMMENT ON COLUMN "accpersonbalance"."balancedate" IS 'Data identificando quando o saldo desta conta/origem/pessoa era esse.';
COMMENT ON COLUMN "accpersonbalance"."courseid" IS 'informacoes que nao precisam ser obrigatorias';
COMMENT ON COLUMN "accpersonbalance"."unitid" IS 'informacoes que nao precisam ser obrigatorias';
COMMENT ON COLUMN "accpersonbalance"."value" IS 'Valor do saldo.';

CREATE SEQUENCE "seq_personbalanceid";
ALTER TABLE "accpersonbalance" ALTER COLUMN "personbalanceid" SET DEFAULT NEXTVAL('"seq_personbalanceid"');
ALTER TABLE "accpersonbalance" ALTER COLUMN "accountschemeid" SET NOT NULL;
ALTER TABLE "accpersonbalance" ALTER COLUMN "personid" SET NOT NULL;
ALTER TABLE "accpersonbalance" ALTER COLUMN "source" SET NOT NULL;
ALTER TABLE "accpersonbalance" ALTER COLUMN "balancedate" SET NOT NULL;
ALTER TABLE "accpersonbalance" ALTER COLUMN "value" SET NOT NULL;

ALTER TABLE "accpersonbalance" ALTER COLUMN "personbalanceid" SET NOT NULL;
ALTER TABLE "accpersonbalance" ADD PRIMARY KEY ("personbalanceid");

CREATE UNIQUE INDEX "idx_accpersonbalance_unique" ON "accpersonbalance" ("accountschemeid","personid","source","balancedate","courseid","unitid","courseversion");

ALTER TABLE "accpersonbalance" ADD FOREIGN KEY ("accountschemeid") REFERENCES "accaccountscheme"("accountschemeid");

ALTER TABLE "accpersonbalance" ADD FOREIGN KEY ("personid") REFERENCES "basperson"("personid");

----------------------------------------------------------------------
-- --
--
-- Table: finloan
-- Purpose: incentivo do tipo financiamento. herda a finincentivetype
--
-- --
----------------------------------------------------------------------

CREATE TABLE "finloan" 
(
    "accountschemeid"          varchar(30), --Codigo identificador da conta a contabil qual o fincanciamento pertence
    "loanerid"                 integer, --Codigo identificador da pessoa financiadora do incentivo.
    "rotative"                 boolean, --TRUE se o valor patrocinado ao aluno devera ser pago por ele proprio no futuro. Caso contrario, FALSE.
    "groupinvoicesvalues"      boolean, --TRUE se os valores devem ser agrupados em um unico titulo (caso do PROCRES, por exemplo) ou se devem ser gerados varios titulos (caso do PCR).
    "collectionoperationid"    integer --Codigo identificador da operacao (finOperation) de cobranca
) INHERITS ("finincentivetype");

COMMENT ON TABLE "finloan" IS 'incentivo do tipo financiamento. herda a finincentivetype';
COMMENT ON COLUMN "finloan"."accountschemeid" IS 'Codigo identificador da conta a contabil qual o fincanciamento pertence';
COMMENT ON COLUMN "finloan"."loanerid" IS 'Codigo identificador da pessoa financiadora do incentivo.';
COMMENT ON COLUMN "finloan"."rotative" IS 'TRUE se o valor patrocinado ao aluno devera ser pago por ele proprio no futuro. Caso contrario, FALSE.';
COMMENT ON COLUMN "finloan"."groupinvoicesvalues" IS 'TRUE se os valores devem ser agrupados em um unico titulo (caso do PROCRES, por exemplo) ou se devem ser gerados varios titulos (caso do PCR).';
COMMENT ON COLUMN "finloan"."collectionoperationid" IS 'Codigo identificador da operacao (finOperation) de cobranca';

ALTER TABLE "finloan" ALTER COLUMN "accountschemeid" SET NOT NULL;
ALTER TABLE "finloan" ALTER COLUMN "rotative" SET NOT NULL;
ALTER TABLE "finloan" ALTER COLUMN "rotative" SET DEFAULT FALSE ;
ALTER TABLE "finloan" ALTER COLUMN "groupinvoicesvalues" SET NOT NULL;
ALTER TABLE "finloan" ALTER COLUMN "groupinvoicesvalues" SET DEFAULT FALSE ;
ALTER TABLE "finloan" ALTER COLUMN "collectionoperationid" SET NOT NULL;

ALTER TABLE "finloan" ALTER COLUMN "incentivetypeid" SET NOT NULL;
ALTER TABLE "finloan" ADD PRIMARY KEY ("incentivetypeid");

ALTER TABLE "finloan" ADD FOREIGN KEY ("accountschemeid") REFERENCES "accaccountscheme"("accountschemeid");

ALTER TABLE "finloan" ADD FOREIGN KEY ("collectionoperationid") REFERENCES "finoperation"("operationid");

ALTER TABLE "finloan" ADD FOREIGN KEY ("loanerid") REFERENCES "baslegalperson"("personid");

----------------------------------------------------------------------
-- --
--
-- Table: basprofessionalactivitypeople
-- Purpose: atividades profissionais das pessoas
--
-- --
----------------------------------------------------------------------

CREATE TABLE "basprofessionalactivitypeople" 
(
    "professionalactivitypeopleid"      integer, --Codigo da atividade profissional da pessoa
    "professionalactivityid"            integer, --Codigo da atividade profissional
    "personid"                          integer, --Codigo da pessoa
    "legalpersonid"                     integer, --Codigo da pessoa juridica
    "begindate"                         date, --Data de inicio
    "enddate"                           date, --Data de termino
    "professionalactivitylinktypeid"    integer, --Codigo do tipo de vinculo da atividade profissional
    "professionalactivityagentid"       integer --Codigo do agente da atividade profissional (estagio)
) INHERITS ("baslog");

COMMENT ON TABLE "basprofessionalactivitypeople" IS 'atividades profissionais das pessoas';
COMMENT ON COLUMN "basprofessionalactivitypeople"."professionalactivitypeopleid" IS 'Codigo da atividade profissional da pessoa';
COMMENT ON COLUMN "basprofessionalactivitypeople"."professionalactivityid" IS 'Codigo da atividade profissional';
COMMENT ON COLUMN "basprofessionalactivitypeople"."personid" IS 'Codigo da pessoa';
COMMENT ON COLUMN "basprofessionalactivitypeople"."legalpersonid" IS 'Codigo da pessoa juridica';
COMMENT ON COLUMN "basprofessionalactivitypeople"."begindate" IS 'Data de inicio';
COMMENT ON COLUMN "basprofessionalactivitypeople"."enddate" IS 'Data de termino';
COMMENT ON COLUMN "basprofessionalactivitypeople"."professionalactivitylinktypeid" IS 'Codigo do tipo de vinculo da atividade profissional';
COMMENT ON COLUMN "basprofessionalactivitypeople"."professionalactivityagentid" IS 'Codigo do agente da atividade profissional (estagio)';

CREATE SEQUENCE "seq_professionalactivitypeopleid";
ALTER TABLE "basprofessionalactivitypeople" ALTER COLUMN "professionalactivitypeopleid" SET DEFAULT NEXTVAL('"seq_professionalactivitypeopleid"');
ALTER TABLE "basprofessionalactivitypeople" ALTER COLUMN "personid" SET NOT NULL;
ALTER TABLE "basprofessionalactivitypeople" ALTER COLUMN "legalpersonid" SET NOT NULL;
ALTER TABLE "basprofessionalactivitypeople" ALTER COLUMN "begindate" SET NOT NULL;
ALTER TABLE "basprofessionalactivitypeople" ALTER COLUMN "professionalactivitylinktypeid" SET NOT NULL;

ALTER TABLE "basprofessionalactivitypeople" ALTER COLUMN "professionalactivitypeopleid" SET NOT NULL;
ALTER TABLE "basprofessionalactivitypeople" ADD PRIMARY KEY ("professionalactivitypeopleid");

ALTER TABLE "basprofessionalactivitypeople" ADD FOREIGN KEY ("personid") REFERENCES "basphysicalperson"("personid");

ALTER TABLE "basprofessionalactivitypeople" ADD FOREIGN KEY ("legalpersonid") REFERENCES "baslegalperson"("personid");

ALTER TABLE "basprofessionalactivitypeople" ADD FOREIGN KEY ("professionalactivitylinktypeid") REFERENCES "basprofessionalactivitylinktype"("professionalactivitylinktypeid");

ALTER TABLE "basprofessionalactivitypeople" ADD FOREIGN KEY ("professionalactivityid") REFERENCES "basprofessionalactivity"("professionalactivityid");

ALTER TABLE "basprofessionalactivitypeople" ADD FOREIGN KEY ("professionalactivityagentid") REFERENCES "basprofessionalactivityagent"("professionalactivityagentid");

----------------------------------------------------------------------
-- --
--
-- Table: sprselectiveprocess
-- Purpose: processos seletivos
--
-- --
----------------------------------------------------------------------

CREATE TABLE "sprselectiveprocess" 
(
    "selectiveprocessid"    varchar(10), --Codigo do processo seletivo
    "companyid"             integer, --Codigo da companhia responsavel pelo processo seletivo
    "institutionid"         integer, --Codigo da instituicao sede do processo seletivo
    "periodid"              varchar(10), --Codigo do periodo de ocorrencia do processo seletivo
    "description"           text, --Descricao
    "begindate"             date, --Data de inicio
    "optionsnumber"         integer, --Numero de opcoes
    "islanguage"            boolean, --t = habilta lingua estrangeira no vestibular e logo o campo language deve ser preenchido na inscricão
    "ishighschool"          boolean, --Se exige ensino medio completo
    "minimumpoints"         float, --Minimo de pontos admitidos
    "maximumpoints"         float --Maximo de pontos possiveis
) INHERITS ("baslog");

COMMENT ON TABLE "sprselectiveprocess" IS 'processos seletivos';
COMMENT ON COLUMN "sprselectiveprocess"."selectiveprocessid" IS 'Codigo do processo seletivo';
COMMENT ON COLUMN "sprselectiveprocess"."companyid" IS 'Codigo da companhia responsavel pelo processo seletivo';
COMMENT ON COLUMN "sprselectiveprocess"."institutionid" IS 'Codigo da instituicao sede do processo seletivo';
COMMENT ON COLUMN "sprselectiveprocess"."periodid" IS 'Codigo do periodo de ocorrencia do processo seletivo';
COMMENT ON COLUMN "sprselectiveprocess"."description" IS 'Descricao';
COMMENT ON COLUMN "sprselectiveprocess"."begindate" IS 'Data de inicio';
COMMENT ON COLUMN "sprselectiveprocess"."optionsnumber" IS 'Numero de opcoes';
COMMENT ON COLUMN "sprselectiveprocess"."islanguage" IS 't = habilta lingua estrangeira no vestibular e logo o campo language deve ser preenchido na inscricão';
COMMENT ON COLUMN "sprselectiveprocess"."ishighschool" IS 'Se exige ensino medio completo';
COMMENT ON COLUMN "sprselectiveprocess"."minimumpoints" IS 'Minimo de pontos admitidos';
COMMENT ON COLUMN "sprselectiveprocess"."maximumpoints" IS 'Maximo de pontos possiveis';

ALTER TABLE "sprselectiveprocess" ALTER COLUMN "selectiveprocessid" SET NOT NULL;
ALTER TABLE "sprselectiveprocess" ALTER COLUMN "companyid" SET NOT NULL;
ALTER TABLE "sprselectiveprocess" ALTER COLUMN "institutionid" SET NOT NULL;
ALTER TABLE "sprselectiveprocess" ALTER COLUMN "periodid" SET NOT NULL;
ALTER TABLE "sprselectiveprocess" ALTER COLUMN "description" SET NOT NULL;
ALTER TABLE "sprselectiveprocess" ALTER COLUMN "begindate" SET NOT NULL;
ALTER TABLE "sprselectiveprocess" ALTER COLUMN "optionsnumber" SET NOT NULL;
ALTER TABLE "sprselectiveprocess" ALTER COLUMN "islanguage" SET NOT NULL;
ALTER TABLE "sprselectiveprocess" ALTER COLUMN "islanguage" SET DEFAULT TRUE ;
ALTER TABLE "sprselectiveprocess" ALTER COLUMN "ishighschool" SET NOT NULL;
ALTER TABLE "sprselectiveprocess" ALTER COLUMN "ishighschool" SET DEFAULT FALSE ;
ALTER TABLE "sprselectiveprocess" ALTER COLUMN "minimumpoints" SET NOT NULL;
ALTER TABLE "sprselectiveprocess" ALTER COLUMN "maximumpoints" SET NOT NULL;
ALTER TABLE "sprselectiveprocess" ALTER COLUMN "maximumpoints" SET DEFAULT 100 ;

ALTER TABLE "sprselectiveprocess" ALTER COLUMN "selectiveprocessid" SET NOT NULL;
ALTER TABLE "sprselectiveprocess" ADD PRIMARY KEY ("selectiveprocessid");

ALTER TABLE "sprselectiveprocess" ADD FOREIGN KEY ("companyid") REFERENCES "bascompanyconf"("companyid");

ALTER TABLE "sprselectiveprocess" ADD FOREIGN KEY ("periodid") REFERENCES "acdperiod"("periodid");

ALTER TABLE "sprselectiveprocess" ADD FOREIGN KEY ("institutionid") REFERENCES "basperson"("personid");

----------------------------------------------------------------------
-- --
--
-- Table: fincounter
-- Purpose: caixas (guiches)
--
-- --
----------------------------------------------------------------------

CREATE TABLE "fincounter" 
(
    "counterid"        integer, --Codigo que identifica o caixa
    "responsableid"    integer, --Funcionario responsavel pelo caixa
    "unitid"           integer, --Campus onde o caixa de encontra
    "isactive"         boolean --Define se o caixa esta ativo ou nao
) INHERITS ("baslog");

COMMENT ON TABLE "fincounter" IS 'caixas (guiches)';
COMMENT ON COLUMN "fincounter"."counterid" IS 'Codigo que identifica o caixa';
COMMENT ON COLUMN "fincounter"."responsableid" IS 'Funcionario responsavel pelo caixa';
COMMENT ON COLUMN "fincounter"."unitid" IS 'Campus onde o caixa de encontra';
COMMENT ON COLUMN "fincounter"."isactive" IS 'Define se o caixa esta ativo ou nao';

CREATE SEQUENCE "seq_counterid";
ALTER TABLE "fincounter" ALTER COLUMN "counterid" SET DEFAULT NEXTVAL('"seq_counterid"');
ALTER TABLE "fincounter" ALTER COLUMN "responsableid" SET NOT NULL;
ALTER TABLE "fincounter" ALTER COLUMN "unitid" SET NOT NULL;
ALTER TABLE "fincounter" ALTER COLUMN "isactive" SET NOT NULL;
ALTER TABLE "fincounter" ALTER COLUMN "isactive" SET DEFAULT TRUE ;

ALTER TABLE "fincounter" ALTER COLUMN "counterid" SET NOT NULL;
ALTER TABLE "fincounter" ADD PRIMARY KEY ("counterid");

ALTER TABLE "fincounter" ADD FOREIGN KEY ("unitid") REFERENCES "basunit"("unitid");

ALTER TABLE "fincounter" ADD FOREIGN KEY ("responsableid") REFERENCES "basphysicalperson"("personid");

ALTER TABLE "fincounter" ADD FOREIGN KEY ("responsableid") REFERENCES "basperson"("personid");

----------------------------------------------------------------------
-- --
--
-- Table: sprinscriptionsetting
-- Purpose: configuracoes das inscricoes do vestibular
--
-- --
----------------------------------------------------------------------

CREATE TABLE "sprinscriptionsetting" 
(
    "selectiveprocessid"    varchar(10), --Codigo do processo seletivo
    "begindate"             date, --Data inicial do periodo de inscricoes
    "enddate"               date, --Data final do periodo de inscricoes
    "beginhour"             time, --Hora de inicio das inscricoes 
    "endhour"               time, --Hora final do periodo de inscricoes
    "fee"                   numeric(14, 4), --Taxa de inscricao
    "invoiceprefix"         text, --Obsoleto. Prefixo dos titulos financeiros para o processo seletivo. Campo utilizado apenas para importacao de dados.
    "emailadmin"            text, --Email da adminitracao do processo seletivo
    "issocialeconomic"      boolean --Flag se terá ou não formulário sócio econômico no processo seletivo
) INHERITS ("baslog");

COMMENT ON TABLE "sprinscriptionsetting" IS 'configuracoes das inscricoes do vestibular';
COMMENT ON COLUMN "sprinscriptionsetting"."selectiveprocessid" IS 'Codigo do processo seletivo';
COMMENT ON COLUMN "sprinscriptionsetting"."begindate" IS 'Data inicial do periodo de inscricoes';
COMMENT ON COLUMN "sprinscriptionsetting"."enddate" IS 'Data final do periodo de inscricoes';
COMMENT ON COLUMN "sprinscriptionsetting"."beginhour" IS 'Hora de inicio das inscricoes ';
COMMENT ON COLUMN "sprinscriptionsetting"."endhour" IS 'Hora final do periodo de inscricoes';
COMMENT ON COLUMN "sprinscriptionsetting"."fee" IS 'Taxa de inscricao';
COMMENT ON COLUMN "sprinscriptionsetting"."invoiceprefix" IS 'Obsoleto. Prefixo dos titulos financeiros para o processo seletivo. Campo utilizado apenas para importacao de dados.';
COMMENT ON COLUMN "sprinscriptionsetting"."emailadmin" IS 'Email da adminitracao do processo seletivo';
COMMENT ON COLUMN "sprinscriptionsetting"."issocialeconomic" IS 'Flag se terá ou não formulário sócio econômico no processo seletivo';

ALTER TABLE "sprinscriptionsetting" ALTER COLUMN "selectiveprocessid" SET NOT NULL;
ALTER TABLE "sprinscriptionsetting" ALTER COLUMN "begindate" SET NOT NULL;
ALTER TABLE "sprinscriptionsetting" ALTER COLUMN "enddate" SET NOT NULL;
ALTER TABLE "sprinscriptionsetting" ALTER COLUMN "beginhour" SET NOT NULL;
ALTER TABLE "sprinscriptionsetting" ALTER COLUMN "endhour" SET NOT NULL;
ALTER TABLE "sprinscriptionsetting" ALTER COLUMN "fee" SET NOT NULL;
ALTER TABLE "sprinscriptionsetting" ALTER COLUMN "emailadmin" SET NOT NULL;
ALTER TABLE "sprinscriptionsetting" ALTER COLUMN "issocialeconomic" SET NOT NULL;
ALTER TABLE "sprinscriptionsetting" ALTER COLUMN "issocialeconomic" SET DEFAULT FALSE ;

ALTER TABLE "sprinscriptionsetting" ALTER COLUMN "selectiveprocessid" SET NOT NULL;
ALTER TABLE "sprinscriptionsetting" ADD PRIMARY KEY ("selectiveprocessid");

ALTER TABLE "sprinscriptionsetting" ADD FOREIGN KEY ("selectiveprocessid") REFERENCES "sprselectiveprocess"("selectiveprocessid");

----------------------------------------------------------------------
-- --
--
-- Table: basphysicalpersonstudent
-- Purpose: pessoa fisica - estudante
--
-- --
----------------------------------------------------------------------

CREATE TABLE "basphysicalpersonstudent" 
(
    "externalcourseidhs"    integer, --Codigo do curso de ensino medio
    "institutionidhs"       integer, --Codigo da instituicao do ensino medio
    "cityidhs"              integer, --Codigo da cidade do ensino medio
    "yearhs"                integer, --Ano de conclusao do ensino medio
    "isinsured"             boolean, --E segurado
    "passive"               varchar(20) --Passivo
) INHERITS ("basphysicalperson");

COMMENT ON TABLE "basphysicalpersonstudent" IS 'pessoa fisica - estudante';
COMMENT ON COLUMN "basphysicalpersonstudent"."externalcourseidhs" IS 'Codigo do curso de ensino medio';
COMMENT ON COLUMN "basphysicalpersonstudent"."institutionidhs" IS 'Codigo da instituicao do ensino medio';
COMMENT ON COLUMN "basphysicalpersonstudent"."cityidhs" IS 'Codigo da cidade do ensino medio';
COMMENT ON COLUMN "basphysicalpersonstudent"."yearhs" IS 'Ano de conclusao do ensino medio';
COMMENT ON COLUMN "basphysicalpersonstudent"."isinsured" IS 'E segurado';
COMMENT ON COLUMN "basphysicalpersonstudent"."passive" IS 'Passivo';

ALTER TABLE "basphysicalpersonstudent" ALTER COLUMN "isinsured" SET NOT NULL;
ALTER TABLE "basphysicalpersonstudent" ALTER COLUMN "isinsured" SET DEFAULT FALSE ;

ALTER TABLE "basphysicalpersonstudent" ALTER COLUMN "personid" SET NOT NULL;
ALTER TABLE "basphysicalpersonstudent" ADD PRIMARY KEY ("personid");

ALTER TABLE "basphysicalpersonstudent" ADD FOREIGN KEY ("cityidhs") REFERENCES "bascity"("cityid");

ALTER TABLE "basphysicalpersonstudent" ADD FOREIGN KEY ("externalcourseidhs") REFERENCES "acdexternalcourse"("externalcourseid");

ALTER TABLE "basphysicalpersonstudent" ADD FOREIGN KEY ("institutionidhs") REFERENCES "baslegalperson"("personid");

----------------------------------------------------------------------
-- --
--
-- Table: basphysicalpersonemployee
-- Purpose: pessoa fisica - funcionario
--
-- --
----------------------------------------------------------------------

CREATE TABLE "basphysicalpersonemployee" 
(
) INHERITS ("basphysicalperson");

COMMENT ON TABLE "basphysicalpersonemployee" IS 'pessoa fisica - funcionario';

ALTER TABLE "basphysicalpersonemployee" ALTER COLUMN "personid" SET NOT NULL;
ALTER TABLE "basphysicalpersonemployee" ADD PRIMARY KEY ("personid");

----------------------------------------------------------------------
-- --
--
-- Table: insphysicalresource
-- Purpose: recursos fisicos
--
-- --
----------------------------------------------------------------------

CREATE TABLE "insphysicalresource" 
(
    "physicalresourceid"         integer, --Codigo do recurso fisico
    "physicalresourceversion"    integer, --Versao do recurso fisico
    "dateversion"                date, --Data da versao
    "description"                text, --Descricao
    "grouptypeid"                integer, --Codigo do grupo
    "room"                       varchar(50), --Sala
    "building"                   varchar(10), --Predio
    "coord"                      integer, --Coordenacao
    "aream2"                     float, --Area em metros quadrados
    "areatype"                   char(1), --Tipo de area
    "costcenter"                 integer, --Centro de custo
    "unitid"                     integer --Referencia para o campo unitId da tabela basUnit
) INHERITS ("baslog");

COMMENT ON TABLE "insphysicalresource" IS 'recursos fisicos';
COMMENT ON COLUMN "insphysicalresource"."physicalresourceid" IS 'Codigo do recurso fisico';
COMMENT ON COLUMN "insphysicalresource"."physicalresourceversion" IS 'Versao do recurso fisico';
COMMENT ON COLUMN "insphysicalresource"."dateversion" IS 'Data da versao';
COMMENT ON COLUMN "insphysicalresource"."description" IS 'Descricao';
COMMENT ON COLUMN "insphysicalresource"."grouptypeid" IS 'Codigo do grupo';
COMMENT ON COLUMN "insphysicalresource"."room" IS 'Sala';
COMMENT ON COLUMN "insphysicalresource"."building" IS 'Predio';
COMMENT ON COLUMN "insphysicalresource"."coord" IS 'Coordenacao';
COMMENT ON COLUMN "insphysicalresource"."aream2" IS 'Area em metros quadrados';
COMMENT ON COLUMN "insphysicalresource"."areatype" IS 'Tipo de area';
COMMENT ON COLUMN "insphysicalresource"."costcenter" IS 'Centro de custo';
COMMENT ON COLUMN "insphysicalresource"."unitid" IS 'Referencia para o campo unitId da tabela basUnit';

CREATE SEQUENCE "seq_physicalresourceid";
ALTER TABLE "insphysicalresource" ALTER COLUMN "physicalresourceid" SET DEFAULT NEXTVAL('"seq_physicalresourceid"');
ALTER TABLE "insphysicalresource" ALTER COLUMN "physicalresourceversion" SET NOT NULL;
ALTER TABLE "insphysicalresource" ALTER COLUMN "dateversion" SET NOT NULL;
ALTER TABLE "insphysicalresource" ALTER COLUMN "description" SET NOT NULL;
ALTER TABLE "insphysicalresource" ALTER COLUMN "grouptypeid" SET NOT NULL;
ALTER TABLE "insphysicalresource" ALTER COLUMN "unitid" SET NOT NULL;

ALTER TABLE "insphysicalresource" ALTER COLUMN "physicalresourceid" SET NOT NULL;
ALTER TABLE "insphysicalresource" ALTER COLUMN "physicalresourceversion" SET NOT NULL;
ALTER TABLE "insphysicalresource" ADD PRIMARY KEY ("physicalresourceid","physicalresourceversion");

ALTER TABLE "insphysicalresource" ADD FOREIGN KEY ("grouptypeid") REFERENCES "insgrouptype"("grouptypeid");

ALTER TABLE "insphysicalresource" ADD FOREIGN KEY ("coord") REFERENCES "basphysicalperson"("personid");

ALTER TABLE "insphysicalresource" ADD FOREIGN KEY ("unitid") REFERENCES "basunit"("unitid");

----------------------------------------------------------------------
-- --
--
-- Table: sprplaceoccurrence
-- Purpose: cadastro de locais de prova disponibilizados para o 
--          processo seletivo 
--
-- --
----------------------------------------------------------------------

CREATE TABLE "sprplaceoccurrence" 
(
    "selectiveprocessid"    varchar(10), --Codigo do processo seletivo
    "placeid"               integer --Codigo do local
) INHERITS ("baslog");

COMMENT ON TABLE "sprplaceoccurrence" IS 'cadastro de locais de prova disponibilizados para o processo seletivo';
COMMENT ON COLUMN "sprplaceoccurrence"."selectiveprocessid" IS 'Codigo do processo seletivo';
COMMENT ON COLUMN "sprplaceoccurrence"."placeid" IS 'Codigo do local';

ALTER TABLE "sprplaceoccurrence" ALTER COLUMN "selectiveprocessid" SET NOT NULL;
ALTER TABLE "sprplaceoccurrence" ALTER COLUMN "placeid" SET NOT NULL;

ALTER TABLE "sprplaceoccurrence" ALTER COLUMN "selectiveprocessid" SET NOT NULL;
ALTER TABLE "sprplaceoccurrence" ALTER COLUMN "placeid" SET NOT NULL;
ALTER TABLE "sprplaceoccurrence" ADD PRIMARY KEY ("selectiveprocessid","placeid");

ALTER TABLE "sprplaceoccurrence" ADD FOREIGN KEY ("selectiveprocessid") REFERENCES "sprselectiveprocess"("selectiveprocessid");

ALTER TABLE "sprplaceoccurrence" ADD FOREIGN KEY ("placeid") REFERENCES "sprplace"("placeid");

----------------------------------------------------------------------
-- --
--
-- Table: sprlanguageoccurrence
-- Purpose: ocorrencias das linguas estrangeiras para um processo 
--          seletivo 
--
-- --
----------------------------------------------------------------------

CREATE TABLE "sprlanguageoccurrence" 
(
    "selectiveprocessid"    varchar(10), --Codigo do processo seletivo
    "languageid"            integer --Codigo da lingua
) INHERITS ("baslog");

COMMENT ON TABLE "sprlanguageoccurrence" IS 'ocorrencias das linguas estrangeiras para um processo seletivo';
COMMENT ON COLUMN "sprlanguageoccurrence"."selectiveprocessid" IS 'Codigo do processo seletivo';
COMMENT ON COLUMN "sprlanguageoccurrence"."languageid" IS 'Codigo da lingua';

ALTER TABLE "sprlanguageoccurrence" ALTER COLUMN "selectiveprocessid" SET NOT NULL;
ALTER TABLE "sprlanguageoccurrence" ALTER COLUMN "languageid" SET NOT NULL;

ALTER TABLE "sprlanguageoccurrence" ALTER COLUMN "selectiveprocessid" SET NOT NULL;
ALTER TABLE "sprlanguageoccurrence" ALTER COLUMN "languageid" SET NOT NULL;
ALTER TABLE "sprlanguageoccurrence" ADD PRIMARY KEY ("selectiveprocessid","languageid");

ALTER TABLE "sprlanguageoccurrence" ADD FOREIGN KEY ("selectiveprocessid") REFERENCES "sprselectiveprocess"("selectiveprocessid");

ALTER TABLE "sprlanguageoccurrence" ADD FOREIGN KEY ("languageid") REFERENCES "sprlanguage"("languageid");

----------------------------------------------------------------------
-- --
--
-- Table: sprothersattleofmatter
-- Purpose: outros criterios de desempate do processo seletivo, 
--          utilizados caso os criterios de desempate nao sejam 
--          suficientes 
--
-- --
----------------------------------------------------------------------

CREATE TABLE "sprothersattleofmatter" 
(
    "othersattleofmatterid"    integer, --Codigo do outro criterio de desempate
    "selectiveprocessid"       varchar(10), --Codigo do processo seletivo
    "tablename"                text, --Nome da tabela que deve ser considerada
    "fieldname"                text, --Campo que deve ser considerado 
    "priority"                 integer, --Prioridade do criterio. Somente usado depois dos critérios tradicionais. Pode iniciar em 1 novamente
    "orderby"                  varchar(10) --Tipo de ordenacao (asc, desc)
) INHERITS ("baslog");

COMMENT ON TABLE "sprothersattleofmatter" IS 'outros criterios de desempate do processo seletivo, utilizados caso os criterios de desempate nao sejam suficientes';
COMMENT ON COLUMN "sprothersattleofmatter"."othersattleofmatterid" IS 'Codigo do outro criterio de desempate';
COMMENT ON COLUMN "sprothersattleofmatter"."selectiveprocessid" IS 'Codigo do processo seletivo';
COMMENT ON COLUMN "sprothersattleofmatter"."tablename" IS 'Nome da tabela que deve ser considerada';
COMMENT ON COLUMN "sprothersattleofmatter"."fieldname" IS 'Campo que deve ser considerado ';
COMMENT ON COLUMN "sprothersattleofmatter"."priority" IS 'Prioridade do criterio. Somente usado depois dos critérios tradicionais. Pode iniciar em 1 novamente';
COMMENT ON COLUMN "sprothersattleofmatter"."orderby" IS 'Tipo de ordenacao (asc, desc)';

CREATE SEQUENCE "seq_othersattleofmatterid";
ALTER TABLE "sprothersattleofmatter" ALTER COLUMN "othersattleofmatterid" SET DEFAULT NEXTVAL('"seq_othersattleofmatterid"');
ALTER TABLE "sprothersattleofmatter" ALTER COLUMN "selectiveprocessid" SET NOT NULL;
ALTER TABLE "sprothersattleofmatter" ALTER COLUMN "tablename" SET NOT NULL;
ALTER TABLE "sprothersattleofmatter" ALTER COLUMN "fieldname" SET NOT NULL;
ALTER TABLE "sprothersattleofmatter" ALTER COLUMN "priority" SET NOT NULL;
ALTER TABLE "sprothersattleofmatter" ALTER COLUMN "orderby" SET DEFAULT 'ASC';

ALTER TABLE "sprothersattleofmatter" ALTER COLUMN "othersattleofmatterid" SET NOT NULL;
ALTER TABLE "sprothersattleofmatter" ADD PRIMARY KEY ("othersattleofmatterid");

ALTER TABLE "sprothersattleofmatter" ADD FOREIGN KEY ("selectiveprocessid") REFERENCES "sprselectiveprocess"("selectiveprocessid");

----------------------------------------------------------------------
-- --
--
-- Table: rshwho
-- Purpose: publico que responde a pesquisa
--
-- --
----------------------------------------------------------------------

CREATE TABLE "rshwho" 
(
    "formid"      integer, --Codigo do questionario
    "personid"    integer --Codigo da pessoa
) INHERITS ("baslog");

COMMENT ON TABLE "rshwho" IS 'publico que responde a pesquisa';
COMMENT ON COLUMN "rshwho"."formid" IS 'Codigo do questionario';
COMMENT ON COLUMN "rshwho"."personid" IS 'Codigo da pessoa';

ALTER TABLE "rshwho" ALTER COLUMN "formid" SET NOT NULL;
ALTER TABLE "rshwho" ALTER COLUMN "personid" SET NOT NULL;

ALTER TABLE "rshwho" ALTER COLUMN "formid" SET NOT NULL;
ALTER TABLE "rshwho" ALTER COLUMN "personid" SET NOT NULL;
ALTER TABLE "rshwho" ADD PRIMARY KEY ("formid","personid");

ALTER TABLE "rshwho" ADD FOREIGN KEY ("formid") REFERENCES "rshform"("formid");

ALTER TABLE "rshwho" ADD FOREIGN KEY ("personid") REFERENCES "basphysicalperson"("personid");

----------------------------------------------------------------------
-- --
--
-- Table: bassectorboss
-- Purpose: chefes de setores
--
-- --
----------------------------------------------------------------------

CREATE TABLE "bassectorboss" 
(
    "bossid"             integer, --Codigo do chefe de setor
    "sectorid"           integer, --Codigo do setor
    "level"              integer, --Nivel
    "expirationlevel"    interval, --Nivel de expiracao
    "issendemail"        boolean, --Envia/recebe emails
    "email"              varchar(60) --Email
) INHERITS ("baslog");

COMMENT ON TABLE "bassectorboss" IS 'chefes de setores';
COMMENT ON COLUMN "bassectorboss"."bossid" IS 'Codigo do chefe de setor';
COMMENT ON COLUMN "bassectorboss"."sectorid" IS 'Codigo do setor';
COMMENT ON COLUMN "bassectorboss"."level" IS 'Nivel';
COMMENT ON COLUMN "bassectorboss"."expirationlevel" IS 'Nivel de expiracao';
COMMENT ON COLUMN "bassectorboss"."issendemail" IS 'Envia/recebe emails';
COMMENT ON COLUMN "bassectorboss"."email" IS 'Email';

CREATE SEQUENCE "seq_bossid";
ALTER TABLE "bassectorboss" ALTER COLUMN "bossid" SET DEFAULT NEXTVAL('"seq_bossid"');
ALTER TABLE "bassectorboss" ALTER COLUMN "sectorid" SET NOT NULL;
ALTER TABLE "bassectorboss" ALTER COLUMN "level" SET NOT NULL;
ALTER TABLE "bassectorboss" ALTER COLUMN "expirationlevel" SET NOT NULL;
ALTER TABLE "bassectorboss" ALTER COLUMN "issendemail" SET NOT NULL;
ALTER TABLE "bassectorboss" ALTER COLUMN "issendemail" SET DEFAULT TRUE ;
ALTER TABLE "bassectorboss" ALTER COLUMN "email" SET NOT NULL;

ALTER TABLE "bassectorboss" ALTER COLUMN "bossid" SET NOT NULL;
ALTER TABLE "bassectorboss" ALTER COLUMN "sectorid" SET NOT NULL;
ALTER TABLE "bassectorboss" ADD PRIMARY KEY ("bossid","sectorid");

ALTER TABLE "bassectorboss" ADD FOREIGN KEY ("bossid") REFERENCES "basphysicalperson"("personid");

ALTER TABLE "bassectorboss" ADD FOREIGN KEY ("sectorid") REFERENCES "bassector"("sectorid");

----------------------------------------------------------------------
-- --
--
-- Table: basstamp
-- Purpose: carimbos
--
-- --
----------------------------------------------------------------------

CREATE TABLE "basstamp" 
(
    "stampid"                integer, --Codigo do carimbo
    "personid"               integer, --Codigo da pessoa
    "functiondescription"    text, --Cargo
    "register"               text --Portaria
) INHERITS ("baslog");

COMMENT ON TABLE "basstamp" IS 'carimbos';
COMMENT ON COLUMN "basstamp"."stampid" IS 'Codigo do carimbo';
COMMENT ON COLUMN "basstamp"."personid" IS 'Codigo da pessoa';
COMMENT ON COLUMN "basstamp"."functiondescription" IS 'Cargo';
COMMENT ON COLUMN "basstamp"."register" IS 'Portaria';

CREATE SEQUENCE "seq_stampid";
ALTER TABLE "basstamp" ALTER COLUMN "stampid" SET DEFAULT NEXTVAL('"seq_stampid"');
ALTER TABLE "basstamp" ALTER COLUMN "personid" SET NOT NULL;
ALTER TABLE "basstamp" ALTER COLUMN "functiondescription" SET NOT NULL;

ALTER TABLE "basstamp" ALTER COLUMN "stampid" SET NOT NULL;
ALTER TABLE "basstamp" ADD PRIMARY KEY ("stampid");

CREATE INDEX "idx_basstamp_personid" ON "basstamp" ("personid");

ALTER TABLE "basstamp" ADD FOREIGN KEY ("personid") REFERENCES "basphysicalperson"("personid");

----------------------------------------------------------------------
-- --
--
-- Table: basdocument
-- Purpose: documentos dos alunos
--
-- --
----------------------------------------------------------------------

CREATE TABLE "basdocument" 
(
    "personid"          integer, --Codigo da pessoa
    "documenttypeid"    integer, --Codigo do tipo do documento
    "content"           text, --numero, texto ou valor do documento
    "isdelivered"       boolean, --se o documento foi entregue ou nao
    "cityid"            integer, --Cidade de expedição do documento, se for necessario
    "organ"             varchar(15), --Orgao Expedidor do documento, se for necessario
    "dateexpedition"    date, --Data de expedicao do documento, se for necessario
    "obs"               text, --Eventual observacao
    "isexcused"         boolean --Campo para setar se determinada pessoa está dispensada de apresentar este documento
) INHERITS ("baslog");

COMMENT ON TABLE "basdocument" IS 'documentos dos alunos';
COMMENT ON COLUMN "basdocument"."personid" IS 'Codigo da pessoa';
COMMENT ON COLUMN "basdocument"."documenttypeid" IS 'Codigo do tipo do documento';
COMMENT ON COLUMN "basdocument"."content" IS 'numero, texto ou valor do documento';
COMMENT ON COLUMN "basdocument"."isdelivered" IS 'se o documento foi entregue ou nao';
COMMENT ON COLUMN "basdocument"."cityid" IS 'Cidade de expedição do documento, se for necessario';
COMMENT ON COLUMN "basdocument"."organ" IS 'Orgao Expedidor do documento, se for necessario';
COMMENT ON COLUMN "basdocument"."dateexpedition" IS 'Data de expedicao do documento, se for necessario';
COMMENT ON COLUMN "basdocument"."obs" IS 'Eventual observacao';
COMMENT ON COLUMN "basdocument"."isexcused" IS 'Campo para setar se determinada pessoa está dispensada de apresentar este documento';

ALTER TABLE "basdocument" ALTER COLUMN "personid" SET NOT NULL;
ALTER TABLE "basdocument" ALTER COLUMN "documenttypeid" SET NOT NULL;
ALTER TABLE "basdocument" ALTER COLUMN "isdelivered" SET NOT NULL;
ALTER TABLE "basdocument" ALTER COLUMN "isdelivered" SET DEFAULT FALSE ;
ALTER TABLE "basdocument" ALTER COLUMN "isexcused" SET NOT NULL;
ALTER TABLE "basdocument" ALTER COLUMN "isexcused" SET DEFAULT FALSE ;

ALTER TABLE "basdocument" ALTER COLUMN "personid" SET NOT NULL;
ALTER TABLE "basdocument" ALTER COLUMN "documenttypeid" SET NOT NULL;
ALTER TABLE "basdocument" ADD PRIMARY KEY ("personid","documenttypeid");

ALTER TABLE "basdocument" ADD FOREIGN KEY ("personid") REFERENCES "basphysicalperson"("personid");

ALTER TABLE "basdocument" ADD FOREIGN KEY ("documenttypeid") REFERENCES "basdocumenttype"("documenttypeid");

ALTER TABLE "basdocument" ADD FOREIGN KEY ("cityid") REFERENCES "bascity"("cityid");

----------------------------------------------------------------------
-- --
--
-- Table: sprselectiveprocessoccurrence
-- Purpose: ocorrencias de outros processos seletivos (enem, pie, 
--          etc...) 
--
-- --
----------------------------------------------------------------------

CREATE TABLE "sprselectiveprocessoccurrence" 
(
    "selectiveprocesstypeid"    integer, --Codigo do tipo de processo seletivo
    "selectiveprocessid"        varchar(10), --Codigo do processo seletivo
    "ismain"                    boolean, --Se e o processo seletivo principal
    "priority"                  integer --Prioridade do processo seletivo (1 e o principal)
) INHERITS ("baslog");

COMMENT ON TABLE "sprselectiveprocessoccurrence" IS 'ocorrencias de outros processos seletivos (enem, pie, etc...)';
COMMENT ON COLUMN "sprselectiveprocessoccurrence"."selectiveprocesstypeid" IS 'Codigo do tipo de processo seletivo';
COMMENT ON COLUMN "sprselectiveprocessoccurrence"."selectiveprocessid" IS 'Codigo do processo seletivo';
COMMENT ON COLUMN "sprselectiveprocessoccurrence"."ismain" IS 'Se e o processo seletivo principal';
COMMENT ON COLUMN "sprselectiveprocessoccurrence"."priority" IS 'Prioridade do processo seletivo (1 e o principal)';

ALTER TABLE "sprselectiveprocessoccurrence" ALTER COLUMN "selectiveprocesstypeid" SET NOT NULL;
ALTER TABLE "sprselectiveprocessoccurrence" ALTER COLUMN "selectiveprocessid" SET NOT NULL;
ALTER TABLE "sprselectiveprocessoccurrence" ALTER COLUMN "ismain" SET NOT NULL;
ALTER TABLE "sprselectiveprocessoccurrence" ALTER COLUMN "ismain" SET DEFAULT FALSE ;
ALTER TABLE "sprselectiveprocessoccurrence" ALTER COLUMN "priority" SET NOT NULL;

ALTER TABLE "sprselectiveprocessoccurrence" ALTER COLUMN "selectiveprocesstypeid" SET NOT NULL;
ALTER TABLE "sprselectiveprocessoccurrence" ALTER COLUMN "selectiveprocessid" SET NOT NULL;
ALTER TABLE "sprselectiveprocessoccurrence" ADD PRIMARY KEY ("selectiveprocesstypeid","selectiveprocessid");

CREATE UNIQUE INDEX "idx_unique_selective_process_id_priority" ON "sprselectiveprocessoccurrence" ("selectiveprocessid","priority");

ALTER TABLE "sprselectiveprocessoccurrence" ADD FOREIGN KEY ("selectiveprocesstypeid") REFERENCES "sprselectiveprocesstype"("selectiveprocesstypeid");

ALTER TABLE "sprselectiveprocessoccurrence" ADD FOREIGN KEY ("selectiveprocessid") REFERENCES "sprselectiveprocess"("selectiveprocessid");

----------------------------------------------------------------------
-- --
--
-- Table: spranswersheet
-- Purpose: gabarito
--
-- --
----------------------------------------------------------------------

CREATE TABLE "spranswersheet" 
(
    "selectiveprocessid"    varchar(10), --Codigo do processo seletivo
    "numberquestion"        integer, --Numero da questao
    "option"                char(1) --Alternativa correta
) INHERITS ("baslog");

COMMENT ON TABLE "spranswersheet" IS 'gabarito';
COMMENT ON COLUMN "spranswersheet"."selectiveprocessid" IS 'Codigo do processo seletivo';
COMMENT ON COLUMN "spranswersheet"."numberquestion" IS 'Numero da questao';
COMMENT ON COLUMN "spranswersheet"."option" IS 'Alternativa correta';

ALTER TABLE "spranswersheet" ALTER COLUMN "selectiveprocessid" SET NOT NULL;
ALTER TABLE "spranswersheet" ALTER COLUMN "numberquestion" SET NOT NULL;
ALTER TABLE "spranswersheet" ALTER COLUMN "option" SET NOT NULL;

ALTER TABLE "spranswersheet" ALTER COLUMN "selectiveprocessid" SET NOT NULL;
ALTER TABLE "spranswersheet" ALTER COLUMN "numberquestion" SET NOT NULL;
ALTER TABLE "spranswersheet" ADD PRIMARY KEY ("selectiveprocessid","numberquestion");

ALTER TABLE "spranswersheet" ADD FOREIGN KEY ("selectiveprocessid") REFERENCES "sprselectiveprocess"("selectiveprocessid");

----------------------------------------------------------------------
-- --
--
-- Table: basphysicalpersonprofessor
-- Purpose: pessoa fisica - professor
--
-- --
----------------------------------------------------------------------

CREATE TABLE "basphysicalpersonprofessor" 
(
) INHERITS ("basphysicalperson");

COMMENT ON TABLE "basphysicalpersonprofessor" IS 'pessoa fisica - professor';

ALTER TABLE "basphysicalpersonprofessor" ALTER COLUMN "personid" SET NOT NULL;
ALTER TABLE "basphysicalpersonprofessor" ADD PRIMARY KEY ("personid");

----------------------------------------------------------------------
-- --
--
-- Table: sprcoursevacant
-- Purpose: vagas dos cursos disponiveis para o processo seletivo
--
-- --
----------------------------------------------------------------------

CREATE TABLE "sprcoursevacant" 
(
    "coursevacantid"        integer, --Codigo das vagas
    "selectiveprocessid"    varchar(10), --Codigo do processo seletivo
    "vacant"                integer, --Vagas
    "description"           text --Valor padrao deste campo sera o nome do curso. Quando agrupa-se mais de um curso, se da um nome para o agrupamento.
) INHERITS ("baslog");

COMMENT ON TABLE "sprcoursevacant" IS 'vagas dos cursos disponiveis para o processo seletivo';
COMMENT ON COLUMN "sprcoursevacant"."coursevacantid" IS 'Codigo das vagas';
COMMENT ON COLUMN "sprcoursevacant"."selectiveprocessid" IS 'Codigo do processo seletivo';
COMMENT ON COLUMN "sprcoursevacant"."vacant" IS 'Vagas';
COMMENT ON COLUMN "sprcoursevacant"."description" IS 'Valor padrao deste campo sera o nome do curso. Quando agrupa-se mais de um curso, se da um nome para o agrupamento.';

CREATE SEQUENCE "seq_coursevacantid";
ALTER TABLE "sprcoursevacant" ALTER COLUMN "coursevacantid" SET DEFAULT NEXTVAL('"seq_coursevacantid"');
ALTER TABLE "sprcoursevacant" ALTER COLUMN "selectiveprocessid" SET NOT NULL;
ALTER TABLE "sprcoursevacant" ALTER COLUMN "vacant" SET NOT NULL;
ALTER TABLE "sprcoursevacant" ALTER COLUMN "description" SET NOT NULL;

ALTER TABLE "sprcoursevacant" ALTER COLUMN "coursevacantid" SET NOT NULL;
ALTER TABLE "sprcoursevacant" ADD PRIMARY KEY ("coursevacantid");

ALTER TABLE "sprcoursevacant" ADD FOREIGN KEY ("selectiveprocessid") REFERENCES "sprselectiveprocess"("selectiveprocessid");

----------------------------------------------------------------------
-- --
--
-- Table: finclosecounter
-- Purpose: fechamentos de caixa
--
-- --
----------------------------------------------------------------------

CREATE TABLE "finclosecounter" 
(
    "closecounterid"    integer, --Codigo do fechamento de caixa
    "operatorid"        integer, --Funcionario responsavel pelo Caixa
    "value"             numeric(14,2), --Valor de fechamento
    "registerdate"      date, --Data do registro do caixa
    "operation"         char(1), --Credito (C) ou Debito (D)
    "counterid"         integer, --Codigo do caixa (finCounter)
    "isclosed"          boolean --Define se o fechamento de caixa e parcial ou total
) INHERITS ("baslog");

COMMENT ON TABLE "finclosecounter" IS 'fechamentos de caixa';
COMMENT ON COLUMN "finclosecounter"."closecounterid" IS 'Codigo do fechamento de caixa';
COMMENT ON COLUMN "finclosecounter"."operatorid" IS 'Funcionario responsavel pelo Caixa';
COMMENT ON COLUMN "finclosecounter"."value" IS 'Valor de fechamento';
COMMENT ON COLUMN "finclosecounter"."registerdate" IS 'Data do registro do caixa';
COMMENT ON COLUMN "finclosecounter"."operation" IS 'Credito (C) ou Debito (D)';
COMMENT ON COLUMN "finclosecounter"."counterid" IS 'Codigo do caixa (finCounter)';
COMMENT ON COLUMN "finclosecounter"."isclosed" IS 'Define se o fechamento de caixa e parcial ou total';

CREATE SEQUENCE "seq_closecounterid";
ALTER TABLE "finclosecounter" ALTER COLUMN "closecounterid" SET DEFAULT NEXTVAL('"seq_closecounterid"');
ALTER TABLE "finclosecounter" ALTER COLUMN "operatorid" SET NOT NULL;
ALTER TABLE "finclosecounter" ALTER COLUMN "value" SET NOT NULL;
ALTER TABLE "finclosecounter" ALTER COLUMN "registerdate" SET DEFAULT now();
ALTER TABLE "finclosecounter" ALTER COLUMN "operation" SET NOT NULL;
ALTER TABLE "finclosecounter" ALTER COLUMN "counterid" SET NOT NULL;
ALTER TABLE "finclosecounter" ALTER COLUMN "isclosed" SET NOT NULL;
ALTER TABLE "finclosecounter" ALTER COLUMN "isclosed" SET DEFAULT FALSE ;

ALTER TABLE "finclosecounter" ALTER COLUMN "closecounterid" SET NOT NULL;
ALTER TABLE "finclosecounter" ADD PRIMARY KEY ("closecounterid");

ALTER TABLE "finclosecounter" ADD FOREIGN KEY ("operatorid") REFERENCES "basphysicalperson"("personid");

ALTER TABLE "finclosecounter" ADD FOREIGN KEY ("counterid") REFERENCES "fincounter"("counterid");

----------------------------------------------------------------------
-- --
--
-- Table: fincountermovement
-- Purpose: movimentacao do caixa
--
-- --
----------------------------------------------------------------------

CREATE TABLE "fincountermovement" 
(
    "countermovementid"    integer, --Codigo identificador da movimentacao de caixa
    "counterid"            integer, --Codigo identificador do caixa (finCounter)
    "operatorid"           integer, --Funcionario operador do caixa
    "value"                numeric(14,4), --Valor da movimentacao
    "movementdate"         timestamp, --Data e horario da movimentacao do caixa
    "operation"            char(1), --Credito (C) ou Débito (D)
    "speciesid"            integer --Especie monetaria (finSpecies)
) INHERITS ("baslog");

COMMENT ON TABLE "fincountermovement" IS 'movimentacao do caixa';
COMMENT ON COLUMN "fincountermovement"."countermovementid" IS 'Codigo identificador da movimentacao de caixa';
COMMENT ON COLUMN "fincountermovement"."counterid" IS 'Codigo identificador do caixa (finCounter)';
COMMENT ON COLUMN "fincountermovement"."operatorid" IS 'Funcionario operador do caixa';
COMMENT ON COLUMN "fincountermovement"."value" IS 'Valor da movimentacao';
COMMENT ON COLUMN "fincountermovement"."movementdate" IS 'Data e horario da movimentacao do caixa';
COMMENT ON COLUMN "fincountermovement"."operation" IS 'Credito (C) ou Débito (D)';
COMMENT ON COLUMN "fincountermovement"."speciesid" IS 'Especie monetaria (finSpecies)';

CREATE SEQUENCE "seq_countermovementid";
ALTER TABLE "fincountermovement" ALTER COLUMN "countermovementid" SET DEFAULT NEXTVAL('"seq_countermovementid"');
ALTER TABLE "fincountermovement" ALTER COLUMN "counterid" SET NOT NULL;
ALTER TABLE "fincountermovement" ALTER COLUMN "operatorid" SET NOT NULL;
ALTER TABLE "fincountermovement" ALTER COLUMN "value" SET NOT NULL;
ALTER TABLE "fincountermovement" ALTER COLUMN "movementdate" SET DEFAULT now();
ALTER TABLE "fincountermovement" ALTER COLUMN "operation" SET NOT NULL;
ALTER TABLE "fincountermovement" ALTER COLUMN "speciesid" SET NOT NULL;

ALTER TABLE "fincountermovement" ALTER COLUMN "countermovementid" SET NOT NULL;
ALTER TABLE "fincountermovement" ADD PRIMARY KEY ("countermovementid");

ALTER TABLE "fincountermovement" ADD FOREIGN KEY ("counterid") REFERENCES "fincounter"("counterid");

ALTER TABLE "fincountermovement" ADD FOREIGN KEY ("operatorid") REFERENCES "basphysicalpersonemployee"("personid");

ALTER TABLE "fincountermovement" ADD FOREIGN KEY ("speciesid") REFERENCES "finspecies"("speciesid");

----------------------------------------------------------------------
-- --
--
-- Table: ccpcopy
-- Purpose: grava as copias que os alunos fizeram em um determinado 
--          periodo, numa sala/predio 
--
-- --
----------------------------------------------------------------------

CREATE TABLE "ccpcopy" 
(
    "copyid"                     integer, --Codigo identificador da copia
    "personid"                   integer, --Codigo identificador da pessoa
    "date"                       timestamp, --Data da copia
    "copiesnumber"               integer, --Numero de copias
    "physicalresourceid"         integer, --Codigo do recurso fisico
    "physicalresourceversion"    integer, --Versao do recurso fisico
    "periodid"                   varchar(10) --Codigo identificador do periodo
) INHERITS ("baslog");

COMMENT ON TABLE "ccpcopy" IS 'grava as copias que os alunos fizeram em um determinado periodo, numa sala/predio';
COMMENT ON COLUMN "ccpcopy"."copyid" IS 'Codigo identificador da copia';
COMMENT ON COLUMN "ccpcopy"."personid" IS 'Codigo identificador da pessoa';
COMMENT ON COLUMN "ccpcopy"."date" IS 'Data da copia';
COMMENT ON COLUMN "ccpcopy"."copiesnumber" IS 'Numero de copias';
COMMENT ON COLUMN "ccpcopy"."physicalresourceid" IS 'Codigo do recurso fisico';
COMMENT ON COLUMN "ccpcopy"."physicalresourceversion" IS 'Versao do recurso fisico';
COMMENT ON COLUMN "ccpcopy"."periodid" IS 'Codigo identificador do periodo';

CREATE SEQUENCE "seq_copyid";
ALTER TABLE "ccpcopy" ALTER COLUMN "copyid" SET DEFAULT NEXTVAL('"seq_copyid"');
ALTER TABLE "ccpcopy" ALTER COLUMN "personid" SET NOT NULL;
ALTER TABLE "ccpcopy" ALTER COLUMN "date" SET NOT NULL;
ALTER TABLE "ccpcopy" ALTER COLUMN "copiesnumber" SET NOT NULL;
ALTER TABLE "ccpcopy" ALTER COLUMN "physicalresourceid" SET NOT NULL;
ALTER TABLE "ccpcopy" ALTER COLUMN "physicalresourceversion" SET NOT NULL;
ALTER TABLE "ccpcopy" ALTER COLUMN "periodid" SET NOT NULL;

ALTER TABLE "ccpcopy" ALTER COLUMN "copyid" SET NOT NULL;
ALTER TABLE "ccpcopy" ADD PRIMARY KEY ("copyid");

ALTER TABLE "ccpcopy" ADD FOREIGN KEY ("physicalresourceid","physicalresourceversion") REFERENCES "insphysicalresource"("physicalresourceid","physicalresourceversion");

ALTER TABLE "ccpcopy" ADD FOREIGN KEY ("personid") REFERENCES "basphysicalperson"("personid");

ALTER TABLE "ccpcopy" ADD FOREIGN KEY ("periodid") REFERENCES "acdperiod"("periodid");

----------------------------------------------------------------------
-- --
--
-- Table: basemployee
-- Purpose: pessoa fisica - funcionario - quantas horas em cada codigo 
--          externo, salario e por mes ou por hora, um salario por 
--          contrato? dois contratos para o mesmo setor? data de 
--          ingresso... 
--
-- --
----------------------------------------------------------------------

CREATE TABLE "basemployee" 
(
    "employeeid"            integer, --Codigo do funcionario
    "personid"              integer, --Codigo da pessoa
    "externalid"            varchar(10), --Codigo no Siga
    "sectorid"              integer, --Codigo do setor
    "salary"                numeric(14,2), --Salario
    "valuehour"             boolean, --se o salário equivale ao valor da hora?
    "weeklyhours"           float, --Quantas horas semanais
    "begindate"             date, --Data inicial deste vinculo
    "enddate"               date, --Data final deste vinculo
    "employeetypeid"        integer, --Tipo de funcionario. Ex: Estagiario, funcionario, bolsista
    "bankid"                varchar(3), --Banco da conta do funcionario
    "branchnumber"          varchar(20), --Numero da agencia
    "branchnumberdigit"     varchar(2), --Digito da agencia
    "accountnumber"         varchar(20), --Numero da conta
    "accountnumberdigit"    varchar(2), --Digito da conta
    "isactiveaccount"       boolean, --Se a conta esta ativa ou nao
    "accounttype"           varchar(2), --Tipo da conta - 01: Conta Corrente 05: Conta Poupança
    "clearinghouse"         integer --Camera de Compensação: Informação utilizada no arquivo de abertura de contas
) INHERITS ("baslog");

COMMENT ON TABLE "basemployee" IS 'pessoa fisica - funcionario - quantas horas em cada codigo externo, salario e por mes ou por hora, um salario por contrato? dois contratos para o mesmo setor? data de ingresso...';
COMMENT ON COLUMN "basemployee"."employeeid" IS 'Codigo do funcionario';
COMMENT ON COLUMN "basemployee"."personid" IS 'Codigo da pessoa';
COMMENT ON COLUMN "basemployee"."externalid" IS 'Codigo no Siga';
COMMENT ON COLUMN "basemployee"."sectorid" IS 'Codigo do setor';
COMMENT ON COLUMN "basemployee"."salary" IS 'Salario';
COMMENT ON COLUMN "basemployee"."valuehour" IS 'se o salário equivale ao valor da hora?';
COMMENT ON COLUMN "basemployee"."weeklyhours" IS 'Quantas horas semanais';
COMMENT ON COLUMN "basemployee"."begindate" IS 'Data inicial deste vinculo';
COMMENT ON COLUMN "basemployee"."enddate" IS 'Data final deste vinculo';
COMMENT ON COLUMN "basemployee"."employeetypeid" IS 'Tipo de funcionario. Ex: Estagiario, funcionario, bolsista';
COMMENT ON COLUMN "basemployee"."bankid" IS 'Banco da conta do funcionario';
COMMENT ON COLUMN "basemployee"."branchnumber" IS 'Numero da agencia';
COMMENT ON COLUMN "basemployee"."branchnumberdigit" IS 'Digito da agencia';
COMMENT ON COLUMN "basemployee"."accountnumber" IS 'Numero da conta';
COMMENT ON COLUMN "basemployee"."accountnumberdigit" IS 'Digito da conta';
COMMENT ON COLUMN "basemployee"."isactiveaccount" IS 'Se a conta esta ativa ou nao';
COMMENT ON COLUMN "basemployee"."accounttype" IS 'Tipo da conta - 01: Conta Corrente 05: Conta Poupança';
COMMENT ON COLUMN "basemployee"."clearinghouse" IS 'Camera de Compensação: Informação utilizada no arquivo de abertura de contas';

CREATE SEQUENCE "seq_employeeid";
ALTER TABLE "basemployee" ALTER COLUMN "employeeid" SET DEFAULT NEXTVAL('"seq_employeeid"');
ALTER TABLE "basemployee" ALTER COLUMN "personid" SET NOT NULL;
ALTER TABLE "basemployee" ALTER COLUMN "valuehour" SET NOT NULL;
ALTER TABLE "basemployee" ALTER COLUMN "valuehour" SET DEFAULT FALSE ;
ALTER TABLE "basemployee" ALTER COLUMN "employeetypeid" SET NOT NULL;
ALTER TABLE "basemployee" ALTER COLUMN "isactiveaccount" SET NOT NULL;
ALTER TABLE "basemployee" ALTER COLUMN "isactiveaccount" SET DEFAULT FALSE ;

ALTER TABLE "basemployee" ALTER COLUMN "employeeid" SET NOT NULL;
ALTER TABLE "basemployee" ADD PRIMARY KEY ("employeeid");

CREATE UNIQUE INDEX "idx_basemployee_personid_externalid" ON "basemployee" ("personid","externalid");

ALTER TABLE "basemployee" ADD FOREIGN KEY ("sectorid") REFERENCES "bassector"("sectorid");

ALTER TABLE "basemployee" ADD FOREIGN KEY ("personid") REFERENCES "basphysicalpersonemployee"("personid");

ALTER TABLE "basemployee" ADD FOREIGN KEY ("employeetypeid") REFERENCES "basemployeetype"("employeetypeid");

ALTER TABLE "basemployee" ADD FOREIGN KEY ("bankid") REFERENCES "finbank"("bankid");

----------------------------------------------------------------------
-- --
--
-- Table: ccppayrolldiscount
-- Purpose: copia com desconto em folha
--
-- --
----------------------------------------------------------------------

CREATE TABLE "ccppayrolldiscount" 
(
    "payrolldiscountid"    integer, --Codigo identificador da copia com desconto em folha
    "date"                 timestamp, --Data da copia
    "branch"               text, --Agencia
    "sectorid"             integer, --Codigo identificador do setor (basSector)
    "serviceid"            integer, --Codigo do servico
    "amount"               float, --Quantidade
    "unitaryvalue"         numeric(14, 4), --Valor unitario
    "personid"             integer, --Codigo identificador da pessoa
    "operator"             text, --Operador
    "operatorsectorid"     integer --Codigo do setor do operador
) INHERITS ("baslog");

COMMENT ON TABLE "ccppayrolldiscount" IS 'copia com desconto em folha';
COMMENT ON COLUMN "ccppayrolldiscount"."payrolldiscountid" IS 'Codigo identificador da copia com desconto em folha';
COMMENT ON COLUMN "ccppayrolldiscount"."date" IS 'Data da copia';
COMMENT ON COLUMN "ccppayrolldiscount"."branch" IS 'Agencia';
COMMENT ON COLUMN "ccppayrolldiscount"."sectorid" IS 'Codigo identificador do setor (basSector)';
COMMENT ON COLUMN "ccppayrolldiscount"."serviceid" IS 'Codigo do servico';
COMMENT ON COLUMN "ccppayrolldiscount"."amount" IS 'Quantidade';
COMMENT ON COLUMN "ccppayrolldiscount"."unitaryvalue" IS 'Valor unitario';
COMMENT ON COLUMN "ccppayrolldiscount"."personid" IS 'Codigo identificador da pessoa';
COMMENT ON COLUMN "ccppayrolldiscount"."operator" IS 'Operador';
COMMENT ON COLUMN "ccppayrolldiscount"."operatorsectorid" IS 'Codigo do setor do operador';

CREATE SEQUENCE "seq_payrolldiscountid";
ALTER TABLE "ccppayrolldiscount" ALTER COLUMN "payrolldiscountid" SET DEFAULT NEXTVAL('"seq_payrolldiscountid"');

ALTER TABLE "ccppayrolldiscount" ALTER COLUMN "payrolldiscountid" SET NOT NULL;
ALTER TABLE "ccppayrolldiscount" ADD PRIMARY KEY ("payrolldiscountid");

ALTER TABLE "ccppayrolldiscount" ADD FOREIGN KEY ("sectorid") REFERENCES "bassector"("sectorid");

ALTER TABLE "ccppayrolldiscount" ADD FOREIGN KEY ("personid") REFERENCES "basphysicalpersonemployee"("personid");

----------------------------------------------------------------------
-- --
--
-- Table: acdcenter
-- Purpose: centros
--
-- --
----------------------------------------------------------------------

CREATE TABLE "acdcenter" 
(
    "centerid"      integer, --Codigo do centro
    "name"          text, --Nome do centro
    "shortname"     varchar(30), --Nome suscinto do centro
    "directorid"    integer --Codigo do diretor do centro
) INHERITS ("baslog");

COMMENT ON TABLE "acdcenter" IS 'centros';
COMMENT ON COLUMN "acdcenter"."centerid" IS 'Codigo do centro';
COMMENT ON COLUMN "acdcenter"."name" IS 'Nome do centro';
COMMENT ON COLUMN "acdcenter"."shortname" IS 'Nome suscinto do centro';
COMMENT ON COLUMN "acdcenter"."directorid" IS 'Codigo do diretor do centro';

CREATE SEQUENCE "seq_centerid";
ALTER TABLE "acdcenter" ALTER COLUMN "centerid" SET DEFAULT NEXTVAL('"seq_centerid"');
ALTER TABLE "acdcenter" ALTER COLUMN "name" SET NOT NULL;
ALTER TABLE "acdcenter" ALTER COLUMN "shortname" SET NOT NULL;

ALTER TABLE "acdcenter" ALTER COLUMN "centerid" SET NOT NULL;
ALTER TABLE "acdcenter" ADD PRIMARY KEY ("centerid");

ALTER TABLE "acdcenter" ADD FOREIGN KEY ("directorid") REFERENCES "basphysicalpersonprofessor"("personid");

----------------------------------------------------------------------
-- --
--
-- Table: basprofessorformation
-- Purpose: formacao do professor
--
-- --
----------------------------------------------------------------------

CREATE TABLE "basprofessorformation" 
(
    "professorid"         integer, --Codigo do professor
    "formationlevelid"    integer, --Codigo do nivel de formacao
    "externalcourseid"    integer, --Codigo do curso de formacao
    "begindate"           date, --Data inicial
    "dateconclusion"      date, --Data de conclusao
    "institutionid"       integer --Codigo da instituicao da formacao
) INHERITS ("baslog");

COMMENT ON TABLE "basprofessorformation" IS 'formacao do professor';
COMMENT ON COLUMN "basprofessorformation"."professorid" IS 'Codigo do professor';
COMMENT ON COLUMN "basprofessorformation"."formationlevelid" IS 'Codigo do nivel de formacao';
COMMENT ON COLUMN "basprofessorformation"."externalcourseid" IS 'Codigo do curso de formacao';
COMMENT ON COLUMN "basprofessorformation"."begindate" IS 'Data inicial';
COMMENT ON COLUMN "basprofessorformation"."dateconclusion" IS 'Data de conclusao';
COMMENT ON COLUMN "basprofessorformation"."institutionid" IS 'Codigo da instituicao da formacao';

ALTER TABLE "basprofessorformation" ALTER COLUMN "professorid" SET NOT NULL;
ALTER TABLE "basprofessorformation" ALTER COLUMN "formationlevelid" SET NOT NULL;
ALTER TABLE "basprofessorformation" ALTER COLUMN "externalcourseid" SET NOT NULL;
ALTER TABLE "basprofessorformation" ALTER COLUMN "begindate" SET NOT NULL;
ALTER TABLE "basprofessorformation" ALTER COLUMN "dateconclusion" SET NOT NULL;
ALTER TABLE "basprofessorformation" ALTER COLUMN "institutionid" SET NOT NULL;

ALTER TABLE "basprofessorformation" ALTER COLUMN "professorid" SET NOT NULL;
ALTER TABLE "basprofessorformation" ALTER COLUMN "formationlevelid" SET NOT NULL;
ALTER TABLE "basprofessorformation" ALTER COLUMN "externalcourseid" SET NOT NULL;
ALTER TABLE "basprofessorformation" ADD PRIMARY KEY ("professorid","formationlevelid","externalcourseid");

ALTER TABLE "basprofessorformation" ADD FOREIGN KEY ("externalcourseid") REFERENCES "acdexternalcourse"("externalcourseid");

ALTER TABLE "basprofessorformation" ADD FOREIGN KEY ("institutionid") REFERENCES "baslegalperson"("personid");

ALTER TABLE "basprofessorformation" ADD FOREIGN KEY ("formationlevelid") REFERENCES "acdformationlevel"("formationlevelid");

ALTER TABLE "basprofessorformation" ADD FOREIGN KEY ("professorid") REFERENCES "basphysicalpersonprofessor"("personid");

----------------------------------------------------------------------
-- --
--
-- Table: insitemphysicalresource
-- Purpose: itens dos recursos fisicos
--
-- --
----------------------------------------------------------------------

CREATE TABLE "insitemphysicalresource" 
(
    "physicalresourceid"         integer, --Codigo do recurso fisico
    "physicalresourceversion"    integer, --Versao do recurso fisico
    "materialid"                 integer, --Codigo do material
    "quantity"                   integer --Quantidade
) INHERITS ("baslog");

COMMENT ON TABLE "insitemphysicalresource" IS 'itens dos recursos fisicos';
COMMENT ON COLUMN "insitemphysicalresource"."physicalresourceid" IS 'Codigo do recurso fisico';
COMMENT ON COLUMN "insitemphysicalresource"."physicalresourceversion" IS 'Versao do recurso fisico';
COMMENT ON COLUMN "insitemphysicalresource"."materialid" IS 'Codigo do material';
COMMENT ON COLUMN "insitemphysicalresource"."quantity" IS 'Quantidade';

ALTER TABLE "insitemphysicalresource" ALTER COLUMN "physicalresourceid" SET NOT NULL;
ALTER TABLE "insitemphysicalresource" ALTER COLUMN "physicalresourceversion" SET NOT NULL;
ALTER TABLE "insitemphysicalresource" ALTER COLUMN "materialid" SET NOT NULL;

ALTER TABLE "insitemphysicalresource" ALTER COLUMN "physicalresourceid" SET NOT NULL;
ALTER TABLE "insitemphysicalresource" ALTER COLUMN "physicalresourceversion" SET NOT NULL;
ALTER TABLE "insitemphysicalresource" ALTER COLUMN "materialid" SET NOT NULL;
ALTER TABLE "insitemphysicalresource" ADD PRIMARY KEY ("physicalresourceid","physicalresourceversion","materialid");

ALTER TABLE "insitemphysicalresource" ADD FOREIGN KEY ("physicalresourceid","physicalresourceversion") REFERENCES "insphysicalresource"("physicalresourceid","physicalresourceversion");

ALTER TABLE "insitemphysicalresource" ADD FOREIGN KEY ("materialid") REFERENCES "insmaterial"("materialid");

----------------------------------------------------------------------
-- --
--
-- Table: sprexamoccurrence
-- Purpose: provas disponiveis para o processo seletivo
--
-- --
----------------------------------------------------------------------

CREATE TABLE "sprexamoccurrence" 
(
    "examoccurrenceid"          integer, --Codigo da ocorrencia de prova
    "selectiveprocessid"        varchar(10), --Codigo do processo seletivo
    "selectiveprocesstypeid"    integer, --Codigo do tipo de processo seletivo
    "examid"                    integer, --Codigo da prova
    "numberquestions"           integer, --Numero de questoes
    "weightquestion"            float, --Peso de cada questao para esta prova
    "numberorder"               integer, --Ordem (para numeracao das questoes)
    "examdatetime"              timestamp, --Data/hora da prova
    "isanswersheet"             boolean, --Indica se a ocorrencia de prova possui ou nao gabarito
    "maximumpoints"             integer --Máximo de pontos possível para a prova
) INHERITS ("baslog");

COMMENT ON TABLE "sprexamoccurrence" IS 'provas disponiveis para o processo seletivo';
COMMENT ON COLUMN "sprexamoccurrence"."examoccurrenceid" IS 'Codigo da ocorrencia de prova';
COMMENT ON COLUMN "sprexamoccurrence"."selectiveprocessid" IS 'Codigo do processo seletivo';
COMMENT ON COLUMN "sprexamoccurrence"."selectiveprocesstypeid" IS 'Codigo do tipo de processo seletivo';
COMMENT ON COLUMN "sprexamoccurrence"."examid" IS 'Codigo da prova';
COMMENT ON COLUMN "sprexamoccurrence"."numberquestions" IS 'Numero de questoes';
COMMENT ON COLUMN "sprexamoccurrence"."weightquestion" IS 'Peso de cada questao para esta prova';
COMMENT ON COLUMN "sprexamoccurrence"."numberorder" IS 'Ordem (para numeracao das questoes)';
COMMENT ON COLUMN "sprexamoccurrence"."examdatetime" IS 'Data/hora da prova';
COMMENT ON COLUMN "sprexamoccurrence"."isanswersheet" IS 'Indica se a ocorrencia de prova possui ou nao gabarito';
COMMENT ON COLUMN "sprexamoccurrence"."maximumpoints" IS 'Máximo de pontos possível para a prova';

CREATE SEQUENCE "seq_examoccurrenceid";
ALTER TABLE "sprexamoccurrence" ALTER COLUMN "examoccurrenceid" SET DEFAULT NEXTVAL('"seq_examoccurrenceid"');
ALTER TABLE "sprexamoccurrence" ALTER COLUMN "selectiveprocessid" SET NOT NULL;
ALTER TABLE "sprexamoccurrence" ALTER COLUMN "selectiveprocesstypeid" SET NOT NULL;
ALTER TABLE "sprexamoccurrence" ALTER COLUMN "examid" SET NOT NULL;
ALTER TABLE "sprexamoccurrence" ALTER COLUMN "examdatetime" SET NOT NULL;
ALTER TABLE "sprexamoccurrence" ALTER COLUMN "isanswersheet" SET NOT NULL;
ALTER TABLE "sprexamoccurrence" ALTER COLUMN "isanswersheet" SET DEFAULT FALSE ;
ALTER TABLE "sprexamoccurrence" ALTER COLUMN "maximumpoints" SET NOT NULL;

ALTER TABLE "sprexamoccurrence" ALTER COLUMN "examoccurrenceid" SET NOT NULL;
ALTER TABLE "sprexamoccurrence" ADD PRIMARY KEY ("examoccurrenceid");

CREATE INDEX "idx_sprexamoccurrence_selectiveprocessid" ON "sprexamoccurrence" ("selectiveprocessid");
CREATE INDEX "idx_sprexamoccurrence_examid" ON "sprexamoccurrence" ("examid");

ALTER TABLE "sprexamoccurrence" ADD FOREIGN KEY ("selectiveprocessid","selectiveprocesstypeid") REFERENCES "sprselectiveprocessoccurrence"("selectiveprocessid","selectiveprocesstypeid");

ALTER TABLE "sprexamoccurrence" ADD FOREIGN KEY ("examid") REFERENCES "sprexam"("examid");

----------------------------------------------------------------------
-- --
--
-- Table: sprplaceroom
-- Purpose: cadastro de salas por locais de prova oferecidos
--
-- --
----------------------------------------------------------------------

CREATE TABLE "sprplaceroom" 
(
    "placeroomid"           integer, --Codigo da sala
    "selectiveprocessid"    varchar(10), --Codigo do processo seletivo
    "languageid"            integer, --Codigo da lingua
    "placeid"               integer, --Codigo do local
    "room"                  varchar(5), --Sala
    "build"                 varchar(5), --Predio
    "vacant"                integer, --Vagas
    "priority"              integer, --Prioridade
    "specialnecessity"      boolean, --Se a sala esta adequada para portadores de necessidade especial
    "ishighschool"          boolean, --Separa candidados com ensino medio incompleto no ensalamento
    "isinternet"            boolean --Separa candidados que fizeram inscricao pela Internet no ensalamento
) INHERITS ("baslog");

COMMENT ON TABLE "sprplaceroom" IS 'cadastro de salas por locais de prova oferecidos';
COMMENT ON COLUMN "sprplaceroom"."placeroomid" IS 'Codigo da sala';
COMMENT ON COLUMN "sprplaceroom"."selectiveprocessid" IS 'Codigo do processo seletivo';
COMMENT ON COLUMN "sprplaceroom"."languageid" IS 'Codigo da lingua';
COMMENT ON COLUMN "sprplaceroom"."placeid" IS 'Codigo do local';
COMMENT ON COLUMN "sprplaceroom"."room" IS 'Sala';
COMMENT ON COLUMN "sprplaceroom"."build" IS 'Predio';
COMMENT ON COLUMN "sprplaceroom"."vacant" IS 'Vagas';
COMMENT ON COLUMN "sprplaceroom"."priority" IS 'Prioridade';
COMMENT ON COLUMN "sprplaceroom"."specialnecessity" IS 'Se a sala esta adequada para portadores de necessidade especial';
COMMENT ON COLUMN "sprplaceroom"."ishighschool" IS 'Separa candidados com ensino medio incompleto no ensalamento';
COMMENT ON COLUMN "sprplaceroom"."isinternet" IS 'Separa candidados que fizeram inscricao pela Internet no ensalamento';

CREATE SEQUENCE "seq_placeroomid";
ALTER TABLE "sprplaceroom" ALTER COLUMN "placeroomid" SET DEFAULT NEXTVAL('"seq_placeroomid"');
ALTER TABLE "sprplaceroom" ALTER COLUMN "selectiveprocessid" SET NOT NULL;
ALTER TABLE "sprplaceroom" ALTER COLUMN "placeid" SET NOT NULL;
ALTER TABLE "sprplaceroom" ALTER COLUMN "room" SET NOT NULL;
ALTER TABLE "sprplaceroom" ALTER COLUMN "build" SET NOT NULL;
ALTER TABLE "sprplaceroom" ALTER COLUMN "vacant" SET NOT NULL;
ALTER TABLE "sprplaceroom" ALTER COLUMN "priority" SET NOT NULL;
ALTER TABLE "sprplaceroom" ALTER COLUMN "specialnecessity" SET NOT NULL;
ALTER TABLE "sprplaceroom" ALTER COLUMN "specialnecessity" SET DEFAULT FALSE ;
ALTER TABLE "sprplaceroom" ALTER COLUMN "ishighschool" SET DEFAULT FALSE;
ALTER TABLE "sprplaceroom" ALTER COLUMN "isinternet" SET DEFAULT FALSE;

ALTER TABLE "sprplaceroom" ALTER COLUMN "placeroomid" SET NOT NULL;
ALTER TABLE "sprplaceroom" ADD PRIMARY KEY ("placeroomid");

ALTER TABLE "sprplaceroom" ADD FOREIGN KEY ("placeid","selectiveprocessid") REFERENCES "sprplaceoccurrence"("placeid","selectiveprocessid");

ALTER TABLE "sprplaceroom" ADD FOREIGN KEY ("selectiveprocessid","languageid") REFERENCES "sprlanguageoccurrence"("selectiveprocessid","languageid");

----------------------------------------------------------------------
-- --
--
-- Table: sprcourseexambalance
-- Purpose: peso das provas por curso
--
-- --
----------------------------------------------------------------------

CREATE TABLE "sprcourseexambalance" 
(
    "examoccurrenceid"    integer, --Codigo da ocorrencia de prova
    "coursevacantid"      integer, --Codigo das vagas
    "weight"              float, --Peso
    "minimumnote"         float --Nota minima
) INHERITS ("baslog");

COMMENT ON TABLE "sprcourseexambalance" IS 'peso das provas por curso';
COMMENT ON COLUMN "sprcourseexambalance"."examoccurrenceid" IS 'Codigo da ocorrencia de prova';
COMMENT ON COLUMN "sprcourseexambalance"."coursevacantid" IS 'Codigo das vagas';
COMMENT ON COLUMN "sprcourseexambalance"."weight" IS 'Peso';
COMMENT ON COLUMN "sprcourseexambalance"."minimumnote" IS 'Nota minima';

ALTER TABLE "sprcourseexambalance" ALTER COLUMN "examoccurrenceid" SET NOT NULL;
ALTER TABLE "sprcourseexambalance" ALTER COLUMN "coursevacantid" SET NOT NULL;
ALTER TABLE "sprcourseexambalance" ALTER COLUMN "weight" SET NOT NULL;
ALTER TABLE "sprcourseexambalance" ALTER COLUMN "minimumnote" SET NOT NULL;

ALTER TABLE "sprcourseexambalance" ALTER COLUMN "examoccurrenceid" SET NOT NULL;
ALTER TABLE "sprcourseexambalance" ALTER COLUMN "coursevacantid" SET NOT NULL;
ALTER TABLE "sprcourseexambalance" ADD PRIMARY KEY ("examoccurrenceid","coursevacantid");

ALTER TABLE "sprcourseexambalance" ADD FOREIGN KEY ("coursevacantid") REFERENCES "sprcoursevacant"("coursevacantid");

ALTER TABLE "sprcourseexambalance" ADD FOREIGN KEY ("examoccurrenceid") REFERENCES "sprexamoccurrence"("examoccurrenceid");

----------------------------------------------------------------------
-- --
--
-- Table: sprinscription
-- Purpose: inscricoes para o processo seletivo
--
-- --
----------------------------------------------------------------------

CREATE TABLE "sprinscription" 
(
    "inscriptionid"           integer, --Codigo da inscricao
    "selectiveprocessid"      varchar(10), --Codigo do processo seletivo
    "personid"                integer, --Codigo da pessoa
    "cityexam"                integer, --Cidade onde a pessoa fara a prova (opcional)
    "placeroomid"             integer, --Codigo do local onde a pessoa fara a prova
    "languageid"              integer, --Codigo da lingua estrangeira escolhida
    "ishighschool"            boolean, --Concluiu ensino medio
    "isinternet"              boolean, --Inscricao foi feita pela internet
    "dateinscription"         date, --Data que a inscricao foi efetuada
    "totalpoints"             float, --Total de pontos obtidos no processo seletivo
    "isclassified"            boolean, --Se classificou
    "inscriptioninvoiceid"    int4 --Numero do boleto da inscricao do aluno
) INHERITS ("baslog");

COMMENT ON TABLE "sprinscription" IS 'inscricoes para o processo seletivo';
COMMENT ON COLUMN "sprinscription"."inscriptionid" IS 'Codigo da inscricao';
COMMENT ON COLUMN "sprinscription"."selectiveprocessid" IS 'Codigo do processo seletivo';
COMMENT ON COLUMN "sprinscription"."personid" IS 'Codigo da pessoa';
COMMENT ON COLUMN "sprinscription"."cityexam" IS 'Cidade onde a pessoa fara a prova (opcional)';
COMMENT ON COLUMN "sprinscription"."placeroomid" IS 'Codigo do local onde a pessoa fara a prova';
COMMENT ON COLUMN "sprinscription"."languageid" IS 'Codigo da lingua estrangeira escolhida';
COMMENT ON COLUMN "sprinscription"."ishighschool" IS 'Concluiu ensino medio';
COMMENT ON COLUMN "sprinscription"."isinternet" IS 'Inscricao foi feita pela internet';
COMMENT ON COLUMN "sprinscription"."dateinscription" IS 'Data que a inscricao foi efetuada';
COMMENT ON COLUMN "sprinscription"."totalpoints" IS 'Total de pontos obtidos no processo seletivo';
COMMENT ON COLUMN "sprinscription"."isclassified" IS 'Se classificou';
COMMENT ON COLUMN "sprinscription"."inscriptioninvoiceid" IS 'Numero do boleto da inscricao do aluno';

CREATE SEQUENCE "seq_inscriptionid";
ALTER TABLE "sprinscription" ALTER COLUMN "inscriptionid" SET DEFAULT NEXTVAL('"seq_inscriptionid"');
ALTER TABLE "sprinscription" ALTER COLUMN "selectiveprocessid" SET NOT NULL;
ALTER TABLE "sprinscription" ALTER COLUMN "personid" SET NOT NULL;
ALTER TABLE "sprinscription" ALTER COLUMN "ishighschool" SET NOT NULL;
ALTER TABLE "sprinscription" ALTER COLUMN "ishighschool" SET DEFAULT TRUE ;
ALTER TABLE "sprinscription" ALTER COLUMN "isinternet" SET NOT NULL;
ALTER TABLE "sprinscription" ALTER COLUMN "isinternet" SET DEFAULT FALSE ;
ALTER TABLE "sprinscription" ALTER COLUMN "dateinscription" SET NOT NULL;
ALTER TABLE "sprinscription" ALTER COLUMN "dateinscription" SET DEFAULT date(now()) ;
ALTER TABLE "sprinscription" ALTER COLUMN "isclassified" SET NOT NULL;
ALTER TABLE "sprinscription" ALTER COLUMN "isclassified" SET DEFAULT FALSE ;

ALTER TABLE "sprinscription" ALTER COLUMN "inscriptionid" SET NOT NULL;
ALTER TABLE "sprinscription" ADD PRIMARY KEY ("inscriptionid");

CREATE INDEX "idx_sprinscription_selectiveprocessid" ON "sprinscription" ("selectiveprocessid");
CREATE INDEX "idx_sprinscription_personid" ON "sprinscription" ("personid");

ALTER TABLE "sprinscription" ADD FOREIGN KEY ("selectiveprocessid") REFERENCES "sprselectiveprocess"("selectiveprocessid");

ALTER TABLE "sprinscription" ADD FOREIGN KEY ("personid") REFERENCES "basphysicalpersonstudent"("personid");

ALTER TABLE "sprinscription" ADD FOREIGN KEY ("placeroomid") REFERENCES "sprplaceroom"("placeroomid");

ALTER TABLE "sprinscription" ADD FOREIGN KEY ("languageid") REFERENCES "sprlanguage"("languageid");

ALTER TABLE "sprinscription" ADD FOREIGN KEY ("cityexam") REFERENCES "bascity"("cityid");

----------------------------------------------------------------------
-- --
--
-- Table: sprnote
-- Purpose: notas dos candidatos nas provas
--
-- --
----------------------------------------------------------------------

CREATE TABLE "sprnote" 
(
    "inscriptionid"       integer, --Codigo da inscricao
    "examoccurrenceid"    integer, --Codigo da ocorrencia da prova
    "note"                float --Nota obtida
) INHERITS ("baslog");

COMMENT ON TABLE "sprnote" IS 'notas dos candidatos nas provas';
COMMENT ON COLUMN "sprnote"."inscriptionid" IS 'Codigo da inscricao';
COMMENT ON COLUMN "sprnote"."examoccurrenceid" IS 'Codigo da ocorrencia da prova';
COMMENT ON COLUMN "sprnote"."note" IS 'Nota obtida';

ALTER TABLE "sprnote" ALTER COLUMN "inscriptionid" SET NOT NULL;
ALTER TABLE "sprnote" ALTER COLUMN "examoccurrenceid" SET NOT NULL;

ALTER TABLE "sprnote" ALTER COLUMN "inscriptionid" SET NOT NULL;
ALTER TABLE "sprnote" ALTER COLUMN "examoccurrenceid" SET NOT NULL;
ALTER TABLE "sprnote" ADD PRIMARY KEY ("inscriptionid","examoccurrenceid");

CREATE INDEX "idx_sprnote_examoccurrenceid" ON "sprnote" ("examoccurrenceid");

ALTER TABLE "sprnote" ADD FOREIGN KEY ("inscriptionid") REFERENCES "sprinscription"("inscriptionid");

ALTER TABLE "sprnote" ADD FOREIGN KEY ("examoccurrenceid") REFERENCES "sprexamoccurrence"("examoccurrenceid");

----------------------------------------------------------------------
-- --
--
-- Table: sprsattleofmatter
-- Purpose: criterios de desempate do processo seletivo
--
-- --
----------------------------------------------------------------------

CREATE TABLE "sprsattleofmatter" 
(
    "sattleofmatterid"    integer, --Codigo do criterio de desempate
    "examoccurrenceid"    integer, --Codigo da ocorrencia de prova
    "coursevacantid"      integer, --Codigo das vagas (NULL vale para todos os cursos)
    "priority"            integer --Ordem de prioridade
) INHERITS ("baslog");

COMMENT ON TABLE "sprsattleofmatter" IS 'criterios de desempate do processo seletivo';
COMMENT ON COLUMN "sprsattleofmatter"."sattleofmatterid" IS 'Codigo do criterio de desempate';
COMMENT ON COLUMN "sprsattleofmatter"."examoccurrenceid" IS 'Codigo da ocorrencia de prova';
COMMENT ON COLUMN "sprsattleofmatter"."coursevacantid" IS 'Codigo das vagas (NULL vale para todos os cursos)';
COMMENT ON COLUMN "sprsattleofmatter"."priority" IS 'Ordem de prioridade';

CREATE SEQUENCE "seq_sattleofmatterid";
ALTER TABLE "sprsattleofmatter" ALTER COLUMN "sattleofmatterid" SET DEFAULT NEXTVAL('"seq_sattleofmatterid"');
ALTER TABLE "sprsattleofmatter" ALTER COLUMN "examoccurrenceid" SET NOT NULL;
ALTER TABLE "sprsattleofmatter" ALTER COLUMN "priority" SET NOT NULL;

ALTER TABLE "sprsattleofmatter" ALTER COLUMN "sattleofmatterid" SET NOT NULL;
ALTER TABLE "sprsattleofmatter" ADD PRIMARY KEY ("sattleofmatterid");

ALTER TABLE "sprsattleofmatter" ADD FOREIGN KEY ("coursevacantid") REFERENCES "sprcoursevacant"("coursevacantid");

ALTER TABLE "sprsattleofmatter" ADD FOREIGN KEY ("examoccurrenceid") REFERENCES "sprexamoccurrence"("examoccurrenceid");

----------------------------------------------------------------------
-- --
--
-- Table: spranswers
-- Purpose: respostas do candidato
--
-- --
----------------------------------------------------------------------

CREATE TABLE "spranswers" 
(
    "inscriptionid"     integer, --Numero da inscricao
    "numberquestion"    integer, --Numero da questao
    "option"            char(1) --Alternativa escolhida pelo candidato
) INHERITS ("baslog");

COMMENT ON TABLE "spranswers" IS 'respostas do candidato';
COMMENT ON COLUMN "spranswers"."inscriptionid" IS 'Numero da inscricao';
COMMENT ON COLUMN "spranswers"."numberquestion" IS 'Numero da questao';
COMMENT ON COLUMN "spranswers"."option" IS 'Alternativa escolhida pelo candidato';

ALTER TABLE "spranswers" ALTER COLUMN "inscriptionid" SET NOT NULL;
ALTER TABLE "spranswers" ALTER COLUMN "numberquestion" SET NOT NULL;
ALTER TABLE "spranswers" ALTER COLUMN "option" SET NOT NULL;

ALTER TABLE "spranswers" ALTER COLUMN "inscriptionid" SET NOT NULL;
ALTER TABLE "spranswers" ALTER COLUMN "numberquestion" SET NOT NULL;
ALTER TABLE "spranswers" ADD PRIMARY KEY ("inscriptionid","numberquestion");

ALTER TABLE "spranswers" ADD FOREIGN KEY ("inscriptionid") REFERENCES "sprinscription"("inscriptionid");

----------------------------------------------------------------------
-- --
--
-- Table: sprselectiveprocesstypedata
-- Purpose: dados complementares para os diversos tipos de processo 
--          seletivo (ex. referencia a processo seletivo externo) 
--
-- --
----------------------------------------------------------------------

CREATE TABLE "sprselectiveprocesstypedata" 
(
    "inscriptionid"             integer, --Codigo da inscricao
    "selectiveprocesstypeid"    integer, --Codigo do tipo de processo seletivo
    "numberinscription"         text --Numero da inscricao adicional
) INHERITS ("baslog");

COMMENT ON TABLE "sprselectiveprocesstypedata" IS 'dados complementares para os diversos tipos de processo seletivo (ex. referencia a processo seletivo externo)';
COMMENT ON COLUMN "sprselectiveprocesstypedata"."inscriptionid" IS 'Codigo da inscricao';
COMMENT ON COLUMN "sprselectiveprocesstypedata"."selectiveprocesstypeid" IS 'Codigo do tipo de processo seletivo';
COMMENT ON COLUMN "sprselectiveprocesstypedata"."numberinscription" IS 'Numero da inscricao adicional';

ALTER TABLE "sprselectiveprocesstypedata" ALTER COLUMN "inscriptionid" SET NOT NULL;
ALTER TABLE "sprselectiveprocesstypedata" ALTER COLUMN "selectiveprocesstypeid" SET NOT NULL;
ALTER TABLE "sprselectiveprocesstypedata" ALTER COLUMN "numberinscription" SET NOT NULL;

ALTER TABLE "sprselectiveprocesstypedata" ALTER COLUMN "inscriptionid" SET NOT NULL;
ALTER TABLE "sprselectiveprocesstypedata" ALTER COLUMN "selectiveprocesstypeid" SET NOT NULL;
ALTER TABLE "sprselectiveprocesstypedata" ADD PRIMARY KEY ("inscriptionid","selectiveprocesstypeid");

ALTER TABLE "sprselectiveprocesstypedata" ADD FOREIGN KEY ("inscriptionid") REFERENCES "sprinscription"("inscriptionid");

ALTER TABLE "sprselectiveprocesstypedata" ADD FOREIGN KEY ("selectiveprocesstypeid") REFERENCES "sprselectiveprocesstype"("selectiveprocesstypeid");

----------------------------------------------------------------------
-- --
--
-- Table: basprofessorcenter
-- Purpose: centros dos professores
--
-- --
----------------------------------------------------------------------

CREATE TABLE "basprofessorcenter" 
(
    "professorid"    integer, --Codigo do Professor
    "centerid"       integer, --Codigo do centro
    "begindate"      date, --data de ingresso neste centro.
    "enddate"        date --Data de desligamento deste Centro
) INHERITS ("baslog");

COMMENT ON TABLE "basprofessorcenter" IS 'centros dos professores';
COMMENT ON COLUMN "basprofessorcenter"."professorid" IS 'Codigo do Professor';
COMMENT ON COLUMN "basprofessorcenter"."centerid" IS 'Codigo do centro';
COMMENT ON COLUMN "basprofessorcenter"."begindate" IS 'data de ingresso neste centro.';
COMMENT ON COLUMN "basprofessorcenter"."enddate" IS 'Data de desligamento deste Centro';

ALTER TABLE "basprofessorcenter" ALTER COLUMN "professorid" SET NOT NULL;
ALTER TABLE "basprofessorcenter" ALTER COLUMN "centerid" SET NOT NULL;
ALTER TABLE "basprofessorcenter" ALTER COLUMN "begindate" SET NOT NULL;

ALTER TABLE "basprofessorcenter" ALTER COLUMN "professorid" SET NOT NULL;
ALTER TABLE "basprofessorcenter" ALTER COLUMN "centerid" SET NOT NULL;
ALTER TABLE "basprofessorcenter" ALTER COLUMN "begindate" SET NOT NULL;
ALTER TABLE "basprofessorcenter" ADD PRIMARY KEY ("professorid","centerid","begindate");

ALTER TABLE "basprofessorcenter" ADD FOREIGN KEY ("centerid") REFERENCES "acdcenter"("centerid");

ALTER TABLE "basprofessorcenter" ADD FOREIGN KEY ("professorid") REFERENCES "basphysicalpersonprofessor"("personid");

----------------------------------------------------------------------
-- --
--
-- Table: acdcurricularcomponent
-- Purpose: componente curricular - disciplina
--
-- --
----------------------------------------------------------------------

CREATE TABLE "acdcurricularcomponent" 
(
    "curricularcomponentid"         varchar(10), --Codigo do componente curricular
    "curricularcomponentversion"    integer, --Versao do componente curricular
    "curricularcomponentgroupid"    integer, --Codigo do grupo do componente curricular
    "centerid"                      integer, --Codigo do centro do componente curricular
    "name"                          text, --Nome
    "shortname"                     varchar(80), --Nome suscinto
    "summary"                       text, --Ementa
    "academiccredits"               float, --Número de créditos acadêmicos, de acordo como está no projeto pedagógico
    "financecredits"                float, --Número de créditos financeiros, para fazer a cobrança
    "lessoncredits"                 float, --Número de créditos aula, que deve sair no registro de notas e caderno de chamada
    "academicnumberhours"           float, --Carga horaria academica
    "financenumberhours"            float, --Carga horaria considerada para o modulo financeiro
    "lessonnumberhours"             float, --Carga horaria em aulas
    "begindate"                     date, --Data de inicio
    "enddate"                       date, --Data de termino
    "educationareaid"               integer --Codigo da area de ensino
) INHERITS ("baslog");

COMMENT ON TABLE "acdcurricularcomponent" IS 'componente curricular - disciplina';
COMMENT ON COLUMN "acdcurricularcomponent"."curricularcomponentid" IS 'Codigo do componente curricular';
COMMENT ON COLUMN "acdcurricularcomponent"."curricularcomponentversion" IS 'Versao do componente curricular';
COMMENT ON COLUMN "acdcurricularcomponent"."curricularcomponentgroupid" IS 'Codigo do grupo do componente curricular';
COMMENT ON COLUMN "acdcurricularcomponent"."centerid" IS 'Codigo do centro do componente curricular';
COMMENT ON COLUMN "acdcurricularcomponent"."name" IS 'Nome';
COMMENT ON COLUMN "acdcurricularcomponent"."shortname" IS 'Nome suscinto';
COMMENT ON COLUMN "acdcurricularcomponent"."summary" IS 'Ementa';
COMMENT ON COLUMN "acdcurricularcomponent"."academiccredits" IS 'Número de créditos acadêmicos, de acordo como está no projeto pedagógico';
COMMENT ON COLUMN "acdcurricularcomponent"."financecredits" IS 'Número de créditos financeiros, para fazer a cobrança';
COMMENT ON COLUMN "acdcurricularcomponent"."lessoncredits" IS 'Número de créditos aula, que deve sair no registro de notas e caderno de chamada';
COMMENT ON COLUMN "acdcurricularcomponent"."academicnumberhours" IS 'Carga horaria academica';
COMMENT ON COLUMN "acdcurricularcomponent"."financenumberhours" IS 'Carga horaria considerada para o modulo financeiro';
COMMENT ON COLUMN "acdcurricularcomponent"."lessonnumberhours" IS 'Carga horaria em aulas';
COMMENT ON COLUMN "acdcurricularcomponent"."begindate" IS 'Data de inicio';
COMMENT ON COLUMN "acdcurricularcomponent"."enddate" IS 'Data de termino';
COMMENT ON COLUMN "acdcurricularcomponent"."educationareaid" IS 'Codigo da area de ensino';

ALTER TABLE "acdcurricularcomponent" ALTER COLUMN "curricularcomponentid" SET NOT NULL;
ALTER TABLE "acdcurricularcomponent" ALTER COLUMN "curricularcomponentversion" SET NOT NULL;
ALTER TABLE "acdcurricularcomponent" ALTER COLUMN "curricularcomponentgroupid" SET NOT NULL;
ALTER TABLE "acdcurricularcomponent" ALTER COLUMN "centerid" SET NOT NULL;
ALTER TABLE "acdcurricularcomponent" ALTER COLUMN "name" SET NOT NULL;
ALTER TABLE "acdcurricularcomponent" ALTER COLUMN "shortname" SET NOT NULL;
ALTER TABLE "acdcurricularcomponent" ALTER COLUMN "academiccredits" SET NOT NULL;
ALTER TABLE "acdcurricularcomponent" ALTER COLUMN "financecredits" SET NOT NULL;
ALTER TABLE "acdcurricularcomponent" ALTER COLUMN "lessoncredits" SET NOT NULL;
ALTER TABLE "acdcurricularcomponent" ALTER COLUMN "academicnumberhours" SET NOT NULL;
ALTER TABLE "acdcurricularcomponent" ALTER COLUMN "financenumberhours" SET NOT NULL;
ALTER TABLE "acdcurricularcomponent" ALTER COLUMN "lessonnumberhours" SET NOT NULL;

ALTER TABLE "acdcurricularcomponent" ALTER COLUMN "curricularcomponentid" SET NOT NULL;
ALTER TABLE "acdcurricularcomponent" ALTER COLUMN "curricularcomponentversion" SET NOT NULL;
ALTER TABLE "acdcurricularcomponent" ADD PRIMARY KEY ("curricularcomponentid","curricularcomponentversion");

ALTER TABLE "acdcurricularcomponent" ADD FOREIGN KEY ("centerid") REFERENCES "acdcenter"("centerid");

ALTER TABLE "acdcurricularcomponent" ADD FOREIGN KEY ("educationareaid") REFERENCES "acdeducationarea"("educationareaid");

----------------------------------------------------------------------
-- --
--
-- Table: acdcourse
-- Purpose: cursos
--
-- --
----------------------------------------------------------------------

CREATE TABLE "acdcourse" 
(
    "courseid"                     varchar(10), --Codigo do curso
    "formationlevelid"             integer, --Codigo do nivel de formacao (graduacao, tecnico, etc)
    "name"                         text, --Nome do curso
    "shortname"                    varchar(50), --Nome suscinto do curso
    "acronym"                      varchar(10), --Abreviatura
    "centerid"                     integer, --Codigo do centro ao qual o curso pertence
    "begindate"                    date, --Data de inicio
    "recognitiondate"              date, --Data de reconhecimento
    "recognitiondocumentnumber"    text, --Numero de documento de reconhecimento
    "moreinfo"                     text, --Mais informacoes
    "enddate"                      date, --Data de termino
    "knowledgeareaid"              integer, --Codigo da area de conhecimento
    "requirements"                 text, --Exigencias
    "obs"                          text, --Observacao
    "reportorder"                  integer, --Sequencia de ordenação de cursos para relatorios
    "educationareaid"              integer, --Area de ensino
    "perctrainingperiod"           float, --Percentual de conclusão do curso para liberar para estágios
    "incomesourceid"               integer, --Codigo da origem
    "enrollbooksequence"           integer, --Número que determina a ordem em que o curso aparecerá no documento do livro matrícula
    "degree"                       text --Grau academico. Ex.: Bacharel
) INHERITS ("baslog");

COMMENT ON TABLE "acdcourse" IS 'cursos';
COMMENT ON COLUMN "acdcourse"."courseid" IS 'Codigo do curso';
COMMENT ON COLUMN "acdcourse"."formationlevelid" IS 'Codigo do nivel de formacao (graduacao, tecnico, etc)';
COMMENT ON COLUMN "acdcourse"."name" IS 'Nome do curso';
COMMENT ON COLUMN "acdcourse"."shortname" IS 'Nome suscinto do curso';
COMMENT ON COLUMN "acdcourse"."acronym" IS 'Abreviatura';
COMMENT ON COLUMN "acdcourse"."centerid" IS 'Codigo do centro ao qual o curso pertence';
COMMENT ON COLUMN "acdcourse"."begindate" IS 'Data de inicio';
COMMENT ON COLUMN "acdcourse"."recognitiondate" IS 'Data de reconhecimento';
COMMENT ON COLUMN "acdcourse"."recognitiondocumentnumber" IS 'Numero de documento de reconhecimento';
COMMENT ON COLUMN "acdcourse"."moreinfo" IS 'Mais informacoes';
COMMENT ON COLUMN "acdcourse"."enddate" IS 'Data de termino';
COMMENT ON COLUMN "acdcourse"."knowledgeareaid" IS 'Codigo da area de conhecimento';
COMMENT ON COLUMN "acdcourse"."requirements" IS 'Exigencias';
COMMENT ON COLUMN "acdcourse"."obs" IS 'Observacao';
COMMENT ON COLUMN "acdcourse"."reportorder" IS 'Sequencia de ordenação de cursos para relatorios';
COMMENT ON COLUMN "acdcourse"."educationareaid" IS 'Area de ensino';
COMMENT ON COLUMN "acdcourse"."perctrainingperiod" IS 'Percentual de conclusão do curso para liberar para estágios';
COMMENT ON COLUMN "acdcourse"."incomesourceid" IS 'Codigo da origem';
COMMENT ON COLUMN "acdcourse"."enrollbooksequence" IS 'Número que determina a ordem em que o curso aparecerá no documento do livro matrícula';
COMMENT ON COLUMN "acdcourse"."degree" IS 'Grau academico. Ex.: Bacharel';

ALTER TABLE "acdcourse" ALTER COLUMN "courseid" SET NOT NULL;
ALTER TABLE "acdcourse" ALTER COLUMN "formationlevelid" SET NOT NULL;
ALTER TABLE "acdcourse" ALTER COLUMN "name" SET NOT NULL;
ALTER TABLE "acdcourse" ALTER COLUMN "shortname" SET NOT NULL;

ALTER TABLE "acdcourse" ALTER COLUMN "courseid" SET NOT NULL;
ALTER TABLE "acdcourse" ADD PRIMARY KEY ("courseid");

ALTER TABLE "acdcourse" ADD FOREIGN KEY ("centerid") REFERENCES "acdcenter"("centerid");

ALTER TABLE "acdcourse" ADD FOREIGN KEY ("knowledgeareaid") REFERENCES "acdknowledgearea"("knowledgeareaid");

ALTER TABLE "acdcourse" ADD FOREIGN KEY ("formationlevelid") REFERENCES "acdformationlevel"("formationlevelid");

ALTER TABLE "acdcourse" ADD FOREIGN KEY ("educationareaid") REFERENCES "acdeducationarea"("educationareaid");

ALTER TABLE "acdcourse" ADD FOREIGN KEY ("incomesourceid") REFERENCES "finincomesource"("incomesourceid");

----------------------------------------------------------------------
-- --
--
-- Table: acdcourseversion
-- Purpose: versao do curso
--
-- --
----------------------------------------------------------------------

CREATE TABLE "acdcourseversion" 
(
    "courseversion"          integer, --Versao do curso
    "courseid"               varchar(10), --Codigo do curso
    "courseversiontypeid"    integer, --Codigo para o tipo de versao de curso
    "begindate"              date, --Data de inicio
    "enddate"                date, --Data de termino
    "semestertotal"          integer, --Total de semestres
    "credits"                float, --Numero de creditos
    "hourtotal"              float, --Carga horaria total
    "hourrequired"           float --Carga horaria exigida
) INHERITS ("baslog");

COMMENT ON TABLE "acdcourseversion" IS 'versao do curso';
COMMENT ON COLUMN "acdcourseversion"."courseversion" IS 'Versao do curso';
COMMENT ON COLUMN "acdcourseversion"."courseid" IS 'Codigo do curso';
COMMENT ON COLUMN "acdcourseversion"."courseversiontypeid" IS 'Codigo para o tipo de versao de curso';
COMMENT ON COLUMN "acdcourseversion"."begindate" IS 'Data de inicio';
COMMENT ON COLUMN "acdcourseversion"."enddate" IS 'Data de termino';
COMMENT ON COLUMN "acdcourseversion"."semestertotal" IS 'Total de semestres';
COMMENT ON COLUMN "acdcourseversion"."credits" IS 'Numero de creditos';
COMMENT ON COLUMN "acdcourseversion"."hourtotal" IS 'Carga horaria total';
COMMENT ON COLUMN "acdcourseversion"."hourrequired" IS 'Carga horaria exigida';

ALTER TABLE "acdcourseversion" ALTER COLUMN "courseversion" SET NOT NULL;
ALTER TABLE "acdcourseversion" ALTER COLUMN "courseid" SET NOT NULL;
ALTER TABLE "acdcourseversion" ALTER COLUMN "courseversiontypeid" SET NOT NULL;

ALTER TABLE "acdcourseversion" ALTER COLUMN "courseversion" SET NOT NULL;
ALTER TABLE "acdcourseversion" ALTER COLUMN "courseid" SET NOT NULL;
ALTER TABLE "acdcourseversion" ADD PRIMARY KEY ("courseversion","courseid");

ALTER TABLE "acdcourseversion" ADD FOREIGN KEY ("courseid") REFERENCES "acdcourse"("courseid");

ALTER TABLE "acdcourseversion" ADD FOREIGN KEY ("courseversiontypeid") REFERENCES "acdcourseversiontype"("courseversiontypeid");

----------------------------------------------------------------------
-- --
--
-- Table: ccprequest
-- Purpose: requisicao de copia
--
-- --
----------------------------------------------------------------------

CREATE TABLE "ccprequest" 
(
    "requestid"           integer, --Codigo identificador da requisicao
    "date"                timestamp, --Data da requisicao
    "serviceid"           integer, --Codigo identificador do servico
    "amount"              float, --Quantidade
    "sectorid"            integer, --Codigo identificador do setor
    "centerid"            integer, --Codigo identificador do centro
    "projectid"           integer, --Codigo identificador do projeto
    "costcenterid"        integer, --Codigo identificador do centro de custo
    "referring"           text, --Requerimento
    "personid"            integer, --Requisitante (pessoa)
    "operator"            text, --Operador
    "operatorsectorid"    integer, --Codigo identificador do setor do operador
    "unitaryvalue"        numeric(14, 4) --Valor unitario
) INHERITS ("baslog");

COMMENT ON TABLE "ccprequest" IS 'requisicao de copia';
COMMENT ON COLUMN "ccprequest"."requestid" IS 'Codigo identificador da requisicao';
COMMENT ON COLUMN "ccprequest"."date" IS 'Data da requisicao';
COMMENT ON COLUMN "ccprequest"."serviceid" IS 'Codigo identificador do servico';
COMMENT ON COLUMN "ccprequest"."amount" IS 'Quantidade';
COMMENT ON COLUMN "ccprequest"."sectorid" IS 'Codigo identificador do setor';
COMMENT ON COLUMN "ccprequest"."centerid" IS 'Codigo identificador do centro';
COMMENT ON COLUMN "ccprequest"."projectid" IS 'Codigo identificador do projeto';
COMMENT ON COLUMN "ccprequest"."costcenterid" IS 'Codigo identificador do centro de custo';
COMMENT ON COLUMN "ccprequest"."referring" IS 'Requerimento';
COMMENT ON COLUMN "ccprequest"."personid" IS 'Requisitante (pessoa)';
COMMENT ON COLUMN "ccprequest"."operator" IS 'Operador';
COMMENT ON COLUMN "ccprequest"."operatorsectorid" IS 'Codigo identificador do setor do operador';
COMMENT ON COLUMN "ccprequest"."unitaryvalue" IS 'Valor unitario';

CREATE SEQUENCE "seq_requestid";
ALTER TABLE "ccprequest" ALTER COLUMN "requestid" SET DEFAULT NEXTVAL('"seq_requestid"');

ALTER TABLE "ccprequest" ALTER COLUMN "requestid" SET NOT NULL;
ALTER TABLE "ccprequest" ADD PRIMARY KEY ("requestid");

ALTER TABLE "ccprequest" ADD FOREIGN KEY ("sectorid") REFERENCES "bassector"("sectorid");

ALTER TABLE "ccprequest" ADD FOREIGN KEY ("centerid") REFERENCES "acdcenter"("centerid");

ALTER TABLE "ccprequest" ADD FOREIGN KEY ("personid") REFERENCES "basphysicalpersonemployee"("personid");
CREATE UNIQUE INDEX idx_unique_operatorsectorid ON ccprequest (operatorsectorid);

----------------------------------------------------------------------
-- --
--
-- Table: ccprequestfax
-- Purpose: requisicao de fax
--
-- --
----------------------------------------------------------------------

CREATE TABLE "ccprequestfax" 
(
    "requestid"    integer, --Codigo identificador da requisicao
    "telephone"    text, --Numero de telefone
    "sended"       boolean, --Se foi enviado ou nao
    "tariff"       text --Tarifa
) INHERITS ("baslog");

COMMENT ON TABLE "ccprequestfax" IS 'requisicao de fax';
COMMENT ON COLUMN "ccprequestfax"."requestid" IS 'Codigo identificador da requisicao';
COMMENT ON COLUMN "ccprequestfax"."telephone" IS 'Numero de telefone';
COMMENT ON COLUMN "ccprequestfax"."sended" IS 'Se foi enviado ou nao';
COMMENT ON COLUMN "ccprequestfax"."tariff" IS 'Tarifa';

ALTER TABLE "ccprequestfax" ALTER COLUMN "requestid" SET NOT NULL;
ALTER TABLE "ccprequestfax" ADD PRIMARY KEY ("requestid");

----------------------------------------------------------------------
-- --
--
-- Table: ccpsector
-- Purpose: setor
--
-- --
----------------------------------------------------------------------

CREATE TABLE "ccpsector" 
(
    "sectorid"       integer, --Codigo identificador do setor
    "description"    text --Descricao do setor
) INHERITS ("baslog");

COMMENT ON TABLE "ccpsector" IS 'setor';
COMMENT ON COLUMN "ccpsector"."sectorid" IS 'Codigo identificador do setor';
COMMENT ON COLUMN "ccpsector"."description" IS 'Descricao do setor';

ALTER TABLE "ccpsector" ALTER COLUMN "sectorid" SET DEFAULT NEXTVAL('"seq_sectorid"');

ALTER TABLE "ccpsector" ALTER COLUMN "sectorid" SET NOT NULL;
ALTER TABLE "ccpsector" ADD PRIMARY KEY ("sectorid");

ALTER TABLE "ccpsector" ADD FOREIGN KEY ("sectorid") REFERENCES "ccprequest"("operatorsectorid");

----------------------------------------------------------------------
-- --
--
-- Table: acdprofessorcurricularcomponent
-- Purpose: disciplinas que o professor esta apto a ministrar
--
-- --
----------------------------------------------------------------------

CREATE TABLE "acdprofessorcurricularcomponent" 
(
    "professorcurricularcomponentid"    integer, --Campo chave primária
    "professorid"                       integer, --Codigo do Professor
    "curricularcomponentid"             varchar(10), --Codigo da disciplina
    "curricularcomponentversion"        integer --Versao da disciplina
) INHERITS ("baslog");

COMMENT ON TABLE "acdprofessorcurricularcomponent" IS 'disciplinas que o professor esta apto a ministrar';
COMMENT ON COLUMN "acdprofessorcurricularcomponent"."professorcurricularcomponentid" IS 'Campo chave primária';
COMMENT ON COLUMN "acdprofessorcurricularcomponent"."professorid" IS 'Codigo do Professor';
COMMENT ON COLUMN "acdprofessorcurricularcomponent"."curricularcomponentid" IS 'Codigo da disciplina';
COMMENT ON COLUMN "acdprofessorcurricularcomponent"."curricularcomponentversion" IS 'Versao da disciplina';

CREATE SEQUENCE "seq_professorcurricularcomponentid";
ALTER TABLE "acdprofessorcurricularcomponent" ALTER COLUMN "professorcurricularcomponentid" SET DEFAULT NEXTVAL('"seq_professorcurricularcomponentid"');
ALTER TABLE "acdprofessorcurricularcomponent" ALTER COLUMN "professorid" SET NOT NULL;
ALTER TABLE "acdprofessorcurricularcomponent" ALTER COLUMN "curricularcomponentid" SET NOT NULL;
ALTER TABLE "acdprofessorcurricularcomponent" ALTER COLUMN "curricularcomponentversion" SET NOT NULL;

ALTER TABLE "acdprofessorcurricularcomponent" ALTER COLUMN "professorcurricularcomponentid" SET NOT NULL;
ALTER TABLE "acdprofessorcurricularcomponent" ADD PRIMARY KEY ("professorcurricularcomponentid");

CREATE UNIQUE INDEX "idx_unique_professor_curricular_component" ON "acdprofessorcurricularcomponent" ("professorid","curricularcomponentid","curricularcomponentversion");

ALTER TABLE "acdprofessorcurricularcomponent" ADD FOREIGN KEY ("curricularcomponentid","curricularcomponentversion") REFERENCES "acdcurricularcomponent"("curricularcomponentid","curricularcomponentversion");

ALTER TABLE "acdprofessorcurricularcomponent" ADD FOREIGN KEY ("professorid") REFERENCES "basphysicalpersonprofessor"("personid");

----------------------------------------------------------------------
-- --
--
-- Table: acdcourseoccurrence
-- Purpose: ocorrencia de curso
--
-- --
----------------------------------------------------------------------

CREATE TABLE "acdcourseoccurrence" 
(
    "courseid"                   varchar(10), --Codigo do curso
    "courseversion"              integer, --Versao do curso
    "turnid"                     integer, --Codigo do turno
    "unitid"                     integer, --Codigo da unidade
    "authorizationdate"          date, --Data de autorizacao
    "authorizationdocument"      text, --Documento de autorizacao
    "status"                     boolean, --Estado (Ativo (true) ou Inativo (false))
    "minimumconclusioncourse"    float, --Prazo mínimo para conclusão de Curso
    "maximumconclusioncourse"    float --Prazo máximo para conclusão de curso. Se este campo for preenchido ativa o esquema de jubilamento
) INHERITS ("baslog");

COMMENT ON TABLE "acdcourseoccurrence" IS 'ocorrencia de curso';
COMMENT ON COLUMN "acdcourseoccurrence"."courseid" IS 'Codigo do curso';
COMMENT ON COLUMN "acdcourseoccurrence"."courseversion" IS 'Versao do curso';
COMMENT ON COLUMN "acdcourseoccurrence"."turnid" IS 'Codigo do turno';
COMMENT ON COLUMN "acdcourseoccurrence"."unitid" IS 'Codigo da unidade';
COMMENT ON COLUMN "acdcourseoccurrence"."authorizationdate" IS 'Data de autorizacao';
COMMENT ON COLUMN "acdcourseoccurrence"."authorizationdocument" IS 'Documento de autorizacao';
COMMENT ON COLUMN "acdcourseoccurrence"."status" IS 'Estado (Ativo (true) ou Inativo (false))';
COMMENT ON COLUMN "acdcourseoccurrence"."minimumconclusioncourse" IS 'Prazo mínimo para conclusão de Curso';
COMMENT ON COLUMN "acdcourseoccurrence"."maximumconclusioncourse" IS 'Prazo máximo para conclusão de curso. Se este campo for preenchido ativa o esquema de jubilamento';

ALTER TABLE "acdcourseoccurrence" ALTER COLUMN "courseid" SET NOT NULL;
ALTER TABLE "acdcourseoccurrence" ALTER COLUMN "courseversion" SET NOT NULL;
ALTER TABLE "acdcourseoccurrence" ALTER COLUMN "turnid" SET NOT NULL;
ALTER TABLE "acdcourseoccurrence" ALTER COLUMN "unitid" SET NOT NULL;
ALTER TABLE "acdcourseoccurrence" ALTER COLUMN "status" SET NOT NULL;
ALTER TABLE "acdcourseoccurrence" ALTER COLUMN "status" SET DEFAULT TRUE ;

ALTER TABLE "acdcourseoccurrence" ALTER COLUMN "courseid" SET NOT NULL;
ALTER TABLE "acdcourseoccurrence" ALTER COLUMN "courseversion" SET NOT NULL;
ALTER TABLE "acdcourseoccurrence" ALTER COLUMN "turnid" SET NOT NULL;
ALTER TABLE "acdcourseoccurrence" ALTER COLUMN "unitid" SET NOT NULL;
ALTER TABLE "acdcourseoccurrence" ADD PRIMARY KEY ("courseid","courseversion","turnid","unitid");

ALTER TABLE "acdcourseoccurrence" ADD FOREIGN KEY ("courseversion","courseid") REFERENCES "acdcourseversion"("courseversion","courseid");

ALTER TABLE "acdcourseoccurrence" ADD FOREIGN KEY ("turnid") REFERENCES "basturn"("turnid");

ALTER TABLE "acdcourseoccurrence" ADD FOREIGN KEY ("unitid") REFERENCES "basunit"("unitid");

----------------------------------------------------------------------
-- --
--
-- Table: acdcertified
-- Purpose: atestados
--
-- --
----------------------------------------------------------------------

CREATE TABLE "acdcertified" 
(
    "certifiedid"        integer, --Codigo do atestado
    "dateissue"          date, --Data de publicacao
    "certifiedtypeid"    integer, --Codigo do tipo de atestado
    "personid"           integer, --Codigo da pessoa a qual o atestado se refere
    "courseid"           varchar(10), --Codigo do curso
    "courseversion"      integer, --Versao do curso
    "unitid"             integer, --Codigo da unidade
    "turnid"             integer --Codigo do turno
) INHERITS ("baslog");

COMMENT ON TABLE "acdcertified" IS 'atestados';
COMMENT ON COLUMN "acdcertified"."certifiedid" IS 'Codigo do atestado';
COMMENT ON COLUMN "acdcertified"."dateissue" IS 'Data de publicacao';
COMMENT ON COLUMN "acdcertified"."certifiedtypeid" IS 'Codigo do tipo de atestado';
COMMENT ON COLUMN "acdcertified"."personid" IS 'Codigo da pessoa a qual o atestado se refere';
COMMENT ON COLUMN "acdcertified"."courseid" IS 'Codigo do curso';
COMMENT ON COLUMN "acdcertified"."courseversion" IS 'Versao do curso';
COMMENT ON COLUMN "acdcertified"."unitid" IS 'Codigo da unidade';
COMMENT ON COLUMN "acdcertified"."turnid" IS 'Codigo do turno';

ALTER TABLE "acdcertified" ALTER COLUMN "certifiedid" SET NOT NULL;
ALTER TABLE "acdcertified" ALTER COLUMN "dateissue" SET NOT NULL;
ALTER TABLE "acdcertified" ALTER COLUMN "certifiedtypeid" SET NOT NULL;
ALTER TABLE "acdcertified" ALTER COLUMN "personid" SET NOT NULL;

ALTER TABLE "acdcertified" ALTER COLUMN "certifiedid" SET NOT NULL;
ALTER TABLE "acdcertified" ALTER COLUMN "dateissue" SET NOT NULL;
ALTER TABLE "acdcertified" ADD PRIMARY KEY ("certifiedid","dateissue");

CREATE INDEX "idx_acdcertified_certifiedtypeid" ON "acdcertified" ("certifiedtypeid");

ALTER TABLE "acdcertified" ADD FOREIGN KEY ("courseid","courseversion","unitid","turnid") REFERENCES "acdcourseoccurrence"("courseid","courseversion","unitid","turnid");

ALTER TABLE "acdcertified" ADD FOREIGN KEY ("certifiedtypeid") REFERENCES "acdcertifiedtype"("certifiedtypeid");

ALTER TABLE "acdcertified" ADD FOREIGN KEY ("personid") REFERENCES "basperson"("personid");

----------------------------------------------------------------------
-- --
--
-- Table: acdcourseability
-- Purpose: compet�ncias de curso
--
-- --
----------------------------------------------------------------------

CREATE TABLE "acdcourseability" 
(
    "courseabilityid"    integer, --Codigo da competencia de curso
    "courseversion"      integer, --Versao do curso
    "courseid"           varchar(10), --Codigo do curso
    "description"        text, --Descricao
    "type"               char(1) --Tipo (Geral (G) ou Especifica (E))
) INHERITS ("baslog");

COMMENT ON TABLE "acdcourseability" IS 'compet�ncias de curso';
COMMENT ON COLUMN "acdcourseability"."courseabilityid" IS 'Codigo da competencia de curso';
COMMENT ON COLUMN "acdcourseability"."courseversion" IS 'Versao do curso';
COMMENT ON COLUMN "acdcourseability"."courseid" IS 'Codigo do curso';
COMMENT ON COLUMN "acdcourseability"."description" IS 'Descricao';
COMMENT ON COLUMN "acdcourseability"."type" IS 'Tipo (Geral (G) ou Especifica (E))';

CREATE SEQUENCE "seq_courseabilityid";
ALTER TABLE "acdcourseability" ALTER COLUMN "courseabilityid" SET DEFAULT NEXTVAL('"seq_courseabilityid"');
ALTER TABLE "acdcourseability" ALTER COLUMN "courseversion" SET NOT NULL;
ALTER TABLE "acdcourseability" ALTER COLUMN "courseid" SET NOT NULL;
ALTER TABLE "acdcourseability" ALTER COLUMN "description" SET NOT NULL;
ALTER TABLE "acdcourseability" ALTER COLUMN "type" SET NOT NULL;

ALTER TABLE "acdcourseability" ALTER COLUMN "courseabilityid" SET NOT NULL;
ALTER TABLE "acdcourseability" ADD PRIMARY KEY ("courseabilityid");

ALTER TABLE "acdcourseability" ADD FOREIGN KEY ("courseversion","courseid") REFERENCES "acdcourseversion"("courseversion","courseid");

----------------------------------------------------------------------
-- --
--
-- Table: acdcoursecoordinator
-- Purpose: coordenadores dos cursos
--
-- --
----------------------------------------------------------------------

CREATE TABLE "acdcoursecoordinator" 
(
    "courseid"           varchar(10), --Codigo do curso
    "courseversion"      integer, --Versao do curso
    "turnid"             integer, --Codigo do turno
    "unitid"             integer, --Codigo da unidade
    "coordinatorid"      integer, --Codigo do coordenador do curso
    "begindate"          date, --Data de inicio da gestao
    "enddate"            date, --Data de fim da gestao
    "level"              integer, --Nivel
    "issendemail"        boolean, --Se recebe/envia e-mail
    "email"              varchar(60), --E-mail do coordenador
    "expirationlevel"    interval --Nivel de expiracao
) INHERITS ("baslog");

COMMENT ON TABLE "acdcoursecoordinator" IS 'coordenadores dos cursos';
COMMENT ON COLUMN "acdcoursecoordinator"."courseid" IS 'Codigo do curso';
COMMENT ON COLUMN "acdcoursecoordinator"."courseversion" IS 'Versao do curso';
COMMENT ON COLUMN "acdcoursecoordinator"."turnid" IS 'Codigo do turno';
COMMENT ON COLUMN "acdcoursecoordinator"."unitid" IS 'Codigo da unidade';
COMMENT ON COLUMN "acdcoursecoordinator"."coordinatorid" IS 'Codigo do coordenador do curso';
COMMENT ON COLUMN "acdcoursecoordinator"."begindate" IS 'Data de inicio da gestao';
COMMENT ON COLUMN "acdcoursecoordinator"."enddate" IS 'Data de fim da gestao';
COMMENT ON COLUMN "acdcoursecoordinator"."level" IS 'Nivel';
COMMENT ON COLUMN "acdcoursecoordinator"."issendemail" IS 'Se recebe/envia e-mail';
COMMENT ON COLUMN "acdcoursecoordinator"."email" IS 'E-mail do coordenador';
COMMENT ON COLUMN "acdcoursecoordinator"."expirationlevel" IS 'Nivel de expiracao';

ALTER TABLE "acdcoursecoordinator" ALTER COLUMN "courseid" SET NOT NULL;
ALTER TABLE "acdcoursecoordinator" ALTER COLUMN "courseversion" SET NOT NULL;
ALTER TABLE "acdcoursecoordinator" ALTER COLUMN "turnid" SET NOT NULL;
ALTER TABLE "acdcoursecoordinator" ALTER COLUMN "unitid" SET NOT NULL;
ALTER TABLE "acdcoursecoordinator" ALTER COLUMN "coordinatorid" SET NOT NULL;
ALTER TABLE "acdcoursecoordinator" ALTER COLUMN "issendemail" SET NOT NULL;
ALTER TABLE "acdcoursecoordinator" ALTER COLUMN "issendemail" SET DEFAULT FALSE ;

ALTER TABLE "acdcoursecoordinator" ALTER COLUMN "courseid" SET NOT NULL;
ALTER TABLE "acdcoursecoordinator" ALTER COLUMN "courseversion" SET NOT NULL;
ALTER TABLE "acdcoursecoordinator" ALTER COLUMN "turnid" SET NOT NULL;
ALTER TABLE "acdcoursecoordinator" ALTER COLUMN "unitid" SET NOT NULL;
ALTER TABLE "acdcoursecoordinator" ALTER COLUMN "coordinatorid" SET NOT NULL;
ALTER TABLE "acdcoursecoordinator" ADD PRIMARY KEY ("courseid","courseversion","turnid","unitid","coordinatorid");

ALTER TABLE "acdcoursecoordinator" ADD FOREIGN KEY ("courseid","courseversion","turnid","unitid") REFERENCES "acdcourseoccurrence"("courseid","courseversion","turnid","unitid");

ALTER TABLE "acdcoursecoordinator" ADD FOREIGN KEY ("coordinatorid") REFERENCES "basphysicalpersonprofessor"("personid");

----------------------------------------------------------------------
-- --
--
-- Table: acdrestricteddocuments
-- Purpose: documentos restritos pertencentes ou nao, a um curso: 1) 
--          todas as pessoas; (sem registro) 2) todas as pessoas de 
--          determinado tipo de curso; (formation level) 3) todas as 
--          pessoas de determinado curso (formation level e course)  
--
-- --
----------------------------------------------------------------------

CREATE TABLE "acdrestricteddocuments" 
(
    "restricteddocumentid"    integer, --Codigo do documento restrito
    "documenttypeid"          integer, --Codigo do tipo de documento
    "formationlevelid"        integer, --Codigo do nivel de formacao
    "courseid"                varchar(10), --Codigo do curso
    "courseversion"           integer, --Versao do curso
    "turnid"                  integer, --Codigo do turno
    "unitid"                  integer, --Codigo da unidade
    "isin"                    boolean --Indica se pertence ou nao a uma determinada condicao
) INHERITS ("baslog");

COMMENT ON TABLE "acdrestricteddocuments" IS 'documentos restritos pertencentes ou nao, a um curso: 1) todas as pessoas; (sem registro) 2) todas as pessoas de determinado tipo de curso; (formation level) 3) todas as pessoas de determinado curso (formation level e course) ';
COMMENT ON COLUMN "acdrestricteddocuments"."restricteddocumentid" IS 'Codigo do documento restrito';
COMMENT ON COLUMN "acdrestricteddocuments"."documenttypeid" IS 'Codigo do tipo de documento';
COMMENT ON COLUMN "acdrestricteddocuments"."formationlevelid" IS 'Codigo do nivel de formacao';
COMMENT ON COLUMN "acdrestricteddocuments"."courseid" IS 'Codigo do curso';
COMMENT ON COLUMN "acdrestricteddocuments"."courseversion" IS 'Versao do curso';
COMMENT ON COLUMN "acdrestricteddocuments"."turnid" IS 'Codigo do turno';
COMMENT ON COLUMN "acdrestricteddocuments"."unitid" IS 'Codigo da unidade';
COMMENT ON COLUMN "acdrestricteddocuments"."isin" IS 'Indica se pertence ou nao a uma determinada condicao';

CREATE SEQUENCE "seq_restricteddocumentid";
ALTER TABLE "acdrestricteddocuments" ALTER COLUMN "restricteddocumentid" SET DEFAULT NEXTVAL('"seq_restricteddocumentid"');
ALTER TABLE "acdrestricteddocuments" ALTER COLUMN "documenttypeid" SET NOT NULL;
ALTER TABLE "acdrestricteddocuments" ALTER COLUMN "isin" SET NOT NULL;
ALTER TABLE "acdrestricteddocuments" ALTER COLUMN "isin" SET DEFAULT FALSE ;

ALTER TABLE "acdrestricteddocuments" ALTER COLUMN "restricteddocumentid" SET NOT NULL;
ALTER TABLE "acdrestricteddocuments" ADD PRIMARY KEY ("restricteddocumentid");

ALTER TABLE "acdrestricteddocuments" ADD FOREIGN KEY ("courseid","courseversion") REFERENCES "acdcourseversion"("courseid","courseversion");

ALTER TABLE "acdrestricteddocuments" ADD FOREIGN KEY ("documenttypeid") REFERENCES "basdocumenttype"("documenttypeid");

ALTER TABLE "acdrestricteddocuments" ADD FOREIGN KEY ("formationlevelid") REFERENCES "acdformationlevel"("formationlevelid");

ALTER TABLE "acdrestricteddocuments" ADD FOREIGN KEY ("turnid") REFERENCES "basturn"("turnid");

ALTER TABLE "acdrestricteddocuments" ADD FOREIGN KEY ("unitid") REFERENCES "basunit"("unitid");

----------------------------------------------------------------------
-- --
--
-- Table: acdcontract
-- Purpose: contratos
--
-- --
----------------------------------------------------------------------

CREATE TABLE "acdcontract" 
(
    "contractid"                    integer, --Codigo do contrato
    "personid"                      integer, --Codigo da pessoa
    "courseid"                      varchar(10), --Codigo do curso
    "courseversion"                 integer, --Versao do curso
    "turnid"                        integer, --Codigo do turno
    "unitid"                        integer, --Codigo do campus
    "formationdate"                 date, --Data de formatura
    "formationperiodid"             varchar(10), --Período de formatura
    "conclusiondate"                date, --Data de conclusao
    "emendsdate"                    date, --Data da apostila
    "diplomadate"                   date, --Data de diploma
    "inscriptionselectiveprocid"    integer, --Codigo da inscricao no vestibular
    "maturityday"                   integer, --Dia do vencimento
    "islistener"                    boolean, --Aluno Ouvinte
    "isrequestacademicdegree"       boolean, --Pedido de Grau Acadêmico (Formatura)
    "globalaverage"                 float, --Média Global - Ingresso cursos sequenciais
    "contractnumber"                varchar(20), --Numero do contrato
    "obs"                           text, --Observacao
    "parcelsnumber"                 integer --Numero de parcelas a serem geredas nas matrículas do aluno
) INHERITS ("baslog");

COMMENT ON TABLE "acdcontract" IS 'contratos';
COMMENT ON COLUMN "acdcontract"."contractid" IS 'Codigo do contrato';
COMMENT ON COLUMN "acdcontract"."personid" IS 'Codigo da pessoa';
COMMENT ON COLUMN "acdcontract"."courseid" IS 'Codigo do curso';
COMMENT ON COLUMN "acdcontract"."courseversion" IS 'Versao do curso';
COMMENT ON COLUMN "acdcontract"."turnid" IS 'Codigo do turno';
COMMENT ON COLUMN "acdcontract"."unitid" IS 'Codigo do campus';
COMMENT ON COLUMN "acdcontract"."formationdate" IS 'Data de formatura';
COMMENT ON COLUMN "acdcontract"."formationperiodid" IS 'Período de formatura';
COMMENT ON COLUMN "acdcontract"."conclusiondate" IS 'Data de conclusao';
COMMENT ON COLUMN "acdcontract"."emendsdate" IS 'Data da apostila';
COMMENT ON COLUMN "acdcontract"."diplomadate" IS 'Data de diploma';
COMMENT ON COLUMN "acdcontract"."inscriptionselectiveprocid" IS 'Codigo da inscricao no vestibular';
COMMENT ON COLUMN "acdcontract"."maturityday" IS 'Dia do vencimento';
COMMENT ON COLUMN "acdcontract"."islistener" IS 'Aluno Ouvinte';
COMMENT ON COLUMN "acdcontract"."isrequestacademicdegree" IS 'Pedido de Grau Acadêmico (Formatura)';
COMMENT ON COLUMN "acdcontract"."globalaverage" IS 'Média Global - Ingresso cursos sequenciais';
COMMENT ON COLUMN "acdcontract"."contractnumber" IS 'Numero do contrato';
COMMENT ON COLUMN "acdcontract"."obs" IS 'Observacao';
COMMENT ON COLUMN "acdcontract"."parcelsnumber" IS 'Numero de parcelas a serem geredas nas matrículas do aluno';

CREATE SEQUENCE "seq_contractid";
ALTER TABLE "acdcontract" ALTER COLUMN "contractid" SET DEFAULT NEXTVAL('"seq_contractid"');
ALTER TABLE "acdcontract" ALTER COLUMN "personid" SET NOT NULL;
ALTER TABLE "acdcontract" ALTER COLUMN "courseid" SET NOT NULL;
ALTER TABLE "acdcontract" ALTER COLUMN "courseversion" SET NOT NULL;
ALTER TABLE "acdcontract" ALTER COLUMN "turnid" SET NOT NULL;
ALTER TABLE "acdcontract" ALTER COLUMN "unitid" SET NOT NULL;
ALTER TABLE "acdcontract" ALTER COLUMN "islistener" SET NOT NULL;
ALTER TABLE "acdcontract" ALTER COLUMN "islistener" SET DEFAULT FALSE ;
ALTER TABLE "acdcontract" ALTER COLUMN "isrequestacademicdegree" SET NOT NULL;
ALTER TABLE "acdcontract" ALTER COLUMN "isrequestacademicdegree" SET DEFAULT FALSE ;

ALTER TABLE "acdcontract" ALTER COLUMN "contractid" SET NOT NULL;
ALTER TABLE "acdcontract" ADD PRIMARY KEY ("contractid");

CREATE INDEX "idx_acdcontract_personid" ON "acdcontract" ("personid");
CREATE UNIQUE INDEX "idx_unique_contract" ON "acdcontract" ("courseid","courseversion","turnid","unitid","personid");

ALTER TABLE "acdcontract" ADD FOREIGN KEY ("courseversion","courseid","turnid","unitid") REFERENCES "acdcourseoccurrence"("courseversion","courseid","turnid","unitid");

ALTER TABLE "acdcontract" ADD FOREIGN KEY ("personid") REFERENCES "basphysicalpersonstudent"("personid");

ALTER TABLE "acdcontract" ADD FOREIGN KEY ("formationperiodid") REFERENCES "acdperiod"("periodid");

ALTER TABLE "acdcontract" ADD FOREIGN KEY ("inscriptionselectiveprocid") REFERENCES "sprinscription"("inscriptionid");

----------------------------------------------------------------------
-- --
--
-- Table: acccostcenter
-- Purpose: centro de custos indicando setores, cursos, qualquer coisa 
--          que tenha movimentacao financeira e precise de 
--          contabilizacao 
--
-- --
----------------------------------------------------------------------

CREATE TABLE "acccostcenter" 
(
    "costcenterid"    varchar(30), --Codigo identificador do centro de custo
    "description"     text --Descricao do centro de custo
) INHERITS ("baslog");

COMMENT ON TABLE "acccostcenter" IS 'centro de custos indicando setores, cursos, qualquer coisa que tenha movimentacao financeira e precise de contabilizacao';
COMMENT ON COLUMN "acccostcenter"."costcenterid" IS 'Codigo identificador do centro de custo';
COMMENT ON COLUMN "acccostcenter"."description" IS 'Descricao do centro de custo';

ALTER TABLE "acccostcenter" ALTER COLUMN "costcenterid" SET NOT NULL;
ALTER TABLE "acccostcenter" ALTER COLUMN "description" SET NOT NULL;

ALTER TABLE "acccostcenter" ALTER COLUMN "costcenterid" SET NOT NULL;
ALTER TABLE "acccostcenter" ADD PRIMARY KEY ("costcenterid");

----------------------------------------------------------------------
-- --
--
-- Table: sprcourseoccurrence
-- Purpose: cursos disponiveis para o processo seletivo
--
-- --
----------------------------------------------------------------------

CREATE TABLE "sprcourseoccurrence" 
(
    "courseoccurrenceid"    integer, --Codigo da ocorrencia de curso
    "coursevacantid"        integer, --Codigo das vagas
    "courseid"              varchar(10), --Codigo do curso
    "courseversion"         integer, --Versao do curso
    "turnid"                integer, --Codigo do turno
    "unitid"                integer, --Codigo da unidade
    "isavailable"           boolean --Indica os cursos que estao disponiveis no vestibular
) INHERITS ("baslog");

COMMENT ON TABLE "sprcourseoccurrence" IS 'cursos disponiveis para o processo seletivo';
COMMENT ON COLUMN "sprcourseoccurrence"."courseoccurrenceid" IS 'Codigo da ocorrencia de curso';
COMMENT ON COLUMN "sprcourseoccurrence"."coursevacantid" IS 'Codigo das vagas';
COMMENT ON COLUMN "sprcourseoccurrence"."courseid" IS 'Codigo do curso';
COMMENT ON COLUMN "sprcourseoccurrence"."courseversion" IS 'Versao do curso';
COMMENT ON COLUMN "sprcourseoccurrence"."turnid" IS 'Codigo do turno';
COMMENT ON COLUMN "sprcourseoccurrence"."unitid" IS 'Codigo da unidade';
COMMENT ON COLUMN "sprcourseoccurrence"."isavailable" IS 'Indica os cursos que estao disponiveis no vestibular';

CREATE SEQUENCE "seq_courseoccurrenceid";
ALTER TABLE "sprcourseoccurrence" ALTER COLUMN "courseoccurrenceid" SET DEFAULT NEXTVAL('"seq_courseoccurrenceid"');
ALTER TABLE "sprcourseoccurrence" ALTER COLUMN "coursevacantid" SET NOT NULL;
ALTER TABLE "sprcourseoccurrence" ALTER COLUMN "courseid" SET NOT NULL;
ALTER TABLE "sprcourseoccurrence" ALTER COLUMN "courseversion" SET NOT NULL;
ALTER TABLE "sprcourseoccurrence" ALTER COLUMN "turnid" SET NOT NULL;
ALTER TABLE "sprcourseoccurrence" ALTER COLUMN "unitid" SET NOT NULL;
ALTER TABLE "sprcourseoccurrence" ALTER COLUMN "isavailable" SET NOT NULL;
ALTER TABLE "sprcourseoccurrence" ALTER COLUMN "isavailable" SET DEFAULT TRUE ;

ALTER TABLE "sprcourseoccurrence" ALTER COLUMN "courseoccurrenceid" SET NOT NULL;
ALTER TABLE "sprcourseoccurrence" ADD PRIMARY KEY ("courseoccurrenceid");

ALTER TABLE "sprcourseoccurrence" ADD FOREIGN KEY ("courseid","courseversion","turnid","unitid") REFERENCES "acdcourseoccurrence"("courseid","courseversion","turnid","unitid");

ALTER TABLE "sprcourseoccurrence" ADD FOREIGN KEY ("coursevacantid") REFERENCES "sprcoursevacant"("coursevacantid");

----------------------------------------------------------------------
-- --
--
-- Table: acdevent
-- Purpose: eventos
--
-- --
----------------------------------------------------------------------

CREATE TABLE "acdevent" 
(
    "eventid"            integer, --Codigo do evento
    "description"        text, --Descricao
    "begindate"          date, --Data de inicio
    "enddate"            date, --Data de termino
    "accountschemeid"    varchar(30), --Codigo do esquema de contabilizacao para cobranca de taxa de inscricao, por exemplo (caso o modulo contabil esteja sendo utilizado, este campo devera ser obrigatorio no formulario). 
    "costcenterid"       varchar(30), --Codigo do centro de custo (caso o modulo contabil esteja sendo utilizado, este campo devera ser obrigatorio no formulario)
    "policyid"           integer, --Codigo da politica financeira (caso o modulo financeiro esteja sendo utilizado, este campo devera ser obrigatorio no formulario)
    "incomesourceid"     integer, --Codigo da origem (caso o modulo financeiro esteja sendo utilizado, este campo devera ser obrigatorio no formulario)
    "inscriptionfee"     float --Taxa de inscricao
) INHERITS ("baslog");

COMMENT ON TABLE "acdevent" IS 'eventos';
COMMENT ON COLUMN "acdevent"."eventid" IS 'Codigo do evento';
COMMENT ON COLUMN "acdevent"."description" IS 'Descricao';
COMMENT ON COLUMN "acdevent"."begindate" IS 'Data de inicio';
COMMENT ON COLUMN "acdevent"."enddate" IS 'Data de termino';
COMMENT ON COLUMN "acdevent"."accountschemeid" IS 'Codigo do esquema de contabilizacao para cobranca de taxa de inscricao, por exemplo (caso o modulo contabil esteja sendo utilizado, este campo devera ser obrigatorio no formulario). ';
COMMENT ON COLUMN "acdevent"."costcenterid" IS 'Codigo do centro de custo (caso o modulo contabil esteja sendo utilizado, este campo devera ser obrigatorio no formulario)';
COMMENT ON COLUMN "acdevent"."policyid" IS 'Codigo da politica financeira (caso o modulo financeiro esteja sendo utilizado, este campo devera ser obrigatorio no formulario)';
COMMENT ON COLUMN "acdevent"."incomesourceid" IS 'Codigo da origem (caso o modulo financeiro esteja sendo utilizado, este campo devera ser obrigatorio no formulario)';
COMMENT ON COLUMN "acdevent"."inscriptionfee" IS 'Taxa de inscricao';

CREATE SEQUENCE "seq_eventid";
ALTER TABLE "acdevent" ALTER COLUMN "eventid" SET DEFAULT NEXTVAL('"seq_eventid"');
ALTER TABLE "acdevent" ALTER COLUMN "description" SET NOT NULL;
ALTER TABLE "acdevent" ALTER COLUMN "begindate" SET NOT NULL;
ALTER TABLE "acdevent" ALTER COLUMN "enddate" SET NOT NULL;
ALTER TABLE "acdevent" ALTER COLUMN "inscriptionfee" SET NOT NULL;

ALTER TABLE "acdevent" ALTER COLUMN "eventid" SET NOT NULL;
ALTER TABLE "acdevent" ADD PRIMARY KEY ("eventid");

ALTER TABLE "acdevent" ADD FOREIGN KEY ("incomesourceid") REFERENCES "finincomesource"("incomesourceid");

ALTER TABLE "acdevent" ADD FOREIGN KEY ("accountschemeid") REFERENCES "accaccountscheme"("accountschemeid");

ALTER TABLE "acdevent" ADD FOREIGN KEY ("costcenterid") REFERENCES "acccostcenter"("costcenterid");

ALTER TABLE "acdevent" ADD FOREIGN KEY ("policyid") REFERENCES "finpolicy"("policyid");

----------------------------------------------------------------------
-- --
--
-- Table: acdeventparticipation
-- Purpose: participa��o no evento
--
-- --
----------------------------------------------------------------------

CREATE TABLE "acdeventparticipation" 
(
    "eventid"     integer, --Codigo do evento
    "personid"    integer --Codigo da pessoa
) INHERITS ("baslog");

COMMENT ON TABLE "acdeventparticipation" IS 'participa��o no evento';
COMMENT ON COLUMN "acdeventparticipation"."eventid" IS 'Codigo do evento';
COMMENT ON COLUMN "acdeventparticipation"."personid" IS 'Codigo da pessoa';

ALTER TABLE "acdeventparticipation" ALTER COLUMN "eventid" SET NOT NULL;
ALTER TABLE "acdeventparticipation" ALTER COLUMN "personid" SET NOT NULL;

ALTER TABLE "acdeventparticipation" ALTER COLUMN "eventid" SET NOT NULL;
ALTER TABLE "acdeventparticipation" ALTER COLUMN "personid" SET NOT NULL;
ALTER TABLE "acdeventparticipation" ADD PRIMARY KEY ("eventid","personid");

ALTER TABLE "acdeventparticipation" ADD FOREIGN KEY ("personid") REFERENCES "basphysicalperson"("personid");

ALTER TABLE "acdeventparticipation" ADD FOREIGN KEY ("eventid") REFERENCES "acdevent"("eventid");

----------------------------------------------------------------------
-- --
--
-- Table: acdtestendcoursecontract
-- Purpose: provas de curso por contrato (enade e provao) - somente os 
--          obrigados a fazer a prova 
--
-- --
----------------------------------------------------------------------

CREATE TABLE "acdtestendcoursecontract" 
(
    "testendcoursetypeid"    integer, --Tipo do teste de final de curso (enade, provao, etc.)
    "contractid"             integer, --Codigo do contrato
    "testendcoursedate"      date, --Data de aplicacao do teste
    "excused"                boolean, --Se foi dispensado
    "ispresent"              boolean --Se o aluno compareceu a prova 
) INHERITS ("baslog");

COMMENT ON TABLE "acdtestendcoursecontract" IS 'provas de curso por contrato (enade e provao) - somente os obrigados a fazer a prova';
COMMENT ON COLUMN "acdtestendcoursecontract"."testendcoursetypeid" IS 'Tipo do teste de final de curso (enade, provao, etc.)';
COMMENT ON COLUMN "acdtestendcoursecontract"."contractid" IS 'Codigo do contrato';
COMMENT ON COLUMN "acdtestendcoursecontract"."testendcoursedate" IS 'Data de aplicacao do teste';
COMMENT ON COLUMN "acdtestendcoursecontract"."excused" IS 'Se foi dispensado';
COMMENT ON COLUMN "acdtestendcoursecontract"."ispresent" IS 'Se o aluno compareceu a prova ';

ALTER TABLE "acdtestendcoursecontract" ALTER COLUMN "testendcoursetypeid" SET NOT NULL;
ALTER TABLE "acdtestendcoursecontract" ALTER COLUMN "contractid" SET NOT NULL;
ALTER TABLE "acdtestendcoursecontract" ALTER COLUMN "testendcoursedate" SET NOT NULL;
ALTER TABLE "acdtestendcoursecontract" ALTER COLUMN "excused" SET NOT NULL;
ALTER TABLE "acdtestendcoursecontract" ALTER COLUMN "excused" SET DEFAULT FALSE ;
ALTER TABLE "acdtestendcoursecontract" ALTER COLUMN "ispresent" SET NOT NULL;
ALTER TABLE "acdtestendcoursecontract" ALTER COLUMN "ispresent" SET DEFAULT TRUE ;

ALTER TABLE "acdtestendcoursecontract" ALTER COLUMN "testendcoursetypeid" SET NOT NULL;
ALTER TABLE "acdtestendcoursecontract" ALTER COLUMN "contractid" SET NOT NULL;
ALTER TABLE "acdtestendcoursecontract" ALTER COLUMN "testendcoursedate" SET NOT NULL;
ALTER TABLE "acdtestendcoursecontract" ADD PRIMARY KEY ("testendcoursetypeid","contractid","testendcoursedate");

ALTER TABLE "acdtestendcoursecontract" ADD FOREIGN KEY ("testendcoursetypeid") REFERENCES "acdtestendcoursetype"("testendcoursetypeid");

ALTER TABLE "acdtestendcoursecontract" ADD FOREIGN KEY ("contractid") REFERENCES "acdcontract"("contractid");

----------------------------------------------------------------------
-- --
--
-- Table: fininvoicetarget
-- Purpose: destino de cobranca
--
-- --
----------------------------------------------------------------------

CREATE TABLE "fininvoicetarget" 
(
    "contractid"    integer, --Codigo do contrato para identificar a pessoa
    "isactive"      boolean --Esta flag define se esta ou nao ativo o destino da cobranca para este contrato, a flag sera falsa quando um contrato for desativado
) INHERITS ("baslog");

COMMENT ON TABLE "fininvoicetarget" IS 'destino de cobranca';
COMMENT ON COLUMN "fininvoicetarget"."contractid" IS 'Codigo do contrato para identificar a pessoa';
COMMENT ON COLUMN "fininvoicetarget"."isactive" IS 'Esta flag define se esta ou nao ativo o destino da cobranca para este contrato, a flag sera falsa quando um contrato for desativado';

ALTER TABLE "fininvoicetarget" ALTER COLUMN "contractid" SET NOT NULL;
ALTER TABLE "fininvoicetarget" ALTER COLUMN "isactive" SET NOT NULL;
ALTER TABLE "fininvoicetarget" ALTER COLUMN "isactive" SET DEFAULT TRUE ;

ALTER TABLE "fininvoicetarget" ALTER COLUMN "contractid" SET NOT NULL;
ALTER TABLE "fininvoicetarget" ADD PRIMARY KEY ("contractid");

ALTER TABLE "fininvoicetarget" ADD FOREIGN KEY ("contractid") REFERENCES "acdcontract"("contractid");

----------------------------------------------------------------------
-- --
--
-- Table: finbanktarget
-- Purpose: debitos automaticos. herda a fininvoicetarget
--
-- --
----------------------------------------------------------------------

CREATE TABLE "finbanktarget" 
(
    "bankid"                varchar(3), --Codigo do banco (finBank)
    "branchnumber"          varchar(20), --Numero da agencia
    "branchnumberdigit"     varchar(10), --Digito verificador da agencia
    "accountnumber"         varchar(20), --Numero da conta corrente
    "accountnumberdigit"    varchar(10) --Digito verificador da conta corrente
) INHERITS ("fininvoicetarget");

COMMENT ON TABLE "finbanktarget" IS 'debitos automaticos. herda a fininvoicetarget';
COMMENT ON COLUMN "finbanktarget"."bankid" IS 'Codigo do banco (finBank)';
COMMENT ON COLUMN "finbanktarget"."branchnumber" IS 'Numero da agencia';
COMMENT ON COLUMN "finbanktarget"."branchnumberdigit" IS 'Digito verificador da agencia';
COMMENT ON COLUMN "finbanktarget"."accountnumber" IS 'Numero da conta corrente';
COMMENT ON COLUMN "finbanktarget"."accountnumberdigit" IS 'Digito verificador da conta corrente';

ALTER TABLE "finbanktarget" ALTER COLUMN "bankid" SET NOT NULL;
ALTER TABLE "finbanktarget" ALTER COLUMN "branchnumber" SET NOT NULL;
ALTER TABLE "finbanktarget" ALTER COLUMN "branchnumberdigit" SET NOT NULL;
ALTER TABLE "finbanktarget" ALTER COLUMN "accountnumber" SET NOT NULL;
ALTER TABLE "finbanktarget" ALTER COLUMN "accountnumberdigit" SET NOT NULL;

ALTER TABLE "finbanktarget" ALTER COLUMN "contractid" SET NOT NULL;
ALTER TABLE "finbanktarget" ADD PRIMARY KEY ("contractid");

ALTER TABLE "finbanktarget" ADD FOREIGN KEY ("bankid") REFERENCES "finbank"("bankid");

----------------------------------------------------------------------
-- --
--
-- Table: acdinterchange
-- Purpose: tabela de intercambio
--
-- --
----------------------------------------------------------------------

CREATE TABLE "acdinterchange" 
(
    "interchangeid"                integer, --Codigo do intercambio
    "personid"                     integer, --Codigo da pessoa
    "contractid"                   integer, --Codigo do contrato
    "interchangetypeid"            integer, --Codigo do tipo de intercambio
    "interchangetypecomplement"    text, --Complemento descrevendo o tipo de intercâmbio daquela pessoa específica
    "activity"                     text, --Descrição da atividade realizada durante o intercambio
    "begindate"                    date, --Data de inicio do intercambio
    "enddate"                      date, --Data de termino do intercambio
    "origincountryid"              integer, --Codigo do pais de origem
    "origininstitutionid"          integer, --Codigo da instituicao de origem
    "destinationcountryid"         integer, --Codigo do pais de destino
    "destinationinstitutionid"     integer, --Codigo da instituicao de destino
    "isremunerated"                boolean --Se e remunerado ou nao
) INHERITS ("baslog");

COMMENT ON TABLE "acdinterchange" IS 'tabela de intercambio';
COMMENT ON COLUMN "acdinterchange"."interchangeid" IS 'Codigo do intercambio';
COMMENT ON COLUMN "acdinterchange"."personid" IS 'Codigo da pessoa';
COMMENT ON COLUMN "acdinterchange"."contractid" IS 'Codigo do contrato';
COMMENT ON COLUMN "acdinterchange"."interchangetypeid" IS 'Codigo do tipo de intercambio';
COMMENT ON COLUMN "acdinterchange"."interchangetypecomplement" IS 'Complemento descrevendo o tipo de intercâmbio daquela pessoa específica';
COMMENT ON COLUMN "acdinterchange"."activity" IS 'Descrição da atividade realizada durante o intercambio';
COMMENT ON COLUMN "acdinterchange"."begindate" IS 'Data de inicio do intercambio';
COMMENT ON COLUMN "acdinterchange"."enddate" IS 'Data de termino do intercambio';
COMMENT ON COLUMN "acdinterchange"."origincountryid" IS 'Codigo do pais de origem';
COMMENT ON COLUMN "acdinterchange"."origininstitutionid" IS 'Codigo da instituicao de origem';
COMMENT ON COLUMN "acdinterchange"."destinationcountryid" IS 'Codigo do pais de destino';
COMMENT ON COLUMN "acdinterchange"."destinationinstitutionid" IS 'Codigo da instituicao de destino';
COMMENT ON COLUMN "acdinterchange"."isremunerated" IS 'Se e remunerado ou nao';

CREATE SEQUENCE "seq_interchangeid";
ALTER TABLE "acdinterchange" ALTER COLUMN "interchangeid" SET DEFAULT NEXTVAL('"seq_interchangeid"');
ALTER TABLE "acdinterchange" ALTER COLUMN "personid" SET NOT NULL;
ALTER TABLE "acdinterchange" ALTER COLUMN "interchangetypeid" SET NOT NULL;
ALTER TABLE "acdinterchange" ALTER COLUMN "begindate" SET NOT NULL;
ALTER TABLE "acdinterchange" ALTER COLUMN "enddate" SET NOT NULL;
ALTER TABLE "acdinterchange" ALTER COLUMN "origincountryid" SET NOT NULL;
ALTER TABLE "acdinterchange" ALTER COLUMN "destinationcountryid" SET NOT NULL;
ALTER TABLE "acdinterchange" ALTER COLUMN "destinationinstitutionid" SET NOT NULL;
ALTER TABLE "acdinterchange" ALTER COLUMN "isremunerated" SET NOT NULL;
ALTER TABLE "acdinterchange" ALTER COLUMN "isremunerated" SET DEFAULT FALSE ;

ALTER TABLE "acdinterchange" ALTER COLUMN "interchangeid" SET NOT NULL;
ALTER TABLE "acdinterchange" ADD PRIMARY KEY ("interchangeid");

ALTER TABLE "acdinterchange" ADD FOREIGN KEY ("contractid") REFERENCES "acdcontract"("contractid");

ALTER TABLE "acdinterchange" ADD FOREIGN KEY ("origininstitutionid") REFERENCES "baslegalperson"("personid");

ALTER TABLE "acdinterchange" ADD FOREIGN KEY ("interchangetypeid") REFERENCES "acdinterchangetype"("interchangetypeid");

ALTER TABLE "acdinterchange" ADD FOREIGN KEY ("destinationinstitutionid") REFERENCES "baslegalperson"("personid");

ALTER TABLE "acdinterchange" ADD FOREIGN KEY ("origincountryid") REFERENCES "bascountry"("countryid");

ALTER TABLE "acdinterchange" ADD FOREIGN KEY ("destinationcountryid") REFERENCES "bascountry"("countryid");

----------------------------------------------------------------------
-- --
--
-- Table: acdlearningperiod
-- Purpose: periodos letivos
--
-- --
----------------------------------------------------------------------

CREATE TABLE "acdlearningperiod" 
(
    "learningperiodid"            integer, --Codigo do periodo letivo
    "periodid"                    varchar(10), --Codigo do periodo
    "courseid"                    varchar(10), --Codigo do curso
    "courseversion"               integer, --Versao do curso
    "turnid"                      integer, --Codigo do turno
    "unitid"                      integer, --Codigo da unidade
    "description"                 text, --Descricao
    "formationlevelid"            integer, --Codigo do nivel de formacao
    "previouslearningperiodid"    integer, --Codigo do periodo letivo anterior
    "begindate"                   date, --Data de inicio
    "enddate"                     date, --Data de termino
    "begindatelessons"            date, --Data de inicio das aulas
    "weekendexamsbegin"           date, --Data de inicio da semana de exames
    "average"                     float, --Media para liberacao de exame
    "finalaverage"                float, --Media final para aprovacao
    "minimumfrequency"            float, --Frequencia minima
    "sagu1periodid"               varchar(10), --Informacao antiga de codigos dos periodos
    "minimumcredits"              integer, --O aluno poderá se matricular 1 vez em um numero menor de creditos que esse
    "minimumcreditsfreshman"      integer, --Numero minimo de creditos que os vestibulandos podem se matricular
    "minimumcreditsturn"          integer, --Numero minimo de créditos para poder cursar disciplinas em outro turno
    "sagu1previousperiodid"       varchar(10), --Codigo do periodo anterior do sagu1
    "parcelsnumber"               integer, --Numero de parcelas padrao
    "policyid"                    integer, --Politica padrao (caso o modulo financeiro esteja sendo utilizado, este campo devera ser obrigatorio no formulario)
    "isfinancegenerate"           boolean --Campo que indica se no momonto da matricula sera gerado financeiro na tabela de previsoes
) INHERITS ("baslog");

COMMENT ON TABLE "acdlearningperiod" IS 'periodos letivos';
COMMENT ON COLUMN "acdlearningperiod"."learningperiodid" IS 'Codigo do periodo letivo';
COMMENT ON COLUMN "acdlearningperiod"."periodid" IS 'Codigo do periodo';
COMMENT ON COLUMN "acdlearningperiod"."courseid" IS 'Codigo do curso';
COMMENT ON COLUMN "acdlearningperiod"."courseversion" IS 'Versao do curso';
COMMENT ON COLUMN "acdlearningperiod"."turnid" IS 'Codigo do turno';
COMMENT ON COLUMN "acdlearningperiod"."unitid" IS 'Codigo da unidade';
COMMENT ON COLUMN "acdlearningperiod"."description" IS 'Descricao';
COMMENT ON COLUMN "acdlearningperiod"."formationlevelid" IS 'Codigo do nivel de formacao';
COMMENT ON COLUMN "acdlearningperiod"."previouslearningperiodid" IS 'Codigo do periodo letivo anterior';
COMMENT ON COLUMN "acdlearningperiod"."begindate" IS 'Data de inicio';
COMMENT ON COLUMN "acdlearningperiod"."enddate" IS 'Data de termino';
COMMENT ON COLUMN "acdlearningperiod"."begindatelessons" IS 'Data de inicio das aulas';
COMMENT ON COLUMN "acdlearningperiod"."weekendexamsbegin" IS 'Data de inicio da semana de exames';
COMMENT ON COLUMN "acdlearningperiod"."average" IS 'Media para liberacao de exame';
COMMENT ON COLUMN "acdlearningperiod"."finalaverage" IS 'Media final para aprovacao';
COMMENT ON COLUMN "acdlearningperiod"."minimumfrequency" IS 'Frequencia minima';
COMMENT ON COLUMN "acdlearningperiod"."sagu1periodid" IS 'Informacao antiga de codigos dos periodos';
COMMENT ON COLUMN "acdlearningperiod"."minimumcredits" IS 'O aluno poderá se matricular 1 vez em um numero menor de creditos que esse';
COMMENT ON COLUMN "acdlearningperiod"."minimumcreditsfreshman" IS 'Numero minimo de creditos que os vestibulandos podem se matricular';
COMMENT ON COLUMN "acdlearningperiod"."minimumcreditsturn" IS 'Numero minimo de créditos para poder cursar disciplinas em outro turno';
COMMENT ON COLUMN "acdlearningperiod"."sagu1previousperiodid" IS 'Codigo do periodo anterior do sagu1';
COMMENT ON COLUMN "acdlearningperiod"."parcelsnumber" IS 'Numero de parcelas padrao';
COMMENT ON COLUMN "acdlearningperiod"."policyid" IS 'Politica padrao (caso o modulo financeiro esteja sendo utilizado, este campo devera ser obrigatorio no formulario)';
COMMENT ON COLUMN "acdlearningperiod"."isfinancegenerate" IS 'Campo que indica se no momonto da matricula sera gerado financeiro na tabela de previsoes';

CREATE SEQUENCE "seq_learningperiodid";
ALTER TABLE "acdlearningperiod" ALTER COLUMN "learningperiodid" SET DEFAULT NEXTVAL('"seq_learningperiodid"');
ALTER TABLE "acdlearningperiod" ALTER COLUMN "periodid" SET NOT NULL;
ALTER TABLE "acdlearningperiod" ALTER COLUMN "courseid" SET NOT NULL;
ALTER TABLE "acdlearningperiod" ALTER COLUMN "courseversion" SET NOT NULL;
ALTER TABLE "acdlearningperiod" ALTER COLUMN "turnid" SET NOT NULL;
ALTER TABLE "acdlearningperiod" ALTER COLUMN "unitid" SET NOT NULL;
ALTER TABLE "acdlearningperiod" ALTER COLUMN "description" SET NOT NULL;
ALTER TABLE "acdlearningperiod" ALTER COLUMN "formationlevelid" SET NOT NULL;
ALTER TABLE "acdlearningperiod" ALTER COLUMN "begindate" SET NOT NULL;
ALTER TABLE "acdlearningperiod" ALTER COLUMN "enddate" SET NOT NULL;
ALTER TABLE "acdlearningperiod" ALTER COLUMN "average" SET NOT NULL;
ALTER TABLE "acdlearningperiod" ALTER COLUMN "finalaverage" SET NOT NULL;
ALTER TABLE "acdlearningperiod" ALTER COLUMN "minimumfrequency" SET NOT NULL;
ALTER TABLE "acdlearningperiod" ALTER COLUMN "minimumcredits" SET NOT NULL;
ALTER TABLE "acdlearningperiod" ALTER COLUMN "minimumcreditsfreshman" SET NOT NULL;
ALTER TABLE "acdlearningperiod" ALTER COLUMN "minimumcreditsturn" SET NOT NULL;
ALTER TABLE "acdlearningperiod" ALTER COLUMN "parcelsnumber" SET NOT NULL;
ALTER TABLE "acdlearningperiod" ALTER COLUMN "isfinancegenerate" SET NOT NULL;
ALTER TABLE "acdlearningperiod" ALTER COLUMN "isfinancegenerate" SET DEFAULT FALSE ;

ALTER TABLE "acdlearningperiod" ALTER COLUMN "learningperiodid" SET NOT NULL;
ALTER TABLE "acdlearningperiod" ADD PRIMARY KEY ("learningperiodid");

CREATE INDEX "idx_acdlearningperiod_periodid" ON "acdlearningperiod" ("periodid");
CREATE INDEX "idx_acdlearningperiod_courseid_unitid_sagu1periodid" ON "acdlearningperiod" ("courseid","unitid","sagu1periodid");

ALTER TABLE "acdlearningperiod" ADD FOREIGN KEY ("courseid","courseversion","turnid","unitid") REFERENCES "acdcourseoccurrence"("courseid","courseversion","turnid","unitid");

ALTER TABLE "acdlearningperiod" ADD FOREIGN KEY ("formationlevelid") REFERENCES "acdformationlevel"("formationlevelid");

ALTER TABLE "acdlearningperiod" ADD FOREIGN KEY ("periodid") REFERENCES "acdperiod"("periodid");

ALTER TABLE "acdlearningperiod" ADD FOREIGN KEY ("policyid") REFERENCES "finpolicy"("policyid");

----------------------------------------------------------------------
-- --
--
-- Table: acdcurriculum
-- Purpose: curriculo de curso
--
-- --
----------------------------------------------------------------------

CREATE TABLE "acdcurriculum" 
(
    "curriculumid"                                   integer, --Codigo da disciplina do curriculo
    "courseid"                                       varchar(10), --Codigo do curso
    "courseversion"                                  integer, --Versao do curso
    "turnid"                                         integer, --Codigo do turno
    "unitid"                                         integer, --Codigo da unidade
    "curricularcomponentid"                          varchar(10), --Codigo da disciplina presente no curriculo
    "curricularcomponentversion"                     integer, --Versao da disciplina presente no curriculo
    "curricularcomponenttypeid"                      integer, --Tipo da disciplina no currículo - Eletiva, estágio, normal...
    "semester"                                       integer, --Semestre previsto para que o aluno curse a disciplina
    "isshowdocumentendcourse"                        boolean, --E exibida no histórico escolar
    "iscurriculum"                                   boolean, --É do Currículo
    "curricularcomponentgroupdocumentendcourseid"    integer, --Grupo de disciplina que vai no histórico final
    "curricularcomponentgroupelectiveid"             integer, --Grupo de disciplina para autorizar a matricula em eletivas (deste grupo)
    "curriculumtypeid"                               integer, --Tipo de curriculo - antigo currículo MCO
    "isconditiontrainingperiod"                      boolean, --Requisito para estágio profissional de alunos
    "enddate"                                        date --Data que a disciplina deixa de fazer parte do currículo
) INHERITS ("baslog");

COMMENT ON TABLE "acdcurriculum" IS 'curriculo de curso';
COMMENT ON COLUMN "acdcurriculum"."curriculumid" IS 'Codigo da disciplina do curriculo';
COMMENT ON COLUMN "acdcurriculum"."courseid" IS 'Codigo do curso';
COMMENT ON COLUMN "acdcurriculum"."courseversion" IS 'Versao do curso';
COMMENT ON COLUMN "acdcurriculum"."turnid" IS 'Codigo do turno';
COMMENT ON COLUMN "acdcurriculum"."unitid" IS 'Codigo da unidade';
COMMENT ON COLUMN "acdcurriculum"."curricularcomponentid" IS 'Codigo da disciplina presente no curriculo';
COMMENT ON COLUMN "acdcurriculum"."curricularcomponentversion" IS 'Versao da disciplina presente no curriculo';
COMMENT ON COLUMN "acdcurriculum"."curricularcomponenttypeid" IS 'Tipo da disciplina no currículo - Eletiva, estágio, normal...';
COMMENT ON COLUMN "acdcurriculum"."semester" IS 'Semestre previsto para que o aluno curse a disciplina';
COMMENT ON COLUMN "acdcurriculum"."isshowdocumentendcourse" IS 'E exibida no histórico escolar';
COMMENT ON COLUMN "acdcurriculum"."iscurriculum" IS 'É do Currículo';
COMMENT ON COLUMN "acdcurriculum"."curricularcomponentgroupdocumentendcourseid" IS 'Grupo de disciplina que vai no histórico final';
COMMENT ON COLUMN "acdcurriculum"."curricularcomponentgroupelectiveid" IS 'Grupo de disciplina para autorizar a matricula em eletivas (deste grupo)';
COMMENT ON COLUMN "acdcurriculum"."curriculumtypeid" IS 'Tipo de curriculo - antigo currículo MCO';
COMMENT ON COLUMN "acdcurriculum"."isconditiontrainingperiod" IS 'Requisito para estágio profissional de alunos';
COMMENT ON COLUMN "acdcurriculum"."enddate" IS 'Data que a disciplina deixa de fazer parte do currículo';

CREATE SEQUENCE "seq_curriculumid";
ALTER TABLE "acdcurriculum" ALTER COLUMN "curriculumid" SET DEFAULT NEXTVAL('"seq_curriculumid"');
ALTER TABLE "acdcurriculum" ALTER COLUMN "courseid" SET NOT NULL;
ALTER TABLE "acdcurriculum" ALTER COLUMN "courseversion" SET NOT NULL;
ALTER TABLE "acdcurriculum" ALTER COLUMN "turnid" SET NOT NULL;
ALTER TABLE "acdcurriculum" ALTER COLUMN "unitid" SET NOT NULL;
ALTER TABLE "acdcurriculum" ALTER COLUMN "curricularcomponentid" SET NOT NULL;
ALTER TABLE "acdcurriculum" ALTER COLUMN "curricularcomponentversion" SET NOT NULL;
ALTER TABLE "acdcurriculum" ALTER COLUMN "curricularcomponenttypeid" SET NOT NULL;
ALTER TABLE "acdcurriculum" ALTER COLUMN "semester" SET NOT NULL;
ALTER TABLE "acdcurriculum" ALTER COLUMN "isshowdocumentendcourse" SET NOT NULL;
ALTER TABLE "acdcurriculum" ALTER COLUMN "isshowdocumentendcourse" SET DEFAULT TRUE ;
ALTER TABLE "acdcurriculum" ALTER COLUMN "iscurriculum" SET NOT NULL;
ALTER TABLE "acdcurriculum" ALTER COLUMN "iscurriculum" SET DEFAULT TRUE ;
ALTER TABLE "acdcurriculum" ALTER COLUMN "curriculumtypeid" SET NOT NULL;
ALTER TABLE "acdcurriculum" ALTER COLUMN "isconditiontrainingperiod" SET NOT NULL;
ALTER TABLE "acdcurriculum" ALTER COLUMN "isconditiontrainingperiod" SET DEFAULT FALSE ;

ALTER TABLE "acdcurriculum" ALTER COLUMN "curriculumid" SET NOT NULL;
ALTER TABLE "acdcurriculum" ADD PRIMARY KEY ("curriculumid");

CREATE INDEX "idx_acdcurriculum_course" ON "acdcurriculum" ("courseid","courseversion");
CREATE UNIQUE INDEX "idx_acdcurriculum_unique" ON "acdcurriculum" ("courseid","courseversion","turnid","unitid","curricularcomponentid","curricularcomponentversion");
CREATE INDEX "idx_acdcurriculum_curricularcomponentgroupdocumentendcourseid" ON "acdcurriculum" ("curricularcomponentgroupdocumentendcourseid");
CREATE INDEX "idx_acdcurriculum_curricularcomponentgroupelectiveid" ON "acdcurriculum" ("curricularcomponentgroupelectiveid");
CREATE INDEX "idx_acdcurriculum_curricularcomponentid_curricularcomponentversion" ON "acdcurriculum" ("curricularcomponentid","curricularcomponentversion");

ALTER TABLE "acdcurriculum" ADD FOREIGN KEY ("curricularcomponentid","curricularcomponentversion") REFERENCES "acdcurricularcomponent"("curricularcomponentid","curricularcomponentversion");

ALTER TABLE "acdcurriculum" ADD FOREIGN KEY ("courseid","courseversion","turnid","unitid") REFERENCES "acdcourseoccurrence"("courseid","courseversion","turnid","unitid");

ALTER TABLE "acdcurriculum" ADD FOREIGN KEY ("curricularcomponenttypeid") REFERENCES "acdcurricularcomponenttype"("curricularcomponenttypeid");

ALTER TABLE "acdcurriculum" ADD FOREIGN KEY ("curriculumtypeid") REFERENCES "acdcurriculumtype"("curriculumtypeid");

----------------------------------------------------------------------
-- --
--
-- Table: finpayrolldiscounttarget
-- Purpose: debito em folha de pagamento (de funcionarios) a nivel de 
--          contrato.  
--
-- --
----------------------------------------------------------------------

CREATE TABLE "finpayrolldiscounttarget" 
(
    "ispayrolldiscount"    boolean, --Define se o pagamento é descontado em folha ou nao
    "employeeid"           integer --Se tiver um codigo de funcionario (personid) neste campo, quer dizer que o dono deste contrato quer que sua mensalidade seja descontada na folha de pagamento deste funcionario. Se nao tiver nenhuma informacao neste campo o desconto sera feito na folha do titular do contrato.
) INHERITS ("fininvoicetarget");

COMMENT ON TABLE "finpayrolldiscounttarget" IS 'debito em folha de pagamento (de funcionarios) a nivel de contrato. ';
COMMENT ON COLUMN "finpayrolldiscounttarget"."ispayrolldiscount" IS 'Define se o pagamento é descontado em folha ou nao';
COMMENT ON COLUMN "finpayrolldiscounttarget"."employeeid" IS 'Se tiver um codigo de funcionario (personid) neste campo, quer dizer que o dono deste contrato quer que sua mensalidade seja descontada na folha de pagamento deste funcionario. Se nao tiver nenhuma informacao neste campo o desconto sera feito na folha do titular do contrato.';

ALTER TABLE "finpayrolldiscounttarget" ALTER COLUMN "ispayrolldiscount" SET NOT NULL;
ALTER TABLE "finpayrolldiscounttarget" ALTER COLUMN "ispayrolldiscount" SET DEFAULT TRUE ;
ALTER TABLE "finpayrolldiscounttarget" ALTER COLUMN "employeeid" SET NOT NULL;

ALTER TABLE "finpayrolldiscounttarget" ALTER COLUMN "contractid" SET NOT NULL;
ALTER TABLE "finpayrolldiscounttarget" ADD PRIMARY KEY ("contractid");

ALTER TABLE "finpayrolldiscounttarget" ADD FOREIGN KEY ("employeeid") REFERENCES "basphysicalpersonemployee"("personid");

----------------------------------------------------------------------
-- --
--
-- Table: acdenrollbookdata
-- Purpose: tabela para armazenar os dados do livro matr�cula
--
-- --
----------------------------------------------------------------------

CREATE TABLE "acdenrollbookdata" 
(
    "personid"             integer, --Codigo da pessoa
    "courseid"             integer, --Codigo do curso
    "courseversion"        integer, --Versao do curso
    "unitid"               integer, --Codigo da unidade
    "turnid"               integer, --Codigo do turno
    "prevcourseid"         integer, --Referencia o curso anterior (para os casos de transferência interna)
    "prevcourseversion"    integer, --Referencia a versão de curso anterior
    "prevunitid"           integer, --Referencia a unidade anterior
    "prevturnid"           integer, --Referencia o turno anterior
    "stateenrollbookid"    integer, --Estado do livro matricula: rematricula, vestibulando, transferencia interna, trancamento, reingresso, etc.
    "periodid"             varchar(10) --Codigo do periodo
) INHERITS ("baslog");

COMMENT ON TABLE "acdenrollbookdata" IS 'tabela para armazenar os dados do livro matr�cula';
COMMENT ON COLUMN "acdenrollbookdata"."personid" IS 'Codigo da pessoa';
COMMENT ON COLUMN "acdenrollbookdata"."courseid" IS 'Codigo do curso';
COMMENT ON COLUMN "acdenrollbookdata"."courseversion" IS 'Versao do curso';
COMMENT ON COLUMN "acdenrollbookdata"."unitid" IS 'Codigo da unidade';
COMMENT ON COLUMN "acdenrollbookdata"."turnid" IS 'Codigo do turno';
COMMENT ON COLUMN "acdenrollbookdata"."prevcourseid" IS 'Referencia o curso anterior (para os casos de transferência interna)';
COMMENT ON COLUMN "acdenrollbookdata"."prevcourseversion" IS 'Referencia a versão de curso anterior';
COMMENT ON COLUMN "acdenrollbookdata"."prevunitid" IS 'Referencia a unidade anterior';
COMMENT ON COLUMN "acdenrollbookdata"."prevturnid" IS 'Referencia o turno anterior';
COMMENT ON COLUMN "acdenrollbookdata"."stateenrollbookid" IS 'Estado do livro matricula: rematricula, vestibulando, transferencia interna, trancamento, reingresso, etc.';
COMMENT ON COLUMN "acdenrollbookdata"."periodid" IS 'Codigo do periodo';

ALTER TABLE "acdenrollbookdata" ALTER COLUMN "personid" SET NOT NULL;
ALTER TABLE "acdenrollbookdata" ALTER COLUMN "courseid" SET NOT NULL;
ALTER TABLE "acdenrollbookdata" ALTER COLUMN "courseversion" SET NOT NULL;
ALTER TABLE "acdenrollbookdata" ALTER COLUMN "unitid" SET NOT NULL;
ALTER TABLE "acdenrollbookdata" ALTER COLUMN "turnid" SET NOT NULL;
ALTER TABLE "acdenrollbookdata" ALTER COLUMN "stateenrollbookid" SET NOT NULL;
ALTER TABLE "acdenrollbookdata" ALTER COLUMN "periodid" SET NOT NULL;

ALTER TABLE "acdenrollbookdata" ADD FOREIGN KEY ("personid") REFERENCES "basperson"("personid");

ALTER TABLE "acdenrollbookdata" ADD FOREIGN KEY ("periodid") REFERENCES "acdperiod"("periodid");

----------------------------------------------------------------------
-- --
--
-- Table: acdexamdate
-- Purpose: datas de exame
--
-- --
----------------------------------------------------------------------

CREATE TABLE "acdexamdate" 
(
    "learningperiodid"    integer, --Codigo do periodo letivo
    "weekdayid"           integer, --Codigo do dia da semana
    "examdate"            date --Data do exame
) INHERITS ("baslog");

COMMENT ON TABLE "acdexamdate" IS 'datas de exame';
COMMENT ON COLUMN "acdexamdate"."learningperiodid" IS 'Codigo do periodo letivo';
COMMENT ON COLUMN "acdexamdate"."weekdayid" IS 'Codigo do dia da semana';
COMMENT ON COLUMN "acdexamdate"."examdate" IS 'Data do exame';

ALTER TABLE "acdexamdate" ALTER COLUMN "learningperiodid" SET NOT NULL;
ALTER TABLE "acdexamdate" ALTER COLUMN "weekdayid" SET NOT NULL;
ALTER TABLE "acdexamdate" ALTER COLUMN "examdate" SET NOT NULL;

ALTER TABLE "acdexamdate" ALTER COLUMN "learningperiodid" SET NOT NULL;
ALTER TABLE "acdexamdate" ALTER COLUMN "weekdayid" SET NOT NULL;
ALTER TABLE "acdexamdate" ADD PRIMARY KEY ("learningperiodid","weekdayid");

ALTER TABLE "acdexamdate" ADD FOREIGN KEY ("learningperiodid") REFERENCES "acdlearningperiod"("learningperiodid");

ALTER TABLE "acdexamdate" ADD FOREIGN KEY ("weekdayid") REFERENCES "basweekday"("weekdayid");

----------------------------------------------------------------------
-- --
--
-- Table: finstudentfinancing
-- Purpose: financiamento estudandil (fies)
--
-- --
----------------------------------------------------------------------

CREATE TABLE "finstudentfinancing" 
(
    "studentfinancingid"    integer, --Codigo identificador do financiamento estudantil
    "contractid"            integer, --Contrato do aluno (acdContract)
    "initialvalue"          numeric(14,4), --Valor inicial do financiamento
    "currentvalue"          numeric(14,4), --Valor atual do financiamento
    "comments"              text --Observacoes
) INHERITS ("baslog");

COMMENT ON TABLE "finstudentfinancing" IS 'financiamento estudandil (fies)';
COMMENT ON COLUMN "finstudentfinancing"."studentfinancingid" IS 'Codigo identificador do financiamento estudantil';
COMMENT ON COLUMN "finstudentfinancing"."contractid" IS 'Contrato do aluno (acdContract)';
COMMENT ON COLUMN "finstudentfinancing"."initialvalue" IS 'Valor inicial do financiamento';
COMMENT ON COLUMN "finstudentfinancing"."currentvalue" IS 'Valor atual do financiamento';
COMMENT ON COLUMN "finstudentfinancing"."comments" IS 'Observacoes';

CREATE SEQUENCE "seq_studentfinancingid";
ALTER TABLE "finstudentfinancing" ALTER COLUMN "studentfinancingid" SET DEFAULT NEXTVAL('"seq_studentfinancingid"');
ALTER TABLE "finstudentfinancing" ALTER COLUMN "contractid" SET NOT NULL;
ALTER TABLE "finstudentfinancing" ALTER COLUMN "initialvalue" SET NOT NULL;
ALTER TABLE "finstudentfinancing" ALTER COLUMN "currentvalue" SET NOT NULL;

ALTER TABLE "finstudentfinancing" ALTER COLUMN "studentfinancingid" SET NOT NULL;
ALTER TABLE "finstudentfinancing" ADD PRIMARY KEY ("studentfinancingid");

CREATE UNIQUE INDEX "idx_finstudentfinancing_unique" ON "finstudentfinancing" ("contractid");

ALTER TABLE "finstudentfinancing" ADD FOREIGN KEY ("contractid") REFERENCES "acdcontract"("contractid");

----------------------------------------------------------------------
-- --
--
-- Table: acddiploma
-- Purpose: emissao de diplomas
--
-- --
----------------------------------------------------------------------

CREATE TABLE "acddiploma" 
(
    "registernumber"    integer, --Numero de registro
    "contractid"        integer, --Contrato
    "sheet"             integer, --Folha
    "book"              varchar(20), --Livro
    "protocolid"        varchar(20), --Numero do processo
    "emissiondate"      date --Data de emissão
) INHERITS ("baslog");

COMMENT ON TABLE "acddiploma" IS 'emissao de diplomas';
COMMENT ON COLUMN "acddiploma"."registernumber" IS 'Numero de registro';
COMMENT ON COLUMN "acddiploma"."contractid" IS 'Contrato';
COMMENT ON COLUMN "acddiploma"."sheet" IS 'Folha';
COMMENT ON COLUMN "acddiploma"."book" IS 'Livro';
COMMENT ON COLUMN "acddiploma"."protocolid" IS 'Numero do processo';
COMMENT ON COLUMN "acddiploma"."emissiondate" IS 'Data de emissão';

ALTER TABLE "acddiploma" ALTER COLUMN "registernumber" SET NOT NULL;
ALTER TABLE "acddiploma" ALTER COLUMN "contractid" SET NOT NULL;
ALTER TABLE "acddiploma" ALTER COLUMN "sheet" SET NOT NULL;
ALTER TABLE "acddiploma" ALTER COLUMN "book" SET NOT NULL;
ALTER TABLE "acddiploma" ALTER COLUMN "protocolid" SET NOT NULL;
ALTER TABLE "acddiploma" ALTER COLUMN "emissiondate" SET NOT NULL;
ALTER TABLE "acddiploma" ALTER COLUMN "emissiondate" SET DEFAULT date(now()) ;

ALTER TABLE "acddiploma" ALTER COLUMN "registernumber" SET NOT NULL;
ALTER TABLE "acddiploma" ADD PRIMARY KEY ("registernumber");

ALTER TABLE "acddiploma" ADD FOREIGN KEY ("contractid") REFERENCES "acdcontract"("contractid");

----------------------------------------------------------------------
-- --
--
-- Table: acdclass
-- Purpose: cadastro da turma dos alunos
--
-- --
----------------------------------------------------------------------

CREATE TABLE "acdclass" 
(
    "classid"                    varchar(20), --Código da turma
    "name"                       text, --Nome completo da turma
    "initiallearningperiodid"    integer, --Período letivo que iniciou a turma
    "vacant"                     integer --Numero de vagas da turma
) INHERITS ("baslog");

COMMENT ON TABLE "acdclass" IS 'cadastro da turma dos alunos';
COMMENT ON COLUMN "acdclass"."classid" IS 'Código da turma';
COMMENT ON COLUMN "acdclass"."name" IS 'Nome completo da turma';
COMMENT ON COLUMN "acdclass"."initiallearningperiodid" IS 'Período letivo que iniciou a turma';
COMMENT ON COLUMN "acdclass"."vacant" IS 'Numero de vagas da turma';

ALTER TABLE "acdclass" ALTER COLUMN "classid" SET NOT NULL;
ALTER TABLE "acdclass" ALTER COLUMN "name" SET NOT NULL;
ALTER TABLE "acdclass" ALTER COLUMN "initiallearningperiodid" SET NOT NULL;
ALTER TABLE "acdclass" ALTER COLUMN "vacant" SET NOT NULL;

ALTER TABLE "acdclass" ALTER COLUMN "classid" SET NOT NULL;
ALTER TABLE "acdclass" ADD PRIMARY KEY ("classid");

ALTER TABLE "acdclass" ADD FOREIGN KEY ("initiallearningperiodid") REFERENCES "acdlearningperiod"("learningperiodid");

----------------------------------------------------------------------
-- --
--
-- Table: acdclasspupil
-- Purpose: cadastro para armazenar todos os alunos que forma um turma
--
-- --
----------------------------------------------------------------------

CREATE TABLE "acdclasspupil" 
(
    "classid"       varchar(20), --Código da turma
    "contractid"    integer, --Codigo do contrato do aluno
    "begindate"     date, --Data que o aluno entrou na turma
    "enddate"       date --Data de saida do aluno dessa turma
) INHERITS ("baslog");

COMMENT ON TABLE "acdclasspupil" IS 'cadastro para armazenar todos os alunos que forma um turma';
COMMENT ON COLUMN "acdclasspupil"."classid" IS 'Código da turma';
COMMENT ON COLUMN "acdclasspupil"."contractid" IS 'Codigo do contrato do aluno';
COMMENT ON COLUMN "acdclasspupil"."begindate" IS 'Data que o aluno entrou na turma';
COMMENT ON COLUMN "acdclasspupil"."enddate" IS 'Data de saida do aluno dessa turma';

ALTER TABLE "acdclasspupil" ALTER COLUMN "classid" SET NOT NULL;
ALTER TABLE "acdclasspupil" ALTER COLUMN "contractid" SET NOT NULL;
ALTER TABLE "acdclasspupil" ALTER COLUMN "begindate" SET NOT NULL;

ALTER TABLE "acdclasspupil" ALTER COLUMN "classid" SET NOT NULL;
ALTER TABLE "acdclasspupil" ALTER COLUMN "contractid" SET NOT NULL;
ALTER TABLE "acdclasspupil" ALTER COLUMN "begindate" SET NOT NULL;
ALTER TABLE "acdclasspupil" ADD PRIMARY KEY ("classid","contractid","begindate");

ALTER TABLE "acdclasspupil" ADD FOREIGN KEY ("classid") REFERENCES "acdclass"("classid");

ALTER TABLE "acdclasspupil" ADD FOREIGN KEY ("contractid") REFERENCES "acdcontract"("contractid");

----------------------------------------------------------------------
-- --
--
-- Table: acdcomplementaryactivitiescategoryrules
-- Purpose: regras para as categorias das atividades complementares
--
-- --
----------------------------------------------------------------------

CREATE TABLE "acdcomplementaryactivitiescategoryrules" 
(
    "complementaryactivitiescategoryrulesid"    integer, --Codigo da regra da categoria da atividade complementar
    "curriculumid"                              integer, --Código do currículo da atividade complementar
    "complementaryactivitiescategoryid"         integer, --Código da categoria da atividade complementar
    "minimumhours"                              float, --Quantidade mínima de horas exigidas nessa categoria 
    "maximumhours"                              float --Quantidade máxima de horas permitidas nessa categoria
) INHERITS ("baslog");

COMMENT ON TABLE "acdcomplementaryactivitiescategoryrules" IS 'regras para as categorias das atividades complementares';
COMMENT ON COLUMN "acdcomplementaryactivitiescategoryrules"."complementaryactivitiescategoryrulesid" IS 'Codigo da regra da categoria da atividade complementar';
COMMENT ON COLUMN "acdcomplementaryactivitiescategoryrules"."curriculumid" IS 'Código do currículo da atividade complementar';
COMMENT ON COLUMN "acdcomplementaryactivitiescategoryrules"."complementaryactivitiescategoryid" IS 'Código da categoria da atividade complementar';
COMMENT ON COLUMN "acdcomplementaryactivitiescategoryrules"."minimumhours" IS 'Quantidade mínima de horas exigidas nessa categoria ';
COMMENT ON COLUMN "acdcomplementaryactivitiescategoryrules"."maximumhours" IS 'Quantidade máxima de horas permitidas nessa categoria';

CREATE SEQUENCE "seq_complementaryactivitiescategoryrulesid";
ALTER TABLE "acdcomplementaryactivitiescategoryrules" ALTER COLUMN "complementaryactivitiescategoryrulesid" SET DEFAULT NEXTVAL('"seq_complementaryactivitiescategoryrulesid"');
ALTER TABLE "acdcomplementaryactivitiescategoryrules" ALTER COLUMN "curriculumid" SET NOT NULL;
ALTER TABLE "acdcomplementaryactivitiescategoryrules" ALTER COLUMN "complementaryactivitiescategoryid" SET NOT NULL;
ALTER TABLE "acdcomplementaryactivitiescategoryrules" ALTER COLUMN "minimumhours" SET NOT NULL;
ALTER TABLE "acdcomplementaryactivitiescategoryrules" ALTER COLUMN "maximumhours" SET NOT NULL;

ALTER TABLE "acdcomplementaryactivitiescategoryrules" ALTER COLUMN "complementaryactivitiescategoryrulesid" SET NOT NULL;
ALTER TABLE "acdcomplementaryactivitiescategoryrules" ADD PRIMARY KEY ("complementaryactivitiescategoryrulesid");

CREATE UNIQUE INDEX "idx_unique_complementaryactivitiescategoryrules" ON "acdcomplementaryactivitiescategoryrules" ("curriculumid","complementaryactivitiescategoryid");

ALTER TABLE "acdcomplementaryactivitiescategoryrules" ADD FOREIGN KEY ("complementaryactivitiescategoryid") REFERENCES "acdcomplementaryactivitiescategory"("complementaryactivitiescategoryid");

ALTER TABLE "acdcomplementaryactivitiescategoryrules" ADD FOREIGN KEY ("curriculumid") REFERENCES "acdcurriculum"("curriculumid");

----------------------------------------------------------------------
-- --
--
-- Table: acdcondition
-- Purpose: condicoes para cursar a disciplina - requisitos
--
-- --
----------------------------------------------------------------------

CREATE TABLE "acdcondition" 
(
    "conditionid"              integer, --Codigo da condicao - requisito
    "type"                     char(1), --Tipo de pré-requisito (Pré / Co-requisito) P e C
    "curriculumid"             integer, --Código da disciplina
    "conditioncurriculumid"    integer, --Disciplina Pré-Requisito
    "credits"                  integer, --Pré-requisito por número de créditos
    "numberhour"               integer, --Pré-requisito por número de horas
    "educationareaid"          integer --Créditos ou número de horas pode ser definifo por área
) INHERITS ("baslog");

COMMENT ON TABLE "acdcondition" IS 'condicoes para cursar a disciplina - requisitos';
COMMENT ON COLUMN "acdcondition"."conditionid" IS 'Codigo da condicao - requisito';
COMMENT ON COLUMN "acdcondition"."type" IS 'Tipo de pré-requisito (Pré / Co-requisito) P e C';
COMMENT ON COLUMN "acdcondition"."curriculumid" IS 'Código da disciplina';
COMMENT ON COLUMN "acdcondition"."conditioncurriculumid" IS 'Disciplina Pré-Requisito';
COMMENT ON COLUMN "acdcondition"."credits" IS 'Pré-requisito por número de créditos';
COMMENT ON COLUMN "acdcondition"."numberhour" IS 'Pré-requisito por número de horas';
COMMENT ON COLUMN "acdcondition"."educationareaid" IS 'Créditos ou número de horas pode ser definifo por área';

CREATE SEQUENCE "seq_conditionid";
ALTER TABLE "acdcondition" ALTER COLUMN "conditionid" SET DEFAULT NEXTVAL('"seq_conditionid"');
ALTER TABLE "acdcondition" ALTER COLUMN "type" SET NOT NULL;
ALTER TABLE "acdcondition" ALTER COLUMN "curriculumid" SET NOT NULL;

ALTER TABLE "acdcondition" ALTER COLUMN "conditionid" SET NOT NULL;
ALTER TABLE "acdcondition" ADD PRIMARY KEY ("conditionid");

CREATE INDEX "idx_acdcondition_type" ON "acdcondition" ("type");
CREATE INDEX "idx_acdcondition_conditioncurriculumid" ON "acdcondition" ("conditioncurriculumid");
CREATE INDEX "idx_acdcondition_curriculumid" ON "acdcondition" ("curriculumid");
CREATE INDEX "idx_acdcondition_curriculumid_type" ON "acdcondition" ("curriculumid","type");

ALTER TABLE "acdcondition" ADD FOREIGN KEY ("curriculumid") REFERENCES "acdcurriculum"("curriculumid");

ALTER TABLE "acdcondition" ADD FOREIGN KEY ("educationareaid") REFERENCES "acdeducationarea"("educationareaid");

ALTER TABLE "acdcondition" ADD FOREIGN KEY ("conditioncurriculumid") REFERENCES "acdcurriculum"("curriculumid");

----------------------------------------------------------------------
-- --
--
-- Table: sprinscriptionoption
-- Purpose: opcoes de curso do candidato
--
-- --
----------------------------------------------------------------------

CREATE TABLE "sprinscriptionoption" 
(
    "inscriptionoptionid"    integer, --Codigo da opcao
    "inscriptionid"          integer, --Codigo da inscricao
    "courseoccurrenceid"     integer, --Codigo da ocorrencia de curso
    "optionnumber"           integer, --Numero da opcao
    "courseposition"         integer, --Posicao do candidato no curso
    "generalposition"        integer --Posicao do candidato no geral
) INHERITS ("baslog");

COMMENT ON TABLE "sprinscriptionoption" IS 'opcoes de curso do candidato';
COMMENT ON COLUMN "sprinscriptionoption"."inscriptionoptionid" IS 'Codigo da opcao';
COMMENT ON COLUMN "sprinscriptionoption"."inscriptionid" IS 'Codigo da inscricao';
COMMENT ON COLUMN "sprinscriptionoption"."courseoccurrenceid" IS 'Codigo da ocorrencia de curso';
COMMENT ON COLUMN "sprinscriptionoption"."optionnumber" IS 'Numero da opcao';
COMMENT ON COLUMN "sprinscriptionoption"."courseposition" IS 'Posicao do candidato no curso';
COMMENT ON COLUMN "sprinscriptionoption"."generalposition" IS 'Posicao do candidato no geral';

CREATE SEQUENCE "seq_inscriptionoptionid";
ALTER TABLE "sprinscriptionoption" ALTER COLUMN "inscriptionoptionid" SET DEFAULT NEXTVAL('"seq_inscriptionoptionid"');
ALTER TABLE "sprinscriptionoption" ALTER COLUMN "inscriptionid" SET NOT NULL;
ALTER TABLE "sprinscriptionoption" ALTER COLUMN "courseoccurrenceid" SET NOT NULL;
ALTER TABLE "sprinscriptionoption" ALTER COLUMN "optionnumber" SET NOT NULL;

ALTER TABLE "sprinscriptionoption" ALTER COLUMN "inscriptionoptionid" SET NOT NULL;
ALTER TABLE "sprinscriptionoption" ADD PRIMARY KEY ("inscriptionoptionid");

CREATE INDEX "idx_sprinscriptionoption_inscriptionid" ON "sprinscriptionoption" ("inscriptionid");

ALTER TABLE "sprinscriptionoption" ADD FOREIGN KEY ("inscriptionid") REFERENCES "sprinscription"("inscriptionid");

ALTER TABLE "sprinscriptionoption" ADD FOREIGN KEY ("courseoccurrenceid") REFERENCES "sprcourseoccurrence"("courseoccurrenceid");

----------------------------------------------------------------------
-- --
--
-- Table: ptcprotocol
-- Purpose: protocolos
--
-- --
----------------------------------------------------------------------

CREATE TABLE "ptcprotocol" 
(
    "protocolid"       varchar(10), --Codigo do protocolo
    "contractid"       integer, --Codigo do contrato
    "personid"         integer, --Codigo da pessoa
    "originplaceid"    integer, --Codigo do local de origem
    "inputdate"        date, --Data de entrada
    "outputdate"       date, --Data de saida
    "situationid"      integer, --Codigo da situacao
    "ischargednow"     boolean, --Se vai ser pago no ato ou na mensalidade
    "protocollogin"    varchar(20), --Usuario que criou o processo
    "tax"              numeric(14,2), --Taxa
    "historictax"      integer --Operacao financeira
) INHERITS ("baslog");

COMMENT ON TABLE "ptcprotocol" IS 'protocolos';
COMMENT ON COLUMN "ptcprotocol"."protocolid" IS 'Codigo do protocolo';
COMMENT ON COLUMN "ptcprotocol"."contractid" IS 'Codigo do contrato';
COMMENT ON COLUMN "ptcprotocol"."personid" IS 'Codigo da pessoa';
COMMENT ON COLUMN "ptcprotocol"."originplaceid" IS 'Codigo do local de origem';
COMMENT ON COLUMN "ptcprotocol"."inputdate" IS 'Data de entrada';
COMMENT ON COLUMN "ptcprotocol"."outputdate" IS 'Data de saida';
COMMENT ON COLUMN "ptcprotocol"."situationid" IS 'Codigo da situacao';
COMMENT ON COLUMN "ptcprotocol"."ischargednow" IS 'Se vai ser pago no ato ou na mensalidade';
COMMENT ON COLUMN "ptcprotocol"."protocollogin" IS 'Usuario que criou o processo';
COMMENT ON COLUMN "ptcprotocol"."tax" IS 'Taxa';
COMMENT ON COLUMN "ptcprotocol"."historictax" IS 'Operacao financeira';

ALTER TABLE "ptcprotocol" ALTER COLUMN "protocolid" SET NOT NULL;
ALTER TABLE "ptcprotocol" ALTER COLUMN "personid" SET NOT NULL;
ALTER TABLE "ptcprotocol" ALTER COLUMN "originplaceid" SET NOT NULL;
ALTER TABLE "ptcprotocol" ALTER COLUMN "inputdate" SET NOT NULL;
ALTER TABLE "ptcprotocol" ALTER COLUMN "situationid" SET NOT NULL;
ALTER TABLE "ptcprotocol" ALTER COLUMN "ischargednow" SET NOT NULL;
ALTER TABLE "ptcprotocol" ALTER COLUMN "ischargednow" SET DEFAULT FALSE ;
ALTER TABLE "ptcprotocol" ALTER COLUMN "protocollogin" SET NOT NULL;

ALTER TABLE "ptcprotocol" ALTER COLUMN "protocolid" SET NOT NULL;
ALTER TABLE "ptcprotocol" ADD PRIMARY KEY ("protocolid");

ALTER TABLE "ptcprotocol" ADD FOREIGN KEY ("originplaceid") REFERENCES "ptcoriginplace"("originplaceid");

ALTER TABLE "ptcprotocol" ADD FOREIGN KEY ("situationid") REFERENCES "ptcsituation"("situationid");

ALTER TABLE "ptcprotocol" ADD FOREIGN KEY ("personid") REFERENCES "basphysicalperson"("personid");

ALTER TABLE "ptcprotocol" ADD FOREIGN KEY ("contractid") REFERENCES "acdcontract"("contractid");

----------------------------------------------------------------------
-- --
--
-- Table: acdmovementcontract
-- Purpose: movimentacao do contrato
--
-- --
----------------------------------------------------------------------

CREATE TABLE "acdmovementcontract" 
(
    "contractid"          integer, --Codigo do contrato
    "statecontractid"     integer, --Codigo do estado contratual
    "statetime"           timestamp, --Momento de ocorrencia da movimentacao
    "reasonid"            integer, --Motivo da movimentacao
    "learningperiodid"    integer --Codigo do periodo letivo no qual a movimentacao ocorreu
) INHERITS ("baslog");

COMMENT ON TABLE "acdmovementcontract" IS 'movimentacao do contrato';
COMMENT ON COLUMN "acdmovementcontract"."contractid" IS 'Codigo do contrato';
COMMENT ON COLUMN "acdmovementcontract"."statecontractid" IS 'Codigo do estado contratual';
COMMENT ON COLUMN "acdmovementcontract"."statetime" IS 'Momento de ocorrencia da movimentacao';
COMMENT ON COLUMN "acdmovementcontract"."reasonid" IS 'Motivo da movimentacao';
COMMENT ON COLUMN "acdmovementcontract"."learningperiodid" IS 'Codigo do periodo letivo no qual a movimentacao ocorreu';

ALTER TABLE "acdmovementcontract" ALTER COLUMN "contractid" SET NOT NULL;
ALTER TABLE "acdmovementcontract" ALTER COLUMN "statecontractid" SET NOT NULL;
ALTER TABLE "acdmovementcontract" ALTER COLUMN "statetime" SET NOT NULL;

ALTER TABLE "acdmovementcontract" ALTER COLUMN "contractid" SET NOT NULL;
ALTER TABLE "acdmovementcontract" ALTER COLUMN "statecontractid" SET NOT NULL;
ALTER TABLE "acdmovementcontract" ALTER COLUMN "statetime" SET NOT NULL;
ALTER TABLE "acdmovementcontract" ADD PRIMARY KEY ("contractid","statecontractid","statetime");

ALTER TABLE "acdmovementcontract" ADD FOREIGN KEY ("contractid") REFERENCES "acdcontract"("contractid");

ALTER TABLE "acdmovementcontract" ADD FOREIGN KEY ("reasonid") REFERENCES "acdreason"("reasonid");

ALTER TABLE "acdmovementcontract" ADD FOREIGN KEY ("statecontractid") REFERENCES "acdstatecontract"("statecontractid");

ALTER TABLE "acdmovementcontract" ADD FOREIGN KEY ("learningperiodid") REFERENCES "acdlearningperiod"("learningperiodid");

----------------------------------------------------------------------
-- --
--
-- Table: acddegree
-- Purpose: graus - composi��o 
--
-- --
----------------------------------------------------------------------

CREATE TABLE "acddegree" 
(
    "degreeid"            integer, --Codigo do grau academico
    "learningperiodid"    integer, --Codigo do periodo letivo
    "description"         text, --Descricao
    "limitdate"           date, --Data limite
    "degreenumber"        integer, --Numero do grau
    "concept"             boolean --Se e conceito (true) ou nota (false)
) INHERITS ("baslog");

COMMENT ON TABLE "acddegree" IS 'graus - composi��o ';
COMMENT ON COLUMN "acddegree"."degreeid" IS 'Codigo do grau academico';
COMMENT ON COLUMN "acddegree"."learningperiodid" IS 'Codigo do periodo letivo';
COMMENT ON COLUMN "acddegree"."description" IS 'Descricao';
COMMENT ON COLUMN "acddegree"."limitdate" IS 'Data limite';
COMMENT ON COLUMN "acddegree"."degreenumber" IS 'Numero do grau';
COMMENT ON COLUMN "acddegree"."concept" IS 'Se e conceito (true) ou nota (false)';

CREATE SEQUENCE "seq_degreeid";
ALTER TABLE "acddegree" ALTER COLUMN "degreeid" SET DEFAULT NEXTVAL('"seq_degreeid"');
ALTER TABLE "acddegree" ALTER COLUMN "learningperiodid" SET NOT NULL;
ALTER TABLE "acddegree" ALTER COLUMN "description" SET NOT NULL;
ALTER TABLE "acddegree" ALTER COLUMN "degreenumber" SET NOT NULL;
ALTER TABLE "acddegree" ALTER COLUMN "concept" SET NOT NULL;
ALTER TABLE "acddegree" ALTER COLUMN "concept" SET DEFAULT FALSE ;

ALTER TABLE "acddegree" ALTER COLUMN "degreeid" SET NOT NULL;
ALTER TABLE "acddegree" ADD PRIMARY KEY ("degreeid");

CREATE INDEX "idx_acddegree_learningperiodid" ON "acddegree" ("learningperiodid");
CREATE INDEX "idx_acddegree_degreenumber" ON "acddegree" ("degreenumber");
CREATE UNIQUE INDEX "idx_acddegree_unique" ON "acddegree" ("learningperiodid","degreenumber");

ALTER TABLE "acddegree" ADD FOREIGN KEY ("learningperiodid") REFERENCES "acdlearningperiod"("learningperiodid");

----------------------------------------------------------------------
-- --
--
-- Table: acdmessagecontractrenewal
-- Purpose: tabela de mensagens a serem exibidas na renovacao 
--          contratual 
--
-- --
----------------------------------------------------------------------

CREATE TABLE "acdmessagecontractrenewal" 
(
    "messagecontractrenewalid"    integer, --Codigo da mensagem
    "learningperiodid"            integer, --Codigo do periodo letivo
    "message"                     text, --Mensagem
    "font"                        text, --Fonte da mensagem
    "sequence"                    integer, --Sequencia na qual a mensagem deve aparecer
    "length"                      integer, --Tamanho (em caracteres)
    "islistener"                  boolean, --Se e para ouvintes
    "status"                      char(1) --Identificador do tipo de vinculo
) INHERITS ("baslog");

COMMENT ON TABLE "acdmessagecontractrenewal" IS 'tabela de mensagens a serem exibidas na renovacao contratual';
COMMENT ON COLUMN "acdmessagecontractrenewal"."messagecontractrenewalid" IS 'Codigo da mensagem';
COMMENT ON COLUMN "acdmessagecontractrenewal"."learningperiodid" IS 'Codigo do periodo letivo';
COMMENT ON COLUMN "acdmessagecontractrenewal"."message" IS 'Mensagem';
COMMENT ON COLUMN "acdmessagecontractrenewal"."font" IS 'Fonte da mensagem';
COMMENT ON COLUMN "acdmessagecontractrenewal"."sequence" IS 'Sequencia na qual a mensagem deve aparecer';
COMMENT ON COLUMN "acdmessagecontractrenewal"."length" IS 'Tamanho (em caracteres)';
COMMENT ON COLUMN "acdmessagecontractrenewal"."islistener" IS 'Se e para ouvintes';
COMMENT ON COLUMN "acdmessagecontractrenewal"."status" IS 'Identificador do tipo de vinculo';

CREATE SEQUENCE "seq_messagecontractrenewalid";
ALTER TABLE "acdmessagecontractrenewal" ALTER COLUMN "messagecontractrenewalid" SET DEFAULT NEXTVAL('"seq_messagecontractrenewalid"');
ALTER TABLE "acdmessagecontractrenewal" ALTER COLUMN "learningperiodid" SET NOT NULL;
ALTER TABLE "acdmessagecontractrenewal" ALTER COLUMN "message" SET NOT NULL;
ALTER TABLE "acdmessagecontractrenewal" ALTER COLUMN "font" SET NOT NULL;
ALTER TABLE "acdmessagecontractrenewal" ALTER COLUMN "sequence" SET NOT NULL;
ALTER TABLE "acdmessagecontractrenewal" ALTER COLUMN "length" SET NOT NULL;
ALTER TABLE "acdmessagecontractrenewal" ALTER COLUMN "islistener" SET NOT NULL;
ALTER TABLE "acdmessagecontractrenewal" ALTER COLUMN "islistener" SET DEFAULT FALSE ;
ALTER TABLE "acdmessagecontractrenewal" ALTER COLUMN "status" SET NOT NULL;

ALTER TABLE "acdmessagecontractrenewal" ALTER COLUMN "messagecontractrenewalid" SET NOT NULL;
ALTER TABLE "acdmessagecontractrenewal" ADD PRIMARY KEY ("messagecontractrenewalid");

ALTER TABLE "acdmessagecontractrenewal" ADD FOREIGN KEY ("learningperiodid") REFERENCES "acdlearningperiod"("learningperiodid");

----------------------------------------------------------------------
-- --
--
-- Table: acdperiodenrolldate
-- Purpose: datas de matricula/ajustes por periodo
--
-- --
----------------------------------------------------------------------

CREATE TABLE "acdperiodenrolldate" 
(
    "periodenrolldateid"    integer, --Codigo da data de matricula/ajustes
    "learningperiodid"      integer, --Codigo do periodo letivo
    "description"           text, --Descricao
    "begindate"             date, --Data de inicio do periodo de matricula/ajustes
    "enddate"               date, --Data de termino do periodo de matricula/ajustes
    "isinternet"            boolean, --Se a matricula estara liberada na Internet
    "isadjustment"          boolean, --Se e um periodo de ajustes
    "isselectiveproc"       boolean --Se e matricula para vestibulandos (bixos)
) INHERITS ("baslog");

COMMENT ON TABLE "acdperiodenrolldate" IS 'datas de matricula/ajustes por periodo';
COMMENT ON COLUMN "acdperiodenrolldate"."periodenrolldateid" IS 'Codigo da data de matricula/ajustes';
COMMENT ON COLUMN "acdperiodenrolldate"."learningperiodid" IS 'Codigo do periodo letivo';
COMMENT ON COLUMN "acdperiodenrolldate"."description" IS 'Descricao';
COMMENT ON COLUMN "acdperiodenrolldate"."begindate" IS 'Data de inicio do periodo de matricula/ajustes';
COMMENT ON COLUMN "acdperiodenrolldate"."enddate" IS 'Data de termino do periodo de matricula/ajustes';
COMMENT ON COLUMN "acdperiodenrolldate"."isinternet" IS 'Se a matricula estara liberada na Internet';
COMMENT ON COLUMN "acdperiodenrolldate"."isadjustment" IS 'Se e um periodo de ajustes';
COMMENT ON COLUMN "acdperiodenrolldate"."isselectiveproc" IS 'Se e matricula para vestibulandos (bixos)';

CREATE SEQUENCE "seq_periodenrolldateid";
ALTER TABLE "acdperiodenrolldate" ALTER COLUMN "periodenrolldateid" SET DEFAULT NEXTVAL('"seq_periodenrolldateid"');
ALTER TABLE "acdperiodenrolldate" ALTER COLUMN "learningperiodid" SET NOT NULL;
ALTER TABLE "acdperiodenrolldate" ALTER COLUMN "description" SET NOT NULL;
ALTER TABLE "acdperiodenrolldate" ALTER COLUMN "begindate" SET NOT NULL;
ALTER TABLE "acdperiodenrolldate" ALTER COLUMN "enddate" SET NOT NULL;
ALTER TABLE "acdperiodenrolldate" ALTER COLUMN "isinternet" SET NOT NULL;
ALTER TABLE "acdperiodenrolldate" ALTER COLUMN "isinternet" SET DEFAULT FALSE ;
ALTER TABLE "acdperiodenrolldate" ALTER COLUMN "isadjustment" SET NOT NULL;
ALTER TABLE "acdperiodenrolldate" ALTER COLUMN "isadjustment" SET DEFAULT FALSE ;
ALTER TABLE "acdperiodenrolldate" ALTER COLUMN "isselectiveproc" SET NOT NULL;
ALTER TABLE "acdperiodenrolldate" ALTER COLUMN "isselectiveproc" SET DEFAULT FALSE ;

ALTER TABLE "acdperiodenrolldate" ALTER COLUMN "periodenrolldateid" SET NOT NULL;
ALTER TABLE "acdperiodenrolldate" ADD PRIMARY KEY ("periodenrolldateid");

ALTER TABLE "acdperiodenrolldate" ADD FOREIGN KEY ("learningperiodid") REFERENCES "acdlearningperiod"("learningperiodid");

----------------------------------------------------------------------
-- --
--
-- Table: ptcprotocolaccess
-- Purpose: controle de acesso aos protocolos
--
-- --
----------------------------------------------------------------------

CREATE TABLE "ptcprotocolaccess" 
(
    "protocolid"    varchar(10), --Codito do protocolo
    "sectorid"      integer --Codigo do setor
) INHERITS ("baslog");

COMMENT ON TABLE "ptcprotocolaccess" IS 'controle de acesso aos protocolos';
COMMENT ON COLUMN "ptcprotocolaccess"."protocolid" IS 'Codito do protocolo';
COMMENT ON COLUMN "ptcprotocolaccess"."sectorid" IS 'Codigo do setor';

ALTER TABLE "ptcprotocolaccess" ALTER COLUMN "protocolid" SET NOT NULL;
ALTER TABLE "ptcprotocolaccess" ALTER COLUMN "sectorid" SET NOT NULL;

ALTER TABLE "ptcprotocolaccess" ALTER COLUMN "protocolid" SET NOT NULL;
ALTER TABLE "ptcprotocolaccess" ALTER COLUMN "sectorid" SET NOT NULL;
ALTER TABLE "ptcprotocolaccess" ADD PRIMARY KEY ("protocolid","sectorid");

ALTER TABLE "ptcprotocolaccess" ADD FOREIGN KEY ("protocolid") REFERENCES "ptcprotocol"("protocolid");

ALTER TABLE "ptcprotocolaccess" ADD FOREIGN KEY ("sectorid") REFERENCES "bassector"("sectorid");

----------------------------------------------------------------------
-- --
--
-- Table: acdmovementcontractcomplement
-- Purpose: complemento da movimentacao de contrato
--
-- --
----------------------------------------------------------------------

CREATE TABLE "acdmovementcontractcomplement" 
(
    "contractid"              integer, --Codigo do contrato
    "statecontractid"         integer, --Codigo do estado contratual
    "statetime"               timestamp, --Momento da ocorrencia da movimentacao
    "statecontractfieldid"    integer, --Codigo do campo de estado contratual
    "value"                   text --Valor
) INHERITS ("baslog");

COMMENT ON TABLE "acdmovementcontractcomplement" IS 'complemento da movimentacao de contrato';
COMMENT ON COLUMN "acdmovementcontractcomplement"."contractid" IS 'Codigo do contrato';
COMMENT ON COLUMN "acdmovementcontractcomplement"."statecontractid" IS 'Codigo do estado contratual';
COMMENT ON COLUMN "acdmovementcontractcomplement"."statetime" IS 'Momento da ocorrencia da movimentacao';
COMMENT ON COLUMN "acdmovementcontractcomplement"."statecontractfieldid" IS 'Codigo do campo de estado contratual';
COMMENT ON COLUMN "acdmovementcontractcomplement"."value" IS 'Valor';

ALTER TABLE "acdmovementcontractcomplement" ALTER COLUMN "contractid" SET NOT NULL;
ALTER TABLE "acdmovementcontractcomplement" ALTER COLUMN "statecontractid" SET NOT NULL;
ALTER TABLE "acdmovementcontractcomplement" ALTER COLUMN "statetime" SET NOT NULL;
ALTER TABLE "acdmovementcontractcomplement" ALTER COLUMN "statecontractfieldid" SET NOT NULL;
ALTER TABLE "acdmovementcontractcomplement" ALTER COLUMN "value" SET NOT NULL;

ALTER TABLE "acdmovementcontractcomplement" ALTER COLUMN "contractid" SET NOT NULL;
ALTER TABLE "acdmovementcontractcomplement" ALTER COLUMN "statecontractid" SET NOT NULL;
ALTER TABLE "acdmovementcontractcomplement" ALTER COLUMN "statetime" SET NOT NULL;
ALTER TABLE "acdmovementcontractcomplement" ALTER COLUMN "statecontractfieldid" SET NOT NULL;
ALTER TABLE "acdmovementcontractcomplement" ADD PRIMARY KEY ("contractid","statecontractid","statetime","statecontractfieldid");

ALTER TABLE "acdmovementcontractcomplement" ADD FOREIGN KEY ("contractid","statecontractid","statetime") REFERENCES "acdmovementcontract"("contractid","statecontractid","statetime");

ALTER TABLE "acdmovementcontractcomplement" ADD FOREIGN KEY ("statecontractfieldid") REFERENCES "acdstatecontractfield"("statecontractfieldid");

----------------------------------------------------------------------
-- --
--
-- Table: acdcurriculumconcurrence
-- Purpose: disciplinas concorrentes, ou seja, apenas uma delas podera 
--          ser cursada pelo aluno (apenas se iscurriculum = f) 
--
-- --
----------------------------------------------------------------------

CREATE TABLE "acdcurriculumconcurrence" 
(
    "curriculumoutid"    integer, --Disciplina que ao ser cursada impede a outra (curriculumInId) de ser cursada
    "curriculuminid"     integer --Disciplina que nao podera ser cursada se a outra (curriculumOutId) for cursada
) INHERITS ("baslog");

COMMENT ON TABLE "acdcurriculumconcurrence" IS 'disciplinas concorrentes, ou seja, apenas uma delas podera ser cursada pelo aluno (apenas se iscurriculum = f)';
COMMENT ON COLUMN "acdcurriculumconcurrence"."curriculumoutid" IS 'Disciplina que ao ser cursada impede a outra (curriculumInId) de ser cursada';
COMMENT ON COLUMN "acdcurriculumconcurrence"."curriculuminid" IS 'Disciplina que nao podera ser cursada se a outra (curriculumOutId) for cursada';

ALTER TABLE "acdcurriculumconcurrence" ALTER COLUMN "curriculumoutid" SET NOT NULL;
ALTER TABLE "acdcurriculumconcurrence" ALTER COLUMN "curriculuminid" SET NOT NULL;

ALTER TABLE "acdcurriculumconcurrence" ALTER COLUMN "curriculumoutid" SET NOT NULL;
ALTER TABLE "acdcurriculumconcurrence" ALTER COLUMN "curriculuminid" SET NOT NULL;
ALTER TABLE "acdcurriculumconcurrence" ADD PRIMARY KEY ("curriculumoutid","curriculuminid");

ALTER TABLE "acdcurriculumconcurrence" ADD FOREIGN KEY ("curriculumoutid") REFERENCES "acdcurriculum"("curriculumid");

ALTER TABLE "acdcurriculumconcurrence" ADD FOREIGN KEY ("curriculuminid") REFERENCES "acdcurriculum"("curriculumid");

----------------------------------------------------------------------
-- --
--
-- Table: acdacademiccalendaradjustments
-- Purpose: ajustes no calend�rio acad�mico
--
-- --
----------------------------------------------------------------------

CREATE TABLE "acdacademiccalendaradjustments" 
(
    "academiccalendaradjustmentsid"    integer, --Codigo do ajuste do calendario academico
    "learningperiodid"                 integer, --Codigo do periodo para ajuste
    "occurrencedate"                   date, --Data de ocorrencia para ajuste
    "weekdayid"                        integer, --Codigo do dia da semana para ajuste
    "turnid"                           integer, --Turno para ajuste
    "professorid"                      integer, --Codigo do professor
    "inout"                            boolean --Informa se é uma ocorrencia que está sendo adicionada no calendário ou retirada
) INHERITS ("baslog");

COMMENT ON TABLE "acdacademiccalendaradjustments" IS 'ajustes no calend�rio acad�mico';
COMMENT ON COLUMN "acdacademiccalendaradjustments"."academiccalendaradjustmentsid" IS 'Codigo do ajuste do calendario academico';
COMMENT ON COLUMN "acdacademiccalendaradjustments"."learningperiodid" IS 'Codigo do periodo para ajuste';
COMMENT ON COLUMN "acdacademiccalendaradjustments"."occurrencedate" IS 'Data de ocorrencia para ajuste';
COMMENT ON COLUMN "acdacademiccalendaradjustments"."weekdayid" IS 'Codigo do dia da semana para ajuste';
COMMENT ON COLUMN "acdacademiccalendaradjustments"."turnid" IS 'Turno para ajuste';
COMMENT ON COLUMN "acdacademiccalendaradjustments"."professorid" IS 'Codigo do professor';
COMMENT ON COLUMN "acdacademiccalendaradjustments"."inout" IS 'Informa se é uma ocorrencia que está sendo adicionada no calendário ou retirada';

CREATE SEQUENCE "seq_academiccalendaradjustmentsid";
ALTER TABLE "acdacademiccalendaradjustments" ALTER COLUMN "academiccalendaradjustmentsid" SET DEFAULT NEXTVAL('"seq_academiccalendaradjustmentsid"');
ALTER TABLE "acdacademiccalendaradjustments" ALTER COLUMN "learningperiodid" SET NOT NULL;
ALTER TABLE "acdacademiccalendaradjustments" ALTER COLUMN "occurrencedate" SET NOT NULL;
ALTER TABLE "acdacademiccalendaradjustments" ALTER COLUMN "inout" SET NOT NULL;
ALTER TABLE "acdacademiccalendaradjustments" ALTER COLUMN "inout" SET DEFAULT FALSE ;

ALTER TABLE "acdacademiccalendaradjustments" ALTER COLUMN "academiccalendaradjustmentsid" SET NOT NULL;
ALTER TABLE "acdacademiccalendaradjustments" ADD PRIMARY KEY ("academiccalendaradjustmentsid");

ALTER TABLE "acdacademiccalendaradjustments" ADD FOREIGN KEY ("professorid") REFERENCES "basphysicalpersonprofessor"("personid");

ALTER TABLE "acdacademiccalendaradjustments" ADD FOREIGN KEY ("learningperiodid") REFERENCES "acdlearningperiod"("learningperiodid");

ALTER TABLE "acdacademiccalendaradjustments" ADD FOREIGN KEY ("weekdayid") REFERENCES "basweekday"("weekdayid");

ALTER TABLE "acdacademiccalendaradjustments" ADD FOREIGN KEY ("turnid") REFERENCES "basturn"("turnid");

----------------------------------------------------------------------
-- --
--
-- Table: acdacademiccalendar
-- Purpose: calend�rio acad�mico
--
-- --
----------------------------------------------------------------------

CREATE TABLE "acdacademiccalendar" 
(
    "academiccalendarid"    integer, --Codigo do evento do calendario academico
    "learningperiodid"      integer, --Codigo do periodo letivo
    "occurrencedate"        date, --Data de ocorrencia do evento
    "weekdayid"             integer --Codigo do dia da semana em que ocorre o evento
) INHERITS ("baslog");

COMMENT ON TABLE "acdacademiccalendar" IS 'calend�rio acad�mico';
COMMENT ON COLUMN "acdacademiccalendar"."academiccalendarid" IS 'Codigo do evento do calendario academico';
COMMENT ON COLUMN "acdacademiccalendar"."learningperiodid" IS 'Codigo do periodo letivo';
COMMENT ON COLUMN "acdacademiccalendar"."occurrencedate" IS 'Data de ocorrencia do evento';
COMMENT ON COLUMN "acdacademiccalendar"."weekdayid" IS 'Codigo do dia da semana em que ocorre o evento';

CREATE SEQUENCE "seq_academiccalendarid";
ALTER TABLE "acdacademiccalendar" ALTER COLUMN "academiccalendarid" SET DEFAULT NEXTVAL('"seq_academiccalendarid"');
ALTER TABLE "acdacademiccalendar" ALTER COLUMN "learningperiodid" SET NOT NULL;
ALTER TABLE "acdacademiccalendar" ALTER COLUMN "occurrencedate" SET NOT NULL;
ALTER TABLE "acdacademiccalendar" ALTER COLUMN "weekdayid" SET NOT NULL;

ALTER TABLE "acdacademiccalendar" ALTER COLUMN "academiccalendarid" SET NOT NULL;
ALTER TABLE "acdacademiccalendar" ADD PRIMARY KEY ("academiccalendarid");

CREATE UNIQUE INDEX "idx_acdacademiccalendar_unique" ON "acdacademiccalendar" ("learningperiodid","occurrencedate");

ALTER TABLE "acdacademiccalendar" ADD FOREIGN KEY ("weekdayid") REFERENCES "basweekday"("weekdayid");

ALTER TABLE "acdacademiccalendar" ADD FOREIGN KEY ("learningperiodid") REFERENCES "acdlearningperiod"("learningperiodid");

----------------------------------------------------------------------
-- --
--
-- Table: ptcprotocolreq
-- Purpose: requerimentos de protocolo
--
-- --
----------------------------------------------------------------------

CREATE TABLE "ptcprotocolreq" 
(
    "protocolid"        varchar(10), --Codigo do protocolo
    "requerimentid"     integer, --Codigo do requerimento
    "situationid"       integer, --Codigo da situacao
    "specifications"    text --Especificacoes
) INHERITS ("baslog");

COMMENT ON TABLE "ptcprotocolreq" IS 'requerimentos de protocolo';
COMMENT ON COLUMN "ptcprotocolreq"."protocolid" IS 'Codigo do protocolo';
COMMENT ON COLUMN "ptcprotocolreq"."requerimentid" IS 'Codigo do requerimento';
COMMENT ON COLUMN "ptcprotocolreq"."situationid" IS 'Codigo da situacao';
COMMENT ON COLUMN "ptcprotocolreq"."specifications" IS 'Especificacoes';

ALTER TABLE "ptcprotocolreq" ALTER COLUMN "protocolid" SET NOT NULL;
ALTER TABLE "ptcprotocolreq" ALTER COLUMN "requerimentid" SET NOT NULL;
ALTER TABLE "ptcprotocolreq" ALTER COLUMN "situationid" SET NOT NULL;

ALTER TABLE "ptcprotocolreq" ALTER COLUMN "protocolid" SET NOT NULL;
ALTER TABLE "ptcprotocolreq" ALTER COLUMN "requerimentid" SET NOT NULL;
ALTER TABLE "ptcprotocolreq" ADD PRIMARY KEY ("protocolid","requerimentid");

ALTER TABLE "ptcprotocolreq" ADD FOREIGN KEY ("protocolid") REFERENCES "ptcprotocol"("protocolid");

ALTER TABLE "ptcprotocolreq" ADD FOREIGN KEY ("requerimentid") REFERENCES "ptcrequeriment"("requerimentid");

ALTER TABLE "ptcprotocolreq" ADD FOREIGN KEY ("situationid") REFERENCES "ptcsituation"("situationid");

----------------------------------------------------------------------
-- --
--
-- Table: acdcurriculumlink
-- Purpose: liga��o de uma disciplina que deixou o curr�culo com 
--          a(s) sua(s) substituta(s) 
--
-- --
----------------------------------------------------------------------

CREATE TABLE "acdcurriculumlink" 
(
    "curriculumid"        integer, --Disciplina que deixou de existir
    "curriculumlinkid"    integer --Disciplina(s) que entraram
) INHERITS ("baslog");

COMMENT ON TABLE "acdcurriculumlink" IS 'liga��o de uma disciplina que deixou o curr�culo com a(s) sua(s) substituta(s)';
COMMENT ON COLUMN "acdcurriculumlink"."curriculumid" IS 'Disciplina que deixou de existir';
COMMENT ON COLUMN "acdcurriculumlink"."curriculumlinkid" IS 'Disciplina(s) que entraram';

ALTER TABLE "acdcurriculumlink" ALTER COLUMN "curriculumid" SET NOT NULL;
ALTER TABLE "acdcurriculumlink" ALTER COLUMN "curriculumlinkid" SET NOT NULL;

ALTER TABLE "acdcurriculumlink" ALTER COLUMN "curriculumid" SET NOT NULL;
ALTER TABLE "acdcurriculumlink" ALTER COLUMN "curriculumlinkid" SET NOT NULL;
ALTER TABLE "acdcurriculumlink" ADD PRIMARY KEY ("curriculumid","curriculumlinkid");

ALTER TABLE "acdcurriculumlink" ADD FOREIGN KEY ("curriculumlinkid") REFERENCES "acdcurriculum"("curriculumid");

ALTER TABLE "acdcurriculumlink" ADD FOREIGN KEY ("curriculumid") REFERENCES "acdcurriculum"("curriculumid");

----------------------------------------------------------------------
-- --
--
-- Table: fininvoice
-- Purpose: tabela principal dos titulos, contendo tanto titulos a 
--          pagar/pagos quanto titulos a receber/recebidos. 
--
-- --
----------------------------------------------------------------------

CREATE TABLE "fininvoice" 
(
    "invoiceid"          integer, --Codigo identificador do titulo
    "personid"           integer, --Codigo identificador da pessoa a qual o titulo pertence
    "accountschemeid"    varchar(30), --Codigo identificador da conta contabil a qual o titulo pertence
    "costcenterid"       varchar(30), --Codigo identificador do centro de custo ao qual o titulo pertence
    "courseid"           varchar(10), --Codigo identificador do curso ao qual a pessoa que originou o titulo pertence
    "courseversion"      integer, --Versao do curso
    "unitid"             integer, --Codigo identificador do campus ao qual o titulo pertence
    "parcelnumber"       integer, --Codigo identificando qual parcela (do total de parcelas) este titulo representa
    "emissiondate"       date, --Data de emissao do titulo
    "maturitydate"       date, --Data de vencimento do titulo
    "value"              numeric(14,4), --Valor do titulo
    "policyid"           integer, --Codigo identificador da politica utilizada pelo titulo (finPolicy)
    "bankinvoiceid"      varchar(30), --Codigo fornecido pelo banco para identificacao do titulo
    "automaticdebit"     boolean, --TRUE (FALSE) indica que o titulo (nao) foi quitado via debito automatico em conta
    "comments"           text, --Informacoes adicionais do titulo
    "incomesourceid"     integer, --Origem de receitas
    "bankaccountid"      integer, --Codigo da conta corrente (finBankAccount) que recebera o dinheiro deste pagamento
    "sagu1invoiceid"     varchar(20), --Para nao perder a referencia a forma antiga de identificacao dos titulos (SAGU1)
    "sectorid"           int
) INHERITS ("baslog");

COMMENT ON TABLE "fininvoice" IS 'tabela principal dos titulos, contendo tanto titulos a pagar/pagos quanto titulos a receber/recebidos.';
COMMENT ON COLUMN "fininvoice"."invoiceid" IS 'Codigo identificador do titulo';
COMMENT ON COLUMN "fininvoice"."personid" IS 'Codigo identificador da pessoa a qual o titulo pertence';
COMMENT ON COLUMN "fininvoice"."accountschemeid" IS 'Codigo identificador da conta contabil a qual o titulo pertence';
COMMENT ON COLUMN "fininvoice"."costcenterid" IS 'Codigo identificador do centro de custo ao qual o titulo pertence';
COMMENT ON COLUMN "fininvoice"."courseid" IS 'Codigo identificador do curso ao qual a pessoa que originou o titulo pertence';
COMMENT ON COLUMN "fininvoice"."courseversion" IS 'Versao do curso';
COMMENT ON COLUMN "fininvoice"."unitid" IS 'Codigo identificador do campus ao qual o titulo pertence';
COMMENT ON COLUMN "fininvoice"."parcelnumber" IS 'Codigo identificando qual parcela (do total de parcelas) este titulo representa';
COMMENT ON COLUMN "fininvoice"."emissiondate" IS 'Data de emissao do titulo';
COMMENT ON COLUMN "fininvoice"."maturitydate" IS 'Data de vencimento do titulo';
COMMENT ON COLUMN "fininvoice"."value" IS 'Valor do titulo';
COMMENT ON COLUMN "fininvoice"."policyid" IS 'Codigo identificador da politica utilizada pelo titulo (finPolicy)';
COMMENT ON COLUMN "fininvoice"."bankinvoiceid" IS 'Codigo fornecido pelo banco para identificacao do titulo';
COMMENT ON COLUMN "fininvoice"."automaticdebit" IS 'TRUE (FALSE) indica que o titulo (nao) foi quitado via debito automatico em conta';
COMMENT ON COLUMN "fininvoice"."comments" IS 'Informacoes adicionais do titulo';
COMMENT ON COLUMN "fininvoice"."incomesourceid" IS 'Origem de receitas';
COMMENT ON COLUMN "fininvoice"."bankaccountid" IS 'Codigo da conta corrente (finBankAccount) que recebera o dinheiro deste pagamento';
COMMENT ON COLUMN "fininvoice"."sagu1invoiceid" IS 'Para nao perder a referencia a forma antiga de identificacao dos titulos (SAGU1)';

CREATE SEQUENCE "seq_invoiceid";
ALTER TABLE "fininvoice" ALTER COLUMN "invoiceid" SET DEFAULT NEXTVAL('"seq_invoiceid"');
ALTER TABLE "fininvoice" ALTER COLUMN "personid" SET NOT NULL;
ALTER TABLE "fininvoice" ALTER COLUMN "accountschemeid" SET NOT NULL;
ALTER TABLE "fininvoice" ALTER COLUMN "costcenterid" SET NOT NULL;
ALTER TABLE "fininvoice" ALTER COLUMN "parcelnumber" SET NOT NULL;
ALTER TABLE "fininvoice" ALTER COLUMN "emissiondate" SET NOT NULL;
ALTER TABLE "fininvoice" ALTER COLUMN "maturitydate" SET NOT NULL;
ALTER TABLE "fininvoice" ALTER COLUMN "value" SET NOT NULL;
ALTER TABLE "fininvoice" ALTER COLUMN "policyid" SET NOT NULL;
ALTER TABLE "fininvoice" ALTER COLUMN "automaticdebit" SET NOT NULL;
ALTER TABLE "fininvoice" ALTER COLUMN "automaticdebit" SET DEFAULT FALSE ;
ALTER TABLE "fininvoice" ALTER COLUMN "incomesourceid" SET NOT NULL;
ALTER TABLE "fininvoice" ALTER COLUMN "bankaccountid" SET NOT NULL;

ALTER TABLE "fininvoice" ALTER COLUMN "invoiceid" SET NOT NULL;
ALTER TABLE "fininvoice" ADD PRIMARY KEY ("invoiceid");

CREATE INDEX "idx_fininvoice_sagu1invoiceid" ON "fininvoice" ("sagu1invoiceid");
CREATE INDEX "idx_fininvoice_bankinvoiceid" ON "fininvoice" ("bankinvoiceid");
CREATE INDEX "idx_fininvoice_maturitydate" ON "fininvoice" ("maturitydate");
CREATE INDEX "idx_fininvoice_personid" ON "fininvoice" ("personid");
CREATE INDEX "idx_fininvoice_invoiceid_maturitydate" ON "fininvoice" ("invoiceid","maturitydate");
CREATE INDEX "idx_fininvoice_courseid_courseversion_unitid" ON "fininvoice" ("courseid","courseversion","unitid");
CREATE INDEX "idx_fininvoice_accountschemeid" ON "fininvoice" ("accountschemeid");

ALTER TABLE "fininvoice" ADD FOREIGN KEY ("courseid","courseversion") REFERENCES "acdcourseversion"("courseid","courseversion");

ALTER TABLE "fininvoice" ADD FOREIGN KEY ("unitid") REFERENCES "basunit"("unitid");

ALTER TABLE "fininvoice" ADD FOREIGN KEY ("costcenterid") REFERENCES "acccostcenter"("costcenterid");

ALTER TABLE "fininvoice" ADD FOREIGN KEY ("policyid") REFERENCES "finpolicy"("policyid");

ALTER TABLE "fininvoice" ADD FOREIGN KEY ("personid") REFERENCES "basperson"("personid");

ALTER TABLE "fininvoice" ADD FOREIGN KEY ("accountschemeid") REFERENCES "accaccountscheme"("accountschemeid");

ALTER TABLE "fininvoice" ADD FOREIGN KEY ("incomesourceid") REFERENCES "finincomesource"("incomesourceid");

ALTER TABLE "fininvoice" ADD FOREIGN KEY ("bankaccountid") REFERENCES "finbankaccount"("bankaccountid");

ALTER TABLE "fininvoice" ADD FOREIGN KEY ("sectorid") REFERENCES "bassector"("sectorid");

----------------------------------------------------------------------
-- --
--
-- Table: finreceivableinvoice
-- Purpose: contem as informacoes adicionais a tabela fininvoice sobre 
--          titulos a receber ou ja recebidos. 
--
-- --
----------------------------------------------------------------------

CREATE TABLE "finreceivableinvoice" 
(
    "senddate"        date, --Data em que o titulo foi enviado para o banco
    "returndate"      date, --Data em que o titulo retornou do banco
    "returnfileid"    integer --Arquivo de retorno do banco
) INHERITS ("fininvoice");

COMMENT ON TABLE "finreceivableinvoice" IS 'contem as informacoes adicionais a tabela fininvoice sobre titulos a receber ou ja recebidos.';
COMMENT ON COLUMN "finreceivableinvoice"."senddate" IS 'Data em que o titulo foi enviado para o banco';
COMMENT ON COLUMN "finreceivableinvoice"."returndate" IS 'Data em que o titulo retornou do banco';
COMMENT ON COLUMN "finreceivableinvoice"."returnfileid" IS 'Arquivo de retorno do banco';

CREATE INDEX "idx_finreceivableinvoice_personid" ON "finreceivableinvoice" ("personid");
CREATE INDEX "idx_finreceivableinvoice_maturitydate" ON "finreceivableinvoice" ("maturitydate");
CREATE INDEX "idx_finreceivableinvoice_sagu1invoiceid" ON "finreceivableinvoice" ("sagu1invoiceid");
CREATE INDEX "idx_finreceivableinvoice_bankinvoiceid" ON "finreceivableinvoice" ("bankinvoiceid");
CREATE INDEX "idx_finreceivableinvoice_invoiceid_maturitydate" ON "finreceivableinvoice" ("invoiceid","maturitydate");
CREATE INDEX "idx_finreceivableinvoice_courseid_courseversion_unitid" ON "finreceivableinvoice" ("courseid","courseversion","unitid");
CREATE INDEX "idx_finreceivableinvoice_accountschemeid" ON "finreceivableinvoice" ("accountschemeid");

ALTER TABLE "finreceivableinvoice" ALTER COLUMN "invoiceid" SET NOT NULL;
ALTER TABLE "finreceivableinvoice" ADD PRIMARY KEY ("invoiceid");

ALTER TABLE "finreceivableinvoice" ADD FOREIGN KEY ("returnfileid") REFERENCES "basfile"("fileid");

----------------------------------------------------------------------
-- --
--
-- Table: finpayableinvoice
-- Purpose: contem as informacoes adicionais a tabela fininvoice sobre 
--          titulos a pagar ou ja pagos 
--
-- --
----------------------------------------------------------------------

CREATE TABLE "finpayableinvoice" 
(
    "receivedate"    date --Data em que o titulo foi recebido pela instituicao para que a mesma efetuasse seu pagamento.
) INHERITS ("fininvoice");

COMMENT ON TABLE "finpayableinvoice" IS 'contem as informacoes adicionais a tabela fininvoice sobre titulos a pagar ou ja pagos';
COMMENT ON COLUMN "finpayableinvoice"."receivedate" IS 'Data em que o titulo foi recebido pela instituicao para que a mesma efetuasse seu pagamento.';

ALTER TABLE "finpayableinvoice" ALTER COLUMN "invoiceid" SET NOT NULL;
ALTER TABLE "finpayableinvoice" ADD PRIMARY KEY ("invoiceid");

----------------------------------------------------------------------
-- --
--
-- Table: acccourseaccount
-- Purpose: define a conta contabil e o centro de custo para um curso  
--          e sua versao em um campus 
--
-- --
----------------------------------------------------------------------

CREATE TABLE "acccourseaccount" 
(
    "courseid"           varchar(10), --Codigo identificador do curso
    "courseversion"      integer, --Versao do curso
    "unitid"             integer, --Codigo identificador do campus
    "accountschemeid"    varchar(30), --Codigo identificador da conta contabil
    "costcenterid"       varchar(30) --Codigo identificador do centro de custo
) INHERITS ("baslog");

COMMENT ON TABLE "acccourseaccount" IS 'define a conta contabil e o centro de custo para um curso  e sua versao em um campus';
COMMENT ON COLUMN "acccourseaccount"."courseid" IS 'Codigo identificador do curso';
COMMENT ON COLUMN "acccourseaccount"."courseversion" IS 'Versao do curso';
COMMENT ON COLUMN "acccourseaccount"."unitid" IS 'Codigo identificador do campus';
COMMENT ON COLUMN "acccourseaccount"."accountschemeid" IS 'Codigo identificador da conta contabil';
COMMENT ON COLUMN "acccourseaccount"."costcenterid" IS 'Codigo identificador do centro de custo';

ALTER TABLE "acccourseaccount" ALTER COLUMN "courseid" SET NOT NULL;
ALTER TABLE "acccourseaccount" ALTER COLUMN "courseversion" SET NOT NULL;
ALTER TABLE "acccourseaccount" ALTER COLUMN "unitid" SET NOT NULL;
ALTER TABLE "acccourseaccount" ALTER COLUMN "accountschemeid" SET NOT NULL;
ALTER TABLE "acccourseaccount" ALTER COLUMN "costcenterid" SET NOT NULL;

ALTER TABLE "acccourseaccount" ALTER COLUMN "courseid" SET NOT NULL;
ALTER TABLE "acccourseaccount" ALTER COLUMN "courseversion" SET NOT NULL;
ALTER TABLE "acccourseaccount" ALTER COLUMN "unitid" SET NOT NULL;
ALTER TABLE "acccourseaccount" ADD PRIMARY KEY ("courseid","courseversion","unitid");

ALTER TABLE "acccourseaccount" ADD FOREIGN KEY ("courseversion","courseid") REFERENCES "acdcourseversion"("courseversion","courseid");

ALTER TABLE "acccourseaccount" ADD FOREIGN KEY ("accountschemeid") REFERENCES "accaccountscheme"("accountschemeid");

ALTER TABLE "acccourseaccount" ADD FOREIGN KEY ("costcenterid") REFERENCES "acccostcenter"("costcenterid");

ALTER TABLE "acccourseaccount" ADD FOREIGN KEY ("unitid") REFERENCES "basunit"("unitid");

----------------------------------------------------------------------
-- --
--
-- Table: finentry
-- Purpose: contem os lancamentos dos titulos, tanto dos a receber 
--          quanto dos a pagar. 
--
-- --
----------------------------------------------------------------------

CREATE TABLE "finentry" 
(
    "entryid"           integer, --Codigo identificador do lancamento
    "invoiceid"         integer, --Codigo identificador do titulo ao qual o lancamento pertence
    "operationid"       integer, --Codigo identificador da operacao (finOperation)
    "entrydate"         date, --Data de criacao do lancamento
    "value"             numeric(14,4), --Valor do lancamento. Somados, os valores dos lancamentos de um titulo resultam no valor liquido do titulo.
    "costcenterid"      varchar(30), --Codigo identificador do centro de custo ao qual o lancamento pertence. Este campo e necessario para casos onde a mensalidade e originada de um centro de custo e o desconto referente a sua bolsa de estudos vem de outro centro de custo.
    "comments"          text, --Informacao complementar que se deseja adicionar ao lancamento.
    "bankreturncode"    varchar(50), --Codigo fornecido pelo banco, geralmente identificando o lote pelo qual o lancamento veio.
    "isaccounted"       boolean, --TRUE (FALSE) indica que o lancamento (nao) foi contabilizado.
    "creationtype"      char(1) --Tipo de criacao: A - Automatica, M - Manual, P, S e V
) INHERITS ("baslog");

COMMENT ON TABLE "finentry" IS 'contem os lancamentos dos titulos, tanto dos a receber quanto dos a pagar.';
COMMENT ON COLUMN "finentry"."entryid" IS 'Codigo identificador do lancamento';
COMMENT ON COLUMN "finentry"."invoiceid" IS 'Codigo identificador do titulo ao qual o lancamento pertence';
COMMENT ON COLUMN "finentry"."operationid" IS 'Codigo identificador da operacao (finOperation)';
COMMENT ON COLUMN "finentry"."entrydate" IS 'Data de criacao do lancamento';
COMMENT ON COLUMN "finentry"."value" IS 'Valor do lancamento. Somados, os valores dos lancamentos de um titulo resultam no valor liquido do titulo.';
COMMENT ON COLUMN "finentry"."costcenterid" IS 'Codigo identificador do centro de custo ao qual o lancamento pertence. Este campo e necessario para casos onde a mensalidade e originada de um centro de custo e o desconto referente a sua bolsa de estudos vem de outro centro de custo.';
COMMENT ON COLUMN "finentry"."comments" IS 'Informacao complementar que se deseja adicionar ao lancamento.';
COMMENT ON COLUMN "finentry"."bankreturncode" IS 'Codigo fornecido pelo banco, geralmente identificando o lote pelo qual o lancamento veio.';
COMMENT ON COLUMN "finentry"."isaccounted" IS 'TRUE (FALSE) indica que o lancamento (nao) foi contabilizado.';
COMMENT ON COLUMN "finentry"."creationtype" IS 'Tipo de criacao: A - Automatica, M - Manual, P, S e V';

CREATE SEQUENCE "seq_entryid";
ALTER TABLE "finentry" ALTER COLUMN "entryid" SET DEFAULT NEXTVAL('"seq_entryid"');
ALTER TABLE "finentry" ALTER COLUMN "invoiceid" SET NOT NULL;
ALTER TABLE "finentry" ALTER COLUMN "operationid" SET NOT NULL;
ALTER TABLE "finentry" ALTER COLUMN "entrydate" SET NOT NULL;
ALTER TABLE "finentry" ALTER COLUMN "value" SET NOT NULL;
ALTER TABLE "finentry" ALTER COLUMN "costcenterid" SET NOT NULL;
ALTER TABLE "finentry" ALTER COLUMN "isaccounted" SET NOT NULL;
ALTER TABLE "finentry" ALTER COLUMN "isaccounted" SET DEFAULT FALSE ;
ALTER TABLE "finentry" ALTER COLUMN "creationtype" SET DEFAULT 'A';

ALTER TABLE "finentry" ALTER COLUMN "entryid" SET NOT NULL;
ALTER TABLE "finentry" ADD PRIMARY KEY ("entryid");

CREATE INDEX "idx_finentry_invoiceid" ON "finentry" ("invoiceid");
CREATE INDEX "idx_finentry_entrydate" ON "finentry" ("entrydate");
CREATE INDEX "idx_finentry_operationid" ON "finentry" ("operationid");

ALTER TABLE "finentry" ADD FOREIGN KEY ("operationid") REFERENCES "finoperation"("operationid");

ALTER TABLE "finentry" ADD FOREIGN KEY ("costcenterid") REFERENCES "acccostcenter"("costcenterid");

ALTER TABLE "finentry" ADD FOREIGN KEY ("invoiceid") REFERENCES "fininvoice"("invoiceid");

----------------------------------------------------------------------
-- --
--
-- Table: finprice
-- Purpose: valor do curso para um determinado periodo
--
-- --
----------------------------------------------------------------------

CREATE TABLE "finprice" 
(
    "learningperiodid"    integer, --Codigo identicador do periodo letivo (acdLearningPeriod)
    "startdate"           date, --Data de inicio
    "enddate"             date, --Data final
    "value"               numeric(14,4) --Preco do curso
) INHERITS ("baslog");

COMMENT ON TABLE "finprice" IS 'valor do curso para um determinado periodo';
COMMENT ON COLUMN "finprice"."learningperiodid" IS 'Codigo identicador do periodo letivo (acdLearningPeriod)';
COMMENT ON COLUMN "finprice"."startdate" IS 'Data de inicio';
COMMENT ON COLUMN "finprice"."enddate" IS 'Data final';
COMMENT ON COLUMN "finprice"."value" IS 'Preco do curso';

ALTER TABLE "finprice" ALTER COLUMN "learningperiodid" SET NOT NULL;
ALTER TABLE "finprice" ALTER COLUMN "startdate" SET NOT NULL;
ALTER TABLE "finprice" ALTER COLUMN "enddate" SET NOT NULL;
ALTER TABLE "finprice" ALTER COLUMN "value" SET NOT NULL;

ALTER TABLE "finprice" ALTER COLUMN "learningperiodid" SET NOT NULL;
ALTER TABLE "finprice" ALTER COLUMN "startdate" SET NOT NULL;
ALTER TABLE "finprice" ALTER COLUMN "enddate" SET NOT NULL;
ALTER TABLE "finprice" ADD PRIMARY KEY ("learningperiodid","startdate","enddate");

ALTER TABLE "finprice" ADD FOREIGN KEY ("learningperiodid") REFERENCES "acdlearningperiod"("learningperiodid");

----------------------------------------------------------------------
-- --
--
-- Table: finenrollfee
-- Purpose: taxas que podem ser cobradas no ato da matricula (taxa de 
--          dce, por exemplo). 
--
-- --
----------------------------------------------------------------------

CREATE TABLE "finenrollfee" 
(
    "learningperiodid"    integer, --Codigo identificador do periodo letivo.
    "operationid"         integer, --Codigo identificador da operacao (finOperation)
    "isfreshman"          boolean, --Se o aluno e calouro ou nao
    "valueispercent"      boolean not null, --Indica se o campo Value corresponde a um valor fixo (FALSE) ou a um percentual (TRUE).
    "value"               numeric(14,4), --Se for um valor fixo (ValueIsPercent = FALSE), corresponde ao valor da taxa. Caso contrario, e um percentual.
    "parcelsnumber"       integer --Numero de parcelas onde a taxa sera cobrada.
) INHERITS ("baslog");

COMMENT ON TABLE "finenrollfee" IS 'taxas que podem ser cobradas no ato da matricula (taxa de dce, por exemplo).';
COMMENT ON COLUMN "finenrollfee"."learningperiodid" IS 'Codigo identificador do periodo letivo.';
COMMENT ON COLUMN "finenrollfee"."operationid" IS 'Codigo identificador da operacao (finOperation)';
COMMENT ON COLUMN "finenrollfee"."isfreshman" IS 'Se o aluno e calouro ou nao';
COMMENT ON COLUMN "finenrollfee"."valueispercent" IS 'Indica se o campo Value corresponde a um valor fixo (FALSE) ou a um percentual (TRUE).';
COMMENT ON COLUMN "finenrollfee"."value" IS 'Se for um valor fixo (ValueIsPercent = FALSE), corresponde ao valor da taxa. Caso contrario, e um percentual.';
COMMENT ON COLUMN "finenrollfee"."parcelsnumber" IS 'Numero de parcelas onde a taxa sera cobrada.';

ALTER TABLE "finenrollfee" ALTER COLUMN "learningperiodid" SET NOT NULL;
ALTER TABLE "finenrollfee" ALTER COLUMN "operationid" SET NOT NULL;
ALTER TABLE "finenrollfee" ALTER COLUMN "isfreshman" SET NOT NULL;
ALTER TABLE "finenrollfee" ALTER COLUMN "isfreshman" SET DEFAULT FALSE ;
ALTER TABLE "finenrollfee" ALTER COLUMN "value" SET NOT NULL;
ALTER TABLE "finenrollfee" ALTER COLUMN "parcelsnumber" SET NOT NULL;

ALTER TABLE "finenrollfee" ALTER COLUMN "learningperiodid" SET NOT NULL;
ALTER TABLE "finenrollfee" ALTER COLUMN "operationid" SET NOT NULL;
ALTER TABLE "finenrollfee" ALTER COLUMN "isfreshman" SET NOT NULL;
ALTER TABLE "finenrollfee" ADD PRIMARY KEY ("learningperiodid","operationid","isfreshman");

ALTER TABLE "finenrollfee" ADD FOREIGN KEY ("learningperiodid") REFERENCES "acdlearningperiod"("learningperiodid");

ALTER TABLE "finenrollfee" ADD FOREIGN KEY ("operationid") REFERENCES "finoperation"("operationid");

----------------------------------------------------------------------
-- --
--
-- Table: acdenrollsummary
-- Purpose: contem um resumo da matricula do contrato por periodo. 
--          esta tabela e varrida para gerar as previsoes da pessoa 
--          quando ja houver preco definido para o periodo. vide campo 
--          multiplicador. 
--
-- --
----------------------------------------------------------------------

CREATE TABLE "acdenrollsummary" 
(
    "enrollsummaryid"     integer, --Codigo do resumo de matricula
    "contractid"          integer, --Codigo do contrato
    "learningperiodid"    integer, --Codigo do periodo letivo
    "recorddate"          date, --Data da criacao do registro.
    "operationid"         integer, --Codigo identificador da operacao. Obtido da tabela de operacoes (finOperation).
    "multiplier"          numeric(14,8), --Quantidade pela qual o preco deverá ser multiplicado para gerar a previsão.
    "isvalue"             boolean not null, --TRUE se o campo multiplier é um valor moeda. FALSE se o campo multiplier e um multiplicador. Utilizado para incentivos que nao sao em percentual (sao em valor).
    "parcelsnumber"       integer, --Quantidade de parcelas na qual o valor sera dividido.
    "isprocessed"         boolean not null --TRUE se o registro foi passado para a tabela de previsoes (finIncomeForecast); FALSE caso contrario.
) INHERITS ("baslog");

COMMENT ON TABLE "acdenrollsummary" IS 'contem um resumo da matricula do contrato por periodo. esta tabela e varrida para gerar as previsoes da pessoa quando ja houver preco definido para o periodo. vide campo multiplicador.';
COMMENT ON COLUMN "acdenrollsummary"."enrollsummaryid" IS 'Codigo do resumo de matricula';
COMMENT ON COLUMN "acdenrollsummary"."contractid" IS 'Codigo do contrato';
COMMENT ON COLUMN "acdenrollsummary"."learningperiodid" IS 'Codigo do periodo letivo';
COMMENT ON COLUMN "acdenrollsummary"."recorddate" IS 'Data da criacao do registro.';
COMMENT ON COLUMN "acdenrollsummary"."operationid" IS 'Codigo identificador da operacao. Obtido da tabela de operacoes (finOperation).';
COMMENT ON COLUMN "acdenrollsummary"."multiplier" IS 'Quantidade pela qual o preco deverá ser multiplicado para gerar a previsão.';
COMMENT ON COLUMN "acdenrollsummary"."isvalue" IS 'TRUE se o campo multiplier é um valor moeda. FALSE se o campo multiplier e um multiplicador. Utilizado para incentivos que nao sao em percentual (sao em valor).';
COMMENT ON COLUMN "acdenrollsummary"."parcelsnumber" IS 'Quantidade de parcelas na qual o valor sera dividido.';
COMMENT ON COLUMN "acdenrollsummary"."isprocessed" IS 'TRUE se o registro foi passado para a tabela de previsoes (finIncomeForecast); FALSE caso contrario.';

CREATE SEQUENCE "seq_enrollsummaryid";
ALTER TABLE "acdenrollsummary" ALTER COLUMN "enrollsummaryid" SET DEFAULT NEXTVAL('"seq_enrollsummaryid"');
ALTER TABLE "acdenrollsummary" ALTER COLUMN "contractid" SET NOT NULL;
ALTER TABLE "acdenrollsummary" ALTER COLUMN "learningperiodid" SET NOT NULL;
ALTER TABLE "acdenrollsummary" ALTER COLUMN "recorddate" SET NOT NULL;
ALTER TABLE "acdenrollsummary" ALTER COLUMN "operationid" SET NOT NULL;
ALTER TABLE "acdenrollsummary" ALTER COLUMN "multiplier" SET NOT NULL;
ALTER TABLE "acdenrollsummary" ALTER COLUMN "isvalue" SET NOT NULL;
ALTER TABLE "acdenrollsummary" ALTER COLUMN "isvalue" SET DEFAULT FALSE ;
ALTER TABLE "acdenrollsummary" ALTER COLUMN "parcelsnumber" SET NOT NULL;
ALTER TABLE "acdenrollsummary" ALTER COLUMN "isprocessed" SET NOT NULL;
ALTER TABLE "acdenrollsummary" ALTER COLUMN "isprocessed" SET DEFAULT FALSE ;

ALTER TABLE "acdenrollsummary" ALTER COLUMN "enrollsummaryid" SET NOT NULL;
ALTER TABLE "acdenrollsummary" ADD PRIMARY KEY ("enrollsummaryid");

ALTER TABLE "acdenrollsummary" ADD FOREIGN KEY ("contractid") REFERENCES "acdcontract"("contractid");

ALTER TABLE "acdenrollsummary" ADD FOREIGN KEY ("learningperiodid") REFERENCES "acdlearningperiod"("learningperiodid");

ALTER TABLE "acdenrollsummary" ADD FOREIGN KEY ("operationid") REFERENCES "finoperation"("operationid");

----------------------------------------------------------------------
-- --
--
-- Table: finincentive
-- Purpose: incentivos de estudo dados a alunos, como bolsas, 
--          financiamentos, patrocinios, etc.  
--
-- --
----------------------------------------------------------------------

CREATE TABLE "finincentive" 
(
    "incentiveid"         integer, --Codigo identificador do incentivo
    "contractid"          integer, --Codigo identificador do contrato (pessoa) ao qual o incentivo sera concedido
    "startdate"           date, --Data a partir da qual o incentivo passa a valer
    "enddate"             date, --Data de expiracao do incentivo
    "incentivetypeid"     integer, --Codigo identificador do tipo de incentivo (finIncentiveType)
    "valueispercent"      boolean, --TRUE (FALSE) se o campo Value representa um percentual (valor).
    "value"               numeric(14,4), --Representa o valor (ValueIsPercent = FALSE) ou o percentual (ValueIsPercent = TRUE) do desconto sobre os titulos de mensalidade emitidos.
    "supporterid"         integer, --Codigo identificador da pessoa que sera o patrocinador do incentivo. So e preenchido se for um patrocinio.
    "agglutinate"         boolean, --TRUE se o financiador recebera apenas um titulo com o valor total dos incentivos que financia ou FALSE se devera ser emitido um titulo para cada incentivo financiado.
    "costcenterid"        varchar(30), --Codigo identificador do centro de custo ao qual o incentivo pertence.
    "cancellationdate"    date --Indica quando o incentivo foi cancelado (caso finalizado antes do previsto)
) INHERITS ("baslog");

COMMENT ON TABLE "finincentive" IS 'incentivos de estudo dados a alunos, como bolsas, financiamentos, patrocinios, etc. ';
COMMENT ON COLUMN "finincentive"."incentiveid" IS 'Codigo identificador do incentivo';
COMMENT ON COLUMN "finincentive"."contractid" IS 'Codigo identificador do contrato (pessoa) ao qual o incentivo sera concedido';
COMMENT ON COLUMN "finincentive"."startdate" IS 'Data a partir da qual o incentivo passa a valer';
COMMENT ON COLUMN "finincentive"."enddate" IS 'Data de expiracao do incentivo';
COMMENT ON COLUMN "finincentive"."incentivetypeid" IS 'Codigo identificador do tipo de incentivo (finIncentiveType)';
COMMENT ON COLUMN "finincentive"."valueispercent" IS 'TRUE (FALSE) se o campo Value representa um percentual (valor).';
COMMENT ON COLUMN "finincentive"."value" IS 'Representa o valor (ValueIsPercent = FALSE) ou o percentual (ValueIsPercent = TRUE) do desconto sobre os titulos de mensalidade emitidos.';
COMMENT ON COLUMN "finincentive"."supporterid" IS 'Codigo identificador da pessoa que sera o patrocinador do incentivo. So e preenchido se for um patrocinio.';
COMMENT ON COLUMN "finincentive"."agglutinate" IS 'TRUE se o financiador recebera apenas um titulo com o valor total dos incentivos que financia ou FALSE se devera ser emitido um titulo para cada incentivo financiado.';
COMMENT ON COLUMN "finincentive"."costcenterid" IS 'Codigo identificador do centro de custo ao qual o incentivo pertence.';
COMMENT ON COLUMN "finincentive"."cancellationdate" IS 'Indica quando o incentivo foi cancelado (caso finalizado antes do previsto)';

CREATE SEQUENCE "seq_incentiveid";
ALTER TABLE "finincentive" ALTER COLUMN "incentiveid" SET DEFAULT NEXTVAL('"seq_incentiveid"');
ALTER TABLE "finincentive" ALTER COLUMN "contractid" SET NOT NULL;
ALTER TABLE "finincentive" ALTER COLUMN "startdate" SET NOT NULL;
ALTER TABLE "finincentive" ALTER COLUMN "enddate" SET NOT NULL;
ALTER TABLE "finincentive" ALTER COLUMN "incentivetypeid" SET NOT NULL;
ALTER TABLE "finincentive" ALTER COLUMN "valueispercent" SET NOT NULL;
ALTER TABLE "finincentive" ALTER COLUMN "valueispercent" SET DEFAULT FALSE ;
ALTER TABLE "finincentive" ALTER COLUMN "agglutinate" SET NOT NULL;
ALTER TABLE "finincentive" ALTER COLUMN "agglutinate" SET DEFAULT FALSE ;

ALTER TABLE "finincentive" ALTER COLUMN "incentiveid" SET NOT NULL;
ALTER TABLE "finincentive" ADD PRIMARY KEY ("incentiveid");

CREATE INDEX "idx_finincentive_contractid" ON "finincentive" ("contractid");
CREATE INDEX "idx_finincentive_startdate" ON "finincentive" ("startdate");
CREATE INDEX "idx_finincentive_enddate" ON "finincentive" ("enddate");
CREATE INDEX "idx_finincentive_cancellationdate" ON "finincentive" ("cancellationdate");

ALTER TABLE "finincentive" ADD FOREIGN KEY ("contractid") REFERENCES "acdcontract"("contractid");

ALTER TABLE "finincentive" ADD FOREIGN KEY ("incentivetypeid") REFERENCES "finincentivetype"("incentivetypeid");

ALTER TABLE "finincentive" ADD FOREIGN KEY ("costcenterid") REFERENCES "acccostcenter"("costcenterid");

ALTER TABLE "finincentive" ADD FOREIGN KEY ("supporterid") REFERENCES "basperson"("personid");

ALTER TABLE "finincentive" ADD FOREIGN KEY ("incentivetypeid") REFERENCES "finincentivetype"("incentivetypeid");

----------------------------------------------------------------------
-- --
--
-- Table: finincomeforecast
-- Purpose: contem as previsoes de lancamento necessarias para geracao 
--          automatica dos titulos de matriculas e processos cujo 
--          pagamento ocorre em mais de uma parcela. 
--
-- --
----------------------------------------------------------------------

CREATE TABLE "finincomeforecast" 
(
    "incomeforecastid"    integer, --Codigo identificador da previsao de lancamento.
    "contractid"          integer, --Codigo identificador do contrato (pessoa) ao qual a previsao pertence.
    "operationid"         integer, --Codigo identificador da operacao (finOperation)
    "accountschemeid"     varchar(30) , --Codigo identificador da conta contabil a qual a previsao pertence
    "costcenterid"        varchar(30) , --Codigo identificador do centro de custo ao qual a previsao pertence
    "value"               numeric(14,4), --Valor da previsao de lancamento
    "comments"            text, --Informacao complementar da previsao de lancamento
    "recorddate"          date, --Data da criacao da previsao
    "maturitydate"        date, --Data em que a previsao devera se tornar titulo
    "isaccounted"         boolean, --TRUE (FALSE) indica que a previsao (nao) foi contabilizada.
    "isprocessed"         boolean, --TRUE (FALSE) indica que a previsao (nao) foi transformada em titulo.
    "isgenerated"         boolean, --TRUE gerado pelo sistema, FALSE gerado manual
    "incentiveid"         integer, --Campo indicando de qual incentivo foi gerado esta previsao
    "issupressed"         boolean, --Marca se a previsao e suprimida (Tem que ser contabilizada mas nao e gerado lancamento desta)
    "enrollsummaryid"     int --Caso a previsão foi gerada a partir de um resumo de matrícula, este é indicado aqui.
) INHERITS ("baslog");

COMMENT ON TABLE "finincomeforecast" IS 'contem as previsoes de lancamento necessarias para geracao automatica dos titulos de matriculas e processos cujo pagamento ocorre em mais de uma parcela.';
COMMENT ON COLUMN "finincomeforecast"."incomeforecastid" IS 'Codigo identificador da previsao de lancamento.';
COMMENT ON COLUMN "finincomeforecast"."contractid" IS 'Codigo identificador do contrato (pessoa) ao qual a previsao pertence.';
COMMENT ON COLUMN "finincomeforecast"."operationid" IS 'Codigo identificador da operacao (finOperation)';
COMMENT ON COLUMN "finincomeforecast"."accountschemeid" IS 'Codigo identificador da conta contabil a qual a previsao pertence';
COMMENT ON COLUMN "finincomeforecast"."costcenterid" IS 'Codigo identificador do centro de custo ao qual a previsao pertence';
COMMENT ON COLUMN "finincomeforecast"."value" IS 'Valor da previsao de lancamento';
COMMENT ON COLUMN "finincomeforecast"."comments" IS 'Informacao complementar da previsao de lancamento';
COMMENT ON COLUMN "finincomeforecast"."recorddate" IS 'Data da criacao da previsao';
COMMENT ON COLUMN "finincomeforecast"."maturitydate" IS 'Data em que a previsao devera se tornar titulo';
COMMENT ON COLUMN "finincomeforecast"."isaccounted" IS 'TRUE (FALSE) indica que a previsao (nao) foi contabilizada.';
COMMENT ON COLUMN "finincomeforecast"."isprocessed" IS 'TRUE (FALSE) indica que a previsao (nao) foi transformada em titulo.';
COMMENT ON COLUMN "finincomeforecast"."isgenerated" IS 'TRUE gerado pelo sistema, FALSE gerado manual';
COMMENT ON COLUMN "finincomeforecast"."incentiveid" IS 'Campo indicando de qual incentivo foi gerado esta previsao';
COMMENT ON COLUMN "finincomeforecast"."issupressed" IS 'Marca se a previsao e suprimida (Tem que ser contabilizada mas nao e gerado lancamento desta)';
COMMENT ON COLUMN "finincomeforecast"."enrollsummaryid" IS 'Caso a previsão foi gerada a partir de um resumo de matrícula, este é indicado aqui.';

CREATE SEQUENCE "seq_incomeforecastid";
ALTER TABLE "finincomeforecast" ALTER COLUMN "incomeforecastid" SET DEFAULT NEXTVAL('"seq_incomeforecastid"');
ALTER TABLE "finincomeforecast" ALTER COLUMN "contractid" SET NOT NULL;
ALTER TABLE "finincomeforecast" ALTER COLUMN "operationid" SET NOT NULL;
ALTER TABLE "finincomeforecast" ALTER COLUMN "accountschemeid" SET NOT NULL;
ALTER TABLE "finincomeforecast" ALTER COLUMN "costcenterid" SET NOT NULL;
ALTER TABLE "finincomeforecast" ALTER COLUMN "value" SET NOT NULL;
ALTER TABLE "finincomeforecast" ALTER COLUMN "recorddate" SET DEFAULT date(now());
ALTER TABLE "finincomeforecast" ALTER COLUMN "isaccounted" SET NOT NULL;
ALTER TABLE "finincomeforecast" ALTER COLUMN "isaccounted" SET DEFAULT FALSE ;
ALTER TABLE "finincomeforecast" ALTER COLUMN "isprocessed" SET NOT NULL;
ALTER TABLE "finincomeforecast" ALTER COLUMN "isprocessed" SET DEFAULT FALSE ;
ALTER TABLE "finincomeforecast" ALTER COLUMN "isgenerated" SET NOT NULL;
ALTER TABLE "finincomeforecast" ALTER COLUMN "isgenerated" SET DEFAULT FALSE ;
ALTER TABLE "finincomeforecast" ALTER COLUMN "issupressed" SET NOT NULL;
ALTER TABLE "finincomeforecast" ALTER COLUMN "issupressed" SET DEFAULT FALSE ;

ALTER TABLE "finincomeforecast" ALTER COLUMN "incomeforecastid" SET NOT NULL;
ALTER TABLE "finincomeforecast" ADD PRIMARY KEY ("incomeforecastid");

CREATE INDEX "idx_finincomeforecast_contractid" ON "finincomeforecast" ("contractid");
CREATE INDEX "idx_finincomeforecast_maturitydate" ON "finincomeforecast" ("maturitydate");
CREATE INDEX "idx_finincomeforecast_recorddate" ON "finincomeforecast" ("recorddate");

ALTER TABLE "finincomeforecast" ADD FOREIGN KEY ("contractid") REFERENCES "acdcontract"("contractid");

ALTER TABLE "finincomeforecast" ADD FOREIGN KEY ("operationid") REFERENCES "finoperation"("operationid");

ALTER TABLE "finincomeforecast" ADD FOREIGN KEY ("accountschemeid") REFERENCES "accaccountscheme"("accountschemeid");

ALTER TABLE "finincomeforecast" ADD FOREIGN KEY ("costcenterid") REFERENCES "acccostcenter"("costcenterid");

ALTER TABLE "finincomeforecast" ADD FOREIGN KEY ("incentiveid") REFERENCES "finincentive"("incentiveid");

ALTER TABLE "finincomeforecast" ADD FOREIGN KEY ("enrollsummaryid") REFERENCES "acdenrollsummary"("enrollsummaryid");

----------------------------------------------------------------------
-- --
--
-- Table: finphysicaltarget
-- Purpose: endereco de cobranca. herda a fininvoicetarget
--
-- --
----------------------------------------------------------------------

CREATE TABLE "finphysicaltarget" 
(
    "cityid"            integer, --Codigo identificador da cidade para cobranca
    "zipcode"           varchar(9), --CEP do endereco de cobranca
    "location"          varchar(100), --Logradouro
    "complement"        varchar(40), --Complemento
    "number"            varchar(10), --Numero
    "neighborhood"      text , --Bairro
    "name"              varchar(100), --Nome da pessoa que deve aparecer no boleto
    "documentnumber"    varchar(11) --Cpf do nome
) INHERITS ("fininvoicetarget");

COMMENT ON TABLE "finphysicaltarget" IS 'endereco de cobranca. herda a fininvoicetarget';
COMMENT ON COLUMN "finphysicaltarget"."cityid" IS 'Codigo identificador da cidade para cobranca';
COMMENT ON COLUMN "finphysicaltarget"."zipcode" IS 'CEP do endereco de cobranca';
COMMENT ON COLUMN "finphysicaltarget"."location" IS 'Logradouro';
COMMENT ON COLUMN "finphysicaltarget"."complement" IS 'Complemento';
COMMENT ON COLUMN "finphysicaltarget"."number" IS 'Numero';
COMMENT ON COLUMN "finphysicaltarget"."neighborhood" IS 'Bairro';
COMMENT ON COLUMN "finphysicaltarget"."name" IS 'Nome da pessoa que deve aparecer no boleto';
COMMENT ON COLUMN "finphysicaltarget"."documentnumber" IS 'Cpf do nome';

ALTER TABLE "finphysicaltarget" ALTER COLUMN "cityid" SET NOT NULL;
ALTER TABLE "finphysicaltarget" ALTER COLUMN "zipcode" SET NOT NULL;
ALTER TABLE "finphysicaltarget" ALTER COLUMN "location" SET NOT NULL;
ALTER TABLE "finphysicaltarget" ALTER COLUMN "name" SET NOT NULL;

ALTER TABLE "finphysicaltarget" ALTER COLUMN "contractid" SET NOT NULL;
ALTER TABLE "finphysicaltarget" ADD PRIMARY KEY ("contractid");

ALTER TABLE "finphysicaltarget" ADD FOREIGN KEY ("cityid") REFERENCES "bascity"("cityid");

----------------------------------------------------------------------
-- --
--
-- Table: acdschedulelearningperiod
-- Purpose: horarios dos periodos letivos
--
-- --
----------------------------------------------------------------------

CREATE TABLE "acdschedulelearningperiod" 
(
    "schedulelearningperiodid"         integer, --Codigo do horario do periodo letivo
    "learningperiodid"                 integer, --Codigo do periodo letivo
    "description"                      text, --Descricao
    "turnid"                           integer, --Codigo do turno
    "begindate"                        date, --Data inicial de aula - vai para os relatórios
    "beginhour"                        time, --Hora de inicio das aulas
    "enddate"                          date, --Data de termino das aulas
    "endhour"                          time, --Hora de termino das aulas
    "minimumnumberlessons"             integer, --Numero minimo de aulas
    "numberhourslessons"               float, --Carga horaria minima das aulas
    "sagu1schedulelearningperiodid"    integer --Codigo do horario existente no SAGU1
) INHERITS ("baslog");

COMMENT ON TABLE "acdschedulelearningperiod" IS 'horarios dos periodos letivos';
COMMENT ON COLUMN "acdschedulelearningperiod"."schedulelearningperiodid" IS 'Codigo do horario do periodo letivo';
COMMENT ON COLUMN "acdschedulelearningperiod"."learningperiodid" IS 'Codigo do periodo letivo';
COMMENT ON COLUMN "acdschedulelearningperiod"."description" IS 'Descricao';
COMMENT ON COLUMN "acdschedulelearningperiod"."turnid" IS 'Codigo do turno';
COMMENT ON COLUMN "acdschedulelearningperiod"."begindate" IS 'Data inicial de aula - vai para os relatórios';
COMMENT ON COLUMN "acdschedulelearningperiod"."beginhour" IS 'Hora de inicio das aulas';
COMMENT ON COLUMN "acdschedulelearningperiod"."enddate" IS 'Data de termino das aulas';
COMMENT ON COLUMN "acdschedulelearningperiod"."endhour" IS 'Hora de termino das aulas';
COMMENT ON COLUMN "acdschedulelearningperiod"."minimumnumberlessons" IS 'Numero minimo de aulas';
COMMENT ON COLUMN "acdschedulelearningperiod"."numberhourslessons" IS 'Carga horaria minima das aulas';
COMMENT ON COLUMN "acdschedulelearningperiod"."sagu1schedulelearningperiodid" IS 'Codigo do horario existente no SAGU1';

CREATE SEQUENCE "seq_schedulelearningperiodid";
ALTER TABLE "acdschedulelearningperiod" ALTER COLUMN "schedulelearningperiodid" SET DEFAULT NEXTVAL('"seq_schedulelearningperiodid"');
ALTER TABLE "acdschedulelearningperiod" ALTER COLUMN "learningperiodid" SET NOT NULL;
ALTER TABLE "acdschedulelearningperiod" ALTER COLUMN "description" SET NOT NULL;
ALTER TABLE "acdschedulelearningperiod" ALTER COLUMN "turnid" SET NOT NULL;

ALTER TABLE "acdschedulelearningperiod" ALTER COLUMN "schedulelearningperiodid" SET NOT NULL;
ALTER TABLE "acdschedulelearningperiod" ADD PRIMARY KEY ("schedulelearningperiodid");

CREATE UNIQUE INDEX "idx_acdschedulelearningperiod_unique" ON "acdschedulelearningperiod" ("learningperiodid","begindate","enddate","beginhour","endhour");

ALTER TABLE "acdschedulelearningperiod" ADD FOREIGN KEY ("turnid") REFERENCES "basturn"("turnid");

ALTER TABLE "acdschedulelearningperiod" ADD FOREIGN KEY ("learningperiodid") REFERENCES "acdlearningperiod"("learningperiodid");

----------------------------------------------------------------------
-- --
--
-- Table: acdcurricularcomponentunblock
-- Purpose: desbloqueios de disciplinas
--
-- --
----------------------------------------------------------------------

CREATE TABLE "acdcurricularcomponentunblock" 
(
    "curricularcomponentunblockid"    integer, --Codigo do desbloqueio
    "learningperiodid"                integer, --Codigo do periodo letivo em que o desbloqueio ocorre
    "contractid"                      integer, --Codigo do contrato ao qual o desbloqueio se aplica
    "curriculumid"                    integer, --Codigo da disciplina do curriculo do aluno
    "curricularcomponentid"           varchar(10), --Codigo da disciplina a ser cursada no lugar da disciplina do currículo
    "curricularcomponentversion"      integer, --Versao da disciplina a ser cursada no lugar da disciplina do curriculo
    "isconditionbreak"                boolean, --Não checa requisitos da disciplina do currículo
    "issubstituted"                   boolean, --Permite que seja cursada uma outra disciplina (curricularComponentId) no lugar da disciplina do currículo (curriculumId)
    "isscheduleshock"                 boolean, --Permite que a disciplina do curriculo (curriculumId) seja cursada em paralelo (mesmo horario) que outra
    "isoutofcurriculum"               boolean, --Permite cursar uma disciplina fora do curriculo
    "flminimumcredits"                boolean, --Liberação do limite de créditos - para calouro e veterenos
    "flminimumturn"                   boolean --Liberação para cursar disciplinas em outro turno que nao o do curso
) INHERITS ("baslog");

COMMENT ON TABLE "acdcurricularcomponentunblock" IS 'desbloqueios de disciplinas';
COMMENT ON COLUMN "acdcurricularcomponentunblock"."curricularcomponentunblockid" IS 'Codigo do desbloqueio';
COMMENT ON COLUMN "acdcurricularcomponentunblock"."learningperiodid" IS 'Codigo do periodo letivo em que o desbloqueio ocorre';
COMMENT ON COLUMN "acdcurricularcomponentunblock"."contractid" IS 'Codigo do contrato ao qual o desbloqueio se aplica';
COMMENT ON COLUMN "acdcurricularcomponentunblock"."curriculumid" IS 'Codigo da disciplina do curriculo do aluno';
COMMENT ON COLUMN "acdcurricularcomponentunblock"."curricularcomponentid" IS 'Codigo da disciplina a ser cursada no lugar da disciplina do currículo';
COMMENT ON COLUMN "acdcurricularcomponentunblock"."curricularcomponentversion" IS 'Versao da disciplina a ser cursada no lugar da disciplina do curriculo';
COMMENT ON COLUMN "acdcurricularcomponentunblock"."isconditionbreak" IS 'Não checa requisitos da disciplina do currículo';
COMMENT ON COLUMN "acdcurricularcomponentunblock"."issubstituted" IS 'Permite que seja cursada uma outra disciplina (curricularComponentId) no lugar da disciplina do currículo (curriculumId)';
COMMENT ON COLUMN "acdcurricularcomponentunblock"."isscheduleshock" IS 'Permite que a disciplina do curriculo (curriculumId) seja cursada em paralelo (mesmo horario) que outra';
COMMENT ON COLUMN "acdcurricularcomponentunblock"."isoutofcurriculum" IS 'Permite cursar uma disciplina fora do curriculo';
COMMENT ON COLUMN "acdcurricularcomponentunblock"."flminimumcredits" IS 'Liberação do limite de créditos - para calouro e veterenos';
COMMENT ON COLUMN "acdcurricularcomponentunblock"."flminimumturn" IS 'Liberação para cursar disciplinas em outro turno que nao o do curso';

CREATE SEQUENCE "seq_curricularcomponentunblockid";
ALTER TABLE "acdcurricularcomponentunblock" ALTER COLUMN "curricularcomponentunblockid" SET DEFAULT NEXTVAL('"seq_curricularcomponentunblockid"');
ALTER TABLE "acdcurricularcomponentunblock" ALTER COLUMN "learningperiodid" SET NOT NULL;
ALTER TABLE "acdcurricularcomponentunblock" ALTER COLUMN "contractid" SET NOT NULL;
ALTER TABLE "acdcurricularcomponentunblock" ALTER COLUMN "isconditionbreak" SET NOT NULL;
ALTER TABLE "acdcurricularcomponentunblock" ALTER COLUMN "isconditionbreak" SET DEFAULT FALSE ;
ALTER TABLE "acdcurricularcomponentunblock" ALTER COLUMN "issubstituted" SET NOT NULL;
ALTER TABLE "acdcurricularcomponentunblock" ALTER COLUMN "issubstituted" SET DEFAULT FALSE ;
ALTER TABLE "acdcurricularcomponentunblock" ALTER COLUMN "isscheduleshock" SET NOT NULL;
ALTER TABLE "acdcurricularcomponentunblock" ALTER COLUMN "isscheduleshock" SET DEFAULT FALSE ;
ALTER TABLE "acdcurricularcomponentunblock" ALTER COLUMN "isoutofcurriculum" SET NOT NULL;
ALTER TABLE "acdcurricularcomponentunblock" ALTER COLUMN "isoutofcurriculum" SET DEFAULT FALSE ;
ALTER TABLE "acdcurricularcomponentunblock" ALTER COLUMN "flminimumcredits" SET NOT NULL;
ALTER TABLE "acdcurricularcomponentunblock" ALTER COLUMN "flminimumcredits" SET DEFAULT FALSE ;
ALTER TABLE "acdcurricularcomponentunblock" ALTER COLUMN "flminimumturn" SET NOT NULL;
ALTER TABLE "acdcurricularcomponentunblock" ALTER COLUMN "flminimumturn" SET DEFAULT FALSE ;

ALTER TABLE "acdcurricularcomponentunblock" ALTER COLUMN "curricularcomponentunblockid" SET NOT NULL;
ALTER TABLE "acdcurricularcomponentunblock" ADD PRIMARY KEY ("curricularcomponentunblockid");

CREATE INDEX "idx_acdcurricularcomponentunblock_isconditionbreak" ON "acdcurricularcomponentunblock" ("isconditionbreak");
CREATE INDEX "idx_acdcurricularcomponentunblock_issubstituted" ON "acdcurricularcomponentunblock" ("issubstituted");
CREATE INDEX "idx_acdcurricularcomponentunblock_isscheduleshock" ON "acdcurricularcomponentunblock" ("isscheduleshock");
CREATE INDEX "idx_acdcurricularcomponentunblock_flminimumcredits" ON "acdcurricularcomponentunblock" ("flminimumcredits");
CREATE INDEX "idx_acdcurricularcomponentunblock_flminimumturn" ON "acdcurricularcomponentunblock" ("flminimumturn");
CREATE INDEX "idx_acdcurricularcomponentunblock_1" ON "acdcurricularcomponentunblock" ("curriculumid","curricularcomponentid","curricularcomponentversion");

ALTER TABLE "acdcurricularcomponentunblock" ADD FOREIGN KEY ("curricularcomponentid","curricularcomponentversion") REFERENCES "acdcurricularcomponent"("curricularcomponentid","curricularcomponentversion");

ALTER TABLE "acdcurricularcomponentunblock" ADD FOREIGN KEY ("learningperiodid") REFERENCES "acdlearningperiod"("learningperiodid");

ALTER TABLE "acdcurricularcomponentunblock" ADD FOREIGN KEY ("curriculumid") REFERENCES "acdcurriculum"("curriculumid");

ALTER TABLE "acdcurricularcomponentunblock" ADD FOREIGN KEY ("contractid") REFERENCES "acdcontract"("contractid");

----------------------------------------------------------------------
-- --
--
-- Table: acdgroup
-- Purpose: turma
--
-- --
----------------------------------------------------------------------

CREATE TABLE "acdgroup" 
(
    "groupid"                      integer, --Codigo do grupo
    "learningperiodid"             integer, --Codigo do periodo letivo no qual a turma e oferecida
    "curriculumid"                 integer, --Codigo da disciplina do curriculo
    "complement"                   text, --Complemento da disciplina oferecida. É o foco da disciplina no semestre.
    "vacant"                       integer, --Vagas disponiveis
    "iscancellation"               boolean, --Se foi cancelada
    "objectives"                   text, --Objetivos 
    "content"                      text, --Conteudo a ser trabalhado 
    "methodology"                  text, --Metodologia de ensino
    "evaluation"                   text, --Metodos de avaliacao
    "basicbibliography"            text[], --Bibliografia basica
    "complementarybibliography"    text[], --Bibliografia complementar
    "observation"                  text, --Observacao
    "regimenid"                    integer, --Codigo do regime
    "isusewebdaily"                boolean, --Usa webDiário
    "isclosed"                     boolean, --Está encerrada a turma
    "totalenrolled"                integer, --Total de matriculados
    "iscontentprogrammarian"       boolean, --Possui conteudo programatico
    "bibliographydescription"      text, --Descrição de bibliografias
    "classid"                      varchar(20) --Código da classe para a qual a disciplina está sendo oferecida
) INHERITS ("baslog");

COMMENT ON TABLE "acdgroup" IS 'turma';
COMMENT ON COLUMN "acdgroup"."groupid" IS 'Codigo do grupo';
COMMENT ON COLUMN "acdgroup"."learningperiodid" IS 'Codigo do periodo letivo no qual a turma e oferecida';
COMMENT ON COLUMN "acdgroup"."curriculumid" IS 'Codigo da disciplina do curriculo';
COMMENT ON COLUMN "acdgroup"."complement" IS 'Complemento da disciplina oferecida. É o foco da disciplina no semestre.';
COMMENT ON COLUMN "acdgroup"."vacant" IS 'Vagas disponiveis';
COMMENT ON COLUMN "acdgroup"."iscancellation" IS 'Se foi cancelada';
COMMENT ON COLUMN "acdgroup"."objectives" IS 'Objetivos ';
COMMENT ON COLUMN "acdgroup"."content" IS 'Conteudo a ser trabalhado ';
COMMENT ON COLUMN "acdgroup"."methodology" IS 'Metodologia de ensino';
COMMENT ON COLUMN "acdgroup"."evaluation" IS 'Metodos de avaliacao';
COMMENT ON COLUMN "acdgroup"."basicbibliography" IS 'Bibliografia basica';
COMMENT ON COLUMN "acdgroup"."complementarybibliography" IS 'Bibliografia complementar';
COMMENT ON COLUMN "acdgroup"."observation" IS 'Observacao';
COMMENT ON COLUMN "acdgroup"."regimenid" IS 'Codigo do regime';
COMMENT ON COLUMN "acdgroup"."isusewebdaily" IS 'Usa webDiário';
COMMENT ON COLUMN "acdgroup"."isclosed" IS 'Está encerrada a turma';
COMMENT ON COLUMN "acdgroup"."totalenrolled" IS 'Total de matriculados';
COMMENT ON COLUMN "acdgroup"."iscontentprogrammarian" IS 'Possui conteudo programatico';
COMMENT ON COLUMN "acdgroup"."bibliographydescription" IS 'Descrição de bibliografias';
COMMENT ON COLUMN "acdgroup"."classid" IS 'Código da classe para a qual a disciplina está sendo oferecida';

CREATE SEQUENCE "seq_groupid";
ALTER TABLE "acdgroup" ALTER COLUMN "groupid" SET DEFAULT NEXTVAL('"seq_groupid"');
ALTER TABLE "acdgroup" ALTER COLUMN "learningperiodid" SET NOT NULL;
ALTER TABLE "acdgroup" ALTER COLUMN "curriculumid" SET NOT NULL;
ALTER TABLE "acdgroup" ALTER COLUMN "iscancellation" SET NOT NULL;
ALTER TABLE "acdgroup" ALTER COLUMN "iscancellation" SET DEFAULT FALSE ;
ALTER TABLE "acdgroup" ALTER COLUMN "regimenid" SET NOT NULL;
ALTER TABLE "acdgroup" ALTER COLUMN "isusewebdaily" SET NOT NULL;
ALTER TABLE "acdgroup" ALTER COLUMN "isusewebdaily" SET DEFAULT TRUE ;
ALTER TABLE "acdgroup" ALTER COLUMN "isclosed" SET NOT NULL;
ALTER TABLE "acdgroup" ALTER COLUMN "isclosed" SET DEFAULT FALSE ;
ALTER TABLE "acdgroup" ALTER COLUMN "iscontentprogrammarian" SET NOT NULL;
ALTER TABLE "acdgroup" ALTER COLUMN "iscontentprogrammarian" SET DEFAULT FALSE ;

ALTER TABLE "acdgroup" ALTER COLUMN "groupid" SET NOT NULL;
ALTER TABLE "acdgroup" ADD PRIMARY KEY ("groupid");

CREATE INDEX "idx_acdgroup_learningperiodid" ON "acdgroup" ("learningperiodid");
CREATE INDEX "idx_acdgroup_curriculumid" ON "acdgroup" ("curriculumid");

ALTER TABLE "acdgroup" ADD FOREIGN KEY ("learningperiodid") REFERENCES "acdlearningperiod"("learningperiodid");

ALTER TABLE "acdgroup" ADD FOREIGN KEY ("curriculumid") REFERENCES "acdcurriculum"("curriculumid");

ALTER TABLE "acdgroup" ADD FOREIGN KEY ("regimenid") REFERENCES "acdregimen"("regimenid");

ALTER TABLE "acdgroup" ADD FOREIGN KEY ("classid") REFERENCES "acdclass"("classid");

----------------------------------------------------------------------
-- --
--
-- Table: acccoursebalance
-- Purpose: saldo de um determinado curso e sua versao em uma unidade, 
--          com uma conta contabil em uma determinada data 
--
-- --
----------------------------------------------------------------------

CREATE TABLE "acccoursebalance" 
(
    "coursebalanceid"    integer, --Codigo identificador do saldo do curso
    "accountschemeid"    varchar(30), --Codigo identificador da conta contabil
    "source"             char(1), --Define se a origem e de Previsoes (P) ou Lancamentos (L)
    "balancedate"        date, --Data em que o saldo desse curso foi computado
    "courseid"           varchar(10), --Codigo identificador do curso
    "courseversion"      integer, --Versao do curso
    "unitid"             integer, --Codigo identificador do campus
    "value"              numeric(14,4) --Valor do saldo do curso
) INHERITS ("baslog");

COMMENT ON TABLE "acccoursebalance" IS 'saldo de um determinado curso e sua versao em uma unidade, com uma conta contabil em uma determinada data';
COMMENT ON COLUMN "acccoursebalance"."coursebalanceid" IS 'Codigo identificador do saldo do curso';
COMMENT ON COLUMN "acccoursebalance"."accountschemeid" IS 'Codigo identificador da conta contabil';
COMMENT ON COLUMN "acccoursebalance"."source" IS 'Define se a origem e de Previsoes (P) ou Lancamentos (L)';
COMMENT ON COLUMN "acccoursebalance"."balancedate" IS 'Data em que o saldo desse curso foi computado';
COMMENT ON COLUMN "acccoursebalance"."courseid" IS 'Codigo identificador do curso';
COMMENT ON COLUMN "acccoursebalance"."courseversion" IS 'Versao do curso';
COMMENT ON COLUMN "acccoursebalance"."unitid" IS 'Codigo identificador do campus';
COMMENT ON COLUMN "acccoursebalance"."value" IS 'Valor do saldo do curso';

CREATE SEQUENCE "seq_coursebalanceid";
ALTER TABLE "acccoursebalance" ALTER COLUMN "coursebalanceid" SET DEFAULT NEXTVAL('"seq_coursebalanceid"');
ALTER TABLE "acccoursebalance" ALTER COLUMN "accountschemeid" SET NOT NULL;
ALTER TABLE "acccoursebalance" ALTER COLUMN "source" SET NOT NULL;
ALTER TABLE "acccoursebalance" ALTER COLUMN "balancedate" SET NOT NULL;
ALTER TABLE "acccoursebalance" ALTER COLUMN "courseid" SET NOT NULL;
ALTER TABLE "acccoursebalance" ALTER COLUMN "courseversion" SET NOT NULL;
ALTER TABLE "acccoursebalance" ALTER COLUMN "unitid" SET NOT NULL;
ALTER TABLE "acccoursebalance" ALTER COLUMN "value" SET NOT NULL;

ALTER TABLE "acccoursebalance" ALTER COLUMN "coursebalanceid" SET NOT NULL;
ALTER TABLE "acccoursebalance" ADD PRIMARY KEY ("coursebalanceid");

CREATE INDEX "idx_acccoursebalance_balancedate" ON "acccoursebalance" ("balancedate");

ALTER TABLE "acccoursebalance" ADD FOREIGN KEY ("accountschemeid","source","balancedate") REFERENCES "accaccountbalance"("accountschemeid","source","balancedate");

ALTER TABLE "acccoursebalance" ADD FOREIGN KEY ("courseid","courseversion","unitid") REFERENCES "acccourseaccount"("courseid","courseversion","unitid");

----------------------------------------------------------------------
-- --
--
-- Table: finreceivableinvoicecommunication
-- Purpose: informa��es sobre comunica��o de arquivos com bancos.
--
-- --
----------------------------------------------------------------------

CREATE TABLE "finreceivableinvoicecommunication" 
(
    "receivableinvoicecommunicationid"    int, --Chave primaria da classe
    "invoiceid"                           int, --Codigo do titulo referente a comunicacao
    "fileid"                              int, --Codigo do arquivo ao qual foi efetuada a comunicacao
    "commdate"                            date --Data da comunicacao do arquivo
) INHERITS ("baslog");

COMMENT ON TABLE "finreceivableinvoicecommunication" IS 'informa��es sobre comunica��o de arquivos com bancos.';
COMMENT ON COLUMN "finreceivableinvoicecommunication"."receivableinvoicecommunicationid" IS 'Chave primaria da classe';
COMMENT ON COLUMN "finreceivableinvoicecommunication"."invoiceid" IS 'Codigo do titulo referente a comunicacao';
COMMENT ON COLUMN "finreceivableinvoicecommunication"."fileid" IS 'Codigo do arquivo ao qual foi efetuada a comunicacao';
COMMENT ON COLUMN "finreceivableinvoicecommunication"."commdate" IS 'Data da comunicacao do arquivo';

CREATE SEQUENCE "seq_receivableinvoicecommunicationid";
ALTER TABLE "finreceivableinvoicecommunication" ALTER COLUMN "receivableinvoicecommunicationid" SET DEFAULT NEXTVAL('"seq_receivableinvoicecommunicationid"');

ALTER TABLE "finreceivableinvoicecommunication" ALTER COLUMN "receivableinvoicecommunicationid" SET NOT NULL;
ALTER TABLE "finreceivableinvoicecommunication" ADD PRIMARY KEY ("receivableinvoicecommunicationid");

ALTER TABLE "finreceivableinvoicecommunication" ADD FOREIGN KEY ("fileid") REFERENCES "finfile"("fileid");

ALTER TABLE "finreceivableinvoicecommunication" ADD FOREIGN KEY ("invoiceid") REFERENCES "fininvoice"("invoiceid");

----------------------------------------------------------------------
-- --
--
-- Table: acdschedule
-- Purpose: horarios
--
-- --
----------------------------------------------------------------------

CREATE TABLE "acdschedule" 
(
    "scheduleid"                  integer, --Codigo do horario
    "groupid"                     integer, --Codigo da turma a qual o horario se refere
    "unitid"                      integer, --Codigo da unidade onde a turma ocorre
    "subgroup"                    char(2), --Campo para ser usado em turmas que tem parte teorica e pratica, sendo que a pratica e dividida em 2 ou mais. Tearica A, pratica 1 B, prática 2 B. O Aluno devera fazer AB.
    "schedulelearningperiodid"    integer, --Codigo do horario do periodo letivo
    "weekdayid"                   integer, --Codigo do dia da semana
    "physicalresourceid"          integer, --Codigo do recurso fisico
    "physicalresourceversion"     integer, --Versao do recurso fisico
    "numcredits"                  float, --Numero de creditos
    "discounting"                 float, --Desconto
    "weight"                      float, --Peso do horário na turma, na nota. A soma dos pesos dos horários deve ser 100%
    "operationid"                 integer, --Código da Operação dos descontos das disciplinas. Por exemplo, se tiver 20% de desconto.
    "leaderid"                    integer, --Lider de turma
    "subleaderid"                 integer, --Vice-lider
    "examdate"                    date --Data do exame
) INHERITS ("baslog");

COMMENT ON TABLE "acdschedule" IS 'horarios';
COMMENT ON COLUMN "acdschedule"."scheduleid" IS 'Codigo do horario';
COMMENT ON COLUMN "acdschedule"."groupid" IS 'Codigo da turma a qual o horario se refere';
COMMENT ON COLUMN "acdschedule"."unitid" IS 'Codigo da unidade onde a turma ocorre';
COMMENT ON COLUMN "acdschedule"."subgroup" IS 'Campo para ser usado em turmas que tem parte teorica e pratica, sendo que a pratica e dividida em 2 ou mais. Tearica A, pratica 1 B, prática 2 B. O Aluno devera fazer AB.';
COMMENT ON COLUMN "acdschedule"."schedulelearningperiodid" IS 'Codigo do horario do periodo letivo';
COMMENT ON COLUMN "acdschedule"."weekdayid" IS 'Codigo do dia da semana';
COMMENT ON COLUMN "acdschedule"."physicalresourceid" IS 'Codigo do recurso fisico';
COMMENT ON COLUMN "acdschedule"."physicalresourceversion" IS 'Versao do recurso fisico';
COMMENT ON COLUMN "acdschedule"."numcredits" IS 'Numero de creditos';
COMMENT ON COLUMN "acdschedule"."discounting" IS 'Desconto';
COMMENT ON COLUMN "acdschedule"."weight" IS 'Peso do horário na turma, na nota. A soma dos pesos dos horários deve ser 100%';
COMMENT ON COLUMN "acdschedule"."operationid" IS 'Código da Operação dos descontos das disciplinas. Por exemplo, se tiver 20% de desconto.';
COMMENT ON COLUMN "acdschedule"."leaderid" IS 'Lider de turma';
COMMENT ON COLUMN "acdschedule"."subleaderid" IS 'Vice-lider';
COMMENT ON COLUMN "acdschedule"."examdate" IS 'Data do exame';

CREATE SEQUENCE "seq_scheduleid";
ALTER TABLE "acdschedule" ALTER COLUMN "scheduleid" SET DEFAULT NEXTVAL('"seq_scheduleid"');
ALTER TABLE "acdschedule" ALTER COLUMN "groupid" SET NOT NULL;
ALTER TABLE "acdschedule" ALTER COLUMN "unitid" SET NOT NULL;

ALTER TABLE "acdschedule" ALTER COLUMN "scheduleid" SET NOT NULL;
ALTER TABLE "acdschedule" ADD PRIMARY KEY ("scheduleid");

CREATE INDEX "idx_acdschedule_groupid" ON "acdschedule" ("groupid");

ALTER TABLE "acdschedule" ADD FOREIGN KEY ("physicalresourceid","physicalresourceversion") REFERENCES "insphysicalresource"("physicalresourceid","physicalresourceversion");

ALTER TABLE "acdschedule" ADD FOREIGN KEY ("weekdayid") REFERENCES "basweekday"("weekdayid");

ALTER TABLE "acdschedule" ADD FOREIGN KEY ("groupid") REFERENCES "acdgroup"("groupid");

ALTER TABLE "acdschedule" ADD FOREIGN KEY ("unitid") REFERENCES "basunit"("unitid");

ALTER TABLE "acdschedule" ADD FOREIGN KEY ("leaderid") REFERENCES "basphysicalpersonstudent"("personid");

ALTER TABLE "acdschedule" ADD FOREIGN KEY ("subleaderid") REFERENCES "basphysicalpersonstudent"("personid");

ALTER TABLE "acdschedule" ADD FOREIGN KEY ("operationid") REFERENCES "finoperation"("operationid");

ALTER TABLE "acdschedule" ADD FOREIGN KEY ("schedulelearningperiodid") REFERENCES "acdschedulelearningperiod"("schedulelearningperiodid");

ALTER TABLE "acdschedule" ADD FOREIGN KEY ("weekdayid") REFERENCES "basweekday"("weekdayid");

----------------------------------------------------------------------
-- --
--
-- Table: ptcprotocolreqcompl
-- Purpose: dados das informacoes adicionais dos requerimentos
--
-- --
----------------------------------------------------------------------

CREATE TABLE "ptcprotocolreqcompl" 
(
    "protocolreqcomplid"    integer, --Codigo do complemento
    "protocolid"            varchar(10), --Codigo do protocolo
    "requerimentid"         integer, --Codigo do requerimento
    "requerimentcomplid"    integer, --Codigo do complemento de requerimento
    "fieldvalue"            text, --Valor
    "family"                integer --Familia
) INHERITS ("baslog");

COMMENT ON TABLE "ptcprotocolreqcompl" IS 'dados das informacoes adicionais dos requerimentos';
COMMENT ON COLUMN "ptcprotocolreqcompl"."protocolreqcomplid" IS 'Codigo do complemento';
COMMENT ON COLUMN "ptcprotocolreqcompl"."protocolid" IS 'Codigo do protocolo';
COMMENT ON COLUMN "ptcprotocolreqcompl"."requerimentid" IS 'Codigo do requerimento';
COMMENT ON COLUMN "ptcprotocolreqcompl"."requerimentcomplid" IS 'Codigo do complemento de requerimento';
COMMENT ON COLUMN "ptcprotocolreqcompl"."fieldvalue" IS 'Valor';
COMMENT ON COLUMN "ptcprotocolreqcompl"."family" IS 'Familia';

CREATE SEQUENCE "seq_protocolreqcomplid";
ALTER TABLE "ptcprotocolreqcompl" ALTER COLUMN "protocolreqcomplid" SET DEFAULT NEXTVAL('"seq_protocolreqcomplid"');
ALTER TABLE "ptcprotocolreqcompl" ALTER COLUMN "protocolid" SET NOT NULL;
ALTER TABLE "ptcprotocolreqcompl" ALTER COLUMN "requerimentid" SET NOT NULL;
ALTER TABLE "ptcprotocolreqcompl" ALTER COLUMN "requerimentcomplid" SET NOT NULL;
ALTER TABLE "ptcprotocolreqcompl" ALTER COLUMN "family" SET NOT NULL;

ALTER TABLE "ptcprotocolreqcompl" ALTER COLUMN "protocolreqcomplid" SET NOT NULL;
ALTER TABLE "ptcprotocolreqcompl" ADD PRIMARY KEY ("protocolreqcomplid");

ALTER TABLE "ptcprotocolreqcompl" ADD FOREIGN KEY ("protocolid","requerimentid") REFERENCES "ptcprotocolreq"("protocolid","requerimentid");

ALTER TABLE "ptcprotocolreqcompl" ADD FOREIGN KEY ("requerimentcomplid") REFERENCES "ptcrequerimentcompl"("requerimentcomplid");

----------------------------------------------------------------------
-- --
--
-- Table: ptcprotocolreqforw
-- Purpose: despachos dos requerimentos
--
-- --
----------------------------------------------------------------------

CREATE TABLE "ptcprotocolreqforw" 
(
    "protocolid"       varchar(10), --Codigo do protocolo
    "requerimentid"    integer, --Codigo do requerimento
    "sequence"         integer, --Sequencia
    "sectorid"         integer, --Codigo do setor
    "forward"          char(1), --Se foi encaminhado
    "coments"          text, --Comentarios
    "inputdate"        date, --Data de entrada
    "outputdate"       date, --Data de saida
    "situationid"      integer, --Codigo da situacao
    "courseid"         varchar(20), --Codigo do curso
    "courseversion"    integer, --Versao do curso
    "unitid"           integer, --Codigo da unidade
    "turnid"           integer --Codigo do turno
) INHERITS ("baslog");

COMMENT ON TABLE "ptcprotocolreqforw" IS 'despachos dos requerimentos';
COMMENT ON COLUMN "ptcprotocolreqforw"."protocolid" IS 'Codigo do protocolo';
COMMENT ON COLUMN "ptcprotocolreqforw"."requerimentid" IS 'Codigo do requerimento';
COMMENT ON COLUMN "ptcprotocolreqforw"."sequence" IS 'Sequencia';
COMMENT ON COLUMN "ptcprotocolreqforw"."sectorid" IS 'Codigo do setor';
COMMENT ON COLUMN "ptcprotocolreqforw"."forward" IS 'Se foi encaminhado';
COMMENT ON COLUMN "ptcprotocolreqforw"."coments" IS 'Comentarios';
COMMENT ON COLUMN "ptcprotocolreqforw"."inputdate" IS 'Data de entrada';
COMMENT ON COLUMN "ptcprotocolreqforw"."outputdate" IS 'Data de saida';
COMMENT ON COLUMN "ptcprotocolreqforw"."situationid" IS 'Codigo da situacao';
COMMENT ON COLUMN "ptcprotocolreqforw"."courseid" IS 'Codigo do curso';
COMMENT ON COLUMN "ptcprotocolreqforw"."courseversion" IS 'Versao do curso';
COMMENT ON COLUMN "ptcprotocolreqforw"."unitid" IS 'Codigo da unidade';
COMMENT ON COLUMN "ptcprotocolreqforw"."turnid" IS 'Codigo do turno';

ALTER TABLE "ptcprotocolreqforw" ALTER COLUMN "protocolid" SET NOT NULL;
ALTER TABLE "ptcprotocolreqforw" ALTER COLUMN "requerimentid" SET NOT NULL;
ALTER TABLE "ptcprotocolreqforw" ALTER COLUMN "sequence" SET NOT NULL;
ALTER TABLE "ptcprotocolreqforw" ALTER COLUMN "sectorid" SET NOT NULL;
ALTER TABLE "ptcprotocolreqforw" ALTER COLUMN "forward" SET NOT NULL;

ALTER TABLE "ptcprotocolreqforw" ALTER COLUMN "protocolid" SET NOT NULL;
ALTER TABLE "ptcprotocolreqforw" ALTER COLUMN "requerimentid" SET NOT NULL;
ALTER TABLE "ptcprotocolreqforw" ALTER COLUMN "sequence" SET NOT NULL;
ALTER TABLE "ptcprotocolreqforw" ADD PRIMARY KEY ("protocolid","requerimentid","sequence");

ALTER TABLE "ptcprotocolreqforw" ADD FOREIGN KEY ("protocolid","requerimentid") REFERENCES "ptcprotocolreq"("protocolid","requerimentid");

ALTER TABLE "ptcprotocolreqforw" ADD FOREIGN KEY ("courseid","courseversion","unitid","turnid") REFERENCES "acdcourseoccurrence"("courseid","courseversion","turnid","unitid");

ALTER TABLE "ptcprotocolreqforw" ADD FOREIGN KEY ("sectorid") REFERENCES "bassector"("sectorid");

ALTER TABLE "ptcprotocolreqforw" ADD FOREIGN KEY ("situationid") REFERENCES "ptcsituation"("situationid");

----------------------------------------------------------------------
-- --
--
-- Table: ptclogemail
-- Purpose: log dos emails enviados aos chefes de setor
--
-- --
----------------------------------------------------------------------

CREATE TABLE "ptclogemail" 
(
    "protocolid"       varchar(10), --Codigo do protocolo
    "requerimentid"    integer, --Codigo do requerimento
    "personid"         integer, --Codigo da pessoa
    "level"            integer, --Nivel
    "sectorid"         integer, --Codigo do setor
    "date"             timestamp, --Data
    "issent"           boolean --Se foi enviado o email
) INHERITS ("baslog");

COMMENT ON TABLE "ptclogemail" IS 'log dos emails enviados aos chefes de setor';
COMMENT ON COLUMN "ptclogemail"."protocolid" IS 'Codigo do protocolo';
COMMENT ON COLUMN "ptclogemail"."requerimentid" IS 'Codigo do requerimento';
COMMENT ON COLUMN "ptclogemail"."personid" IS 'Codigo da pessoa';
COMMENT ON COLUMN "ptclogemail"."level" IS 'Nivel';
COMMENT ON COLUMN "ptclogemail"."sectorid" IS 'Codigo do setor';
COMMENT ON COLUMN "ptclogemail"."date" IS 'Data';
COMMENT ON COLUMN "ptclogemail"."issent" IS 'Se foi enviado o email';

ALTER TABLE "ptclogemail" ALTER COLUMN "protocolid" SET NOT NULL;
ALTER TABLE "ptclogemail" ALTER COLUMN "requerimentid" SET NOT NULL;
ALTER TABLE "ptclogemail" ALTER COLUMN "personid" SET NOT NULL;
ALTER TABLE "ptclogemail" ALTER COLUMN "level" SET NOT NULL;
ALTER TABLE "ptclogemail" ALTER COLUMN "sectorid" SET NOT NULL;
ALTER TABLE "ptclogemail" ALTER COLUMN "date" SET NOT NULL;
ALTER TABLE "ptclogemail" ALTER COLUMN "date" SET DEFAULT date(now()) ;
ALTER TABLE "ptclogemail" ALTER COLUMN "issent" SET NOT NULL;
ALTER TABLE "ptclogemail" ALTER COLUMN "issent" SET DEFAULT FALSE ;

ALTER TABLE "ptclogemail" ALTER COLUMN "protocolid" SET NOT NULL;
ALTER TABLE "ptclogemail" ALTER COLUMN "requerimentid" SET NOT NULL;
ALTER TABLE "ptclogemail" ALTER COLUMN "personid" SET NOT NULL;
ALTER TABLE "ptclogemail" ALTER COLUMN "level" SET NOT NULL;
ALTER TABLE "ptclogemail" ALTER COLUMN "sectorid" SET NOT NULL;
ALTER TABLE "ptclogemail" ALTER COLUMN "date" SET NOT NULL;
ALTER TABLE "ptclogemail" ADD PRIMARY KEY ("protocolid","requerimentid","personid","level","sectorid","date");

ALTER TABLE "ptclogemail" ADD FOREIGN KEY ("protocolid","requerimentid") REFERENCES "ptcprotocolreq"("protocolid","requerimentid");

ALTER TABLE "ptclogemail" ADD FOREIGN KEY ("personid") REFERENCES "basphysicalperson"("personid");

----------------------------------------------------------------------
-- --
--
-- Table: acdscheduleprofessor
-- Purpose: professores por hor�rio
--
-- --
----------------------------------------------------------------------

CREATE TABLE "acdscheduleprofessor" 
(
    "scheduleprofessorid"          integer, --Codigo do professor de horario
    "scheduleid"                   integer, --Codigo do horario
    "professorid"                  integer, --Codigo do professor
    "isinstitutionalevaluation"    boolean, --E avaliado na Avaliacao Instituicional
    "weight"                       float --Peso da nota do professor no horário (sempre base 100%) se tem um professor no horário e 100% se tiver mais a soma deles deve ser 100%
) INHERITS ("baslog");

COMMENT ON TABLE "acdscheduleprofessor" IS 'professores por hor�rio';
COMMENT ON COLUMN "acdscheduleprofessor"."scheduleprofessorid" IS 'Codigo do professor de horario';
COMMENT ON COLUMN "acdscheduleprofessor"."scheduleid" IS 'Codigo do horario';
COMMENT ON COLUMN "acdscheduleprofessor"."professorid" IS 'Codigo do professor';
COMMENT ON COLUMN "acdscheduleprofessor"."isinstitutionalevaluation" IS 'E avaliado na Avaliacao Instituicional';
COMMENT ON COLUMN "acdscheduleprofessor"."weight" IS 'Peso da nota do professor no horário (sempre base 100%) se tem um professor no horário e 100% se tiver mais a soma deles deve ser 100%';

CREATE SEQUENCE "seq_scheduleprofessorid";
ALTER TABLE "acdscheduleprofessor" ALTER COLUMN "scheduleprofessorid" SET DEFAULT NEXTVAL('"seq_scheduleprofessorid"');
ALTER TABLE "acdscheduleprofessor" ALTER COLUMN "scheduleid" SET NOT NULL;
ALTER TABLE "acdscheduleprofessor" ALTER COLUMN "isinstitutionalevaluation" SET NOT NULL;
ALTER TABLE "acdscheduleprofessor" ALTER COLUMN "isinstitutionalevaluation" SET DEFAULT TRUE ;

ALTER TABLE "acdscheduleprofessor" ALTER COLUMN "scheduleprofessorid" SET NOT NULL;
ALTER TABLE "acdscheduleprofessor" ADD PRIMARY KEY ("scheduleprofessorid");

CREATE INDEX "idx_acdscheduleprofessor_professorid" ON "acdscheduleprofessor" ("professorid");
CREATE INDEX "idx_acdscheduleprofessor_scheduleid" ON "acdscheduleprofessor" ("scheduleid");

ALTER TABLE "acdscheduleprofessor" ADD FOREIGN KEY ("professorid") REFERENCES "basphysicalpersonprofessor"("personid");

ALTER TABLE "acdscheduleprofessor" ADD FOREIGN KEY ("scheduleid") REFERENCES "acdschedule"("scheduleid");

----------------------------------------------------------------------
-- --
--
-- Table: acdenroll
-- Purpose: matriculas
--
-- --
----------------------------------------------------------------------

CREATE TABLE "acdenroll" 
(
    "enrollid"                     integer, --Codigo da matricula
    "contractid"                   integer, --Codigo do contrato
    "groupid"                      integer, --Codigo da turma
    "curriculumid"                 integer, --Codigo da disciplina do curriculo
    "dateenroll"                   date, --Data da matricula
    "hourenroll"                   time without time zone, --Hora da matricula
    "datecancellation"             date, --Data de cancelamento
    "hourcancellation"             time without time zone, --Hora de cancelamento
    "reasoncancellationid"         integer, --Motivo do cancelamento da matricula
    "note"                         float, --Nota - media dos graus
    "examnote"                     float, --Nota do exame
    "finalnote"                    float, --Nota final
    "concept"                      text, --Conceito
    "textevaluation"               text, --Parecer - Texto de Avaliação
    "frequency"                    float, --Frequencia
    "obsexploitation"              text, --Aproveitamento
    "exploitationinstitutionid"    integer, --Instituicao da disciplina aproveitada
    "numberhourexploitation"       float, --Carga horaria aproveitada
    "creditsexploitation"          float, --Creditos aproveitados
    "isshowdocumentendcourse"      boolean, --Aparece no documento final do curso
    "statusid"                     integer, --Estado atual nesta disciplina: Matriculado, dispensado, reprovado, aprovado ou desistente
    "frequencyalertemail"          char(1), --Email de alerta de frequencia: 0 - Não teve aviso; 1 - Teve um aviso (alerta) que está chegando no limite de faltas; 2 - Aviso de limite de faltas
    "isinternet"                   boolean, --Matricula feita pela internet (true)
    "ip"                           inet, --Ip da maquina que o aluno fez a matricula - pode ser diferente do ip da baslog pois aquele é sempre o ultimo.
    "isconfirm"                    boolean, --Confirmação de Matricula
    "issetfree"                    boolean, --Marcar as disciplinas que foram desbloqueadas como true
    "complement"                   text, --Complemento da disciplina oferecida. É o foco da disciplina no semestre.
    "exploitationtype"             char(1), --Flag de aproveitamos I (In) = Interno ou E (external) = Externo
    "process"                      text --campo para futuramente ser substituido pelo protocolId. receberá as observações de provas especiais etc
) INHERITS ("baslog");

COMMENT ON TABLE "acdenroll" IS 'matriculas';
COMMENT ON COLUMN "acdenroll"."enrollid" IS 'Codigo da matricula';
COMMENT ON COLUMN "acdenroll"."contractid" IS 'Codigo do contrato';
COMMENT ON COLUMN "acdenroll"."groupid" IS 'Codigo da turma';
COMMENT ON COLUMN "acdenroll"."curriculumid" IS 'Codigo da disciplina do curriculo';
COMMENT ON COLUMN "acdenroll"."dateenroll" IS 'Data da matricula';
COMMENT ON COLUMN "acdenroll"."hourenroll" IS 'Hora da matricula';
COMMENT ON COLUMN "acdenroll"."datecancellation" IS 'Data de cancelamento';
COMMENT ON COLUMN "acdenroll"."hourcancellation" IS 'Hora de cancelamento';
COMMENT ON COLUMN "acdenroll"."reasoncancellationid" IS 'Motivo do cancelamento da matricula';
COMMENT ON COLUMN "acdenroll"."note" IS 'Nota - media dos graus';
COMMENT ON COLUMN "acdenroll"."examnote" IS 'Nota do exame';
COMMENT ON COLUMN "acdenroll"."finalnote" IS 'Nota final';
COMMENT ON COLUMN "acdenroll"."concept" IS 'Conceito';
COMMENT ON COLUMN "acdenroll"."textevaluation" IS 'Parecer - Texto de Avaliação';
COMMENT ON COLUMN "acdenroll"."frequency" IS 'Frequencia';
COMMENT ON COLUMN "acdenroll"."obsexploitation" IS 'Aproveitamento';
COMMENT ON COLUMN "acdenroll"."exploitationinstitutionid" IS 'Instituicao da disciplina aproveitada';
COMMENT ON COLUMN "acdenroll"."numberhourexploitation" IS 'Carga horaria aproveitada';
COMMENT ON COLUMN "acdenroll"."creditsexploitation" IS 'Creditos aproveitados';
COMMENT ON COLUMN "acdenroll"."isshowdocumentendcourse" IS 'Aparece no documento final do curso';
COMMENT ON COLUMN "acdenroll"."statusid" IS 'Estado atual nesta disciplina: Matriculado, dispensado, reprovado, aprovado ou desistente';
COMMENT ON COLUMN "acdenroll"."frequencyalertemail" IS 'Email de alerta de frequencia: 0 - Não teve aviso; 1 - Teve um aviso (alerta) que está chegando no limite de faltas; 2 - Aviso de limite de faltas';
COMMENT ON COLUMN "acdenroll"."isinternet" IS 'Matricula feita pela internet (true)';
COMMENT ON COLUMN "acdenroll"."ip" IS 'Ip da maquina que o aluno fez a matricula - pode ser diferente do ip da baslog pois aquele é sempre o ultimo.';
COMMENT ON COLUMN "acdenroll"."isconfirm" IS 'Confirmação de Matricula';
COMMENT ON COLUMN "acdenroll"."issetfree" IS 'Marcar as disciplinas que foram desbloqueadas como true';
COMMENT ON COLUMN "acdenroll"."complement" IS 'Complemento da disciplina oferecida. É o foco da disciplina no semestre.';
COMMENT ON COLUMN "acdenroll"."exploitationtype" IS 'Flag de aproveitamos I (In) = Interno ou E (external) = Externo';
COMMENT ON COLUMN "acdenroll"."process" IS 'campo para futuramente ser substituido pelo protocolId. receberá as observações de provas especiais etc';

CREATE SEQUENCE "seq_enrollid";
ALTER TABLE "acdenroll" ALTER COLUMN "enrollid" SET DEFAULT NEXTVAL('"seq_enrollid"');
ALTER TABLE "acdenroll" ALTER COLUMN "contractid" SET NOT NULL;
ALTER TABLE "acdenroll" ALTER COLUMN "groupid" SET NOT NULL;
ALTER TABLE "acdenroll" ALTER COLUMN "curriculumid" SET NOT NULL;
ALTER TABLE "acdenroll" ALTER COLUMN "isshowdocumentendcourse" SET NOT NULL;
ALTER TABLE "acdenroll" ALTER COLUMN "isshowdocumentendcourse" SET DEFAULT FALSE ;
ALTER TABLE "acdenroll" ALTER COLUMN "statusid" SET NOT NULL;
ALTER TABLE "acdenroll" ALTER COLUMN "frequencyalertemail" SET DEFAULT '0';
ALTER TABLE "acdenroll" ALTER COLUMN "isinternet" SET NOT NULL;
ALTER TABLE "acdenroll" ALTER COLUMN "isinternet" SET DEFAULT FALSE ;
ALTER TABLE "acdenroll" ALTER COLUMN "isconfirm" SET NOT NULL;
ALTER TABLE "acdenroll" ALTER COLUMN "isconfirm" SET DEFAULT FALSE ;
ALTER TABLE "acdenroll" ALTER COLUMN "issetfree" SET NOT NULL;
ALTER TABLE "acdenroll" ALTER COLUMN "issetfree" SET DEFAULT FALSE ;

ALTER TABLE "acdenroll" ALTER COLUMN "enrollid" SET NOT NULL;
ALTER TABLE "acdenroll" ADD PRIMARY KEY ("enrollid");

CREATE INDEX "idx_acdenroll_contractid" ON "acdenroll" ("contractid");
CREATE INDEX "idx_acdenroll_groupid" ON "acdenroll" ("groupid");
CREATE INDEX "idx_acdenroll_statusid" ON "acdenroll" ("statusid");
CREATE INDEX "idx_acdenroll_curriculumid" ON "acdenroll" ("curriculumid");
CREATE INDEX "idx_acdenroll_contractid_curriculumid_statusid" ON "acdenroll" ("contractid","curriculumid","statusid");

ALTER TABLE "acdenroll" ADD FOREIGN KEY ("exploitationinstitutionid") REFERENCES "baslegalperson"("personid");

ALTER TABLE "acdenroll" ADD FOREIGN KEY ("contractid") REFERENCES "acdcontract"("contractid");

ALTER TABLE "acdenroll" ADD FOREIGN KEY ("groupid") REFERENCES "acdgroup"("groupid");

ALTER TABLE "acdenroll" ADD FOREIGN KEY ("statusid") REFERENCES "acdenrollstatus"("statusid");

ALTER TABLE "acdenroll" ADD FOREIGN KEY ("curriculumid") REFERENCES "acdcurriculum"("curriculumid");

ALTER TABLE "acdenroll" ADD FOREIGN KEY ("reasoncancellationid") REFERENCES "acdreasoncancellation"("reasoncancellationid");

----------------------------------------------------------------------
-- --
--
-- Table: acdcomplementaryactivities
-- Purpose: atividades complementares
--
-- --
----------------------------------------------------------------------

CREATE TABLE "acdcomplementaryactivities" 
(
    "complementaryactivitiesid"            integer, --Codigo da atividade complementar
    "complementaryactivitiescategoryid"    integer, --Categoria da atividade complementar
    "periodid"                             varchar(10), --Período que a atividade foi cursada
    "enrollid"                             integer, --Matricula
    "description"                          text, --Descrição da atividade complementar
    "totalhours"                           float, --Numero de horas
    "totalcredits"                         float, --Numero de créditos
    "degree"                               float, --Grau/Nota
    "concept"                              varchar(15) --Conceito
) INHERITS ("baslog");

COMMENT ON TABLE "acdcomplementaryactivities" IS 'atividades complementares';
COMMENT ON COLUMN "acdcomplementaryactivities"."complementaryactivitiesid" IS 'Codigo da atividade complementar';
COMMENT ON COLUMN "acdcomplementaryactivities"."complementaryactivitiescategoryid" IS 'Categoria da atividade complementar';
COMMENT ON COLUMN "acdcomplementaryactivities"."periodid" IS 'Período que a atividade foi cursada';
COMMENT ON COLUMN "acdcomplementaryactivities"."enrollid" IS 'Matricula';
COMMENT ON COLUMN "acdcomplementaryactivities"."description" IS 'Descrição da atividade complementar';
COMMENT ON COLUMN "acdcomplementaryactivities"."totalhours" IS 'Numero de horas';
COMMENT ON COLUMN "acdcomplementaryactivities"."totalcredits" IS 'Numero de créditos';
COMMENT ON COLUMN "acdcomplementaryactivities"."degree" IS 'Grau/Nota';
COMMENT ON COLUMN "acdcomplementaryactivities"."concept" IS 'Conceito';

CREATE SEQUENCE "seq_complementaryactivitiesid";
ALTER TABLE "acdcomplementaryactivities" ALTER COLUMN "complementaryactivitiesid" SET DEFAULT NEXTVAL('"seq_complementaryactivitiesid"');
ALTER TABLE "acdcomplementaryactivities" ALTER COLUMN "complementaryactivitiescategoryid" SET NOT NULL;
ALTER TABLE "acdcomplementaryactivities" ALTER COLUMN "periodid" SET NOT NULL;
ALTER TABLE "acdcomplementaryactivities" ALTER COLUMN "enrollid" SET NOT NULL;
ALTER TABLE "acdcomplementaryactivities" ALTER COLUMN "description" SET NOT NULL;
ALTER TABLE "acdcomplementaryactivities" ALTER COLUMN "totalhours" SET NOT NULL;
ALTER TABLE "acdcomplementaryactivities" ALTER COLUMN "totalcredits" SET NOT NULL;

ALTER TABLE "acdcomplementaryactivities" ALTER COLUMN "complementaryactivitiesid" SET NOT NULL;
ALTER TABLE "acdcomplementaryactivities" ADD PRIMARY KEY ("complementaryactivitiesid");

ALTER TABLE "acdcomplementaryactivities" ADD FOREIGN KEY ("complementaryactivitiescategoryid") REFERENCES "acdcomplementaryactivitiescategory"("complementaryactivitiescategoryid");

ALTER TABLE "acdcomplementaryactivities" ADD FOREIGN KEY ("enrollid") REFERENCES "acdenroll"("enrollid");

ALTER TABLE "acdcomplementaryactivities" ADD FOREIGN KEY ("periodid") REFERENCES "acdperiod"("periodid");

----------------------------------------------------------------------
-- --
--
-- Table: acddegreeenroll
-- Purpose: notas dos graus para cada matricula
--
-- --
----------------------------------------------------------------------

CREATE TABLE "acddegreeenroll" 
(
    "degreeid"       integer, --Codigo do grau
    "enrollid"       integer, --Codigo da matricula
    "note"           float, --Nota
    "concept"        varchar(15), --Conceito
    "descriptive"    text --Descritivo
) INHERITS ("baslog");

COMMENT ON TABLE "acddegreeenroll" IS 'notas dos graus para cada matricula';
COMMENT ON COLUMN "acddegreeenroll"."degreeid" IS 'Codigo do grau';
COMMENT ON COLUMN "acddegreeenroll"."enrollid" IS 'Codigo da matricula';
COMMENT ON COLUMN "acddegreeenroll"."note" IS 'Nota';
COMMENT ON COLUMN "acddegreeenroll"."concept" IS 'Conceito';
COMMENT ON COLUMN "acddegreeenroll"."descriptive" IS 'Descritivo';

ALTER TABLE "acddegreeenroll" ALTER COLUMN "degreeid" SET NOT NULL;
ALTER TABLE "acddegreeenroll" ALTER COLUMN "enrollid" SET NOT NULL;

ALTER TABLE "acddegreeenroll" ALTER COLUMN "degreeid" SET NOT NULL;
ALTER TABLE "acddegreeenroll" ALTER COLUMN "enrollid" SET NOT NULL;
ALTER TABLE "acddegreeenroll" ADD PRIMARY KEY ("degreeid","enrollid");

ALTER TABLE "acddegreeenroll" ADD FOREIGN KEY ("degreeid") REFERENCES "acddegree"("degreeid");

ALTER TABLE "acddegreeenroll" ADD FOREIGN KEY ("enrollid") REFERENCES "acdenroll"("enrollid");

----------------------------------------------------------------------
-- --
--
-- Table: acdwebdailylog
-- Purpose: logs de acesso dos professores ao webdiario
--
-- --
----------------------------------------------------------------------

CREATE TABLE "acdwebdailylog" 
(
    "webdailylogid"          integer, --Codigo do registro de log
    "scheduleprofessorid"    integer, --Horario da disciplina, com o professor e periodo letivo
    "accessdate"             date, --Data de acesso
    "accesshour"             time, --Horario de acesso
    "lessondate"             date, --O acesso foi feito referenciando a data de aula preenchida neste campo
    "professoripaddress"     inet --Ip de onde o professor acessou o sistema
) INHERITS ("baslog");

COMMENT ON TABLE "acdwebdailylog" IS 'logs de acesso dos professores ao webdiario';
COMMENT ON COLUMN "acdwebdailylog"."webdailylogid" IS 'Codigo do registro de log';
COMMENT ON COLUMN "acdwebdailylog"."scheduleprofessorid" IS 'Horario da disciplina, com o professor e periodo letivo';
COMMENT ON COLUMN "acdwebdailylog"."accessdate" IS 'Data de acesso';
COMMENT ON COLUMN "acdwebdailylog"."accesshour" IS 'Horario de acesso';
COMMENT ON COLUMN "acdwebdailylog"."lessondate" IS 'O acesso foi feito referenciando a data de aula preenchida neste campo';
COMMENT ON COLUMN "acdwebdailylog"."professoripaddress" IS 'Ip de onde o professor acessou o sistema';

CREATE SEQUENCE "seq_webdailylogid";
ALTER TABLE "acdwebdailylog" ALTER COLUMN "webdailylogid" SET DEFAULT NEXTVAL('"seq_webdailylogid"');
ALTER TABLE "acdwebdailylog" ALTER COLUMN "scheduleprofessorid" SET NOT NULL;
ALTER TABLE "acdwebdailylog" ALTER COLUMN "accessdate" SET NOT NULL;
ALTER TABLE "acdwebdailylog" ALTER COLUMN "accessdate" SET DEFAULT date(now()) ;
ALTER TABLE "acdwebdailylog" ALTER COLUMN "accesshour" SET NOT NULL;
ALTER TABLE "acdwebdailylog" ALTER COLUMN "accesshour" SET DEFAULT now() ;
ALTER TABLE "acdwebdailylog" ALTER COLUMN "lessondate" SET NOT NULL;

ALTER TABLE "acdwebdailylog" ALTER COLUMN "webdailylogid" SET NOT NULL;
ALTER TABLE "acdwebdailylog" ADD PRIMARY KEY ("webdailylogid");

CREATE INDEX "idx_acdwebdailylog_scheduleprofessorid" ON "acdwebdailylog" ("scheduleprofessorid");

ALTER TABLE "acdwebdailylog" ADD FOREIGN KEY ("scheduleprofessorid") REFERENCES "acdscheduleprofessor"("scheduleprofessorid");

----------------------------------------------------------------------
-- --
--
-- Table: acdexploitation
-- Purpose: dados dos aproveitamentos
--
-- --
----------------------------------------------------------------------

CREATE TABLE "acdexploitation" 
(
    "exploitationid"             integer, --Sequencia para identificar o aproveitamento (chave primaria)
    "enrollid"                   integer, --Chave estrangeira para a tabela acdEnroll. Corresponde a matricula do curso atual do aluno.
    "exploitationtype"           char(1), --Identificador do tipo de aproveitamento (I = Interno e E = Externo).
    "exploitationenrollid"       integer, --Quando for aproveitamento interno, este campo sera a chave estrangeira correspondente a disciplina cursada pelo aluno no curso anterior. Quando for aproveitamento externo, este campo sera NULL.
    "exploitationnumberhours"    float, --Numero de horas aproveitadas
    "exploitationcredits"        float, --Numero de creditos aproveitados
    "institutionid"              integer, --Instituicao onde a disciplina foi cursada
    "coursename"                 text, --Curso da pessoa na instituicao onde a disciplina foi cursada.
    "curricularcomponentname"    text, --Nome da disciplina na instituicao onde foi cursada.
    "finalnote"                  text, --Nota ou conceito final obtido pelo aluno na disciplina.
    "numberhours"                float, --Numero de horas que a disciplina possuia na instituicao onde foi cursada.
    "credits"                    float, --Numero de creditos que a disciplina possuia na instituicao onde foi cursada.
    "period"                     text --Periodo em que a disciplina foi cursada.
) INHERITS ("baslog");

COMMENT ON TABLE "acdexploitation" IS 'dados dos aproveitamentos';
COMMENT ON COLUMN "acdexploitation"."exploitationid" IS 'Sequencia para identificar o aproveitamento (chave primaria)';
COMMENT ON COLUMN "acdexploitation"."enrollid" IS 'Chave estrangeira para a tabela acdEnroll. Corresponde a matricula do curso atual do aluno.';
COMMENT ON COLUMN "acdexploitation"."exploitationtype" IS 'Identificador do tipo de aproveitamento (I = Interno e E = Externo).';
COMMENT ON COLUMN "acdexploitation"."exploitationenrollid" IS 'Quando for aproveitamento interno, este campo sera a chave estrangeira correspondente a disciplina cursada pelo aluno no curso anterior. Quando for aproveitamento externo, este campo sera NULL.';
COMMENT ON COLUMN "acdexploitation"."exploitationnumberhours" IS 'Numero de horas aproveitadas';
COMMENT ON COLUMN "acdexploitation"."exploitationcredits" IS 'Numero de creditos aproveitados';
COMMENT ON COLUMN "acdexploitation"."institutionid" IS 'Instituicao onde a disciplina foi cursada';
COMMENT ON COLUMN "acdexploitation"."coursename" IS 'Curso da pessoa na instituicao onde a disciplina foi cursada.';
COMMENT ON COLUMN "acdexploitation"."curricularcomponentname" IS 'Nome da disciplina na instituicao onde foi cursada.';
COMMENT ON COLUMN "acdexploitation"."finalnote" IS 'Nota ou conceito final obtido pelo aluno na disciplina.';
COMMENT ON COLUMN "acdexploitation"."numberhours" IS 'Numero de horas que a disciplina possuia na instituicao onde foi cursada.';
COMMENT ON COLUMN "acdexploitation"."credits" IS 'Numero de creditos que a disciplina possuia na instituicao onde foi cursada.';
COMMENT ON COLUMN "acdexploitation"."period" IS 'Periodo em que a disciplina foi cursada.';

CREATE SEQUENCE "seq_exploitationid";
ALTER TABLE "acdexploitation" ALTER COLUMN "exploitationid" SET DEFAULT NEXTVAL('"seq_exploitationid"');
ALTER TABLE "acdexploitation" ALTER COLUMN "enrollid" SET NOT NULL;
ALTER TABLE "acdexploitation" ALTER COLUMN "exploitationtype" SET NOT NULL;
ALTER TABLE "acdexploitation" ALTER COLUMN "exploitationnumberhours" SET NOT NULL;

ALTER TABLE "acdexploitation" ALTER COLUMN "exploitationid" SET NOT NULL;
ALTER TABLE "acdexploitation" ADD PRIMARY KEY ("exploitationid");

ALTER TABLE "acdexploitation" ADD FOREIGN KEY ("enrollid") REFERENCES "acdenroll"("enrollid");

ALTER TABLE "acdexploitation" ADD FOREIGN KEY ("exploitationenrollid") REFERENCES "acdenroll"("enrollid");

ALTER TABLE "acdexploitation" ADD FOREIGN KEY ("institutionid") REFERENCES "basperson"("personid");

----------------------------------------------------------------------
-- --
--
-- Table: acdevaluation
-- Purpose: avalia��es
--
-- --
----------------------------------------------------------------------

CREATE TABLE "acdevaluation" 
(
    "evaluationid"           integer, --Codigo da avaliacao
    "scheduleprofessorid"    integer, --Codigo do professor (do horario da oferecida)
    "degreeid"               integer, --Codigo do grau do qual a avaliacao faz parte (compondo, assim, a nota deste grau)
    "description"            text, --Descricao
    "dateforecast"           date, --Data prevista para a avaliacao ser aplicada
    "weight"                 float --Peso para calculo de media ponderada
) INHERITS ("baslog");

COMMENT ON TABLE "acdevaluation" IS 'avalia��es';
COMMENT ON COLUMN "acdevaluation"."evaluationid" IS 'Codigo da avaliacao';
COMMENT ON COLUMN "acdevaluation"."scheduleprofessorid" IS 'Codigo do professor (do horario da oferecida)';
COMMENT ON COLUMN "acdevaluation"."degreeid" IS 'Codigo do grau do qual a avaliacao faz parte (compondo, assim, a nota deste grau)';
COMMENT ON COLUMN "acdevaluation"."description" IS 'Descricao';
COMMENT ON COLUMN "acdevaluation"."dateforecast" IS 'Data prevista para a avaliacao ser aplicada';
COMMENT ON COLUMN "acdevaluation"."weight" IS 'Peso para calculo de media ponderada';

CREATE SEQUENCE "seq_evaluationid";
ALTER TABLE "acdevaluation" ALTER COLUMN "evaluationid" SET DEFAULT NEXTVAL('"seq_evaluationid"');
ALTER TABLE "acdevaluation" ALTER COLUMN "scheduleprofessorid" SET NOT NULL;
ALTER TABLE "acdevaluation" ALTER COLUMN "degreeid" SET NOT NULL;
ALTER TABLE "acdevaluation" ALTER COLUMN "description" SET NOT NULL;

ALTER TABLE "acdevaluation" ALTER COLUMN "evaluationid" SET NOT NULL;
ALTER TABLE "acdevaluation" ADD PRIMARY KEY ("evaluationid");

CREATE INDEX "idx_acdevaluation_scheduleprofessorid" ON "acdevaluation" ("scheduleprofessorid");

ALTER TABLE "acdevaluation" ADD FOREIGN KEY ("degreeid") REFERENCES "acddegree"("degreeid");

ALTER TABLE "acdevaluation" ADD FOREIGN KEY ("scheduleprofessorid") REFERENCES "acdscheduleprofessor"("scheduleprofessorid");

----------------------------------------------------------------------
-- --
--
-- Table: acdevaluationenroll
-- Purpose: nota das avaliacoes para cada matricula
--
-- --
----------------------------------------------------------------------

CREATE TABLE "acdevaluationenroll" 
(
    "evaluationid"    integer, --Codigo da avaliacao
    "enrollid"        integer, --Codigo da matricula
    "note"            float, --Nota
    "concept"         varchar(15), --Conceito
    "descritive"      text, --Descritivo
    "isnotappear"     boolean --TRUE se o aluno nao compareceu para fazer a avaliacao. Caso contrario, FALSE
) INHERITS ("baslog");

COMMENT ON TABLE "acdevaluationenroll" IS 'nota das avaliacoes para cada matricula';
COMMENT ON COLUMN "acdevaluationenroll"."evaluationid" IS 'Codigo da avaliacao';
COMMENT ON COLUMN "acdevaluationenroll"."enrollid" IS 'Codigo da matricula';
COMMENT ON COLUMN "acdevaluationenroll"."note" IS 'Nota';
COMMENT ON COLUMN "acdevaluationenroll"."concept" IS 'Conceito';
COMMENT ON COLUMN "acdevaluationenroll"."descritive" IS 'Descritivo';
COMMENT ON COLUMN "acdevaluationenroll"."isnotappear" IS 'TRUE se o aluno nao compareceu para fazer a avaliacao. Caso contrario, FALSE';

ALTER TABLE "acdevaluationenroll" ALTER COLUMN "evaluationid" SET NOT NULL;
ALTER TABLE "acdevaluationenroll" ALTER COLUMN "enrollid" SET NOT NULL;
ALTER TABLE "acdevaluationenroll" ALTER COLUMN "isnotappear" SET NOT NULL;
ALTER TABLE "acdevaluationenroll" ALTER COLUMN "isnotappear" SET DEFAULT FALSE ;

ALTER TABLE "acdevaluationenroll" ALTER COLUMN "evaluationid" SET NOT NULL;
ALTER TABLE "acdevaluationenroll" ALTER COLUMN "enrollid" SET NOT NULL;
ALTER TABLE "acdevaluationenroll" ADD PRIMARY KEY ("evaluationid","enrollid");

ALTER TABLE "acdevaluationenroll" ADD FOREIGN KEY ("evaluationid") REFERENCES "acdevaluation"("evaluationid");

ALTER TABLE "acdevaluationenroll" ADD FOREIGN KEY ("enrollid") REFERENCES "acdenroll"("enrollid");

----------------------------------------------------------------------
-- --
--
-- Table: acdfrequenceenroll
-- Purpose: registros de frequencia para cada matricula
--
-- --
----------------------------------------------------------------------

CREATE TABLE "acdfrequenceenroll" 
(
    "enrollid"              integer, --Codigo da matricula
    "scheduleid"            integer, --Codigo do horario da turma
    "frequencydate"         date, --Data do registro de frequencia
    "turnid"                integer, --Codigo do turno
    "frequency"             integer, --Frequencia
    "iscancellation"        boolean, --Se a aula foi cancelada
    "reasoncancellation"    text, --Motivo do cancelamento
    "justifiedabsence"      boolean, --Falta justificada
    "cancelledabsence"      boolean --Falta abonada (cancelada)
) INHERITS ("baslog");

COMMENT ON TABLE "acdfrequenceenroll" IS 'registros de frequencia para cada matricula';
COMMENT ON COLUMN "acdfrequenceenroll"."enrollid" IS 'Codigo da matricula';
COMMENT ON COLUMN "acdfrequenceenroll"."scheduleid" IS 'Codigo do horario da turma';
COMMENT ON COLUMN "acdfrequenceenroll"."frequencydate" IS 'Data do registro de frequencia';
COMMENT ON COLUMN "acdfrequenceenroll"."turnid" IS 'Codigo do turno';
COMMENT ON COLUMN "acdfrequenceenroll"."frequency" IS 'Frequencia';
COMMENT ON COLUMN "acdfrequenceenroll"."iscancellation" IS 'Se a aula foi cancelada';
COMMENT ON COLUMN "acdfrequenceenroll"."reasoncancellation" IS 'Motivo do cancelamento';
COMMENT ON COLUMN "acdfrequenceenroll"."justifiedabsence" IS 'Falta justificada';
COMMENT ON COLUMN "acdfrequenceenroll"."cancelledabsence" IS 'Falta abonada (cancelada)';

ALTER TABLE "acdfrequenceenroll" ALTER COLUMN "enrollid" SET NOT NULL;
ALTER TABLE "acdfrequenceenroll" ALTER COLUMN "scheduleid" SET NOT NULL;
ALTER TABLE "acdfrequenceenroll" ALTER COLUMN "frequencydate" SET NOT NULL;
ALTER TABLE "acdfrequenceenroll" ALTER COLUMN "turnid" SET NOT NULL;
ALTER TABLE "acdfrequenceenroll" ALTER COLUMN "frequency" SET NOT NULL;
ALTER TABLE "acdfrequenceenroll" ALTER COLUMN "iscancellation" SET NOT NULL;
ALTER TABLE "acdfrequenceenroll" ALTER COLUMN "iscancellation" SET DEFAULT FALSE ;
ALTER TABLE "acdfrequenceenroll" ALTER COLUMN "justifiedabsence" SET NOT NULL;
ALTER TABLE "acdfrequenceenroll" ALTER COLUMN "justifiedabsence" SET DEFAULT FALSE ;
ALTER TABLE "acdfrequenceenroll" ALTER COLUMN "cancelledabsence" SET NOT NULL;
ALTER TABLE "acdfrequenceenroll" ALTER COLUMN "cancelledabsence" SET DEFAULT FALSE ;

ALTER TABLE "acdfrequenceenroll" ALTER COLUMN "enrollid" SET NOT NULL;
ALTER TABLE "acdfrequenceenroll" ALTER COLUMN "scheduleid" SET NOT NULL;
ALTER TABLE "acdfrequenceenroll" ALTER COLUMN "frequencydate" SET NOT NULL;
ALTER TABLE "acdfrequenceenroll" ALTER COLUMN "turnid" SET NOT NULL;
ALTER TABLE "acdfrequenceenroll" ADD PRIMARY KEY ("enrollid","scheduleid","frequencydate","turnid");

CREATE INDEX "idx_acdfrequenceenroll_scheduleid" ON "acdfrequenceenroll" ("scheduleid");


-- Tabela de agencias bancarias
-- 2007-10-30
-- --

CREATE TABLE finBranch (
    bankId varchar(3) not null references finBank(bankid),
    branchNumber varchar(30) not null,
    branchNumberDigit varchar(2),
    cityId int not null references bascity(cityId)
) INHERITS (basLog);
ALTER TABLE finBranch ADD PRIMARY KEY (bankId, branchNumber);
COMMENT ON TABLE finBranch IS 'Tabela que possui as ag�ncias dos cheques recebidos ou as ag�ncias dos cheques emitidos.';

-- --
-- Controle de cueques
-- 2007-10-30
-- --
CREATE SEQUENCE seq_checkid;
CREATE TABLE finCheck (
    checkId int default nextval('seq_checkid'),
    personId int not null references basperson(personId),
    checkNumber varchar(20) not null,
    emissionDate date not null default date(now()),
    maturityDate date not null,
    newMaturityDate date,
    downDate date,
    reasonId int,
    issuingName text,
    issuingCPF text,
    observation text,
    "value" numeric(14,4) not null,
    tax numeric(14,4),
    interest numeric(14,4),
    discount numeric(14,4),
    totalValue numeric(14,4) not null,
    status char not null default 'C',
    bankId varchar(3) not null,
    branchNumber varchar(30) not null,
    destinationBankAccountId int references finBankAccount(bankAccountId)
) INHERITS (basLog);
ALTER TABLE finCheck ADD PRIMARY KEY (checkId);
ALTER TABLE finCheck ADD FOREIGN KEY (bankId, branchNumber) references finBranch(bankId, branchNumber);
COMMENT ON TABLE finCheck IS 'Tabela que para gravar os cheques emitidos e recebidos';
COMMENT ON COLUMN finCheck.personId IS 'Pessoa do qual recebemos o cheque(cliente) ou pessoa para o qual enviamos o cheque(fornecedor)';
COMMENT ON COLUMN finCheck.checknumber IS 'N�mero do cheque recebido ou emitido';
COMMENT ON COLUMN finCheck.emissionDate IS 'Data que um cheque foi emitido(feito) para um fornecedor ou que um cheque foi recebido de um cliente';
COMMENT ON COLUMN finCheck.maturityDate IS 'Data de vencimento do cheque para um fornecedor ou de vencimento de um cheque recebido por um cliente';
COMMENT ON COLUMN finCheck.maturityDate IS 'Nova data de vencimento/prorroga��o que � definida caso um clinte pe�a mais alguns dias, por exemplo';
COMMENT ON COLUMN finCheck.downDate IS 'Data que um cheque foi compensado';
COMMENT ON COLUMN finCheck.reasonId IS 'Campo para informar o hist�rico/motivo/fim/prop�sito do cheque. Se j� estiver definido no t�tulo, n�o � necess�rio';
COMMENT ON COLUMN finCheck.bankId IS 'Codigo do banco do qual se recebe um cheque ou envia um cheque';
COMMENT ON COLUMN finCheck.branchNumber IS 'Codigo da ag�ncia do qual se recebe um cheque ou envia um cheque';
COMMENT ON COLUMN finCheck.destinationBankAccountId IS 'C�digo do banco, ag�ncia e conta da institui��o para o qual v�o cair os cheques recebidos dos clientes.';
COMMENT ON COLUMN finCheck.issuingName IS 'Emitente do cheque';
COMMENT ON COLUMN finCheck.issuingCPF IS 'CPF do emitente do cheque';
COMMENT ON COLUMN finCheck."value" IS 'Valor do cheque';
COMMENT ON COLUMN finCheck.tax IS 'Taxa sobre o cheque';
COMMENT ON COLUMN finCheck.interest IS 'Juros sobre o valor do cheque';
COMMENT ON COLUMN finCheck.discount IS 'Descontos/abatimentos sobre o valor do cheque';
COMMENT ON COLUMN finCheck.totalValue IS 'Valor total do cheque';
COMMENT ON COLUMN finCheck.status IS 'Status do cheque: C com fundo e S sem fundo';

CREATE SEQUENCE seq_checkinvoiceid;
CREATE TABLE finCheckInvoice (
    checkInvoiceId int default nextval('seq_checkinvoiceid'),
    checkId int references finCheck(checkid),
    invoiceId int references finInvoice(invoiceId)
) INHERITS (basLog);
ALTER TABLE finCheckInvoice ADD PRIMARY KEY (checkInvoiceId);
COMMENT ON TABLE finCheckInvoice IS 'Tabela que grava o v�nculo entre os cheques e titulos';
COMMENT ON COLUMN finCheckInvoice.invoiceId IS 'C�digo do t�tulo para vincular o cheque ao t�tulo';
COMMENT ON COLUMN finCheckInvoice.checkId IS 'C�digo do cheque para vincular o cheque ao t�tulo';

-- --
-- tabela para o conte�do program�tico dos professores
-- 2007-12-04
-- dah
-- --
CREATE TABLE acdfrequencecontent (
    scheduleid integer NOT NULL,
    occurrencedate date NOT NULL,
    turnid integer NOT NULL,
    content text
)
INHERITS (baslog);
ALTER TABLE ONLY acdfrequencecontent
    ADD CONSTRAINT acdfrequencecontent_pkey PRIMARY KEY (scheduleid, occurrencedate, turnid);
COMMENT ON TABLE acdfrequencecontent IS 'tabela com o conte�do das aulas';

