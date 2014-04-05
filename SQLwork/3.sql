#task 3
DROP PROCEDURE IF EXISTS print_department;
DELIMITER //
CREATE PROCEDURE print_department(
			IN did INT(11))
BEGIN
 SELECT * FROM workers WHERE id = did;
 SELECT * FROM workers WHERE pid = did;
END//
DELIMITER ;

-- Example:
-- CALL print_department(13);