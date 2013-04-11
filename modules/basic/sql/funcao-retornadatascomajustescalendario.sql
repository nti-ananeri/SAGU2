/* 
    Funcao que corrigi o calendario colocando o dia da semana correto 
*/
/* Atualizada os ajustes do calendário */
UPDATE acdacademiccalendaradjustments A SET weekDayId = B.weekDayId FROM (
SELECT
    A.academiccalendaradjustmentsid,
    C.weekDayId
FROM                                                                                                         
    acdAcademicCalendarAdjustments A INNER JOIN                                                              
    acdScheduleProfessor B ON ( A.scheduleId = B.scheduleId AND                                              
                                A.professorId = B.professorId ) INNER JOIN                                   
    acdSchedule C ON ( C.scheduleId = B.scheduleId                                                           
                       AND C.weekDayId = A.weekDayId ) INNER JOIN                                            
    acdGroup D ON ( D.groupId = C.groupId ) INNER JOIN                                                       
    acdCurriculum E ON ( E.curriculumId = D.curriculumId )  INNER JOIN                                       
    acdCurricularComponent F ON ( F.curricularComponentId = E.curricularComponentId AND                      
                                  F.curricularComponentVersion = E.curricularComponentVersion ) INNER JOIN   
    acdScheduleLearningPeriod G ON ( G.scheduleLearningPeriodId = C.scheduleLearningPeriodId ) INNER JOIN    
    acdLearningPeriod H ON ( H.learningPeriodId = G.learningPeriodId ) LEFT JOIN                             
    acdAcademicCalendar I ON ( I.learningPeriodId = H.learningPeriodId AND                                   
                               I.occurrenceDate = A.occurrenceDate )                                         
WHERE                                                                                                        
    A.occurrencedate BETWEEN H.beginDate AND H.endDate AND 
    A.occurrencedate BETWEEN G.beginDate AND G.endDate AND 
    D.groupId IN ( SELECT groupId FROM acdGroup WHERE learningPeriodId IN (SELECT learningPeriodId FROM acdLearningPeriod WHERE periodId = '2009.1') )
    AND NOT I.occurrenceDate IS NULL                                                                  
GROUP BY                                                                                                     
    A.occurrencedate,                                                                                        
    C.schedulelearningperiodId,                                                                              
    G.numberhourslessons,                                                                                    
    F.lessonNumberHours,                                                                                     
    E.curriculumId,                                                                                          
    D.groupId,
    A.academiccalendaradjustmentsid,
    A.weekDayId,
    C.weekDayId ) B WHERE A.academiccalendaradjustmentsid = B.academiccalendaradjustmentsid AND A.weekDayId != B.weekDayId  ;

/* Insere as frequencias que nao existem */
INSERT INTO 
    acdFrequenceEnroll 
    (enrollid, frequencydate, scheduleid, turnid, frequency) 
SELECT 
    acdEnroll.enrollid, 
    acdAcademicCalendar.occurrenceDate, 
    acdSchedule.scheduleId, 
    acdScheduleLearningPeriod.turnId, 
    0 
FROM 
    acdGroup INNER JOIN 
    acdLearningPeriod ON (acdGroup.learningperiodId = acdLearningPeriod.learningPeriodId) INNER JOIN 
    acdSchedule ON ( acdGroup.groupId = acdSchedule.groupId ) INNER JOIN
    acdScheduleProfessor ON (acdSchedule.scheduleId = acdScheduleProfessor.scheduleId) INNER JOIN 
    acdScheduleLearningPeriod ON ( acdSchedule.scheduleLearningPeriodId = acdScheduleLearningPeriod.scheduleLearningPeriodId ) INNER JOIN 
    acdEnroll on ( acdEnroll.groupId = acdGroup.groupId ) INNER JOIN
    acdAcademicCalendar ON ( acdAcademicCalendar.learningPeriodId = acdlearningperiod.learningperiodid 
                             AND acdAcademicCalendar.weekDayId = acdschedule.weekDayId AND
                             acdAcademicCalendar.occurrenceDate BETWEEN acdScheduleLearningPeriod.beginDate AND acdScheduleLearningPeriod.endDate  ) LEFT JOIN 
    acdFrequenceEnroll ON ( acdFrequenceEnroll.frequencyDate = acdAcademicCalendar.occurrenceDate 
                            AND acdfrequenceEnroll.enrollId = acdEnroll.enrollId )  
