CREATE OR REPLACE FUNCTION vPercent(value float, percent float) RETURNS float AS $$
    SELECT ROUND(($1*($2/100.00))::numeric,2)::float;
$$ LANGUAGE 'sql';

------------------------------------------------------------
-- --
-- Purpose: calcula os dias de incremento para feriados
--          
-- 2008-04-27
-- gmurilo
-- --
-----------------------------------------------------------

CREATE OR REPLACE FUNCTION holidayvalidationdiscount (date, int4) RETURNS int4 AS $$ 
DECLARE
    holidayDate_ DATE;
    daysToDecrease INT;
    inputDate_ DATE;  
BEGIN
    inputDate_      := $1; 
    daysToDecrease  := $2;
    holidayDate_    := $1-$2;
                             
    WHILE ( LENGTH((SELECT holidayDate FROM basHoliday WHERE holidayDate = holidayDate_)::text) > 0 OR  (SELECT date_part('dow',holidayDate_)) IN (0,6) )
    LOOP
        holidayDate_ := holidayDate_+1;
        daysToDecrease := daysToDecrease-1;
    END LOOP; 
    RETURN daysToDecrease; 
END; 
$$
LANGUAGE 'plpgsql';

------------------------------------------------------------
-- --
-- Purpose: Inclusao de funcao balance para calculos com dat
--          Alterada funcoes antigas das balances para usare
--          mesma funcao
-- 2008-03-14
-- gmurilo
-- --
-----------------------------------------------------------

CREATE OR REPLACE FUNCTION balanceNew_(INT, BOOLEAN, Date) RETURNS NUMERIC AS $$
DECLARE mValue numeric;
DECLARE cValue numeric;
DECLARE dateRef date;
DECLARE calcMode boolean;
DECLARE invoiceId_ integer;
BEGIN
dateRef := $3;
calcMode := $2;
invoiceId_ := $1;
SELECT INTO mValue SUM (CASE 
                            WHEN A.operationTypeId = 'D' THEN ( 1 * B.value ) 
                            ELSE ( -1 * B.value ) 
                        END ) 
                        FROM finEntry B 
                        INNER JOIN finOperation A USING (operationId) 
                        WHERE B.invoiceId = invoiceId_ AND B.entryDate <= dateRef;
IF calcMode THEN
    SELECT INTO cValue CASE WHEN count(*) > 0 THEN SUM ( A.value ) ELSE 0 END  FROM finCheckInvoice A INNER JOIN finCheck B ON ( B.status = 'C' AND B.downDate IS NULL AND A.checkID = B.checkId );
    mValue := mValue-cValue;
END IF;

RETURN mValue;
END;
$$ LANGUAGE 'plpgsql';

----------------------------------------------------------------------
-- --
-- Purpose: Problema quanto não era enviado o numero do boleto ou quan
--          do o boleto não existia
-- 2008-12-17
-- gmurilo
-- --
----------------------------------------------------------------------

CREATE OR REPLACE FUNCTION balanceNew(INT, BOOLEAN, DATE) RETURNS NUMERIC AS $$
     DECLARE
         invoiceId_ integer;
         calcMode boolean;
         dateRef date;
         finInvoiceBalance_ RECORD;
     BEGIN
         invoiceId_  := $1;
         calcMode    := $2;
         dateRef     := $3;
         IF NOT dateRef IS NULL THEN
             RETURN balanceNew_(invoiceId_, calcMode, dateRef);
         ELSE
             SELECT INTO finInvoiceBalance_ invoiceId, balance, balanceWithChecks
                 FROM
                     finInvoiceBalance
                 WHERE invoiceId = invoiceId_;
             IF finInvoiceBalance_.invoiceId IS NULL THEN
                 IF invoiceId_ IS NULL THEN
                     RETURN 0;
                 END IF;
                 INSERT INTO finInvoiceBalance (invoiceId, balance, balanceWithChecks) VALUES (invoiceId_, balanceNew_( invoiceId_, FALSE, now()::date ), balanceNew_( invoiceId_, TRUE, now()::date ));
                 RETURN balanceNew_( invoiceId_, calcMode, now()::date );
             ELSIF calcMode THEN
                 RETURN finInvoiceBalance_.balanceWithChecks;
             ELSE
                 RETURN finInvoiceBalance_.balance;
             END IF;
         END IF;
     END;
