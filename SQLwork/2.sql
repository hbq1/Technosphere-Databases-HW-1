#task 2
DROP PROCEDURE IF EXISTS change;
DELIMITER //

CREATE PROCEDURE change(IN cid INTEGER, IN newpid INT(11))
BEGIN
 UPDATE workers SET pid = newpid WHERE id = cid;
END//

DELIMITER ;
-- Example:
-- CALL change(13, 18);