WHERE 
    periodId = '2009.1' AND 
    acdFrequenceEnroll.frequencyDate IS NULL 
GROUP BY 
    acdEnroll.enrollId, 
    acdAcademicCalendar.occurrenceDate, 
    acdSchedule.scheduleId, 
    acdScheduleLearningperiod.turnId;

/* Insere as frequencias dos ajustes do calendario que nao existem */
INSERT INTO 
    acdFrequenceEnroll 
    (enrollid, frequencydate, scheduleid, turnid, frequency) 

SELECT 
    acdEnroll.enrollid, 
    acdAcademicCalendarAdjustments.occurrenceDate, 
    acdSchedule.scheduleId, 
    acdScheduleLearningPeriod.turnId, 
    0 
FROM 
    acdGroup INNER JOIN 
    acdLearningPeriod ON (acdGroup.learningperiodId = acdLearningPeriod.learningPeriodId) INNER JOIN 
    acdSchedule ON ( acdGroup.groupId = acdSchedule.groupId ) INNER JOIN 
    acdScheduleProfessor ON (acdSchedule.scheduleId = acdScheduleProfessor.scheduleId) INNER JOIN 
    acdScheduleLearningPeriod ON ( acdSchedule.scheduleLearningPeriodId = acdScheduleLearningPeriod.scheduleLearningPeriodId ) INNER JOIN 
    acdEnroll on ( acdEnroll.groupId = acdGroup.groupId ) INNER JOIN
    acdAcademicCalendarAdjustments ON ( acdAcademicCalendarAdjustments.scheduleId = acdScheduleProfessor.scheduleId 
                                        AND acdAcademicCalendarAdjustments.professorId = acdScheduleProfessor.professorId
                                        AND acdAcademicCalendarAdjustments.weekDayId = acdschedule.weekDayId 
                                        AND acdAcademicCalendarAdjustments.occurrenceDate BETWEEN acdScheduleLearningPeriod.beginDate AND acdScheduleLearningPeriod.endDate  ) LEFT JOIN 
    acdFrequenceEnroll ON ( acdFrequenceEnroll.frequencyDate = acdAcademicCalendarAdjustments.occurrenceDate 
                            AND acdfrequenceEnroll.enrollId = acdEnroll.enrollId )  
WHERE 
    periodId = '2009.1' AND 
    acdFrequenceEnroll.frequencyDate IS NULL 
GROUP BY 
    acdEnroll.enrollId, 
    acdAcademicCalendarAdjustments.occurrenceDate, 
    acdSchedule.scheduleId, 
    acdScheduleLearningperiod.turnId;

/* coloca as notas que estavam cm nulo com o status de nula */
UPDATE
    acdDegreeEnroll 
SET 
    isnotpresent = TRUE
WHERE
    note IS NULL ;

/* Coloca as notas cm sem nota pros alunos que nao tiverem nota */
INSERT INTO 
    acdDegreeEnroll 
    (enrollId, degreeId, isnotpresent) 
SELECT 
    acdEnroll.enrollid, 
    acdDegree.degreeId,
    true
FROM 
    acdGroup INNER JOIN 
    acdLearningPeriod ON (acdGroup.learningperiodId = acdLearningPeriod.learningPeriodId) INNER JOIN 
    acdEnroll ON ( acdEnroll.groupId = acdGroup.groupId ) INNER JOIN
    acdDegree ON ( acdDegree.learningPeriodId = acdLearningPeriod.learningPeriodId ) LEFT JOIN 
    acdDegreeEnroll ON ( acdDegreeEnroll.degreeId = acdDegree.degreeId 
                            AND acdDegreeEnroll.enrollId = acdEnroll.enrollId )  
WHERE 
    periodId = '2009.1' AND 
    acdDegreeEnroll.enrollId IS NULL 
