DROP DATABASE IF EXISTS db_a;
CREATE DATABASE db_a;

-- table admin
DROP TABLE IF EXISTS db_a.admin;
CREATE TABLE db_a.admin (
  id       INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  username VARCHAR(255),
  password VARCHAR(255)
);

-- table activity
DROP TABLE IF EXISTS db_a.activity;
CREATE TABLE db_a.activity (
  id   INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(255)
);

-- table enroll
DROP TABLE IF EXISTS db_a.enroll;
CREATE TABLE db_a.enroll (
  id         INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  sno        VARCHAR(255),
  sname      VARCHAR(255),
  activityId INT UNSIGNED
);

ALTER TABLE db_a.enroll
ADD CONSTRAINT
  fk_enroll_activityId
FOREIGN KEY (activityId)
REFERENCES db_a.activity (id);

-- add a admin
INSERT INTO db_a.admin VALUES (NULL, 'admin', '123');

-- admin login
SELECT *
FROM db_a.admin
WHERE username = 'admin' AND password = '123';

-- admin add activity
INSERT INTO db_a.activity VALUES (NULL, '北海公园划船');
INSERT INTO db_a.activity VALUES (NULL, '国家大剧院参观');
INSERT INTO db_a.activity VALUES (NULL, '登香山');

-- admin list all activities
SELECT *
FROM db_a.activity;

-- admin delete an activity
DELETE FROM db_a.activity
WHERE id = 1;

-- student list all activities
SELECT *
FROM db_a.activity;

-- student enroll
INSERT INTO db_a.enroll VALUES (NULL, 's001', '张三', 1);
INSERT INTO db_a.enroll VALUES (NULL, 's002', '李四', 1);
INSERT INTO db_a.enroll VALUES (NULL, 's003', '王二', 2);

-- admin list all enroll
SELECT
  e.sno,
  e.sname,
  a.name
FROM db_a.activity a JOIN db_a.enroll e
    ON a.id = e.activityId;

SELECT
  e.sno,
  e.sname,
  a.name
FROM db_a.activity a JOIN db_a.enroll e
    ON a.id = e.activityId
WHERE a.id = 1;

TRUNCATE TABLE db_a.enroll;
SET FOREIGN_KEY_CHECKS =0;
TRUNCATE TABLE db_a.activity;

LOAD DATA LOCAL INFILE 'c:/SELECT___FROM_db_a_activity.tsv' INTO TABLE db_a.activity
FIELDS TERMINATED BY '\t'
LINES TERMINATED BY '\n'
(name);