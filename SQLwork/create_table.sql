--table creation 
DROP TABLE IF EXISTS workers;
CREATE TABLE workers (
	id INT AUTO_INCREMENT,
	pid INT,
	name VARCHAR(255),
	PRIMARY KEY (id)
);
