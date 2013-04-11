drop function enrollPupil( integer, integer, varchar, varchar, inet );
CREATE OR REPLACE FUNCTION enrollPupil( integer, integer, varchar, varchar, inet ) RETURNS integer AS '
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
        groupId = $2;

    SELECT INTO tupla1 
        curricularComponentId, 
        curricularComponentVersion,
        periodId,
        groupId
    FROM 
        acdGroup INNER JOIN 
        acdCurriculum USING (curriculumId) INNER JOIN
        acdLearningPeriod ON ( acdLearningPeriod.learningPeriodId = acdGroup.learningPeriodId )
    WHERE groupId = $2;

    IF enrollId_ IS NULL AND NOT tupla1.groupId IS NULL THEN
        
        RAISE DEBUG ''Verifica disciplina de adaptacao'';
        IF $3 = ''ADAP'' THEN
            isAdaptation_ := true;
        ELSE
            isAdaptation_ := false;
        END IF;
        
        RAISE DEBUG ''Verifica disciplina de dependencia''; 
        IF $3 = ''DEPEND'' THEN
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
                                          AND C.curricularComponentVersion = tupla1.curricularComponentVersion ) LEFT JOIN
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

        SELECT INTO enrollId_  nextval(''seq_enrollId'');

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
                         tupla2.curriculumId, 
                         tupla2.learningPeriodId,
                         isDependence_,
                         isAdaptation_,
                         (SELECT value::integer FROM basConfig WHERE parameter = ''ENROLL_STATUS_ENROLLED''), 
                         now()::date,
                         now()::time,
                         $4, 
                         $5 );
            RAISE NOTICE ''Codigo de matricula %'',enrollId_; 
            RETURN enrollId_;
    ELSE
        IF NOT enrollId_ IS NULL THEN
            RAISE NOTICE ''Ja matriculado na disciplina.\n Codigo de matricula %.'',enrollId_; 
        ELSIF tupla1.groupId IS NULL THEN
            RAISE NOTICE ''Codigo de disciplina oferecida % nao encontrado.'',$2; 
            
        END IF;
        RETURN enrollId_;
    END IF;
END; 

' LANGUAGE 'plpgsql';

CREATE OR REPLACE FUNCTION enrollClassPupil( integer, integer, varchar, varchar, inet ) RETURNS integer AS '
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
        groupId = $2;

    SELECT INTO tupla1 
        curricularComponentId, 
        curricularComponentVersion,
        periodId,
        groupId
    FROM 
        acdGroup INNER JOIN 
        acdCurriculum USING (curriculumId) INNER JOIN
        acdLearningPeriod ON ( acdLearningPeriod.learningPeriodId = acdGroup.learningPeriodId )
    WHERE groupId = $2;

    IF enrollId_ IS NULL AND NOT tupla1.groupId IS NULL THEN
        
        RAISE DEBUG ''Verifica disciplina de adaptacao'';
        IF $3 = ''ADAP'' THEN
            isAdaptation_ := true;
        ELSE
            isAdaptation_ := false;
        END IF;
        
        RAISE DEBUG ''Verifica disciplina de dependencia''; 
        IF $3 = ''DEPEND'' THEN
            isDependence_ := true;
        ELSE
            isDependence_ := false;
        END IF;

        SELECT INTO tupla2
            B.curriculumId,
            A.contractId,
            COALESCE( C.curricularComponentId, E.curricularComponentId) AS curricularComponentId,
            COALESCE( C.curricularComponentVersion, E.curricularComponentVersion ) AS curricularComponentVersion,
            F.learningPeriodId,
            B.semester,
            nextSemester(A.contractId) as nextSemester
        FROM 
            acdContract A INNER JOIN 
            acdCurriculum B USING ( courseId, courseVersion, turnId, unitId ) LEFT JOIN
            acdCurricularComponent C ON ( C.curricularComponentId = tupla1.curricularComponentId 
                                          AND C.curricularComponentVersion = tupla1.curricularComponentVersion ) LEFT JOIN
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
        
        IF tupla2.semester = tupla2.nextsemester THEN
            SELECT INTO enrollId_  nextval(''seq_enrollId'');
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
                             tupla2.curriculumId, 
                             tupla2.learningPeriodId,
                             isDependence_,
                             isAdaptation_,
                             (SELECT value::integer FROM basConfig WHERE parameter = ''ENROLL_STATUS_ENROLLED''), 
                             now()::date,
                             now()::time,
                             $4, 
                             $5 );
                RAISE NOTICE ''Codigo de matricula %'',enrollId_; 
                RETURN enrollId_;
        ELSE
            RETURN 0;
        END IF;
    ELSE
        IF NOT enrollId_ IS NULL THEN
            RAISE NOTICE ''Ja matriculado na disciplina.\n Codigo de matricula %.'',enrollId_; 
        ELSIF tupla1.groupId IS NULL THEN
            RAISE NOTICE ''Codigo de disciplina oferecida % nao encontrado.'',$2; 
        END IF;
        RETURN enrollId_;
    END IF;
END; 

' LANGUAGE 'plpgsql';


select enrollPupil(38132, 14132, ''::varchar, 'gmurilo'::varchar, '127.0.0.1'::inet );
select enrollClassPupil(38132, 14132, ''::varchar, 'gmurilo'::varchar, '127.0.0.1'::inet );

//select * from acdenroll where contractid = 38132
//delete from acdenroll where contractid = 38132
delete from acdclasspupil where classid = 'ADASN2009.2A'