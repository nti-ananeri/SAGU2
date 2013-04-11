BEGIN TRANSACTION;
UPDATE 
    acdEnroll A
SET 
    finalNote = B.finalNote,
    note = B.note,
    frequency = B.frequencia,
    statusId = B.statuscomfrequencia FROM ( 
SELECT 
    CASE 
        WHEN frequencia < frequenciaMinima THEN 
            ( SELECT value::integer FROM basconfig where parameter = 'ENROLL_STATUS_DISAPPROVED_FOR_LACKS' )
        WHEN NOT statussemfrequencia IS NULL THEN
            statussemfrequencia
        ELSE
            ( SELECT value::integer FROM basconfig where parameter = 'ENROLL_STATUS_DISAPPROVED' )
    END as statuscomfrequencia,
    A.*
FROM 
    ( SELECT 
        CASE 
            WHEN NOT B.totalGeral IS NULL AND B.totalGeral < A.frequenciatotal THEN 
                ( B.totalGeral* (A.minimumfrequency/100.00) )
            ELSE
                ( A.frequenciaTotal*(A.minimumfrequency/100.00) )
        END as frequenciaMinima,
        CASE 
            WHEN C.frequencia = 0 AND A.frequency IS NULL THEN
                A.frequenciaTotal
            WHEN C.frequencia = 0 AND NOT A.frequency IS NULL THEN
                A.frequency
            WHEN C.frequencia > 0 AND ( A.frequency IS NULL OR C.frequencia > A.frequency ) THEN
                C.frequencia
            WHEN C.frequencia > 0 AND ( C.frequencia < A.frequency ) THEN
                A.frequency
            ELSE
                A.frequenciaTotal
       END as frequencia,
       A.groupId,
       A.examNote,
       A.finalNote,
       A.enrollId,
       A.note,
       A.statussemfrequencia
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
            ELSE
                ( SELECT value::integer FROM basConfig WHERE parameter = 'ENROLL_STATUS_DISAPPROVED' )
            END as statusSemFrequencia,
            A.note,
            A.enrollId,
            A.finalNote,
            A.lessonNumberHours as frequenciaTotal,
            A.frequency,
            A.groupId,
            A.examNote,
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
                    NOT D.periodId = '2009.2'
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
        ) A LEFT JOIN
    (
    SELECT 
        sum(totalgeral) as totalGeral, 
        sum(totalhoras) as totalHoras, 
        sum(totaladicionada) as totalAdicionado, 
        groupid 
    FROM ( SELECT 
        A.groupId,
        SUM( D.numberhourslessons) as totalHoras,
        0 as totalAdicionada,
        SUM( D.numberhourslessons) as totalGeral
    FROM 
        acdGroup A INNER JOIN 
        acdSchedule B ON ( B.groupId = A.groupId ) INNER JOIN
        acdScheduleProfessor C ON ( B.scheduleId = C.scheduleId ) INNER JOIN
        acdScheduleLearningPeriod D ON ( D.scheduleLearningPeriodId = B.scheduleLearningPeriodId ) INNER JOIN
        acdLearningPeriod E ON ( E.learningPeriodId = D.learningPeriodId ) INNER JOIN
        acdAcademicCalendar F ON ( F.occurrenceDate BETWEEN E.beginDate AND E.endDate 
                                   AND F.occurrenceDate BETWEEN D.beginDate AND D.endDate 
                                   AND F.learningPeriodId = E.learningPeriodId 
                                   AND F.weekDayId = B.weekDayId ) LEFT JOIN
        acdAcademicCalendarAdjustments G ON ( G.weekDayId = B.weekDayId 
                                              AND G.scheduleId = B.scheduleId 
                                              AND G.professorId = C.professorId 
                                              AND G.inout IS FALSE 
                                              AND G.occurrenceDate = F.occurrenceDate )
    WHERE
        G.occurrenceDate IS NULL 
    GROUP BY A.groupId

    UNION 
    SELECT 
        E.groupId,
        0 as totalHoras,
        SUM( D.numberhourslessons) as totalAdicionada,
        SUM( D.numberhourslessons) as totalGeral
    FROM 
        acdAcademicCalendarAdjustments A INNER JOIN
        acdScheduleProfessor B ON ( B.scheduleId = A.scheduleId
                                    AND B.professorId = A.professorId 
                                    AND A.inout IS TRUE ) INNER JOIN
        acdSchedule C ON ( C.scheduleId = B.scheduleId 
                           AND C.weekDayId = A.weekDayId ) INNER JOIN
        acdScheduleLearningPeriod D ON ( D.scheduleLearningPeriodId = C.scheduleLearningPeriodId ) INNER JOIN
        acdGroup E ON ( E.groupId = C.groupId )
    GROUP BY 
        E.groupId
    ) A
    GROUP BY groupId ) B USING ( groupId ) LEFT JOIN
    ( SELECT sum(frequency) as frequencia, enrollid from acdfrequenceenroll group by enrollid ) C ON ( A.enrollId = C.enrollId )
    ) A 
    ORDER BY A.enrollId
) B WHERE A.enrollId = B.enrollId AND A.groupId = 13753;
/*update acdenroll A set statusid = 3 from (SELECT * FROM acdgroup inner join acdlearningperiod using ( learningperiodid ) ) B where A.groupid = B.groupid and a.statusid = 1 and NOT B.periodid = '2009.2';*/

UPDATE acdGroup SET isclosed = TRUE WHERE groupId IN (
SELECT 
    groupId 
FROM 
    acdGroup INNER JOIN
    acdLearningPeriod USING ( learningPeriodId )
WHERE
    NOT periodId =  '2009.2' ) AND isClosed = FALSE AND groupId = 13753;
COMMIT;
