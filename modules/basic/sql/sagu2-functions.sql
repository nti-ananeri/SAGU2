-----------------------------------------------------------------------
-- --
-- Purpose: Create plpgsql language needed for some functions
--
-- --
-----------------------------------------------------------------------
CREATE LANGUAGE plpgsql;
-----------------------------------------------------------------------
-- --
-- Purpose: Função que retorna o email a partir do código da pessoa
--
-- --
-----------------------------------------------------------------------
CREATE OR REPLACE FUNCTION getEmail( "personid" INT ) RETURNS VARCHAR AS '
  SELECT lower(email) FROM ONLY basPerson WHERE personId = $1 
' LANGUAGE 'sql';

-----------------------------------------------------------------------
-- --
-- Purpose: Função que traz o período de um determinado título
--
-- --
----------------------------------------------------------------------
CREATE OR REPLACE FUNCTION getLearningPeriodBeginDate( "learningPeriodId" INT ) RETURNS DATE AS '
  SELECT beginDate FROM acdLearningPeriod WHERE learningPeriodId = $1 
' LANGUAGE 'sql';

-----------------------------------------------------------------------
-- --
-- Purpose: Função que traz o período de um determinado título
-- --
----------------------------------------------------------------------
CREATE OR REPLACE FUNCTION getInvoicePeriod( INT ) RETURNS VARCHAR AS '
  SELECT B.periodId
    FROM acdLearningPeriod B,
         finInvoice A
   WHERE A.maturityDate
 BETWEEN B.beginDate
     AND B.endDate
     AND A.courseId = B.courseId
     AND A.courseVersion = B.courseVersion
     AND A.policyId = B.policyId
     AND A.unitId = B.unitId
     AND A.invoiceId = $1
GROUP BY B.periodId
   LIMIT 1 
' LANGUAGE 'sql';
-----------------------------------------------------------------------
-- --
-- Purpose: Função que traz o período de um determinado título
-- --
----------------------------------------------------------------------
CREATE OR REPLACE FUNCTION getInvoiceLearningPeriod( INT ) RETURNS INT AS '
  SELECT B.learningPeriodId
    FROM acdLearningPeriod B,
         finInvoice A
   WHERE A.maturityDate
 BETWEEN B.beginDate
     AND B.endDate
     AND A.courseId = B.courseId
     AND A.courseVersion = B.courseVersion
     AND A.policyId = B.policyId
     AND A.unitId = B.unitId
     AND A.invoiceId = $1
' LANGUAGE 'sql';
-----------------------------------------------------------------------
-- --
-- Purpose: Função que retorna a descricao da lingua estrangeira
--
-- --
----------------------------------------------------------------------
CREATE OR REPLACE FUNCTION getLanguage( INT ) RETURNS VARCHAR AS '
SELECT description 
  FROM sprLanguage 
 WHERE languageId = $1 
' LANGUAGE 'sql';

-----------------------------------------------------------------------
-- --
-- Purpose: Função que retorna o nome da cidade
--
-- --
----------------------------------------------------------------------
CREATE OR REPLACE FUNCTION getCity( INT ) RETURNS VARCHAR AS '
SELECT name 
  FROM basCity 
 WHERE cityId = $1 
' LANGUAGE 'sql';

-----------------------------------------------------------------------
-- --
-- Purpose: Função que retorna valor da taxa para um determinado período
--
-- --
----------------------------------------------------------------------
CREATE OR REPLACE FUNCTION getBankTaxValue( INT ) RETURNS numeric AS '
SELECT A.banktaxvalue
  FROM finPolicy A
 INNER JOIN acdLearningPeriod AS B
    ON (A.policyId = B.policyId)
 WHERE B.learningPeriodId = $1 ' LANGUAGE 'sql';

----------------------------------------------------------------------
-- --
-- Purpose: Retorna a abreviatura de uma disciplina
--          
--
-- --
----------------------------------------------------------------------
CREATE OR REPLACE FUNCTION getCurricularComponentShortName( VARCHAR ) RETURNS VARCHAR AS '
SELECT shortName
  FROM acdCurricularComponent
 WHERE curricularComponentId = $1' LANGUAGE 'sql';

CREATE OR REPLACE FUNCTION getCurricularComponentShortName( VARCHAR ) RETURNS VARCHAR AS '
SELECT shortName
  FROM acdCurricularComponent
 WHERE curricularComponentId = $1' LANGUAGE 'sql';

----------------------------------------------------------------------
-- --
-- Purpose: Retorna o nome de uma disciplina
--          
--
-- --
----------------------------------------------------------------------
CREATE OR REPLACE FUNCTION getCurricularComponentName( VARCHAR ) RETURNS VARCHAR AS '
SELECT name
  FROM acdCurricularComponent
 WHERE curricularComponentId = $1' LANGUAGE 'sql';

----------------------------------------------------------------------
-- --
-- Purpose: Retorna o nome de um curso
--          
--
-- --
----------------------------------------------------------------------
CREATE OR REPLACE FUNCTION getCourseName( VARCHAR ) RETURNS VARCHAR AS '
SELECT name
  FROM acdCourse
 WHERE courseId = $1' LANGUAGE 'sql';

----------------------------------------------------------------------
-- --
-- Purpose: Retorna a abreviatura de um curso
--          
--
-- --
----------------------------------------------------------------------
CREATE OR REPLACE FUNCTION getCourseShortName( VARCHAR ) RETURNS VARCHAR AS '
SELECT shortName
  FROM acdCourse
 WHERE courseId = $1' LANGUAGE 'sql';

----------------------------------------------------------------------
-- --
-- Purpose: Retorna a descrição da unidade
--          
--
-- --
----------------------------------------------------------------------
CREATE OR REPLACE FUNCTION getUnitDescription( INT ) RETURNS VARCHAR AS '
SELECT description
  FROM basUnit
 WHERE unitId = $1' LANGUAGE 'sql';

----------------------------------------------------------------------
-- --
-- Purpose: Retorna a descrição do turno
--          
--
-- --
----------------------------------------------------------------------
CREATE OR REPLACE FUNCTION getTurnDescription( INT ) RETURNS VARCHAR AS '
SELECT description
  FROM basTurn
 WHERE turnId = $1' LANGUAGE 'sql';

