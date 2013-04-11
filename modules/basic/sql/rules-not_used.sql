CREATE OR REPLACE RULE rul_acdgroup_totalenrolled_insert AS ON INSERT TO acdEnroll DO 
UPDATE acdGroup 
   SET totalEnrolled = ( SELECT COUNT(*) 
                           FROM acdEnroll A
                          WHERE A.dateCancellation IS NULL 
                            AND A.groupId = NEW.groupId ) 
 WHERE groupId = NEW.groupId;

CREATE OR REPLACE RULE rul_acdgroup_totalenrolled_update AS ON UPDATE TO acdEnroll DO 
UPDATE acdGroup 
   SET totalEnrolled = ( SELECT COUNT(*) 
                           FROM acdEnroll A
                          WHERE A.dateCancellation IS NULL 
                            AND A.groupId = NEW.groupId ) 
 WHERE groupId = NEW.groupId;

CREATE OR REPLACE RULE rul_acdgroup_totalenrolled_delete AS ON DELETE TO acdEnroll DO 
UPDATE acdGroup 
   SET totalEnrolled = ( SELECT COUNT(*) 
                           FROM acdEnroll A
                          WHERE A.dateCancellation IS NULL 
                            AND A.groupId = OLD.groupId ) 
 WHERE groupId = OLD.groupId;

