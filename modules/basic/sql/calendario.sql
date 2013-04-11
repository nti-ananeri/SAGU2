--ALTER TABLE acdAcademicCalendarAdjustments ADD COLUMN useLearningPeriodDateReference BOOL DEFAULT TRUE;
--ALTER TABLE acdAcademicCalendarAdjustments ADD COLUMN useCalendarDateReference BOOL DEFAULT TRUE;

CREATE OR REPLACE FUNCTION getOccurrenceDates ( groupId_ integer ) RETURNS SETOF RECORD AS '
SELECT 
* 
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
ORDER BY
    A.occurrenceDate
' LANGUAGE 'sql';

CREATE OR REPLACE FUNCTION getGroupOfferedHours(groupId_ integer) RETURNS float AS '
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
' LANGUAGE 'sql';

CREATE OR REPLACE FUNCTION getScheduleOfferedHours(groupId_ integer, scheduleId_ integer) RETURNS float AS '
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
' LANGUAGE 'sql';


CREATE OR REPLACE FUNCTION getOccurrenceDatesProfessor ( groupId_ integer, professorId_ integer ) RETURNS SETOF RECORD AS '
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
' LANGUAGE 'sql';


/*select * FROM getOccurrenceDates ( 14185 ) AS
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
        professorId integer ) ;

select * FROM getOccurrenceDatesProfessor ( 14185 , 13554) AS
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
        professorId integer ) ; 

SELECT 
    B.scheduleId,
    A.groupId,
    E.courseid,
    E.courseversion,
    F.name AS curricularComponent,
    F.academicnumberhours,
    F.lessonNumberHours,
    F.practiceHours,
    getGroupOfferedHours(A.groupId) as horasTotaisDisciplia,
    getScheduleOfferedHours(A.groupId, B.scheduleId) as horasTotaisHorario,
    G.description AS weekDayDescription, 
    getTurnDescription ( D.turnId ) as turnDescription,
    C.description AS scheduleLearningPeriodDescription, 
    C.beginHour, 
    C.endHour, 
    C.beginDate as dataInicialHorario,
    C.endDate as dataFinalHorario,
    D.beginDate as dataInicialPeriodoLetivo,
    D.endDate as dataFinalPeriodoLetivo,
    I.description AS physicalResourceDescription,
    getPersonName(H.professorId) as professorName

FROM 
    acdGroup A INNER JOIN
    acdSchedule B ON ( B.groupId = A.groupId ) INNER JOIN 
    acdScheduleLearningPeriod C ON ( C.scheduleLearningPeriodId = B.scheduleLearningPeriodId ) INNER JOIN
    acdLearningPeriod D ON ( D.learningPeriodId = C.learningPeriodId ) INNER JOIN
    acdCurriculum E ON ( E.curriculumId = A.curriculumId ) INNER JOIN
    acdCurricularComponent F ON ( F.curricularComponentId = E.curricularComponentId 
                                  AND F.curricularComponentVersion = E.curricularComponentVersion ) INNER JOIN
    basWeekDay G ON ( G.weekDayId = B.weekDayId ) LEFT JOIN
    acdScheduleProfessor H ON ( H.scheduleId = B.scheduleId ) LEFT JOIN
    insPhysicalResource I ON ( I.physicalresourceid = B.physicalresourceid 
                               AND I.physicalresourceversion = B.physicalresourceversion ) 
WHERE
    D.periodid = '2009.2'
ORDER BY
    getPersonName(H.professorId),
    F.name,
    A.groupId,
    B.scheduleId; */