GROUP BY 
    acdEnroll.enrollid, 
    acdDegree.degreeId;
SELECT 
    *
FROM 
    ( 
    SELECT 
        CASE 
        --Aprovado
        WHEN ( A.note >= A.average ) THEN
            ( SELECT value::integer FROM basConfig WHERE parameter = 'ENROLL_STATUS_APPROVED' )
        --Aprovado em exame final 
        WHEN ( A.examNote > 0 AND A.finalNote >= A.finalAverage ) THEN
            ( SELECT value::integer FROM basConfig WHERE parameter = 'ENROLL_STATUS_APPROVED_INEXAM' )
        --Reprovado em exame final 
        WHEN ( A.examNote > 0 AND A.finalNote < A.finalAverage ) THEN
            ( SELECT value::integer FROM basConfig WHERE parameter = 'ENROLL_STATUS_DISAPPROVED_INEXAM' )
        --Reprovado
        WHEN ( A.note < A.average ) THEN
            ( SELECT value::integer FROM basConfig WHERE parameter = 'ENROLL_STATUS_DISAPPROVED' )
        END as statusSemFrequencia,
        A.note,
        A.enrollId,
        A.finalNote,
        A.lessonNumberHours as frequenciaTotal,
        A.frequency,
        A.groupId,
        A.examNote,
        A.statusId,
        (A.lessonNumberHours*(A.minimumfrequency/100.00)) as horasMinimas,
        A.minimumfrequency
    FROM
    (
        SELECT 
            ROUND ( (CASE 
                WHEN A.examNote IS NULL THEN ( noteCalculetad *  averageweight )
                WHEN NOT A.examNote IS NULL THEN ( noteCalculetad *  averageweight )  + ( examNote * examweight ) / ( examweight + averageweight )
            END)::numeric(14,2) , 2 ) as finalNote,
            A.examNote,
            A.noteCalculetad as note,
            A.enrollId,
            A.finalAverage,
            A.average,
            A.lessonNumberHours,
            A.groupId,
            A.frequency,
            A.statusId,
            A.minimumfrequency
        FROM 
        ( 
            SELECT 
                  ( SUM ( CASE 
                    WHEN B.isNotPresent THEN 0 ELSE ( B.note*C.weight ) 
                  END ) / SUM ( C.weight ) )::numeric(14,2) as noteCalculetad,
                  A.note::numeric(14,2) as note,
                  D.averageweight,
                  A.examNote,
                  D.examweight,
                  A.finalNote,
                  D.average,
                  D.finalAverage,
                  A.enrollId,
                  COALESCE( I.lessonNumberHours, H.lessonNumberHours ) as lessonNumberHours,
                  E.groupId,
                  A.frequency,
                  A.statusId,
                  D.minimumfrequency
            FROM
                acdEnroll A INNER JOIN
                acdDegreeEnroll B ON ( A.enrollId = B.enrollId ) INNER JOIN
                acdDegree C ON ( C.degreeId = B.degreeId ) INNER JOIN
                acdLearningPeriod D ON ( D.learningPeriodId = C.learningPeriodId ) LEFT JOIN
                acdGroup E ON ( E.groupId = A.groupId ) LEFT JOIN
                acdCurriculum F ON ( F.curriculumId = E.curriculumId ) LEFT JOIN
                acdCurriculum G ON ( G.curriculumId = A.curriculumId ) LEFT JOIN
                acdCurricularComponent H ON ( H.curricularComponentId = F.curricularComponentId AND
                                              H.curricularComponentVersion = F.curricularComponentVersion ) LEFT JOIN
                acdCurricularComponent I ON ( I.curricularComponentId = G.curricularComponentId AND
                                              I.curricularComponentVersion = G.curricularComponentVersion )
            WHERE
                D.periodId = '2009.1'
                AND NOT C.isSubstitutive
            GROUP BY
                A.enrollId,
                A.note,
                D.averageweight,
                A.examNote,
                D.examweight,
                A.finalNote,
                D.average,
                D.finalAverage,
                E.groupId,
                I.lessonNumberHours, 
                H.lessonNumberHours,
                A.frequency,
                A.statusId,
                D.minimumfrequency
            ) A
        ) A 
    ) A 
