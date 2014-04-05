DROP PROCEDURE IF EXISTS path;
DELIMITER //
CREATE PROCEDURE path(IN id1 INT(11), IN id2 INT(11))
BEGIN
 DECLARE cur,cur2 INT(11);
 CREATE TABLE tmp(
	num INT auto_increment,
	id INT,
	PRIMARY KEY (num));
 CREATE TABLE tmp2(
	num INT auto_increment,
	id INT,
	PRIMARY KEY (num));
 SET cur = id1;
 INSERT INTO tmp(id) VALUES(cur);
 up: LOOP
	IF cur = -1 THEN LEAVE up;
	END IF;
	SELECT pid INTO cur2 FROM workers WHERE id = cur;
	SET cur = cur2;
	INSERT INTO tmp(id) VALUES(cur);
 END LOOP up;
 SET cur = id2;
 up: LOOP
	IF (SELECT COUNT(cur) FROM tmp WHERE id = cur) = 1 THEN LEAVE up;
	END IF;
	INSERT INTO tmp2(id) VALUES(cur);
	SELECT pid INTO cur2 FROM workers WHERE id = cur;	
	SET cur = cur2;
 END LOOP up;	
 SELECT pid INTO cur2 FROM workers WHERE id = cur;	
 SET cur = cur2;
 up: LOOP
	DELETE FROM tmp WHERE id = cur; 
	IF cur = -1 THEN LEAVE up;
	END IF;
	SELECT pid INTO cur2 FROM workers WHERE id = cur;	
	SET cur = cur2;
 END LOOP up;	
 SELECT id FROM tmp;
 SELECT id FROM tmp2 ORDER BY num DESC;
 DROP TABLE tmp;
 DROP TABLE tmp2;
END//
DELIMITER ;
-- Example:
-- CALL path(13);