$$ LANGUAGE 'plpgsql';

----------------------------------------------------------------------
-- --
-- Purpose: alteracoes nas funcoes balances
-- 2008-08-30
-- gmurilo
-- --
----------------------------------------------------------------------

CREATE OR REPLACE FUNCTION balance(INT) RETURNS NUMERIC AS $$
    DECLARE 
        invoiceId_ integer;
    BEGIN
        invoiceId_  := $1;
        RETURN balancenew(invoiceId_, FALSE, NULL);
    END;
$$ LANGUAGE 'plpgsql';

CREATE OR REPLACE FUNCTION balance(INT, BOOLEAN) RETURNS NUMERIC AS $$
    DECLARE 
        invoiceId_ integer;
        calcMode boolean;
    BEGIN
        invoiceId_  := $1;
        calcMode    := $2;
        IF calcMode THEN
            RETURN balancenew(invoiceId_, calcMode, NULL);
        ELSE
            RETURN balancenew(invoiceId_, FALSE, NULL);
        END IF;
    END;
$$ LANGUAGE 'plpgsql';

------------------------------------------------------------
-- Purpose: Alterações balanceWithPolicies, problema com mul
--          ta
-- 2008-05-26
-- gmurilo
-- --
------------------------------------------------------------

CREATE OR REPLACE FUNCTION balanceWithPoliciesNew(int,date,date,boolean) RETURNS numeric AS $$
DECLARE
    policyInfo RECORD; --variavel usada para obter informacoes da politica
    invoiceInfo RECORD; --variavel usada para obter informacoes do titulo
    balance_ numeric; --variavel usada para guardar o valor nominal do titulo
    balanceInvoice numeric; --variavel usada para guardar valor ajustado do titulo
    balanceInvoiceToInterest numeric; --variavel usada para guardar valor que serÃ¡ usado no cÃ¡lculo dos juros
    credits numeric;
    debits numeric;
    initDate date;
    endDate date;
    lastMonthDay date;
    discountDate date;