WHERE 
    A.statusId <> A.statusSemFrequencia 
ORDER BY enrollId
/* 
Esquema                    | public
Nome                       | getoccurrencedates
Tipo de dado do resultado  | SETOF record
Tipos de dado do argumento | integer
Tipo                       | normal
Volatilidade               | volatile
Dono                       | postgres
Linguagem                  | sql
*/

CREATE OR REPLACE FUNCTION getOccurrenceDates ( groupId_ integer ) RETURNS SETOF RECORD AS '
SELECT * FROM ( SELECT 
    A.occurrencedate,
    B.schedulelearningperiodId,
    B.numberhourslessons,
    F.lessonNumberHours,
    E.curriculumId,
    D.groupId
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
    A.occurrencedate BETWEEN B.beginDate AND B.endDate
    AND A.occurrencedate BETWEEN G.beginDate AND G.endDate
    AND D.groupId = $1
    AND I.occurrenceDate IS NULL
GROUP BY
    A.occurrencedate,
    B.schedulelearningperiodId,
    B.numberhourslessons,
    F.lessonNumberHours,
    E.curriculumId,
    D.groupId
UNION
SELECT 
    A.occurrencedate,
    C.schedulelearningperiodId,
    SUM(D.numberhourslessons),
    I.lessonNumberHours,
    H.curriculumId,
    C.groupId
FROM 
    acdAcademicCalendarAdjustments A INNER JOIN 
    acdScheduleProfessor B ON ( B.professorId = A.professorId 
                                AND B.scheduleId = A.scheduleId ) INNER JOIN
    acdSchedule C ON ( C.scheduleId = B.scheduleId AND C.weekDayId = A.weekDayId ) INNER JOIN
    acdScheduleLearningPeriod D ON ( D.scheduleLearningPeriodId = C.scheduleLearningPeriodId ) INNER JOIN
    acdLearningPeriod E ON ( E.learningPeriodId = D.learningPeriodId )  LEFT JOIN
    acdAcademicCalendar F ON ( F.occurrenceDate = A.occurrenceDate 
                               AND F.learningPeriodId = E.learningPeriodId 
                               AND A.occurrenceDate BETWEEN E.beginDate AND E.endDate 
                               AND A.occurrenceDate BETWEEN D.beginDate AND D.endDate ) LEFT JOIN
    acdGroup G ON ( G.groupId = C.groupId ) LEFT JOIN
    acdCurriculum H ON ( H.curriculumId = G.curriculumId )  LEFT JOIN
    acdCurricularComponent I ON ( I.curricularComponentId = H.curricularComponentId AND
                                  I.curricularComponentVersion = H.curricularComponentVersion )
WHERE
    C.groupId = $1
/*Caso deseje so os intervalos de data validos descomente a linha a seguir */
--AND NOT F.occurrenceDate IS NULL
GROUP BY
    A.occurrencedate,
    C.schedulelearningperiodId,
    I.lessonNumberHours,
    H.curriculumId,
    C.groupId ) A
ORDER BY 1 ' LANGUAGE 'sql';

/*
Esquema                    | public
Nome                       | getgroupscomproblema
Tipo de dado do resultado  | SETOF record
Tipos de dado do argumento | character varying
Tipo                       | normal
Volatilidade               | volatile
Dono                       | postgres
Linguagem                  | plpgsql
*/
CREATE OR REPLACE FUNCTION getGroupsWrongLessonHours ( periodId_ varchar ) RETURNS SETOF RECORD AS '
DECLARE results RECORD;                                                                                           
results2 RECORD;                                                                                                  
BEGIN                                                                                                             
FOR results IN                                                                                                    
    SELECT groupId FROM acdGroup WHERE learningPeriodId IN (SELECT learningPeriodId FROM acdLearningPeriod WHERE periodId = $1 )   
