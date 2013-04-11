--
-- Name: createacademiccalendar(integer, character varying, character varying, inet); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION createacademiccalendar(learningperiodid_ integer, maskdate_ character varying, username_ character varying, ipaddress_ inet) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE period RECORD;
dates RECORD;
dateInsert RECORD;
diasinseridos integer;
count integer;
feriado RECORD;
lastFeriado RECORD;
countDias integer;
hasHoliday boolean;
BEGIN
    diasinseridos := 0;
    hasHoliday := false;
    SELECT INTO period
        TO_CHAR(beginDate, maskDate_) as beginDate,
        TO_CHAR(endDate, maskDate_) as endDate,
        (enddate - begindate) as totalDias
    FROM
        acdlearningperiod
    WHERE
        learningPeriodId = learningPeriodId_;
    count:= period.totalDias;
    WHILE ( count >= 0 )
    LOOP
       SELECT INTO dateInsert ( TO_DATE(period.endDate,maskDate_) - count ) as occurrenceDate, extract(dow from  ( TO_DATE(period.endDate,maskDate_) - count ))+1 as weekDayId;
        SELECT INTO feriado
            CASE
                WHEN A.holidayDate IS NULL THEN
                    TRUE
                ELSE
                    FALSE
            END as isHoliday,
            holidayDate
        FROM
            basHoliday A RIGHT JOIN ( SELECT dateInsert.occurrenceDate as holidaydate ) B USING (holidaydate);
        IF feriado.isHoliday is true AND NOT dateInsert.weekDayId = 1 THEN
            INSERT INTO acdAcademicCalendar ( username,
                    ipaddress,
                    occurrenceDate,
                    weekDayId,
                    learningPeriodId )
                        VALUES              ( username_,
                    ipaddress_,
                    dateInsert.occurrenceDate,
                    dateInsert.weekDayId,
                    learningPeriodId_);
            diasinseridos := diasinseridos+1;
            IF hasHoliday IS TRUE THEN
                countDias  := (6 - extract(dow FROM lastFeriado.holidayDate));
                hasHoliday := FALSE;
                RAISE NOTICE 'Dia feriado %', lastFeriado.holidayDate;
                RAISE NOTICE 'Dia a ser inserido %', lastFeriado.holidayDate+countDias;
/*
            INSERT INTO academicCalendarAdjustmentsNew  ( username,
                    ipaddress,
                    occurrenceDate,
                    weekDayId,
                    learningPeriodId )
                        VALUES              ( username_,
                    ipaddress_,
                    (lastFeriado.holidayDate+countDias),
                    extract( dow from lastFeriado.holidayDate) +1,
                    learningPeriodId_); */
            END IF;
        ELSE
            IF feriado.isHoliday IS FALSE AND NOT dateInsert.weekDayId = 1 THEN
                lastFeriado := feriado;
                hasHoliday  := TRUE;
            END IF;
        END IF;
        count:=count-1;
    END LOOP;
    RETURN diasinseridos;
END; $$;


ALTER FUNCTION public.createacademiccalendar(learningperiodid_ integer, maskdate_ character varying, username_ character varying, ipaddress_ inet) OWNER TO postgres;