BEGIN
    --Ajusta informacoes do titulo
    initDate := $3;
    endDate := $2; --maturityDate
    SELECT INTO lastMonthDay TO_DATE('01'||CASE WHEN LENGTH(extract(month from endDate+ interval '1 month')::varchar) = 1 THEN '0'||extract(month from endDate+ interval '1 month')::varchar ELSE extract(month from endDate+ interval '1 month')::varchar END ||extract(year from endDate), 'DDMMYYYY')-1;
    WHILE(SELECT date_part('dow', lastMonthDay) IN (0,6) OR LENGTH((SELECT holidayDate FROM basHoliday WHERE holidayDate = lastMonthDay)::text) > 0)
    LOOP
        lastMonthDay := lastMonthDay +1;
    END LOOP;
    SELECT INTO invoiceInfo *
             FROM ONLY finInvoice
             WHERE
             invoiceId = $1;

    --Ajusta informacoes da politica
    SELECT INTO policyInfo *
            FROM finPolicy
          WHERE
          policyId = (SELECT policyId FROM ONLY finInvoice WHERE invoiceId = $1 );

    --Ajusta valor nominal do titulo (baseado em crÃ©dito/debito)    
    SELECT INTO balance_ balance($1);

    --Inicializa o valor atual sem aplicar nenhuma politica
    --Aplica a taxa do banco ao titulo
    SELECT INTO balanceInvoice 
    (
        (CASE 
            WHEN policyInfo.bankTaxValue > 0 THEN
            (CASE 
                  WHEN NOT policyInfo.isBankTaxValueInPercent THEN (balance_+policyInfo.BankTaxValue)
                  WHEN policyInfo.isBankTaxValueInPercent THEN (balance_+((balance_*policyInfo.BankTaxValue)/100))
             END)
            ELSE balance_
         END)
    );

    --valor do tÃ­tulo sem a multa
    balanceInvoiceToInterest := balanceInvoice;

    --Aplica a multa ao titulo
    SELECT INTO balanceInvoice 
    (
        (CASE 
            WHEN balance($1) = 0 THEN balanceInvoice 
            WHEN (initDate-endDate) > policyInfo.daysToFine   THEN
            (CASE 
                  WHEN NOT policyInfo.isFineInPercent THEN (balance_+policyInfo.fine)
                  WHEN policyInfo.isFineInPercent THEN (balance_+((balance_*policyInfo.fine)/100))
             END)
            ELSE balanceInvoice 
        END)
    );

    --verifica se se o valor para calculo dos juros serÃ¡ sem a multa
    SELECT INTO balanceInvoiceToInterest 
    (
        (CASE
            WHEN policyInfo.isFineInOriginalValue THEN 
                balanceInvoiceToInterest
            ELSE
                balanceInvoice
         END)
    );

    --Aplica os juros ao titulo
    SELECT INTO balanceInvoice 
    (
        --verifica se deve calcular pela data de vencimento
        (CASE WHEN policyInfo.calculateValueWithMaturiyDate THEN 
         
            (CASE 
                WHEN (initDate-endDate) > policyInfo.daystointerest THEN
                (CASE
                    WHEN NOT policyInfo.isMonthlyInterestInPercent THEN
                        balanceInvoice+round((policyInfo.monthlyInterest*(initDate-endDate))::numeric,2)                        
                    WHEN policyInfo.useFineCompositive = TRUE THEN
                        (balanceInvoiceToInterest*((1+((policyInfo.monthlyInterest)::float/100.00))^((initDate-endDate)::float/30.00)))
                    WHEN policyInfo.useFineCompositive = FALSE THEN
                        balanceInvoice+((((balanceInvoiceToInterest/30.00)*policyInfo.monthlyInterest)/100)*(initDate-endDate)::float)
                END)
                ELSE
                balanceInvoice
            END)

        --ou se pela data de vencimento mais os dias de juros
        ELSE

            (CASE 
                WHEN (initDate-endDate) > policyInfo.daystointerest THEN
                (CASE
                    WHEN NOT policyInfo.isMonthlyInterestInPercent THEN
                        balanceInvoice+(policyInfo.monthlyInterest*(initDate-endDate-policyInfo.daysToInterest)::float)
                    WHEN policyInfo.useFineCompositive = TRUE THEN
                        (balanceInvoiceToInterest*((1+((policyInfo.monthlyInterest)::float/100.00))^((initDate-endDate-policyInfo.daysToInterest)::float/30.00)))
                    WHEN policyInfo.useFineCompositive = FALSE THEN
                        balanceInvoice+((((balanceInvoiceToInterest/30.00)*policyInfo.monthlyInterest)/100)*(initDate-endDate-policyInfo.daysToInterest)::float)
                END)
                ELSE
                balanceInvoice
            END)

        END)

    );
   --Subtrai do saldo do titulo o valor do cheque
    SELECT INTO balanceInvoice  ( balanceInvoice  - ( CASE WHEN $4 IS TRUE THEN saldoCheque($1) ELSE 0 END ) );

    SELECT INTO balanceInvoice ( CASE WHEN balanceInvoice IS NULL THEN balance_ ELSE balanceInvoice END );
    discountDate := invoiceInfo.maturityDate-(holidayvalidationdiscount(invoiceInfo.maturityDate,policyInfo.daysToDiscount));
    SELECT INTO balanceInvoice 
    (
        (CASE 
            WHEN (policyInfo.isDiscountAtLastMonthDay) THEN
                CASE 
                    WHEN policyInfo.isDiscountInPercent AND initDate <= lastMonthDay THEN 
                    (balanceInvoice-(balanceInvoice*((policyInfo.discount)::float/100.00)))
                    WHEN NOT policyInfo.isDiscountInPercent AND initDate <= lastMonthDay THEN
                    (balanceInvoice-policyInfo.discount) 
                    ELSE balanceInvoice 
                END
            ELSE
                CASE          
                    WHEN initDate <= discountDate AND balance_ > 0 AND policyInfo.isDiscountInPercent THEN 
                    (balanceInvoice-(balanceInvoice*((policyInfo.discount)::float/100.00)))
                    WHEN initDate <= discountDate AND balance_ > 0 AND NOT policyInfo.isDiscountInPercent THEN
                    (balanceInvoice-policyInfo.discount) 
                    ELSE balanceInvoice 
                END
         END)
    );
    RETURN balanceInvoice;
    END