LOOP                                                                                                              
    SELECT INTO results2                                                                                          
        sum(numberhourslessons) as horasCadastradas,                                                              
        groupId,                                                                                                  
        curriculumId,                                                                                             
        lessonNumberHours,
        min(numberhourslessons) as numeroMinmoHoras,
        max(numberhourslessons) as numeroMaximoHoras
    FROM                                                                                                          
        getOccurrenceDates (results.groupId) AS ( occurrencedate date,                                            
                                        schedulelearningperiodid integer,                                         
                                        numberhourslessons float,                                                 
                                        lessonNumberHours float,   
                                        curriculumId integer,                                                     
                                        groupId integer )                                                         
    GROUP BY                                                                                                      
        groupId,                                                                                                  
        curriculumId,                                                                                             
        lessonNumberHours;                                                                                        

IF results2.horascadastradas < results2.lessonnumberhours THEN                                                   
    RETURN NEXT results2;                                                                                         
END IF;                                                                                                           
END LOOP;                   
END;
' LANGUAGE 'plpgsql';







CREATE OR REPLACE VIEW viewsOccurrenceDates  AS SELECT * FROM ( SELECT                                                                                                       
    A.occurrencedate,                                                                                        
    B.schedulelearningperiodId,
    B.learningPeriodId,
    B.numberhourslessons,                                                                                    
    F.lessonNumberHours,                                                                                     
    E.curriculumId,                                                                                          
    D.groupId,
    C.scheduleId,
    H.professorId,
    C.weekDayId,
    B.turnId
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
    A.occurrencedate BETWEEN B.beginDate AND B.endDate                                                       
    AND A.occurrencedate BETWEEN G.beginDate AND G.endDate                                                   
    AND D.groupId IN ( SELECT groupId FROM acdGroup WHERE learningPeriodId IN (SELECT learningPeriodId FROM acdLearningPeriod WHERE periodId = '2009.1') )
    AND I.occurrenceDate IS NULL                                                                             
GROUP BY                                                                                                     
    A.occurrencedate,                                                                                        
    B.schedulelearningperiodId,                                                                              
    B.learningPeriodId,
    B.numberhourslessons,                                                                                    
    F.lessonNumberHours,                                                                                     
    E.curriculumId,                                                                                          
    D.groupId,
    C.scheduleId,
    H.professorId,
    C.weekDayId,
    B.turnId
UNION                                                                                                        
SELECT 
    A.occurrencedate,
    C.schedulelearningperiodId,
    D.learningPeriodId,
    SUM(D.numberhourslessons) as numberhourslessons,
    I.lessonNumberHours,
    H.curriculumId,
    C.groupId,
    A.scheduleId,
    A.professorId,
    A.weekDayId,
    A.turnId
FROM 
    acdAcademicCalendarAdjustments A INNER JOIN 
    acdScheduleProfessor B ON ( B.professorId = A.professorId 
                                AND B.scheduleId = A.scheduleId ) INNER JOIN
    acdSchedule C ON ( C.scheduleId = B.scheduleId AND C.weekDayId = A.weekDayId ) INNER JOIN
    acdScheduleLearningPeriod D ON ( D.scheduleLearningPeriodId = C.scheduleLearningPeriodId ) INNER JOIN
    acdLearningPeriod E ON ( E.learningPeriodId = D.learningPeriodId )  LEFT JOIN
    acdAcademicCalendar F ON ( F.occurrenceDate = A.occurrenceDate 
                               AND F.learningPeriodId = E.learningPeriodId 
                               AND A.occurrenceDate BETWEEN E.beginDate AND E.endDate 
                               AND A.occurrenceDate BETWEEN D.beginDate AND D.endDate ) LEFT JOIN
    acdGroup G ON ( G.groupId = C.groupId ) LEFT JOIN
    acdCurriculum H ON ( H.curriculumId = G.curriculumId )  LEFT JOIN
    acdCurricularComponent I ON ( I.curricularComponentId = H.curricularComponentId AND
                                  I.curricularComponentVersion = H.curricularComponentVersion )
WHERE
    C.groupId IN ( SELECT groupId FROM acdGroup WHERE learningPeriodId IN (SELECT learningPeriodId FROM acdLearningPeriod WHERE periodId = '2009.1') )
GROUP BY
    A.occurrencedate,
    C.schedulelearningperiodId,
    I.lessonNumberHours,
    H.curriculumId,
    C.groupId,
    A.scheduleId,
    A.professorId,
    A.weekDayId,
    A.turnId,
    D.learningPeriodId
 ) A ORDER BY A.groupId, A.occurrenceDate;



