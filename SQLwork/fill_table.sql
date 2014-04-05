--table filling
DELETE FROM workers;
LOAD DATA LOCAL INFILE '~/homework1-data.csv'
INTO TABLE workers
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
(id, pid, name);
