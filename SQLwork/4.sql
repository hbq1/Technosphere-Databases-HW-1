#task 4
DROP PROCEDURE IF EXISTS print_lists;
DELIMITER //
CREATE PROCEDURE print_lists()
BEGIN
 DECLARE fin INTEGER DEFAULT 0;
 DECLARE id_cur INT(11);
 DECLARE id_curs CURSOR FOR
	SELECT id FROM workers;
 DECLARE CONTINUE HANDLER 
	FOR NOT FOUND SET fin = 1;
 OPEN id_curs;
 search: LOOP
	FETCH id_curs INTO id_cur;
	IF fin = 1 THEN	LEAVE search;
	END IF;
	IF (SELECT COUNT(id_cur) FROM workers WHERE pid = id_cur) = 0 THEN SELECT id_cur;
	END IF;
 END LOOP search;
 CLOSE id_curs;
END//
DELIMITER ;
-- Example:
-- CALL print_lists();