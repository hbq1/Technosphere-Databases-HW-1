#task 9
DROP PROCEDURE IF EXISTS outhierarchy;
DROP PROCEDURE IF EXISTS hierarchy2;
DELIMITER //

CREATE PROCEDURE outhierarchy(boss INT(11), dpth INT(11), addition VARCHAR(301)) 
BEGIN
 DECLARE tmp, fin, id_cur INT(11) DEFAULT 0;
 DECLARE id_name VARCHAR(200);
 DECLARE ans VARCHAR(1000) DEFAULT '';
 DECLARE id_curs CURSOR FOR
	SELECT id, name FROM workers WHERE pid = boss;
 DECLARE CONTINUE HANDLER 
	FOR NOT FOUND SET fin = 1;
 OPEN id_curs;
 go: LOOP
	FETCH id_curs INTO id_cur, id_name;
	IF fin = 1 THEN	LEAVE go;
	END IF;
	INSERT INTO temp(name) VALUES (CONCAT(addition, id_name));
	SET max_sp_recursion_depth = 300;
	CALL outhierarchy(id_cur, dpth+1, CONCAT(addition,' '));
 END LOOP go;
 CLOSE id_curs;
END//

CREATE PROCEDURE hierarchy2()
BEGIN
 CREATE TABLE temp(
	id INT auto_increment,
	name varchar(3000),
	PRIMARY KEY (id));
 CALL outhierarchy(-1,0,' ');
 SELECT name AS Hierarchy FROM temp;
 DROP TABLE temp;
END//

DELIMITER ;
-- Example:
-- CALL hierarchy2();
