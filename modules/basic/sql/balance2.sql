------------------------------------------------------------
-- Purpose: Altera��es balanceWithPolicies, problema com mul
--          ta
-- 2008-05-26
-- gmurilo
-- --
------------------------------------------------------------

CREATE OR REPLACE FUNCTION balanceWithPoliciesForValue(numeric,date,date,int) RETURNS numeric AS $$
DECLARE
    policyInfo RECORD; --variavel usada para obter informacoes da politica
    invoiceInfo RECORD; --variavel usada para obter informacoes do titulo
    balance_ numeric; --variavel usada para guardar o valor nominal do titulo
    balanceInvoice numeric; --variavel usada para guardar valor ajustado do titulo
    balanceInvoiceToInterest numeric; --variavel usada para guardar valor que será usado no cálculo dos juros
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

    --Ajusta informacoes da politica
    SELECT INTO policyInfo *
            FROM finPolicy
          WHERE
          policyId = $4;

    --Ajusta valor nominal do titulo (baseado em crédito/debito)    
    balance_ := $1;

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

    --valor do título sem a multa
    balanceInvoiceToInterest := balanceInvoice;

    --Aplica a multa ao titulo
    SELECT INTO balanceInvoice 
    (
        (CASE 
            WHEN balance_ = 0 THEN balanceInvoice 
            WHEN (initDate-endDate) > policyInfo.daysToFine   THEN
            (CASE 
                  WHEN NOT policyInfo.isFineInPercent THEN (balance_+policyInfo.fine)
                  WHEN policyInfo.isFineInPercent THEN (balance_+((balance_*policyInfo.fine)/100))
             END)
            ELSE balanceInvoice 
        END)
    );

    --verifica se se o valor para calculo dos juros será sem a multa
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

    SELECT INTO balanceInvoice ( CASE WHEN balanceInvoice IS NULL THEN balance_ ELSE balanceInvoice END );
    discountDate := endDate-(holidayvalidationdiscount(endDate,policyInfo.daysToDiscount));

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