--
-- Name: curricularcomponentapproved(integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION curricularcomponentapproved(contractid integer) RETURNS SETOF record
    LANGUAGE plpgsql
    AS $_$
DECLARE
    results RECORD;
BEGIN

FOR results IN 
SELECT DISTINCT 
    A.contractId, 
    A.courseId, 
    A.courseVersion, 
    A.turnId, 
    A.unitId, 
    D.semester, 
    D.curricularComponentVersion, 
    D.curricularComponentId, 
    E.name as curricularComponentName, 
    B.statusId,
    COALESCE ( F.periodId, K.periodId ),
    E.academicNumberHours,
    E.lessonNumberHours,
    COALESCE ( B.finalNote::varchar, H.finalNote::varchar, G.finalNote::varchar ) as finalNote,
    G.exploitationType,
    getPersonName(G.institutionId) as institutionName,
    I.description,
B.curriculumId,
B.enrollId
FROM  
    acdContract A INNER JOIN
    acdEnroll B ON ( B.contractId = A.contractId )
    LEFT JOIN acdGroup C ON ( C.groupId = B.groupId ) 
    LEFT JOIN acdCurriculum D ON (D.curriculumId IN (SELECT B.curriculumId UNION SELECT C.curriculumId ) AND D.curriculumTypeId IN (SELECT value::integer FROM basConfig WHERE parameter ILIKE 'ACD_CURRICULUM_TYPE_CURRICULAR_INTEGRATE')) 
    LEFT JOIN acdCurricularComponent E ON ( E.curricularComponentId = D.curricularComponentId AND E.curricularComponentVersion = D.curricularComponentVersion )
    LEFT JOIN acdLearningPeriod F ON ( C.learningPeriodId = F.learningPeriodId )
    LEFT JOIN acdExploitation G ON ( G.enrollId = B.enrollId )
    LEFT JOIN acdEnroll H ON ( H.enrollId = G.exploitationEnrollId )
    LEFT JOIN acdEnrollStatus I ON ( I.statusId = B.statusId ) 
    LEFT JOIN acdLearningPeriod K ON ( K.learningPeriodId = B.learningPeriodId )
WHERE 
    B.statusId IN (SELECT value::int FROM basConfig WHERE parameter ILIKE  'ENROLL_STATUS_APPRO%' OR parameter ilike 'ENROLL_STATUS_EXC%' ) AND B.contractId = $1
LOOP
    RETURN NEXT results;
END LOOP;

END;
$_$;


ALTER FUNCTION public.curricularcomponentapproved(contractid integer) OWNER TO postgres;

--
-- Name: curricularcomponentdisapproved(integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION curricularcomponentdisapproved(contractid integer) RETURNS SETOF record
    LANGUAGE plpgsql
    AS $_$
DECLARE
    results RECORD;
BEGIN

FOR results IN 
SELECT DISTINCT 
    A.contractId, 
    A.courseId, 
    A.courseVersion, 
    A.turnId, 
    A.unitId, 
    D.semester, 
    D.curricularComponentVersion, 
    D.curricularComponentId, 
    E.name as curricularComponentName, 
    B.statusId,
    G.periodId,
    E.academicNumberHours,
    E.lessonNumberHours,    
    B.finalNote::varchar,
    F.description,
B.curriculumId,
B.groupId,
B.enrollId
FROM  
    acdContract A INNER JOIN
    acdEnroll B ON ( B.contractId = A.contractId )
    LEFT JOIN acdGroup C ON ( C.groupId = B.groupId ) 
    LEFT JOIN acdCurriculum D ON (D.curriculumId IN (SELECT B.curriculumId UNION SELECT C.curriculumId ) AND D.curriculumTypeId IN (SELECT value::integer FROM basConfig WHERE parameter ILIKE 'ACD_CURRICULUM_TYPE_CURRICULAR_INTEGRATE')) 
    LEFT JOIN acdCurricularComponent E ON ( E.curricularComponentId = D.curricularComponentId AND E.curricularComponentVersion = D.curricularComponentVersion )
    LEFT JOIN acdEnrollStatus F ON ( F.statusId = B.statusId )
    LEFT JOIN acdLearningPeriod G ON ( G.learningPeriodId = C.learningPeriodId )
WHERE 
    B.statusId IN (SELECT value::int FROM basConfig WHERE parameter ILIKE  'ENROLL_STATUS_DISAPPRO%' ) AND B.contractId = $1
LOOP
    RETURN NEXT results;
END LOOP;

END;
$_$;


ALTER FUNCTION public.curricularcomponentdisapproved(contractid integer) OWNER TO postgres;

--
-- Name: curricularcomponentenrolled(integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION curricularcomponentenrolled(contractid integer) RETURNS SETOF record
    LANGUAGE plpgsql
    AS $_$
DECLARE
    results RECORD;
BEGIN
FOR results IN 
SELECT DISTINCT 
    A.contractId, 
    A.courseId, 
    A.courseVersion, 
    A.turnId, 
    A.unitId, 
    D.semester, 
    D.curricularComponentVersion, 
    D.curricularComponentId, 
    E.name as curricularComponentName, 
    B.statusId,
    F.periodId,
    E.academicNumberHours,
    E.lessonNumberHours,
    G.description,
B.curriculumId,
B.groupId,
B.enrollId
FROM  
    acdContract A INNER JOIN
    acdEnroll B ON ( B.contractId = A.contractId )
    LEFT JOIN acdGroup C ON ( C.groupId = B.groupId ) 
    LEFT JOIN acdCurriculum D ON (D.curriculumId IN (SELECT B.curriculumId UNION SELECT C.curriculumId ) AND D.curriculumTypeId IN (SELECT value::integer FROM basConfig WHERE parameter ILIKE 'ACD_CURRICULUM_TYPE_CURRICULAR_INTEGRATE')) 
    LEFT JOIN acdCurricularComponent E ON ( E.curricularComponentId = D.curricularComponentId AND E.curricularComponentVersion = D.curricularComponentVersion )
    LEFT JOIN acdLearningPeriod F ON ( C.learningPeriodId = F.learningPeriodId )
    LEFT JOIN acdEnrollStatus G ON ( G.statusId = B.statusId )
WHERE 
    B.statusId IN (SELECT value::int FROM basConfig WHERE parameter ILIKE  'ENROLL_STATUS_ENROLLED' ) AND B.contractId = $1
LOOP
    RETURN NEXT results;
END LOOP;

END;
$_$;


ALTER FUNCTION public.curricularcomponentenrolled(contractid integer) OWNER TO postgres;

--
-- Name: curricularcomponentnotcoursed(integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION curricularcomponentnotcoursed(contractid integer) RETURNS SETOF record
    LANGUAGE plpgsql
    AS $_$
DECLARE
    results RECORD;
    contract RECORD;
    maximumDependent_ integer;
BEGIN
SELECT INTO contract  maximumDependent, courseId, courseVersion, turnId, unitId FROM acdCourseOccurrence INNER JOIN acdContract USING (courseId, courseVersion, turnId, unitId) WHERE contractId = $1;
maximumDependent_ := contract.maximumDependent;

FOR results IN 
SELECT DISTINCT A.contractId, A.courseId, A.courseVersion, A.turnId, A.unitId, A.semester, A.curricularComponentVersion, A.curricularComponentId, A.curricularComponentName, A.academicNumberHours, A.lessonNumberHours, A.curriculumId FROM ( SELECT 
    A.contractId,
    A.courseId,
    A.courseVersion,
    A.turnId,
    A.unitId,
    B.semester,
    C.curricularComponentId,
    C.curricularComponentVersion,
    C.name as curricularComponentName,
    C.academicNumberHours,
    C.lessonNumberHours,
    B.curriculumId
FROM 
    acdContract A
    RIGHT JOIN acdCurriculum B ON ( B.courseId = A.courseId AND B.courseVersion = A.courseVersion AND B.turnId = A.turnId AND A.unitId = B.unitId AND B.curriculumTypeId IN (SELECT value::integer FROM basConfig WHERE parameter ILIKE 'ACD_CURRICULUM_TYPE_CURRICULAR_INTEGRATE') )
    INNER JOIN acdCurricularComponent C ON (C.curricularComponentId = B.curricularComponentId AND C.curricularComponentVersion = B.curricularComponentVersion )
WHERE 
    A.contractId = $1
GROUP BY 
    A.contractId,
    A.courseId,
    A.courseVersion,
    A.turnId,
    A.unitId,
    B.semester,
    C.curricularComponentId,
    C.curricularComponentVersion,
    C.lessonNumberHours,
    C.academicNumberHours,
    C.name,
    B.curriculumId ) A LEFT JOIN ( 
    SELECT DISTINCT B.contractId, D.semester, D.curricularComponentId, D.curricularComponentVersion FROM  
    acdEnroll B
    LEFT JOIN acdGroup C ON ( C.groupId = B.groupId ) 
    LEFT JOIN acdCurriculum D ON (D.curriculumId IN (SELECT B.curriculumId UNION SELECT C.curriculumId ) AND D.curriculumTypeId IN (SELECT value::integer FROM basConfig WHERE parameter ILIKE 'ACD_CURRICULUM_TYPE_CURRICULAR_INTEGRATE')) 
    WHERE B.statusId IN (SELECT value::int FROM basConfig WHERE parameter ILIKE  'ENROLL_STATUS_APPRO%' OR parameter ilike 'ENROLL_STATUS_EXC%') AND B.contractId = $1  ) B ON (A.curricularComponentId = B.curricularComponentId AND A.curricularComponentVersion = B.curricularComponentVersion AND A.contractId = B.contractId )
WHERE B.contractId IS NULL 
LOOP
    RETURN NEXT results;
END LOOP;

END;
$_$;


ALTER FUNCTION public.curricularcomponentnotcoursed(contractid integer) OWNER TO postgres;

--
-- Name: enrollclasspupil(integer, integer, character varying, character varying, inet); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION enrollclasspupil(contractid_ integer, groupid_ integer, mode_ character varying, username_ character varying, ipaddress_ inet) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE tupla1 RECORD;
tupla2 RECORD;
isAdaptation_ boolean;
isDependence_ boolean;
enrollId_ integer; 
enrollParcel RECORD;
debitosAnteriores numeric(14,2);

BEGIN
    SELECT INTO enrollId_
        enrollId 
    FROM 
        acdEnroll 
    WHERE
        groupId = groupId_ AND
        contractId = contractId_ ;

    SELECT INTO tupla1 
        curricularComponentId, 
        curricularComponentVersion,
        periodId,
        groupId
    FROM 
        acdGroup INNER JOIN 
        acdCurriculum USING (curriculumId) INNER JOIN
        acdLearningPeriod ON ( acdLearningPeriod.learningPeriodId = acdGroup.learningPeriodId )
    WHERE 
        groupId = groupId_ AND 
        contractId = contractId_;

    SELECT INTO debitosAnteriores
        sum(balance(invoiceId))
    FROM 
        ONLY finReceivableInvoice
    WHERE
        contractId = contractId_
    AND maturityDate <= now()::date-2
    GROUP BY
        contractId;

    SELECT INTO enrollParcel 
        balance(invoiceId),
        invoiceId,
        maturityDate,
        CASE 
            WHEN maturityDate >= now()::date THEN 
                FALSE
            ELSE
                TRUE
        END as vencida
    FROM 
        ONLY finReceivableInvoice
    WHERE
        contractId = contractId_
    AND periodId = tupla1.periodId;

    IF enrollId_ IS NULL AND NOT tupla1.groupId IS NULL AND ( enrollParcel.balance = 0 OR ( enrollParcel.balance IS NULL AND debitosAnteriores <= 0 )  OR ( NOT enrollParcel.balance IS NULL AND enrollParcel.vencida = FALSE ) ) THEN
        
        RAISE NOTICE 'Verifica disciplina de adaptacao';
        IF mode_ = 'ADAP' THEN
            isAdaptation_ := true;
        ELSE
            isAdaptation_ := false;
        END IF;
        
        RAISE NOTICE 'Verifica disciplina de dependencia'; 
        IF mode_ = 'DEPEND' THEN
            isDependence_ := true;
        ELSE
            isDependence_ := false;
        END IF;

        SELECT INTO tupla2
            B.curriculumId,
            A.contractId,
            B.curricularComponentId,
            B.curricularComponentVersion,
            C.learningPeriodId,
            B.semester,
            nextSemester(A.contractId) as nextSemester
        FROM 
            acdContract A INNER JOIN 
            acdCurriculum B ON ( B.courseId = A.courseId
                                 AND B.courseVersion = A.courseVersion
                                 AND B.turnId = A.turnId
                                 AND B.unitId = A.unitId 
                                 AND B.curricularComponentId = tupla1.curricularComponentId
                                 AND B.curricularComponentVersion = tupla1.curricularComponentVersion  ) INNER JOIN
            acdLearningPeriod C ON ( C.periodId = tupla1.periodId 
                                     AND C.courseId = A.courseId 
                                     AND C.courseVersion = A.courseVersion
                                     AND C.unitId = A.unitId 
                                     AND C.turnId = A.turnId )
        WHERE
            A.contractId = contractId_;
        RAISE NOTICE 'Verifica disciplina de dependencia %', tupla2; 
        IF tupla2.semester = tupla2.nextsemester THEN
            SELECT INTO enrollId_  nextval('seq_enrollId');
            INSERT INTO 
                acdEnroll ( enrollId,
                            contractId, 
                            groupId, 
                            curriculumId, 
                            learningPeriodId, 
                            isDependence,
                            isAdaptation,
                            statusId, 
                            dateEnroll,
                            hourEnroll,
                            username, 
                            ipaddress )
            VALUES         
                           ( enrollId_,
                             contractId_, 
                             groupId_,
                             tupla2.curriculumId, 
                             tupla2.learningPeriodId,
                             isDependence_,
                             isAdaptation_,
                             (SELECT value::integer FROM basConfig WHERE parameter = 'ENROLL_STATUS_ENROLLED'), 
                             now()::date,
                             now()::time,
                             username_, 
                             ipaddress_ );
                RAISE NOTICE 'Codigo de matricula %',enrollId_; 
                enrollId_ := enrollId_+5;
                RETURN enrollId_;
        ELSE
            RETURN 0;
        END IF;
    ELSE
        IF NOT enrollId_ IS NULL THEN
            RAISE NOTICE 'Ja matriculado na disciplina.
 Codigo de matricula %.',enrollId_; 
        ELSIF tupla1.groupId IS NULL THEN
            RAISE NOTICE 'Codigo de disciplina oferecida % nao encontrado.',groupId_; 
        ELSE
            IF groupId_ IS NULL THEN
                RETURN 1;
            ELSIF ( NOT enrollParcel.balance IS NULL AND enrollParcel.vencida = TRUE ) THEN
                RETURN 2;
            ELSIF ( enrollParcel.balance IS NULL AND debitosAnteriores > 0 ) THEN
                RETURN 3;
            ELSE
                RETURN 0;
            END IF;
        END IF;
        RETURN enrollId_;
    END IF;
END; 
$$;


ALTER FUNCTION public.enrollclasspupil(contractid_ integer, groupid_ integer, mode_ character varying, username_ character varying, ipaddress_ inet) OWNER TO postgres;

--
-- Name: enrollpupil(integer, integer, character varying, character varying, inet); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION enrollpupil(integer, integer, character varying, character varying, inet) RETURNS integer
    LANGUAGE plpgsql
    AS $_$
DECLARE tupla1 RECORD;
tupla2 RECORD;
isAdaptation_ boolean;
isDependence_ boolean;
enrollId_ integer; 
BEGIN
    SELECT INTO enrollId_
        enrollId 
    FROM 
        acdEnroll 
    WHERE
        groupId = $2 AND
        contractId = $1;

    SELECT INTO tupla1 
        curricularComponentId, 
        curricularComponentVersion,
        periodId,
        groupId,
        curriculumId
    FROM 
        acdGroup INNER JOIN 
        acdCurriculum USING (curriculumId) INNER JOIN
        acdLearningPeriod ON ( acdLearningPeriod.learningPeriodId = acdGroup.learningPeriodId )
    WHERE groupId = $2;

    IF enrollId_ IS NULL AND NOT tupla1.groupId IS NULL THEN
        
        RAISE DEBUG 'Verifica disciplina de adaptacao';
        IF $3 = 'ADAP' THEN
            isAdaptation_ := true;
        ELSE
            isAdaptation_ := false;
        END IF;
        
        RAISE DEBUG 'Verifica disciplina de dependencia'; 
        IF $3 = 'DEPEND' THEN
            isDependence_ := true;
        ELSE
            isDependence_ := false;
        END IF;

        SELECT INTO tupla2
            B.curriculumId,
            A.contractId,
            COALESCE( C.curricularComponentId, E.curricularComponentId) AS curricularComponentId,
            COALESCE( C.curricularComponentVersion, E.curricularComponentVersion ) AS curricularComponentVersion,
            F.learningPeriodId
        FROM 
            acdContract A INNER JOIN 
            acdCurriculum B USING ( courseId, courseVersion, turnId, unitId ) LEFT JOIN
            acdCurricularComponent C ON ( C.curricularComponentId = tupla1.curricularComponentId 
                                          AND C.curricularComponentVersion = tupla1.curricularComponentVersion
                                          AND B.curricularComponentId = C.curricularComponentId 
                                          AND B.curricularComponentVersion  = C.curricularComponentVersion ) LEFT JOIN
            acdCurriculumLink D ON ( D.curriculumLinkId = B.curriculumId OR D.curriculumId = B.curriculumId ) LEFT JOIN
            acdCurriculum E ON  ( E.curricularComponentId = tupla1.curricularComponentId 
                                  AND E.curricularComponentVersion = tupla1.curricularComponentVersion ) LEFT JOIN
            acdLearningPeriod F ON ( F.periodId = tupla1.periodId 
                                     AND F.courseId = A.courseId
                                     AND F.courseVersion = A.courseVersion
                                     AND F.turnId = A.turnId
                                     AND F.unitId = A.unitId )
        WHERE 
            contractId = $1;

        SELECT INTO enrollId_  nextval('seq_enrollId');

        INSERT INTO 
            acdEnroll ( enrollId,
                        contractId, 
                        groupId, 
                        curriculumId, 
                        learningPeriodId, 
                        isDependence,
                        isAdaptation,
                        statusId, 
                        dateEnroll,
                        hourEnroll,
                        username, 
                        ipaddress )
        VALUES         
                       ( enrollId_,
                         $1, 
                         $2,
                         tupla1.curriculumId, 
                         tupla2.learningPeriodId,
                         isDependence_,
                         isAdaptation_,
                         (SELECT value::integer FROM basConfig WHERE parameter = 'ENROLL_STATUS_ENROLLED'), 
                         now()::date,
                         now()::time,
                         $4, 
                         $5 );
            RAISE NOTICE 'Codigo de matricula %',enrollId_; 
            RETURN enrollId_;
    ELSE
        IF NOT enrollId_ IS NULL THEN
            RAISE NOTICE 'Ja matriculado na disciplina.
 Codigo de matricula %.',enrollId_; 
        ELSIF tupla1.groupId IS NULL THEN
            RAISE NOTICE 'Codigo de disciplina oferecida % nao encontrado.',$2; 
            
        END IF;
        RETURN enrollId_;
    END IF;
END; 

$_$;


ALTER FUNCTION public.enrollpupil(integer, integer, character varying, character varying, inet) OWNER TO postgres;
--
-- Name: getcontractcourseid(integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION getcontractcurricularcomponents(_contractid integer, _curriculumtypeid integer[], _statusid integer[]) RETURNS integer
    LANGUAGE plpgsql
    AS $$

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
$$;


ALTER FUNCTION public.getcontractcurricularcomponents(_contractid integer, _curriculumtypeid integer[], _statusid integer[]) OWNER TO postgres;

--
-- Name: getgroupofferedhours(integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION getgroupofferedhours(groupid_ integer) RETURNS double precision
    LANGUAGE sql
    AS $_$
SELECT 
    sum(numberhourslessons)
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
        professorId integer ) 
GROUP BY 
    groupId
$_$;


ALTER FUNCTION public.getgroupofferedhours(groupid_ integer) OWNER TO postgres;

--
-- Name: getincomesourcedescription(integer); Type: FUNCTION; Schema: public; Owner: postgres
--


CREATE FUNCTION getoccurrencedates(groupid_ integer) RETURNS SETOF record
    LANGUAGE sql
    AS $_$
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
$_$;


ALTER FUNCTION public.getoccurrencedates(groupid_ integer) OWNER TO postgres;

--
-- Name: getoccurrencedatesgroupbygroup(integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION getoccurrencedatesgroupbygroup(groupid_ integer) RETURNS SETOF record
    LANGUAGE sql
    AS $_$
SELECT 
    occurrencedate,
    groupId,
    learningPeriodId,
    sum(numberhourslessons) as numberhourslessons,
    lessonNumberHours,
    academicNumberHours,
    practiceHours,
    curriculumId,
    professorId

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
    professorId
ORDER BY
    occurrenceDate
$_$;


ALTER FUNCTION public.getoccurrencedatesgroupbygroup(groupid_ integer) OWNER TO postgres;

--
-- Name: getoccurrencedatesprofessor(integer, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION getoccurrencedatesprofessor(groupid_ integer, professorid_ integer) RETURNS SETOF record
    LANGUAGE sql
    AS $_$
SELECT 
    *
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
        professorId integer ) 
WHERE professorId = $2
$_$;


ALTER FUNCTION public.getoccurrencedatesprofessor(groupid_ integer, professorid_ integer) OWNER TO postgres;


--
-- Name: getscheduleofferedhours(integer, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION getscheduleofferedhours(groupid_ integer, scheduleid_ integer) RETURNS double precision
    LANGUAGE sql
    AS $_$
SELECT 
    sum(numberhourslessons)
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
        professorId integer )
WHERE
    scheduleId = $2
GROUP BY 
    groupId,
    scheduleId
$_$;


ALTER FUNCTION public.getscheduleofferedhours(groupid_ integer, scheduleid_ integer) OWNER TO postgres;


--
-- Name: insertfrequence(character varying, inet, integer, timestamp without time zone, double precision, integer); Type: FUNCTION; Schema: public; Owner: postgres
-- ESTA FUNCAO ESTÁ DESATUALIZADA
--

CREATE FUNCTION insertfrequence(username_ character varying, ipaddress_ inet, enrollid_ integer, frequencydate_ timestamp without time zone, frequency_ double precision, professorid_ integer) RETURNS boolean
    LANGUAGE plpgsql
    AS $_$
DECLARE
    enrollId_ integer;
    frequencyDate_ timestamp;
    frequency_ float;
    userName_ varchar(30);
    ipaddress_ inet;
    professorId_ integer;
    frequencyForRecord float;
    tuplaSchedules RECORD;
    retorno BOOLEAN;
BEGIN
    userName_   := $1;
    ipAddress_  := $2;
    enrollId_ := $3;
    frequencyDate_ := $4;
    frequency_:= $5;
    professorId_ := $6;
    FOR tuplaSchedules IN 
    SELECT 
userName_,
ipaddress_,
        enrollId, 
scheduleId,
frequencyDate_,
        turnId,
numberhourslessons as maxFrequency
    FROM 
acdEnroll A INNER JOIN
acdSchedule B USING ( groupId ) INNER JOIN
acdScheduleProfessor C USING ( scheduleId ) INNER JOIN
acdScheduleLearningPeriod D USING ( scheduleLearningPeriodId )
    WHERE
enrollId = enrollId_
    AND professorId = professorId_
    ORDER BY 
        D.beginDate, D.beginHour
    LOOP
DELETE FROM acdFrequenceEnroll WHERE scheduleId = tuplaSchedules.scheduleId AND enrollId = tuplaSchedules.enrollId AND frequencyDate = frequencyDate_;
IF frequency_ > 0 THEN
    frequencyForRecord := ( tuplaSchedules.maxFrequency - frequency_ ) + frequency_ ;
    frequency_ := frequency_  - frequencyForRecord;
            IF frequencyForRecord  > 0 THEN
                INSERT INTO acdFrequenceEnroll (userName,
                                                ipAddress,
                                                enrollId,
                                                scheduleId,
                                                frequencyDate,
                                                turnId,
                                                frequency ) 
                                            VALUES
                                                
(userName_,
                                                ipAddress_,
                                                enrollId_,
                                                tuplaSchedules.scheduleId,
                                                frequencyDate_,
                                                tuplaSchedules.turnId,
                                                frequencyForRecord );
            END IF;
END IF;
    END LOOP;
    retorno := true;
    RETURN retorno;
END;

$_$;


ALTER FUNCTION public.insertfrequence(username_ character varying, ipaddress_ inet, enrollid_ integer, frequencydate_ timestamp without time zone, frequency_ double precision, professorid_ integer) OWNER TO postgres;

--
-- Name: insertfrequence(character varying, inet, integer, timestamp without time zone, double precision, integer); Type: FUNCTION; Schema: public; Owner: postgres
-- ESTA FUNCAO É A CORRETA
-- 02-11-2010
--

CREATE OR REPLACE FUNCTION insertfrequence(username_ character varying, ipaddress_ inet, enrollid_ integer, frequencydate_ timestamp without time zone, frequency_ double precision, professorid_ integer)
  RETURNS boolean AS
$BODY$
DECLARE
    enrollId_ integer;
    frequencyDate_ timestamp;
    frequency_ float;
    userName_ varchar(30);
    ipaddress_ inet;
    professorId_ integer;
    groupId_ integer;
    frequencyForRecord float;
    tuplaSchedules RECORD;
    retorno BOOLEAN;
BEGIN
    userName_      := $1;
    ipAddress_     := $2;
    enrollId_      := $3;
    frequencyDate_ := $4;
    frequency_     := $5;
    professorId_   := $6;
    
    SELECT INTO groupId_ groupId FROM acdEnroll WHERE enrollId = enrollId_;

    FOR tuplaSchedules IN 
    SELECT 
        userName_,
        ipaddress_,
        enrollId, 
        B.scheduleId,
        frequencyDate_,
        D.turnId,
        D.numberhourslessons as maxFrequency
    FROM 
        acdEnroll A INNER JOIN
        acdSchedule B USING ( groupId ) INNER JOIN
        acdScheduleProfessor C USING ( scheduleId ) INNER JOIN
        acdScheduleLearningPeriod D USING ( scheduleLearningPeriodId ) INNER JOIN
        ( SELECT * FROM getoccurrencedatesprofessor( groupId_, professorId_ ) AS A ( occurrencedate date,
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
        weight float ) ) E ON ( E.groupId = A.groupId AND E.occurrenceDate = frequencyDate_ AND E.weekDayId = B.weekDayId AND E.scheduleId = B.scheduleId AND E.professorId = C.professorId )
    WHERE
        enrollId = enrollId_
        AND C.professorId = professorId_
    ORDER BY 
        D.beginDate, D.beginHour
    LOOP
        DELETE FROM acdFrequenceEnroll WHERE scheduleId = tuplaSchedules.scheduleId AND enrollId = tuplaSchedules.enrollId AND frequencyDate = frequencyDate_;
        IF frequency_ > 0 THEN
            IF frequency_ > tuplaSchedules.maxFrequency THEN
                frequencyForRecord := ( tuplaSchedules.maxFrequency - frequency_ ) + frequency_;
                frequency_ := frequency_  - frequencyForRecord;
            ELSE
                frequencyForRecord := frequency_;
                frequency_ := frequency_  - frequencyForRecord;
            END IF;

            IF frequencyForRecord  > 0 THEN
                INSERT INTO acdFrequenceEnroll (userName,
                                                ipAddress,
                                                enrollId,
                                                scheduleId,
                                                frequencyDate,
                                                turnId,
                                                frequency ) 
                                            VALUES
                                                
                                                (userName_,
                                                ipAddress_,
                                                enrollId_,
                                                tuplaSchedules.scheduleId,
                                                frequencyDate_,
                                                tuplaSchedules.turnId,
                                                frequencyForRecord );
            END IF;
        END IF;
    END LOOP;

    FOR tuplaSchedules IN 
    SELECT 
        userName_,
        ipaddress_,
        A.enrollId, 
        C.scheduleId,
        frequencyDate_,
        D.turnId,
        0
    FROM 
        acdEnroll A INNER JOIN
        acdSchedule B USING ( groupId ) INNER JOIN
        acdScheduleProfessor C USING ( scheduleId ) INNER JOIN
        acdScheduleLearningPeriod D USING ( scheduleLearningPeriodId ) INNER JOIN
        ( SELECT * FROM getoccurrencedatesprofessor( groupId_, professorId_ ) AS A ( occurrencedate date,
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
        weight float ) ) E ON ( E.groupId = A.groupId AND E.occurrenceDate = frequencyDate_ AND E.weekDayId = B.weekDayId AND E.scheduleId = B.scheduleId AND E.professorId = C.professorId ) LEFT JOIN
        acdFrequenceEnroll F ON ( F.enrollId = A.enrollId AND F.scheduleId = E.scheduleId AND F.frequencyDate = E.occurrenceDate AND F.turnId = D.turnId )  
    WHERE
        A.enrollId = enrollId_
        AND C.professorId = professorId_
        AND F.enrollId IS NULL
    ORDER BY 
        D.beginDate, D.beginHour

        
    LOOP
        INSERT INTO acdFrequenceEnroll (userName,
                                        ipAddress,
                                        enrollId,
                                        scheduleId,
                                        frequencyDate,
                                        turnId,
                                        frequency ) 
                                       VALUES       
                                       (userName_,
                                        ipAddress_,
                                        enrollId_,
                                        tuplaSchedules.scheduleId,
                                        frequencyDate_,
                                        tuplaSchedules.turnId,
                                        0 );
        
    END LOOP;
    retorno := true;
    RETURN retorno;
END;
$BODY$
  LANGUAGE 'plpgsql' VOLATILE
  COST 100;
ALTER FUNCTION insertfrequence(character varying, inet, integer, timestamp without time zone, double precision, integer) OWNER TO postgres;

--
-- Name: nextsemester(integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION nextsemester(integer) RETURNS integer
    LANGUAGE plpgsql
    AS $_$
DECLARE
    results RECORD;
    contract RECORD;
    nextSemester_ INTEGER;
    maximumDependent_ INTEGER;
BEGIN
SELECT INTO contract  maximumDependent, courseId, courseVersion, turnId, unitId FROM acdCourseOccurrence INNER JOIN acdContract USING (courseId, courseVersion, turnId, unitId) WHERE contractId = $1;
maximumDependent_ := contract.maximumDependent;
FOR results IN 
SELECT 
    A.contractid, 
    A.courseId, 
    A.courseVersion, 
    A.turnId, 
    A.unitId, 
    A.semester, 
    count(semester) as disciplinasFaltantes
FROM ( 
SELECT DISTINCT A.contractId, A.courseId, A.courseVersion, A.turnId, A.unitId, A.semester, A.curricularComponentVersion, A.curricularComponentId, A.curricularComponentName FROM ( SELECT 
    A.contractId,
    A.courseId,
    A.courseVersion,
    A.turnId,
    A.unitId,
    B.semester,
    C.curricularComponentId,
    C.curricularComponentVersion,
    C.name as curricularComponentName    
FROM 
    acdContract A
    RIGHT JOIN acdCurriculum B ON ( B.courseId = A.courseId AND B.courseVersion = A.courseVersion AND B.turnId = A.turnId AND A.unitId = B.unitId AND B.curriculumTypeId IN (SELECT value::integer FROM basConfig WHERE parameter ILIKE 'ACD_CURRICULUM_TYPE_CURRICULAR_INTEGRATE') )
    INNER JOIN acdCurricularComponent C ON (C.curricularComponentId = B.curricularComponentId AND C.curricularComponentVersion = B.curricularComponentVersion )
WHERE 
    A.contractId = $1
GROUP BY 
    A.contractId,
    A.courseId,
    A.courseVersion,
    A.turnId,
    A.unitId,
    B.semester,
    C.curricularComponentId,
    C.curricularComponentVersion,
    C.name ) A LEFT JOIN ( 
    SELECT DISTINCT B.contractId, D.semester, D.curricularComponentId, D.curricularComponentVersion FROM  
    acdEnroll B
    LEFT JOIN acdGroup C ON ( C.groupId = B.groupId ) 
    LEFT JOIN acdCurriculum D ON (D.curriculumId IN (SELECT B.curriculumId UNION SELECT C.curriculumId ) AND D.curriculumTypeId IN (SELECT value::integer FROM basConfig WHERE parameter ILIKE 'ACD_CURRICULUM_TYPE_CURRICULAR_INTEGRATE')) 
    WHERE B.statusId IN (SELECT value::int FROM basConfig WHERE parameter ILIKE  'ENROLL_STATUS_APPRO%' OR parameter ilike 'ENROLL_STATUS_EXC%') AND B.contractId = $1  ) B ON (A.curricularComponentId = B.curricularComponentId AND A.curricularComponentVersion = B.curricularComponentVersion AND A.contractId = B.contractId )
WHERE B.contractId IS NULL ) A  
GROUP BY 
    A.contractid, A.courseId, A.courseVersion, A.turnId, A.unitId, A.semester 
ORDER BY 
    A.contractid, A.courseId, A.courseVersion, A.turnId, A.unitId, A.semester 
LOOP
    IF (maximumDependent_) > 0 THEN
        maximumDependent_ := maximumDependent_ - results.disciplinasFaltantes;
        IF ( maximumDependent_ <= 0 ) THEN
            nextSemester_ := results.semester;
        END IF;
    END IF;
END LOOP;
RETURN nextSemester_;
END;
$_$;


ALTER FUNCTION public.nextsemester(integer) OWNER TO postgres;

--
-- Name: returntextasinteger(text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION returntextasinteger(text) RETURNS text
    LANGUAGE sql
    AS $_$
    SELECT regexp_replace($1,'[^0123456789]','','g')
$_$;


ALTER FUNCTION public.returntextasinteger(text) OWNER TO postgres;

