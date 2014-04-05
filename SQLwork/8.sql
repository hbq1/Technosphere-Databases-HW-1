#task 8
DROP PROCEDURE IF EXISTS deepth;
DELIMITER //
CREATE PROCEDURE deepth(IN num INT(11))
BEGIN
 DECLARE tmp, tmp2, ans INT(11) DEFAULT 0;
 SET tmp2 = num;
 go: LOOP
	SET ans = ans + 1;
	SELECT pid INTO tmp FROM workers WHERE id = tmp2;
	IF tmp = -1 THEN LEAVE go;
	END IF;
	SET tmp2 = tmp;
 END LOOP go;
 SELECT ans;
END//
DELIMITER ;
-- Example:
-- CALL deepth(13);