#task 7
DROP PROCEDURE IF EXISTS anomalies;
DROP PROCEDURE IF EXISTS dfs;

DELIMITER //

CREATE PROCEDURE dfs(IN pid INTEGER)
BEGIN
	DECLARE curr_id INTEGER;
	DECLARE stop INTEGER DEFAULT 0;

	DECLARE c_id CURSOR FOR
	SELECT id FROM workers WHERE boss_id = pid;
	
	DECLARE CONTINUE HANDLER 
    FOR NOT FOUND SET stop = 1;

    IF (SELECT count(id) FROM tmp WHERE id = pid) = 0 THEN 
    	INSERT INTO tmp(id) value(pid);
    ELSE
    	SELECT pid; 
    END IF;
    OPEN c_id;
get_id: LOOP
    FETCH c_id INTO curr_id;
    if stop=1 then LEAVE get_id; END IF;
    SET max_sp_recursion_depth = 5000;
    CALL dfs(curr_id);
END LOOP get_id;
	CLOSE c_id;  
END//

CREATE PROCEDURE anomalies()
BEGIN
	CREATE TABLE tmp(
	id INTEGER);
	CALL dfs(1);
	DROP TABLE tmp;
END//
DELIMITER ;
-- Example:
-- CALL anomalies();