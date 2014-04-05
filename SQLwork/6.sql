#task 6
DROP PROCEDURE IF EXISTS numofpeople;
DROP PROCEDURE IF EXISTS getnumofpeople;
DELIMITER //
CREATE PROCEDURE numofpeople(INOUT ans INT(11), IN num INT(11))
BEGIN
 DECLARE tmp, fin, id_cur INT(11) DEFAULT 0;
 DECLARE id_curs CURSOR FOR
	SELECT id FROM workers WHERE pid = num;
 DECLARE CONTINUE HANDLER 
	FOR NOT FOUND SET fin = 1;
 OPEN id_curs;
 go: LOOP
	FETCH id_curs INTO id_cur;
	IF fin = 1 THEN	LEAVE go;
	END IF;
	SET max_sp_recursion_depth = 3000;
	CALL numofpeople(tmp, id_cur);
	SET ans = ans+1+tmp;
	SET tmp = 0;
 END LOOP go;
 CLOSE id_curs;
END//

CREATE PROCEDURE getnumofpeople(IN num INT(11))
BEGIN
 DECLARE ans INT(11) DEFAULT 0;
 CALL numofpeople(ans, num);
 SELECT ans;
END//
DELIMITER ;
-- Example:
-- CALL getnumofpeople(13);