CREATE DATABASE toothpaste;
USE toothpaste;

SET SQL_MODE="EMPTY_STRING_IS_NULL,STRICT_TRANS_TABLES";

CREATE TABLE data (
  id tinyint(3) UNSIGNED NOT NULL AUTO_INCREMENT,
  packsize tinyint(3) NOT NULL DEFAULT 1,
  quantity tinyint(3) NOT NULL DEFAULT 1,
  cost DECIMAL(4,2) NOT NULL,
  delivery DECIMAL(3,2) NOT NULL,
  discount tinyint(3) NOT NULL,
  discountCode tinytext,
  tubeCost DECIMAL(3,1),
  url tinytext,
  key id (id)
);

LOAD DATA LOCAL INFILE '/home/seirra/Documents/sql/toothpaste/data.csv'
INTO TABLE data
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

UPDATE data SET packsize = DEFAULT WHERE packsize = 0;

UPDATE data SET quantity = DEFAULT WHERE quantity = 0;

UPDATE data SET tubeCost =  ((cost * quantity + delivery) - discount) / (packsize * quantity);

SELECT * from data ORDER BY tubeCost;