----------------------------------------------------------------------
-- --
-- Purpose: Função que retorna verdadeiro ou falso se o aluno é bixo ou não.
--          
--
-- --
----------------------------------------------------------------------
CREATE OR REPLACE FUNCTION is_freshman( VARCHAR, INT ) RETURNS boolean AS '
SELECT count(*) > 0 
  FROM sprInscription 
 WHERE selectiveProcessId = $1
   AND personId = $2 ' LANGUAGE 'sql';

----------------------------------------------------------------------
-- --
-- Purpose: Função que retorna o valor, positivo ou negativo, do saldo
--          dos lançamentos de um título entre duas datas
--
-- --
----------------------------------------------------------------------
CREATE OR REPLACE FUNCTION balanceWithBetweenDates( int, date, date ) RETURNS numeric AS '
SELECT SUM( CASE WHEN A.operationTypeId = \'D\' THEN ( 1 * B.value )
                 WHEN A.operationTypeId = \'C\' THEN ( -1 * B.value )
            END
          )::numeric
  FROM finOperation A,
       ( SELECT value,
                operationId,
                invoiceId,
                entryDate
           FROM finEntry
           ) AS B
 WHERE invoiceId = $1
       AND entryDate >= $2
       AND entryDate <= $3
       AND A.operationId = B.operationId' LANGUAGE 'sql';



----------------------------------------------------------------------
-- --
-- Purpose: Função que retorna o valor, positivo ou negativo, do saldo
--          dos lançamentos de um título dentro de uma data limite
--
-- --
----------------------------------------------------------------------
CREATE OR REPLACE FUNCTION balanceWithEndDate( int, date ) RETURNS numeric AS '
SELECT SUM( CASE WHEN A.operationTypeId = \'D\' THEN ( 1 * B.value )
                 WHEN A.operationTypeId = \'C\' THEN ( -1 * B.value )
            END
          )::numeric
  FROM finOperation A,
       ( SELECT value,
                operationId,
                invoiceId,
                entryDate
           FROM finEntry 
          WHERE invoiceId = $1
            AND entryDate <= $2 ) AS B
 WHERE A.operationId = B.operationId' LANGUAGE 'sql';
----------------------------------------------------------------------
-- --
-- Purpose: Função que retorna true se o aluno tem registros na 
--          acdEnroll e eles forem diferentes do statusId passado
--          como parâmetro
--
-- --
----------------------------------------------------------------------
CREATE OR REPLACE FUNCTION hasEnroll(INT, INT, INT) RETURNS BOOLEAN AS '
    SELECT CASE WHEN ( count(*) > 0 ) THEN true ELSE FALSE END 
                FROM acdEnroll A
          INNER JOIN acdGroup B
               USING ( groupId )
               WHERE A.contractId = $1
                 AND B.learningPeriodId = $2
                 AND A.statusId <> $3' LANGUAGE 'sql';

----------------------------------------------------------------------
-- --
-- Purpose: Função que retorna true se existe determinado movimentação
--          contratual para um aluno num período letivo
--
-- --
----------------------------------------------------------------------
CREATE OR REPLACE FUNCTION hasContractualMovement(INT, INT, INT) RETURNS BOOLEAN AS '
SELECT CASE WHEN ( count(*) > 0 ) THEN true ELSE false END 
  FROM acdMovementContract
 WHERE contractId = $1
   AND learningPeriodId = $2
   AND statecontractid = $3;
' LANGUAGE 'sql';

----------------------------------------------------------------------
-- --
-- Purpose: Função que retorna o valor, positivo ou negativo, do saldo
--          dos lançamentos de um título
--
-- --
----------------------------------------------------------------------
CREATE OR REPLACE FUNCTION balance(INT) RETURNS NUMERIC AS '
SELECT SUM( CASE WHEN A.operationTypeId = \'D\' THEN ( 1 * B.value ) 
                 WHEN A.operationTypeId = \'C\' THEN ( -1 * B.value ) 
            END 
          )
  FROM finOperation A, 
       finEntry B 
 WHERE A.operationId = B.operationId 
   AND B.invoiceId = $1
' LANGUAGE 'sql';

----------------------------------------------------------------------
-- --
-- Purpose: Função que retorna o valor, positivo ou negativo, do saldo
--          dos lançamentos de um título, levando em consideração os
--          cheques lançados para aquele título. Se o cheque for para
--          mais de um título, o valor do cheque é dividido pelo núme-
--          ro de títulos à qual ele pertence. O segundo parâmetro de-
--          fine se será levado em consideração ou não, os cheques.
-- --
----------------------------------------------------------------------
CREATE OR REPLACE FUNCTION balance(INT, BOOLEAN) RETURNS NUMERIC AS '
SELECT ( CASE WHEN checks.sum > 0 
              THEN entries.sum - checks.sum 
              ELSE entries.sum
          END )
  FROM 
       ( SELECT SUM ( CASE WHEN A.operationTypeId = \'D\' THEN ( 1 * B.value ) 
                           WHEN A.operationTypeId = \'C\' THEN ( -1 * B.value )
                      END
                    ) AS sum
           FROM finOperation A
     INNER JOIN finEntry B
             ON ( A.operationId = B.operationId )
          WHERE B.invoiceId = $1 ) entries,

       ( SELECT ( SUM ( CASE WHEN $2 = true  THEN ( D.totalValue )
                             WHEN $2 = false THEN ( 0 )
                        END 
                      ) / ( SELECT CASE WHEN count(*) > 0 THEN count(*)
                                        ELSE 1
                                   END
                             FROM finCheckInvoice 
                            WHERE checkId IN ( SELECT checkId
                                                 FROM finCheckInvoice 
                                                WHERE invoiceId = $1 ) ) ) AS sum
           FROM finCheckInvoice C
     INNER JOIN finCheck D
             ON (     D.checkId = C.checkId
                  AND D.status = \'C\'
                  AND D.downDate IS NULL )
          WHERE C.invoiceId = $1 ) checks
