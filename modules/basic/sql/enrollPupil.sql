CREATE OR REPLACE FUNCTION "public"."enrollpupil" (
    integer,
    integer,
    varchar,
    varchar,
    inet
)
RETURNS integer AS
$body$
DECLARE 
    tupla1 RECORD;
    tupla2 RECORD;
    isAdaptation_ boolean;
    isDependence_ boolean;
    enrollId_ integer; 
    curriculumId_ integer;
    learningPeriodId_ integer;
    BEGIN
    /* Verifica se a pessoa já não está matriculada nesta disciplina */
    SELECT INTO enrollId_
        enrollId 
    FROM 
        acdEnroll 
    WHERE
        contractid = $1 AND
        groupId = $2 AND
        --Verifica se a disciplina não está cancelada
        statusid not in ((SELECT value::integer FROM basConfig WHERE parameter = 'ENROLL_STATUS_CANCELLED'));
    /* Preenche as Informações de disciplina, versão, periodo e curriculum */
    SELECT INTO tupla1 
        curricularComponentId, 
        curricularComponentVersion,
        TO_ASCII(acdCurricularComponent.name) as name,
        periodId,
        curriculumId,
        groupId,
        lessonnumberhours
    FROM 
        acdGroup INNER JOIN 
        acdCurriculum USING (curriculumId) INNER JOIN
        acdLearningPeriod ON ( acdLearningPeriod.learningPeriodId = acdGroup.learningPeriodId ) INNER JOIN
        acdCurricularComponent USING ( curricularComponentId, curricularComponentVersion )
    WHERE groupId = $2;
    
    /* Ajusta o learningperiodid reference ao curso da pessoa */
	SELECT INTO learningPeriodId_ max(learningPeriodId) FROM acdLearningPeriod INNER JOIN acdContract USING ( courseId, courseVersion, turnId, unitId ) WHERE contractId = $1;

    /* Caso a disciplina não esteja "matriculada", e esteja oferecida */
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
        FOR tupla2 IN  	
            SELECT 
			    curriculumId, 
	            curricularComponentId, 
	            curricularComponentVersion,
                TO_ASCII(acdCurricularComponent.name) as name,
                lessonnumberhours
            FROM 
                acdCurriculum INNER JOIN 
                acdCurricularComponent USING ( curricularComponentId, curricularComponentVersion ) INNER JOIN
                acdContract USING ( courseId, courseVersion, turnId, unitId )
            WHERE
                contractId = $1
		LOOP
            IF ( curriculumId_ IS NULL ) THEN
                IF 	( tupla2.name = tupla1.name OR tupla2.curricularComponentId = tupla1.curricularComponentId ) THEN
                    IF ( tupla2.lessonnumberhours >= (tupla1.lessonnumberhours*0.75) ) THEN
        	            curriculumId_ := tupla2.curriculumId;
                	END IF;
	            END IF;	
            END IF;
    	END LOOP;
        IF curriculumId_ IS NULL THEN
            FOR tupla2 IN  	
                SELECT 
                    A.curriculumId, 
                    C.curricularComponentId, 
                    C.curricularComponentVersion,
                    TO_ASCII(D.name) as name,
                    D.lessonnumberhours
                FROM 
                    acdCurriculum A INNER JOIN 
                    acdCurriculumLink B ON ( B.curriculumlinkid = A.curriculumId ) INNER JOIN
                    acdCurriculum C ON ( C.curriculumId = B.curriculumId ) INNER JOIN
                    acdCurricularComponent D ON ( D.curricularComponentId = C.curricularComponentId AND D.curricularComponentVersion = C.curricularComponentVersion ) INNER JOIN                      
                    acdContract E ON ( E.courseId = A.courseId AND E.courseVersion = A.courseVersion AND E.turnId = A.turnId AND E.unitId = A.unitId )
                WHERE
                    E.contractId = $1
            LOOP
                IF ( curriculumId_ IS NULL ) THEN
                    IF 	( tupla2.name = tupla1.name OR tupla2.curricularComponentId = tupla1.curricularComponentId ) THEN
                        IF ( tupla2.lessonnumberhours >= (tupla1.lessonnumberhours*0.75) ) THEN
                            curriculumId_ := tupla2.curriculumId;
                        END IF;
                    END IF;	
                END IF;
            END LOOP;
            IF curriculumId_ IS NULL THEN	
                curriculumId_ := tupla1.curriculumId;
            END IF;
        END IF;
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
                         curriculumId_, 
                         learningPeriodId_,
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
$body$
LANGUAGE 'plpgsql'
VOLATILE
CALLED ON NULL INPUT
SECURITY INVOKER;