$$ LANGUAGE plpgsql;  

------------------------------------------------------------
-- --
-- Purpose: atualização das funcoes de balance, para q sejam
--          desconsiderados sabados e domingos e feriados
-- 2008-03-31
-- gmurilo
-- --
-----------------------------------------------------------


CREATE OR REPLACE FUNCTION balanceWithPolicies(int) RETURNS numeric AS $$
DECLARE
    balance_ numeric; --variavel usada para guardar o valor nominal do titulo
    initDate date;
BEGIN
    SELECT INTO initDate ( SELECT ( CASE WHEN tolDate IS NULL THEN maturityDate ELSE ( CASE WHEN tolDate >= now()::date THEN tolDate ELSE maturityDate END ) END  )  FROM ONLY finInvoice WHERE invoiceId = $1 );
    SELECT INTO balance_ ( SELECT balanceWithPoliciesNew($1,initDate,now()::date,false) );
    RETURN balance_;
END
$$ LANGUAGE 'plpgsql';

CREATE OR REPLACE FUNCTION balanceWithPolicies(int, boolean) RETURNS numeric AS $$
DECLARE
    balance_ numeric; --variavel usada para guardar o valor nominal do titulo
    initDate date;
BEGIN
    SELECT INTO initDate ( SELECT ( CASE WHEN tolDate IS NULL THEN maturityDate ELSE ( CASE WHEN tolDate >= now()::date THEN tolDate ELSE maturityDate END ) END  ) FROM ONLY finInvoice WHERE invoiceId = $1 );
    SELECT INTO balance_ ( SELECT balanceWithPoliciesNew($1,initDate,now()::date,$2) );
    RETURN balance_;
END
$$ LANGUAGE 'plpgsql';

CREATE OR REPLACE FUNCTION balanceWithPoliciesDated(int,date) RETURNS numeric AS $$
DECLARE
    balance_ numeric; --variavel usada para guardar o valor nominal do titulo
    initDate date;
BEGIN
    SELECT INTO initDate ( SELECT ( CASE WHEN tolDate IS NULL THEN maturityDate ELSE ( CASE WHEN tolDate >= $2 THEN tolDate ELSE maturityDate END ) END  ) FROM ONLY finInvoice WHERE invoiceId = $1 );
    SELECT INTO balance_ ( SELECT balanceWithPoliciesNew($1,initDate,$2,false) );
    RETURN balance_;        
END
$$ LANGUAGE 'plpgsql';

CREATE OR REPLACE FUNCTION balanceWithPoliciesDated(int, date, boolean) RETURNS numeric AS $$
    SELECT 
        CASE
            WHEN tolDate IS NULL OR tolDate < now()::date THEN 
                balanceWithPoliciesNew(invoiceId, maturityDate, $2, $3)
            ELSE
                balanceWithPoliciesNew(invoiceId, tolDate, $2, $3) 
        END
    FROM ONLY finInvoice WHERE invoiceId = $1;        
$$ LANGUAGE 'SQL';


