#task 1
DROP PROCEDURE IF EXISTS insert_p;
DELIMITER //
CREATE PROCEDURE insert_p(
			IN boss INT(11),
			IN pname VARCHAR(255))
BEGIN
INSERT INTO workers(pid, name) VALUES (boss, pname);
END//
DELIMITER ;
-- Example:
-- CALL insert_p(13, Pupkin);