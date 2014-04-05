#task 5
DROP PROCEDURE IF EXISTS hierarchy;
DELIMITER //
CREATE PROCEDURE hierarchy(IN id_cur INT(11))
BEGIN
 DECLARE tmp,tmp2 INT(11);
 SELECT pid INTO tmp FROM workers WHERE id = id_cur;
 print: LOOP 
	IF tmp <> -1 THEN SELECT * FROM workers WHERE id = tmp;
	SET tmp2 = tmp;
	SELECT pid INTO tmp FROM workers WHERE id = tmp2;
	ELSE LEAVE print;
 	END IF;
 END LOOP print;
END//
DELIMITER ;
-- Example:
-- CALL hierarchy(13);