CREATE OR REPLACE FUNCTION updateFinInvoiceBalance() RETURNS TRIGGER AS $$
    DECLARE
        finInvoiceBalance_ RECORD;
        invoiceId_ INTEGER;
        balance_ numeric;
        balanceWithChecks_ numeric;
        username_ varchar;
        datetime_ timestamp;
        ipaddress_ inet;
    BEGIN
        IF ( TG_OP = 'UPDATE' OR TG_OP = 'DELETE' ) THEN
            invoiceId_          := OLD.invoiceId;
            balance_            := balanceNew(OLD.invoiceId, FALSE, now()::date);
            balanceWithChecks_  := balanceNew(OLD.invoiceId, TRUE, now()::date);
            username_           := OLD.username;
            datetime_           := OLD.datetime;
            ipaddress_          := OLD.ipaddress;
        ELSE
            invoiceId_          := NEW.invoiceId;
            balance_            := balanceNew(NEW.invoiceId, FALSE, now()::date);
            balanceWithChecks_  := balanceNew(NEW.invoiceId, TRUE, now()::date);
            username_           := NEW.username;
            datetime_           := NEW.datetime;
            ipaddress_          := NEW.ipaddress;
        END IF;
        SELECT INTO finInvoiceBalance_ invoiceId FROM ONLY finInvoiceBalance WHERE ( invoiceId = invoiceId_ ) ;
        
        IF finInvoiceBalance_.invoiceId IS NULL THEN
                INSERT INTO
                     finInvoiceBalance
                             (invoiceId,
                             balance,
                             balanceWithChecks,
                             username,
                             datetime,
                             ipaddress)
                     VALUES (invoiceId_,
                             balance_,
                             balanceWithChecks_,
                             username_,
                             datetime_,
                             ipaddress_);
        ELSE
             UPDATE finInvoiceBalance
                 SET
                     balance = balance_ , 
                     balanceWithChecks = balanceWithChecks_
              WHERE invoiceId = invoiceId_;
         END IF;
         IF (TG_OP = 'INSERT' ) THEN
             RETURN NEW;
         ELSE
             RETURN OLD;
         END IF;
 END;
$$ 
LANGUAGE 'plpgsql';
----------------------------------------------------------------------
-- --
-- Purpose: balance aplicando apenas desconto sem multa nem juros
-- 2009-06-12
-- gmurilo
-- --
----------------------------------------------------------------------

         
CREATE OR REPLACE FUNCTION balancerp(int) RETURNS numeric(14,2) as $BODY$
DECLARE      
    policyInfo RECORD; --variavel usada para obter informacoes da politica
    invoiceInfo RECORD; --variavel usada para obter informacoes do titulo
    balance_ numeric; --variavel usada para guardar o valor nominal do titulo
    balanceInvoice numeric; --variavel usada para guardar valor ajustado do titulo
BEGIN               
    --Ajusta informacoes do titulo                    
    SELECT INTO invoiceInfo SUM(A.value) as vP        
          FROM ONLY 
            finEntry A                     
          WHERE  
          A.invoiceId = $1 AND A.operationId IN (SELECT operationId FROM finOperation WHERE operationGroupId = 'N' AND operationtypeid = 'D')
    GROUP BY A.invoiceId;       
                 
    --Ajusta informacoes da politica                  
    SELECT INTO policyInfo *    
         FROM finPolicy      
       WHERE     
       policyId = (SELECT policyId FROM ONLY finInvoice WHERE invoiceId = $1 );
                 
    --Ajusta valor nominal do titulo (baseado em crédito/debito)
    balance_ := invoiceInfo.vP; 
                 
    --Inicializa o valor atual sem aplicar nenhumaa   politica
    --Aplica a taxa do banco ao titulo                
    SELECT INTO balanceInvoice  
    (               
     (CASE       
         WHEN policyInfo.bankTaxValue > 0 THEN     
         (CASE   
               WHEN NOT policyInfo.isBankTaxValueInPercent THEN (balance_+policyInfo.BankTaxValue)
               WHEN policyInfo.isBankTaxValueInPercent THEN (balance_+((balance_*policyInfo.BankTaxValue)/100))
          END)   
         ELSE balance_       
      END)       
    );              
                 
    SELECT INTO balanceInvoice ( CASE WHEN balanceInvoice IS NULL THEN balance_ ELSE balanceInvoice END );
    SELECT INTO balanceInvoice  
    (               
    CASE WHEN policyInfo.isDiscountInPercent THEN    
                 (balanceInvoice-(balanceInvoice*((policyInfo.discount)::float/100.00)))
       WHEN NOT policyInfo.isDiscountInPercent THEN
                 (balanceInvoice-policyInfo.discount)
    END            
    );              
    RETURN balanceInvoice;      
END;             
$BODY$ LANGUAGE 'plpgsql';
