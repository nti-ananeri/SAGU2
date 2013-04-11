----------------------------------------------------------------------
-- --
-- Purpose: A função pega o groupId da tupla inserida, atualizada ou
--          excluida e calcula o total de matriculados para esse 
--          groupId.
--          A trigger atualiza o campo totalEnrolled da acdGroup com 
--          esse número total de matrículados.
--
-- --
----------------------------------------------------------------------

-- createlang plpgsql sagu2 -Upostgres

DROP TRIGGER IF EXISTS setTotalEnrolled ON acdEnroll;

DROP FUNCTION IF EXISTS setTotalEnrolled();

CREATE FUNCTION setTotalEnrolled()
RETURNS OPAQUE AS '
DECLARE
    groupid_ INTEGER;
    totalenrolled_ INTEGER;
BEGIN
    IF TG_OP = ''INSERT'' OR TG_OP = ''UPDATE'' THEN
        SELECT INTO totalenrolled_ COUNT(*) FROM acdenroll WHERE groupid = NEW.groupid AND statusid <> 5;
        UPDATE acdgroup SET totalenrolled = totalenrolled_ WHERE groupid = NEW.groupid;
        RETURN NEW;
    END IF;
    IF TG_OP = ''DELETE'' THEN
        SELECT INTO totalenrolled_ COUNT(*) FROM acdenroll WHERE groupid = OLD.groupid AND statusid <> 5;
        UPDATE acdgroup SET totalenrolled = totalenrolled_ WHERE groupid = OLD.groupid;
        RETURN OLD;
    END IF;
END;
' LANGUAGE 'plpgsql';

   CREATE TRIGGER setTotalEnrolled
            AFTER INSERT OR UPDATE OR DELETE
               ON acdEnroll FOR EACH ROW
EXECUTE PROCEDURE setTotalEnrolled();
