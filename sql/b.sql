DROP DATABASE IF EXISTS db_b;
CREATE DATABASE db_b;

-- table admin
DROP TABLE IF EXISTS db_b.admin;
CREATE TABLE db_b.admin (
  id       INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  email VARCHAR(255),
  password VARCHAR(255)
);

-- table product
DROP TABLE IF EXISTS db_b.product;
CREATE TABLE db_b.product (
  id     INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  name   VARCHAR(255),
  unit   VARCHAR(255),
  amount INT,
  price  DECIMAL(7, 2)
);

-- table warning
DROP TABLE IF EXISTS db_b.warning;
CREATE TABLE db_b.warning (
  id  INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  min INT          DEFAULT 10,
  max INT          DEFAULT 100
);

-- add a admin
INSERT INTO db_b.admin VALUES (NULL, 'admin', '123');

-- admin login
SELECT *
FROM db_b.admin
WHERE username = 'admin' AND password = '123';

-- admin add product
INSERT INTO db_b.product VALUES (NULL, '钢笔', '个', 12, 10);
INSERT INTO db_b.product VALUES (NULL, '鼠标', '个', 5, 20);

-- admin list all products
SELECT *
FROM db_b.product;

-- admin delete an product
DELETE FROM db_b.product
WHERE id = 1;

-- admin edit a product
SELECT *
FROM db_b.product
WHERE id = 1;

UPDATE db_b.product
SET name = '',
  unit   = '',
  amount = 100,
  price  = 123.5
WHERE id = 1;

-- student list all activities
SELECT *
FROM db_b.activity;

-- student enroll
INSERT INTO db_b.enroll VALUES (NULL, 's001', '张三', 1);
INSERT INTO db_b.enroll VALUES (NULL, 's002', '李四', 1);
INSERT INTO db_b.enroll VALUES (NULL, 's003', '王二', 2);

-- add a warning
INSERT INTO db_b.warning (id) VALUES (NULL);

-- list warning
# A
SELECT *
FROM db_b.warning;

# B
SELECT *
FROM db_b.warning ORDER BY id DESC LIMIT 1;

-- admin set warning
# A
UPDATE db_b.warning
SET min = 1,
  max   = 1000
WHERE id = 1;

# B
INSERT db_b.warning VALUES (NULL, 2, 2000);
