SHOW DATABASES;

DROP DATABASE IF EXISTS demo;
CREATE DATABASE demo;

USE demo;

DROP TABLE IF EXISTS demo.user;
CREATE TABLE demo.user (
  id       INT(11) UNSIGNED AUTO_INCREMENT PRIMARY KEY, -- unsigned 无符（负）号
  email    VARCHAR(255) UNIQUE,
  username VARCHAR(255),
  password VARCHAR(255) NOT NULL,
  sex      CHAR(1)          DEFAULT 'M'
  COMMENT 'M:male; F:female',
  age      INT(3),
  height   DOUBLE(3, 2), -- 1.75 m
  salary   DECIMAL(6, 2), -- 1234.56
  birthday DATE
)
  COMMENT '用户表';

CREATE INDEX ind_birthday ON demo.user (birthday);
DROP INDEX ind_email ON demo.user;
DESC demo.user;
SHOW COLUMNS FROM demo.user;
SHOW INDEXES FROM demo.user;


SELECT *
FROM demo.user
WHERE email = '';

INSERT INTO demo.user VALUES (NULL, 'tester@test.com', 'tester', '123', 'F', 16, 1.6, 6000, '1996-1-2');
INSERT INTO demo.user (id, email, password, sex) VALUES (3, 'b@b.com', '123', NULL);
SELECT *
FROM demo.user;

DELETE FROM demo.user
WHERE id = 5;

TRUNCATE TABLE demo.user;

-- student table
# sno 2007220647 2003

DROP TABLE IF EXISTS demo.Persons;
CREATE TABLE Persons (
  P_Id     INT UNIQUE,
  LastName VARCHAR(255) NOT NULL UNIQUE
  #   CONSTRAINT uc_PersonID UNIQUE (P_Id,LastName)
);

DESC Persons;

INSERT INTO demo.Persons VALUES (1, 'a');
INSERT INTO demo.Persons VALUES (NULL, 'b');
INSERT INTO demo.Persons VALUES (2, 'a');

SELECT *
FROM Persons;


DROP TABLE IF EXISTS demo.student;
CREATE TABLE demo.student (
  id            INT(11) UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  name          VARCHAR(255),
  department_id INT(11) UNSIGNED --
);

DROP TABLE IF EXISTS demo.department;
CREATE TABLE demo.department (
  id   INT(11) UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(255),
  tel  VARCHAR(255)
);

ALTER TABLE demo.student AUTO_INCREMENT = 10000000;

ALTER TABLE demo.student
ADD CONSTRAINT
  fk_student_department_id
FOREIGN KEY (department_id)
REFERENCES demo.department (id);
-- ON DELETE SET NULL ; -- Cascading Style Sheet

ALTER   TABLE demo.student
    add CONSTRAINT
fk_st_de_id
FOREIGN KEY (department_id)
REFERENCES  demo.department(id);


ALTER TABLE demo.student
DROP age;

ALTER TABLE demo.student
MODIFY name VARCHAR(1024);

ALTER TABLE demo.student
DROP FOREIGN KEY fk_student_department_id; -- ?
DESC demo.student; -- describe

INSERT INTO demo.student VALUES (NULL, 'student1', 1);
INSERT INTO demo.student VALUES (NULL, 'student2', 2);
DELETE FROM demo.student;
# TRUNCATE TABLE demo.student;

SELECT *
FROM demo.student;

INSERT INTO demo.department VALUES (NULL, 'CS', '...');
INSERT INTO demo.department VALUES (NULL, 'EE', '...');

SELECT *
FROM demo.department;

SET FOREIGN_KEY_CHECKS = 0;
SET FOREIGN_KEY_CHECKS = 1;

DELETE FROM demo.department
WHERE id = 2;
DELETE FROM demo.department
WHERE id = 1;

DROP TABLE demo.student;
DROP TABLE demo.department;

SHOW TABLES;

SELECT
  s.name,
  d.name
FROM demo.student s JOIN demo.department d
    ON s.department_id = d.id;

# DESC demo.department;

CREATE TABLE index_test (
  id           INT(11) UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  index_column INT(11) UNSIGNED
);

CREATE INDEX ind_index_column ON demo.index_test(index_column);
DROP INDEX ind_index_column ON demo.index_test;
TRUNCATE TABLE demo.index_test;

SELECT count(*)
FROM demo.index_test;

SELECT *
FROM demo.index_test
WHERE index_column = 999999;