CREATE OR REPLACE VIEW viewgroupscomproblema AS

select * FROM getGroupsWrongLessonHours ('2009.1') AS (horasCadastradas float, groupId integer, curriculumId integer, lessonNumberHours float, numeroMinimoHoras float, numeroMaximoHoras float) ;

/*
Esquema                    | public
Nome                       | inserehoras
Tipo de dado do resultado  | integer
Tipos de dado do argumento | integer, integer
Tipo                       | normal
Volatilidade               | volatile
Dono                       | postgres
Linguagem                  | plpgsql
*/
CREATE OR REPLACE FUNCTION inserehoras( groupId_ integer , weekDayId_ integer ) RETURNS INTEGER AS '
DECLARE result1 RECORD;
horariosInseridos INTEGER;
horasCadastradas float;
horasDisciplina float;
BEGIN

horariosInseridos := 0;
horasCadastradas := 0;

FOR result1 IN SELECT 
    A.learningPeriodId,
    A.occurrenceDate,
    B.turnId,
    min(B.weekDayId) as weekDayId,
    B.professorId,
    true as inout,
    min(B.scheduleId) as scheduleId,
    D.groupId,
    D.lessonNumberHours,
    D.horasCadastradas,
    D.numeromaximohoras
FROM 
    acdacademiccalendar A INNER JOIN
    viewsOccurrenceDates B ON ( B.learningPeriodId = A.learningPeriodId ) LEFT JOIN  
    viewsOccurrenceDates C ON ( C.learningPeriodId = B.learningPeriodId AND C.occurrenceDate = A.occurrenceDate ) LEFT JOIN  
    viewgroupscomproblema D ON ( D.groupId = B.groupId )
WHERE
    C.occurrenceDate IS NULL
AND D.groupId = $1
AND A.weekDayId = $2
GROUP BY
    A.learningPeriodId,
    A.occurrenceDate,
    B.professorId,
    D.groupId,
    D.lessonNumberHours,
    D.horasCadastradas,
    D.numeromaximohoras,
    B.turnId
ORDER BY 
    D.groupId,
    A.occurrenceDate
LOOP
    IF horasCadastradas = 0 THEN    
        RAISE NOTICE ''Ajustando parametros'';
        horasCadastradas := result1.horasCadastradas;
        RAISE NOTICE ''Horas cadastradas %'',horasCadastradas;
        horasDisciplina  := result1.lessonNumberHours;
        RAISE NOTICE ''Horas da disciplina %'',horasDisciplina;
        horariosInseridos := 0;
    END IF;

    IF horasCadastradas < horasDisciplina THEN
        horariosInseridos := horariosInseridos + 1;
        RAISE NOTICE ''Horarios inseridos %'',horariosInseridos;
        horasCadastradas := horasCadastradas + result1.numeromaximohoras;
        RAISE NOTICE ''Horas Cadastradas %'',horasCadastradas;
        INSERT INTO acdAcademicCalendarAdjustments ( learningPeriodId,
                                                     occurrenceDate,
                                                     weekDayId,
                                                     turnId,
                                                     professorId,
                                                     inOut,
                                                     scheduleId )
                                                     VALUES
                                                     ( result1.learningPeriodId,
                                                     result1.occurrenceDate,
                                                     result1.weekDayId,
                                                     result1.turnId,
                                                     result1.professorId,
                                                     result1.inOut,
                                                     result1.scheduleId );
    ELSE
        RETURN horariosInseridos;
    END IF;
END LOOP;
RETURN horariosInseridos;
END; ' LANGUAGE 'plpgsql'

SELECT inserehoras(groupId, 7 /*WeekDayId*/) FROM viewgroupscomproblema;