' LANGUAGE 'sql';
-----------------------------------------------------------------------
-- --
-- Purpose: Função que retorna o nome da pessoa (utilizado para aumentar
--          o desempenho de busca de dados
--
-- -- 
-----------------------------------------------------------------------
CREATE OR REPLACE FUNCTION getPersonName(INT) RETURNS VARCHAR AS '
   SELECT name 
FROM ONLY basPerson
    WHERE personId = $1 
' LANGUAGE 'sql';

-----------------------------------------------------------------------
-- --
-- Purpose: Função que retorna o endereço da pessoa (utilizado para aumentar
--          o desempenho de busca de dados
--
-- -- 
-----------------------------------------------------------------------
CREATE OR REPLACE FUNCTION getPersonAddress(INT) RETURNS VARCHAR AS '
SELECT A.location || \' - \' ||
       A.complement || \' - \' ||
       A.neighborhood || \' - \' ||
       B.name || \' - \' ||
       B.stateId
FROM ONLY basPerson A
     LEFT JOIN basCity B
          USING(cityId)
WHERE personId = $1
' LANGUAGE 'sql';

-----------------------------------------------------------------------
-- --
-- Purpose: Função que retorna determinado documento de uma pessoa 
-- -- 
-----------------------------------------------------------------------
CREATE OR REPLACE FUNCTION getPersonDocument(INT, INT) RETURNS VARCHAR AS '
SELECT content 
  FROM basDocument
 WHERE personId = $1
   AND documentTypeId = $2
' LANGUAGE 'sql';

-----------------------------------------------------------------------
-- --
-- Purpose: Função que retorna a nota de uma prova do vestibular
--
-- -- 
-----------------------------------------------------------------------
CREATE OR REPLACE FUNCTION getExamNote(INT, INT) RETURNS FLOAT8 AS '
   SELECT note 
FROM ONLY sprNote
    WHERE inscriptionId = $1
      AND examOccurrenceId = $2
' LANGUAGE 'sql';


-----------------------------------------------------------------------
-- --
-- Purpose: Função para retornar o número de dias ao qual um título em 
-- aberto está em relação ao dia do pagamento
-- -- 
-----------------------------------------------------------------------
CREATE OR REPLACE FUNCTION updatedTime(int) RETURNS varchar AS '
SELECT CASE WHEN balance($1) = 0
            THEN \'(x)\'
            ELSE EXTRACT(DAY FROM (NOW() - (SELECT maturityDate 
                                              FROM finReceivableInvoice
                                             WHERE invoiceId = $1)
                                  )
                        )::varchar
            END '
LANGUAGE SQL;

-----------------------------------------------------------------------
-- --
-- Purpose: Função que retorna o valor atualizado conforme políticas   
-- estabelecidas na finPolicy  (parâmetro: invoiceId)
-- -- 
-----------------------------------------------------------------------
CREATE OR REPLACE FUNCTION balanceWithPolicies(int) RETURNS numeric AS $$
DECLARE 
    policyInfo RECORD; 
    invoiceInfo RECORD; 
    balance float; 
    balanceInvoice float;
BEGIN
    SELECT INTO policyInfo *
           FROM finPolicy
          WHERE policyId = (SELECT policyId
                              FROM ONLY finInvoice
                             WHERE invoiceId = $1 );

    SELECT INTO invoiceInfo *
           FROM ONLY finReceivableInvoice
          WHERE invoiceId = $1;
    SELECT INTO balance SUM( CASE WHEN A.operationTypeId = 'D' THEN ( 1 * B.value ) WHEN A.operationTypeId = 'C' THEN ( -1 * B.value ) END)
           FROM finOperation A, finEntry B
          WHERE A.operationId = B.operationId
            AND B.invoiceId = $1;

     SELECT INTO balanceInvoice
            CASE WHEN balance = 0
                 THEN 0::numeric

                 WHEN now()::date <= invoiceInfo.maturityDate
                 THEN (balance*((100-policyInfo.discountPercent)/100))::numeric

                 WHEN now()::date <= (invoiceInfo.maturityDate+(policyInfo.daysToInterest||' day')::interval)::date
                 THEN balance::numeric
                 WHEN now()::date > (invoiceInfo.maturityDate+(policyInfo.daysToInterest||'day ')::interval)::date
                 THEN CASE WHEN policyInfo.daysToFine > 0
                           THEN balance +
                                (
                                    (balance * (policyInfo.monthlyInterestPercent/100)) +
                                    (balance *
                                        (
                                            (
                                                (policyInfo.finePercent/30) *
                                                 EXTRACT
                                                 (DAY FROM
                                                    (now()::date -
                                                        (invoiceInfo.maturityDate -
                                                            (
                                                                (policyInfo.daysTointerest-policyInfo.daysToFine)||' day'
                                                            )::interval
                                                        )
                                                    )
                                               )::int
                                            )/100
                                        )
                                    )
                                )
                           ELSE balance +
                                (
                                    (balance * (policyInfo.monthlyInterestPercent/100)) +
                                    (balance *
                                        (
                                            (
                                                (policyInfo.finePercent/30) *
                                                 EXTRACT
                                                 (DAY FROM
                                                    (now()::date -
                                                        (invoiceInfo.maturityDate -
                                                            (
                                                                (policyInfo.daysTointerest)||' day'
                                                            )::interval
                                                        )
                                                    )
                                               )::int
                                            )/100
                                        )
                                    )
                                )
                            END
           END;
    RETURN balanceInvoice;
END
$$ LANGUAGE plpgsql;

-----------------------------------------------------------------------
-- --
-- Purpose: Função que retorna o valor atualizado conforme políticas   
-- estabelecidas na finPolicy  (parâmetro: invoiceId)
-- Se o segunto parâmetro for true, analiza também os cheques
-- -- 
-----------------------------------------------------------------------
CREATE OR REPLACE FUNCTION balanceWithPolicies(int, boolean) RETURNS numeric AS $$
DECLARE 
    policyInfo RECORD; 
    invoiceInfo RECORD; 
    balance float; 
    balanceInvoice float;
BEGIN
    SELECT INTO policyInfo *
           FROM finPolicy
          WHERE policyId = (SELECT policyId
                              FROM ONLY finInvoice
                             WHERE invoiceId = $1 );

    SELECT INTO invoiceInfo *
           FROM ONLY finReceivableInvoice
          WHERE invoiceId = $1;

    SELECT INTO balance ( CASE WHEN checks.sum > 0 
                               THEN entries.sum - checks.sum 
                               ELSE entries.sum
                           END )
                   FROM 
                        ( SELECT SUM ( CASE WHEN A.operationTypeId = 'D' THEN ( 1 * B.value ) 
                                            WHEN A.operationTypeId = 'C' THEN ( -1 * B.value )
                                       END
                                     ) AS sum
                            FROM finOperation A
                      INNER JOIN finEntry B
                              ON ( A.operationId = B.operationId )
                           WHERE B.invoiceId = $1 ) entries,

                        ( SELECT ( SUM ( CASE WHEN $2 = true  THEN ( D.totalValue )
                                              WHEN $2 = false THEN ( 0 )
                                         END 
                                       ) / ( SELECT CASE WHEN count(*) > 0 THEN count(*)
                                                         ELSE 1
                                                    END
                                              FROM finCheckInvoice 
                                             WHERE checkId IN ( SELECT checkId
                                                                  FROM finCheckInvoice 
                                                                 WHERE invoiceId = $1 ) ) ) AS sum
                            FROM finCheckInvoice C
                      INNER JOIN finCheck D
                              ON (     D.checkId = C.checkId
                                   AND D.status = 'C'
                                   AND D.downDate IS NULL )
                           WHERE C.invoiceId = $1 ) checks;

     SELECT INTO balanceInvoice
            CASE WHEN balance = 0
                 THEN 0::numeric

                 WHEN now()::date <= invoiceInfo.maturityDate
                 THEN (balance*((100-policyInfo.discountPercent)/100))::numeric

                 WHEN now()::date <= (invoiceInfo.maturityDate+(policyInfo.daysToInterest||' day')::interval)::date
                 THEN balance::numeric
                 WHEN now()::date > (invoiceInfo.maturityDate+(policyInfo.daysToInterest||'day ')::interval)::date
                 THEN CASE WHEN policyInfo.daysToFine > 0
                           THEN balance +
                                (
                                    (balance * (policyInfo.monthlyInterestPercent/100)) +
                                    (balance *
                                        (
                                            (
                                                (policyInfo.finePercent/30) *
                                                 EXTRACT
                                                 (DAY FROM
                                                    (now()::date -
                                                        (invoiceInfo.maturityDate -
                                                            (
                                                                (policyInfo.daysTointerest-policyInfo.daysToFine)||' day'
                                                            )::interval
                                                        )
                                                    )
                                               )::int
                                            )/100
                                        )
                                    )
                                )
                           ELSE balance +
                                (
                                    (balance * (policyInfo.monthlyInterestPercent/100)) +
                                    (balance *
                                        (
                                            (
                                                (policyInfo.finePercent/30) *
                                                 EXTRACT
                                                 (DAY FROM
                                                    (now()::date -
                                                        (invoiceInfo.maturityDate -
                                                            (
                                                                (policyInfo.daysTointerest)||' day'
                                                            )::interval
                                                        )
                                                    )
                                               )::int
                                            )/100
                                        )
                                    )
                                )
                            END
           END;
    RETURN balanceInvoice;
END
$$ LANGUAGE plpgsql;

-----------------------------------------------------------------------
-- --
-- Purpose: Retorna saldo baseado em data especificada na function
-- -- 
-----------------------------------------------------------------------
CREATE OR REPLACE FUNCTION balanceWithPoliciesDated(int, date) RETURNS numeric AS
$$
DECLARE
    policyInfo RECORD;
    invoiceInfo RECORD;
    balance float;
    balanceInvoice float;
BEGIN
    SELECT INTO policyInfo *
           FROM finPolicy
          WHERE policyId = (SELECT policyId
                              FROM ONLY finInvoice
                             WHERE invoiceId = $1 );

    SELECT INTO invoiceInfo *
           FROM ONLY finReceivableInvoice
          WHERE invoiceId = $1;
    SELECT INTO balance SUM( CASE WHEN A.operationTypeId = 'D' THEN ( 1 * B.value ) WHEN A.operationTypeId = 'C' THEN ( -1 * B.value ) END)
           FROM finOperation A, finEntry B
          WHERE A.operationId = B.operationId
            AND B.invoiceId = $1;

     SELECT INTO balanceInvoice
            CASE WHEN balance = 0
                 THEN 0::numeric
                 WHEN $2::date <= invoiceInfo.maturityDate
                 THEN (balance*((100-policyInfo.discountPercent)/100))::numeric

                 WHEN $2::date <= (invoiceInfo.maturityDate+(policyInfo.daysToInterest||' day')::interval)::date
                 THEN balance::numeric
                 WHEN $2::date > (invoiceInfo.maturityDate+(policyInfo.daysToInterest||'day ')::interval)::date
                 THEN CASE WHEN policyInfo.daysToFine > 0
                           THEN balance +
                                (
                                    (balance * (policyInfo.monthlyInterestPercent/100)) +
                                    (balance *
                                        (
                                            (
                                                (policyInfo.finePercent/30) *
                                                 EXTRACT
                                                 (DAY FROM
                                                    ($2::date -
                                                        (invoiceInfo.maturityDate -
                                                            (
                                                                (policyInfo.daysTointerest-policyInfo.daysToFine)||' day'
                                                            )::interval
                                                        )
                                                    )
                                               )::int
                                            )/100
                                        )
                                    )
                                )
                           ELSE balance +
                                (
                                    (balance * (policyInfo.monthlyInterestPercent/100)) +
                                    (balance *
                                        (
                                            (
                                                (policyInfo.finePercent/30) *
                                                 EXTRACT
                                                 (DAY FROM
                                                    ($2::date -
                                                        (invoiceInfo.maturityDate -
                                                            (
                                                                (policyInfo.daysTointerest)||' day'
                                                            )::interval
                                                        )
                                                    )
                                               )::int
                                            )/100
                                        )
                                    )
                                )
                            END
           END;
    RETURN balanceInvoice;
END
$$ LANGUAGE plpgsql;

-----------------------------------------------------------------------
-- --
-- Purpose: Função que retorna a idade da pessoa em anos
-- -- 
-----------------------------------------------------------------------
CREATE OR REPLACE FUNCTION getPhysicalPersonAge(INTEGER) RETURNS INTEGER AS '
     SELECT extract(year FROM age(date(now()), dateBirth))::INT
  FROM ONLY basPhysicalPerson
      WHERE personId = $1
' LANGUAGE 'sql';

-----------------------------------------------------------------------
-- --
-- Purpose: Retorna o código do período anterior de um determinado 
--          período letivo
-- -- 
-----------------------------------------------------------------------
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

-----------------------------------------------------------------------
-- --
-- Purpose: Retorna o código do período letivo anterior de um
--          determinado período letivo
-- -- 
-----------------------------------------------------------------------

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

-----------------------------------------------------------------------
-- --
-- Purpose: Retorna várias datas concatenado com o dia da semana
-- dentro de um intervalo especificado
-- --
-----------------------------------------------------------------------

CREATE OR REPLACE FUNCTION getDateIntervalWeek (beginDate varchar, endDate varchar, dateMask varchar) RETURNS SETOF varchar AS $end$

DECLARE
    count integer;

BEGIN
    count:= TO_DATE(endDate,dateMask) - TO_DATE(beginDate,dateMask);

    WHILE (count>=0)
    LOOP
          RETURN NEXT (TO_CHAR((TO_DATE(endDate,dateMask) - count),dateMask) || ';' || extract ( DOW FROM TO_DATE(endDate,dateMask) - count ) );
          count:=count-1;
    END LOOP;
    RETURN;
END;
$end$
LANGUAGE 'plpgsql' STABLE;

-- Uses example:
--SELECT * from getDateIntervalWeek ('01/01/2006','20/01/2006','dd/mm/yyyy');
-- getdateintervalweek
-----------------------
-- 10/01/2006;2
-- 11/01/2006;3
-- 12/01/2006;4
-- 13/01/2006;5
-- 14/01/2006;6
-- 15/01/2006;0
-- 16/01/2006;1
-- 17/01/2006;2
-- 18/01/2006;3
-- 19/01/2006;4
-- 20/01/2006;5
--(11 rows)


-----------------------------------------------------------------------
-- --
-- Purpose: Retorna um intervalo de datas
-- --
-----------------------------------------------------------------------
CREATE OR REPLACE FUNCTION getDateInterval (beginDate varchar, endDate
varchar, maskDate varchar) RETURNS SETOF varchar AS $end$

DECLARE
    count integer;

BEGIN
    count:= TO_DATE(endDate,maskDate) - TO_DATE(beginDate,maskDate);

    WHILE (count>=0)
    LOOP
          RETURN NEXT (TO_CHAR(( TO_DATE(endDate,maskDate) - count ),
maskDate));
          count:=count-1;
    END LOOP;
    RETURN;
END;
$end$
LANGUAGE 'plpgsql' STABLE;

-- Uses exemple:
-- -- SELECT * FROM getDateInterval('01/01/2006', '10/01/2006', 'dd/mm/yyyy'); -- getdateinterval ------------------- -- 01/01/2006 -- 02/01/2006 -- 03/01/2006 -- 04/01/2006 -- 05/01/2006 -- 06/01/2006 -- 07/01/2006 -- 08/01/2006 -- 09/01/2006 -- 10/01/2006 --(10 rows) 


-----------------------------------------------------------------------
-- --
-- Purpose: Testa se a primeira data está dentro do intervalo 
-- especificado pelas outras duas datas
-- --
-----------------------------------------------------------------------
CREATE OR REPLACE FUNCTION isBetweenDates(mainDate varchar, firstDate varchar, secondDate varchar, dateMask varchar) RETURNS boolean AS $end$

DECLARE
    result1 date;
    result2 date;
    result3 date;

BEGIN
          SELECT INTO result1 TO_DATE(mainDate,  dateMask);
          SELECT INTO result2 TO_DATE(firstDate, dateMask);
          SELECT INTO result3 TO_DATE(secondDate,dateMask);
          
          IF result1 >= result2 AND result1 <= result3
          THEN
              RETURN TRUE;
          END IF;
    RETURN FALSE;
END;
$end$
LANGUAGE 'plpgsql' STABLE;

--- Uses example:
--sagu2=# SELECT isBetweenDates('10/04/2005','01/01/2005','06/06/2005','dd/mm/yyyy');
-- isbetweendates
------------------
-- t
--(1 row)
--
--sagu2=# SELECT isBetweenDates('10/07/2005','01/01/2005','06/06/2005','dd/mm/yyyy');
-- isbetweendates
------------------
-- f
--(1 row)

-----------------------------------------------------------------------
-- --
-- Purpose: Função que retorna o número de parcelas restantes
--          nas previsões
--
-- -- 
-----------------------------------------------------------------------
CREATE OR REPLACE FUNCTION getRestantParcels(INT) RETURNS BIGINT AS '
   SELECT count(months) 
     FROM (SELECT DISTINCT EXTRACT(MONTH FROM maturitydate) as months 
                      FROM finincomeforecast 
                     WHERE contractid = $1 
                       AND isprocessed = false) AS sel 
' LANGUAGE 'sql';

-----------------------------------------------------------------------
-- --
-- Purpose: Função que retorna as datas para pagamento de parcelas
--          incrementando um mes a cada parcela
--
-- --
-----------------------------------------------------------------------
CREATE OR REPLACE FUNCTION getParcelsDates (beginDate varchar, months integer, dateMask varchar) RETURNS SETOF varchar AS $end$

DECLARE
    count integer;
    plus interval;

BEGIN
    count:= 0;
    WHILE (count<months)
    LOOP  
          plus:= '' || count || ' month';
          RETURN NEXT  TO_CHAR((TO_DATE(beginDate,dateMask) + plus)::DATE, dateMask);
          count:=count+1;
    END LOOP;
    RETURN;
END;
$end$
LANGUAGE 'plpgsql' STABLE;

-- Usage example
-- Parameters: Initial date, number of parcels, mask date
--SELECT * from getParcelsDates ('30/10/2005', 6, 'dd/mm/yyyy');
-- getparcelsdates
-------------------
-- 30/10/2005
-- 30/11/2005
-- 30/12/2005
-- 30/01/2006
-- 28/02/2006
-- 30/03/2006
--(6 registros)
--

-----------------------------------------------------------------------
-- --
-- Purpose: Função que retorna true ou false, conforme a última 
--          movimentação contratual do de um determinado contrato
--
-- --
-----------------------------------------------------------------------
CREATE OR REPLACE FUNCTION isContractOut(_contractId int) RETURNS boolean AS $end$

DECLARE
    result1 int;
    result2 boolean;

BEGIN
    result2 = false;

    SELECT INTO result1 stateContractId 
           FROM acdMovementContract 
          WHERE contractId = _contractId
       ORDER BY stateTime DESC
          LIMIT 1;

    IF result1 > 0
        THEN
            SELECT INTO result2 isCloseContract
                   FROM acdStateContract
                  WHERE inOutTransition = 'O'
                    AND stateContractid = result1;

            IF result2 = true
                THEN
                    RETURN TRUE;
                END IF;

            SELECT INTO result2 isCloseContract
                   FROM acdStateContract
                  WHERE inOutTransition = 'T'
                    AND stateContractid = result1;
            IF result2 = true
                THEN
                    RETURN TRUE;
                END IF;
        END IF;

    RETURN FALSE;
END;
$end$
LANGUAGE 'plpgsql' STABLE;

-----------------------------------------------------------------------
-- --
-- Purpose: Função que retorna o código do aluno de um contrato 
--
-- --
-----------------------------------------------------------------------
CREATE OR REPLACE FUNCTION getContractPersonId( "contractId" INT ) RETURNS INT AS '
  SELECT personId FROM acdContract WHERE contractId = $1 
' LANGUAGE 'sql';

-----------------------------------------------------------------------
-- --
-- Purpose: Função que retorna o código do curso de um contrato 
--
-- --
-----------------------------------------------------------------------
CREATE OR REPLACE FUNCTION getContractCourseId( "contractId" INT ) RETURNS varchar AS '
  SELECT courseId FROM acdContract WHERE contractId = $1 
' LANGUAGE 'sql';

-----------------------------------------------------------------------
-- --
-- Purpose: Função que retorna o código da unidade de um contrato 
--
-- --
-----------------------------------------------------------------------
CREATE OR REPLACE FUNCTION getContractUnitId( "contractId" INT ) RETURNS int AS '
  SELECT unitId FROM acdContract WHERE contractId = $1 
' LANGUAGE 'sql';

-----------------------------------------------------------------------
-- --
-- Purpose: Função que retorna o código da unidade de um contrato 
--
-- --
-----------------------------------------------------------------------
CREATE OR REPLACE FUNCTION getContractCourseVersion( "contractId" INT ) RETURNS int AS '
  SELECT courseVersion FROM acdContract WHERE contractId = $1 
' LANGUAGE 'sql';

-----------------------------------------------------------------------
-- --
-- Purpose: Função que retorna o estado atual de um contrato 
--
-- --
-----------------------------------------------------------------------
CREATE OR REPLACE FUNCTION getContractState(_contractId int) RETURNS int AS $end$

DECLARE
    result1 int;

BEGIN

    SELECT INTO result1 stateContractId 
           FROM acdMovementContract 
          WHERE contractId = _contractId
       ORDER BY stateTime DESC
          LIMIT 1;

    RETURN result1;
END;
$end$
LANGUAGE 'plpgsql' STABLE;

-----------------------------------------------------------------------
-- --
-- Purpose: Função que retorna o estado de um contrato no período entre duas datas 
--
-- --
-----------------------------------------------------------------------
CREATE OR REPLACE FUNCTION getContractStateBetweenDates(_contractId int, beginDate date, endDate date) RETURNS int AS $end$

DECLARE
    result1 int;

BEGIN

    SELECT INTO result1 stateContractId 
           FROM acdMovementContract 
          WHERE contractId = _contractId
            AND stateTime >= beginDate
            AND stateTime <= endDate
       ORDER BY stateTime DESC
          LIMIT 1;

    RETURN result1;
END;
$end$
LANGUAGE 'plpgsql' STABLE;

-----------------------------------------------------------------------
-- --
-- Purpose: Função que retorna a data de ativação de um contrato 
--
-- --
-----------------------------------------------------------------------
DROP FUNCTION IF EXISTS getContractActivationDate(_contractId int);
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

-----------------------------------------------------------------------
-- --
-- Purpose: Função que retorna o estado da primeira movimentacao contratual
--
-- --
-----------------------------------------------------------------------
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

-----------------------------------------------------------------------
-- --
-- Purpose: Função que retorna a data de desativação de um contrato 
--
-- --
-----------------------------------------------------------------------
DROP FUNCTION IF EXISTS getContractDisactivationDate(_contractId int);
CREATE OR REPLACE FUNCTION getContractDisactivationDate(_contractId acdContract.contractId%TYPE) RETURNS acdMovementContract.stateTime%TYPE AS $end$

DECLARE
    result1 RECORD;
    result2 boolean;

BEGIN
    SELECT INTO result1 stateContractId, stateTime
           FROM acdMovementContract 
          WHERE contractId = _contractId
       ORDER BY acdMovementContract.stateTime DESC
          LIMIT 1;

    IF result1.stateContractId > 0
        THEN
            SELECT INTO result2 isCloseContract
                   FROM acdStateContract
                  WHERE inOutTransition <> 'I'
                    AND stateContractId NOT IN (4, 6, 8, 10)
                    AND stateContractid = result1.stateContractId;
            IF result2 = true
            THEN
                RETURN result1.stateTime;
            END IF;
        END IF;

    RETURN NULL;
END;
$end$
LANGUAGE 'plpgsql' STABLE;

-----------------------------------------------------------------------
-- --
-- Purpose: Função que retorna o código da razão de desativação de um contrato 
--
-- --
-----------------------------------------------------------------------
CREATE OR REPLACE FUNCTION getContractDisactivationReasonId(_contractId int) RETURNS varchar AS $end$

DECLARE
    result1 RECORD;
    result2 boolean;
    result3 varchar;

BEGIN
    SELECT INTO result1 stateContractId, reasonId 
           FROM acdMovementContract 
          WHERE contractId = _contractId
       ORDER BY acdMovementContract.stateTime DESC
          LIMIT 1;

    IF result1.stateContractId > 0
        THEN
            SELECT INTO result2 isCloseContract
                   FROM acdStateContract
                  WHERE inOutTransition <> 'I'
                    AND stateContractId NOT IN (4, 6, 8, 10)
                    AND stateContractid = result1.stateContractId;
            
            IF result2 = true
                THEN
                    RETURN result1.reasonId;
            END IF;
        END IF;

    RETURN '';
END;
$end$
LANGUAGE 'plpgsql' STABLE;

-----------------------------------------------------------------------
-- --
-- Purpose: Função que retorna o número de discplinas de um determinado contrato 
--          com os status desejados
-- --
-----------------------------------------------------------------------
CREATE OR REPLACE FUNCTION getContractCurricularComponents(_contractId int, _curriculumTypeId int[], _statusId int[]) RETURNS int AS $end$

DECLARE
    result1 int;

BEGIN
    SELECT INTO result1 count(*) 
           FROM acdEnroll A
     INNER JOIN acdCurriculum B
             ON (B.curriculumId = A.curriculumId)
     INNER JOIN acdContract C
             ON (C.contractId = A.contractId)
          WHERE C.contractId = _contractId
            AND C.courseId = B.courseId
            AND C.courseVersion = B.courseVersion
            AND C.unitId = B.unitId
            AND C.turnId = B.turnId
            AND B.curriculumTypeId = ANY (_curriculumTypeId)
            AND A.statusId = ANY (_statusId);

    RETURN result1;
END;
$end$
LANGUAGE 'plpgsql';

-----------------------------------------------------------------------
-- --
-- Purpose: Retorna a cidade de expedição de um determinado documento
--          de uma pessoa
-- --
-----------------------------------------------------------------------
CREATE OR REPLACE FUNCTION getpersondocumentcity(int4, int4) RETURNS "int4" AS '
SELECT cityId
  FROM basDocument
 WHERE personId = $1
   AND documentTypeId = $2 '
  LANGUAGE 'sql';

-----------------------------------------------------------------------
-- --
-- Purpose: Retorna a data de expedição de um determinado documento
--          de uma pessoa
-- --
-----------------------------------------------------------------------
CREATE OR REPLACE FUNCTION getpersondocumentdateexpedition(int4, int4) RETURNS "date" AS '
SELECT dateExpedition
  FROM basDocument
 WHERE personId = $1
   AND documentTypeId = $2 '
  LANGUAGE 'sql';

-----------------------------------------------------------------------
-- --
-- Purpose: Retorna o orgao de expedição de um determinado documento
--          de uma pessoa
-- --
-----------------------------------------------------------------------
CREATE OR REPLACE FUNCTION getpersondocumentorgan(int4, int4) RETURNS "varchar" AS '
SELECT organ
  FROM basDocument
 WHERE personId = $1
   AND documentTypeId = $2 '
  LANGUAGE 'sql';


-----------------------------------------------------------------------
-- --
-- Purpose: Retorna o caracter que identifica um turno
-- --
-----------------------------------------------------------------------
CREATE OR REPLACE FUNCTION getturncharid(int4) RETURNS character AS ' SELECT charid
  FROM basTurn
 WHERE turnId = $1'
  LANGUAGE 'sql';

-----------------------------------------------------------------------
-- --
-- Purpose: Retorna a descrição da origem
-- --
-----------------------------------------------------------------------
CREATE OR REPLACE FUNCTION getIncomeSourceDescription(int4) RETURNS varchar AS 
'
 SELECT description 
   FROM finIncomeSource
  WHERE incomeSourceId = $1 '
 LANGUAGE 'sql';

-----------------------------------------------------------------------
-- --
-- Purpose: Retorna o código do tipo de collection
-- --
-----------------------------------------------------------------------
CREATE FUNCTION getCollectionTypeDescription(int) RETURNS VARCHAR AS 
'
 SELECT description
   FROM finCollectionType
  WHERE collectionTypeId = $1'
 LANGUAGE 'sql';

-----------------------------------------------------------------------
-- --
-- Purpose: Retorna a descrição das origens
-- --
-----------------------------------------------------------------------
CREATE OR REPLACE FUNCTION getIncomeSourceDescription(int4) RETURNS varchar AS 
'
 SELECT description 
   FROM finIncomeSource
  WHERE incomeSourceId = $1 '
 LANGUAGE 'sql';

-----------------------------------------------------------------------
-- --
-- Purpose: Retorna o semestre ou ano de uma turma que é passada como
--          parâmetro, com o período letivo inicial dela. É uma função
--          recursiva de busca. Se não encontrar, retorna 0 (zero)
-- -- 
-----------------------------------------------------------------------
CREATE OR REPLACE FUNCTION getClassPeriod(_classId varchar(20), _learningPeriodId int) RETURNS int AS $end$

DECLARE
    result  RECORD;
    result2 RECORD;
    initialLearningPeriodId_ int;
    learningPeriodId_ int;
    cont_ int;

BEGIN
    learningPeriodId_ = _learningPeriodId;
    cont_             = 0;

    SELECT INTO result initialLearningPeriodId
           FROM acdClass
          WHERE classId = _classId;
    initialLearningPeriodId_ = result.initialLearningPeriodId;

    cont_ := (cont_ + 1);
    IF initialLearningPeriodId_ = learningPeriodId_
        THEN
            RETURN cont_;
        END IF;

    LOOP
        cont_ := (cont_ + 1);
        SELECT INTO result2 previousLearningPeriodId
               FROM acdLearningPeriod
              WHERE learningPeriodId = learningPeriodId_;
        learningPeriodId_ = result2.previousLearningPeriodId;

        IF initialLearningPeriodId_ = learningPeriodId_
            THEN
                RETURN cont_;
            END IF;

        IF learningPeriodId_ IS NULL
            THEN
                RETURN 0;
            END IF;

        END LOOP;

    RETURN 0;
END;
$end$
LANGUAGE 'plpgsql' STABLE;


--
-- Name: getstatescontractfromcontracttoenrollbookrules(integer, character varying); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION getstatescontractfromcontracttoenrollbookrules(integer, character varying) RETURNS integer[]
    AS $_$

DECLARE
    result1 RECORD;
    result2 integer[];
    --str     text;
    --str_aux text;
    x       integer;

BEGIN
    x = 0;
    --str     := '';
    --str_aux := '{';
    --str_aux := '';


    FOR result1 IN SELECT A.stateContractId 
                     FROM acdMovementContract A
               INNER JOIN acdContract B
                       ON (A.contractId = B.contractId)
               INNER JOIN acdLearningPeriod C
                       ON (C.courseId      = B.courseId AND
                           C.courseVersion = B.courseVersion AND
                           C.unitId        = B.unitId AND
                           C.turnId        = B.turnId)
                    WHERE A.contractId = $1--152373--$1
                      AND C.periodId   = $2--'2006B'--$2
                      AND A.stateTime BETWEEN C.beginDate AND C.endDate
                 ORDER BY A.stateTime DESC

    LOOP  
          result2[x] = result1.stateContractID;
	  x = x + 1;
          --result2 := result1.stateContractId;

          --str     := str_aux || result1.stateContractId;
          --str_aux := str     || ',';

    END LOOP;

     --     str_aux := str;
     --     str     := str || '}';

     --str := str || '}';


    --RETURN result2;
    --str := str || '}';

    RETURN result2[0:x];

END;
$_$
    LANGUAGE plpgsql STABLE;


ALTER FUNCTION public.getstatescontractfromcontracttoenrollbookrules(integer, character varying) OWNER TO postgres;


--
-- Name: getstatescontractfromcontracttoenrollbookrules(integer, timestamp without time zone, character varying); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION getstatescontractfromcontracttoenrollbookrules(integer, timestamp without time zone, character varying) RETURNS text
    AS $_$

DECLARE
    result1 RECORD;
    str     text;
    str_aux text;

BEGIN
    str     := '';
    str_aux := '';

    FOR result1 IN SELECT A.stateContractId 
                     FROM acdMovementContract A
               INNER JOIN acdContract B
                       ON (A.contractId = B.contractId)
               INNER JOIN acdLearningPeriod C
                       ON (C.courseId      = B.courseId AND
                           C.courseVersion = B.courseVersion AND
                           C.unitId        = B.unitId AND
                           C.turnId        = B.turnId)
                    WHERE A.stateTime  = $2
                      AND A.contractId = $1
                      AND C.periodId   = $3
                 ORDER BY A.stateTime DESC

    LOOP  
          str     := str_aux || result1.stateContractId;
          str_aux := str     || ',';
    END LOOP;

    RETURN str;

END;
$_$
    LANGUAGE plpgsql STABLE;


ALTER FUNCTION public.getstatescontractfromcontracttoenrollbookrules(integer, timestamp without time zone, character varying) OWNER TO postgres;

----------------------------------------------------------------------
-- --
-- Purpose: Validate a price for insert or delete on finPrice table
-- 2008-06-30
-- gmurilo
-- --
----------------------------------------------------------------------
CREATE OR REPLACE FUNCTION validatePrice() RETURNS trigger AS $stat$
DECLARE
    priceData  RECORD;
    stat_ BOOLEAN;

BEGIN
        FOR priceData IN SELECT startDate, endDate FROM finPrice WHERE learningPeriodId = NEW.learningPeriodId LOOP
            IF (NEW.startDate, NEW.endDate) OVERLAPS (priceData.startDate, priceData.endDate) THEN
                RAISE EXCEPTION 'Date periods must be different than all registers for that learning period';
            END IF;
        END LOOP;
        RETURN NEW;
END
$stat$  LANGUAGE plpgsql;

--
-- NAME: Create the trigger for price validation
--
CREATE TRIGGER finPrice_validateDate BEFORE UPDATE OR INSERT ON finPrice FOR EACH ROW EXECUTE PROCEDURE validatePrice();

CREATE OR REPLACE FUNCTION UpdateOrInsertFrequenceEnroll(var_username baslog.username%TYPE, var_ipaddress baslog.ipaddress%TYPE, var_enrollid acdfrequenceenroll.enrollid%TYPE, var_scheduleid acdfrequenceenroll.scheduleId%TYPE, var_frequencydate acdfrequenceenroll.frequencydate%TYPE, var_turnid acdfrequenceenroll.turnid%TYPE, var_frequency acdfrequenceenroll.frequency%TYPE) RETURNS boolean AS $end$


BEGIN

    UPDATE acdFrequenceEnroll
        SET frequency     = var_frequency
        WHERE enrollid    = var_enrollid AND
            scheduleid    = var_scheduleId AND
            frequencydate = var_frequencydate AND
            turnId        = var_turnId;

    IF FOUND THEN

        RETURN TRUE;

    END IF;
    
    INSERT INTO acdfrequenceenroll
           (username,
           ipaddress,
           enrollid,
           scheduleid,
           frequencydate,
           turnid,
           frequency)
    VALUES (var_username,
           var_ipaddress,
           var_enrollid,
           var_scheduleid,
           var_frequencydate,
           var_turnid,
           var_frequency);
           
    IF FOUND THEN

        RETURN TRUE;

    END IF;

    RETURN FALSE;
END;
$end$
LANGUAGE 'plpgsql' VOLATILE;

-----------------------------------------------------------------------
-- --
-- Purpose: Criação de função para seguir a herança de uma tabela, 
--          utilizada no relatório que gera a descrição da base de
--          dados no módulo de documentação
--
-- --
-----------------------------------------------------------------------
CREATE OR REPLACE FUNCTION inheritanceHierarchy (oid integer) RETURNS SETOF integer AS $end$
DECLARE
    aux integer;
    flag integer;
BEGIN
    aux:=oid;
    select into flag count(inhparent) FROM pg_inherits WHERE inhrelid = aux;
    WHILE (flag>0)
    LOOP
          RETURN NEXT aux;
          SELECT into aux inhparent FROM pg_inherits WHERE inhrelid = aux;
          select into flag count(inhparent) FROM pg_inherits WHERE inhrelid = aux;
    END LOOP;
    RETURN;
END;
$end$
LANGUAGE 'plpgsql' STABLE;

-----------------------------------------------------------------------
-- --
-- Purpose: Função que traz a descrição do setor
--
-- --
-----------------------------------------------------------------------
CREATE OR REPLACE FUNCTION getSectorDescription(int) RETURNS varchar AS '
SELECT description 
  FROM basSector
 WHERE sectorId = $1 
' LANGUAGE SQL;

-----------------------------------------------------------------------
-- --
-- Purpose: Funcao que retorna a data inicial do periodo letivo
--
-- --
-----------------------------------------------------------------------
CREATE OR REPLACE FUNCTION getPeriodBeginDate("periodId" VARCHAR, "courseId" VARCHAR, "courseVersion" INT, "unitId" INT) RETURNS DATE AS '
  SELECT min(beginDate) 
    FROM acdLearningPeriod 
   WHERE periodId = $1 
     AND courseId = $2
     AND courseVersion = $3
     AND unitId = $4
' LANGUAGE 'sql';

-----------------------------------------------------------------------
-- --
-- Purpose: Funcao que retorna a data final do periodo letivo
--
-- --
-----------------------------------------------------------------------
CREATE OR REPLACE FUNCTION getPeriodEndDate("periodId" VARCHAR, "courseId" VARCHAR, "courseVersion" INT, "unitId" INT) RETURNS DATE AS '
  SELECT max(endDate) 
    FROM acdLearningPeriod 
   WHERE periodId = $1 
     AND courseId = $2
     AND courseVersion = $3
     AND unitId = $4
' LANGUAGE 'sql';
