DROP DATABASE IF EXISTS db_dict;
CREATE DATABASE db_dict;

-- table word
DROP TABLE IF EXISTS db_dict.word;
CREATE TABLE db_dict.word (
  id      INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  english VARCHAR(255)
);

-- table definition
DROP TABLE IF EXISTS db_dict.definition;
CREATE TABLE db_dict.definition (
  id           INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  partOfSpeech VARCHAR(255),
  chinese      VARCHAR(255),
  wordId       INT UNSIGNED
);

DROP TABLE IF EXISTS db_dict.sentence;
CREATE TABLE db_dict.sentence (
  id           INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  english      VARCHAR(255),
  chinese      VARCHAR(255),
  definitionId INT UNSIGNED
);

ALTER TABLE db_dict.definition
ADD CONSTRAINT
  fk_definition_wordId
FOREIGN KEY (wordId)
REFERENCES db_dict.word (id);

ALTER TABLE db_dict.sentence
ADD CONSTRAINT
  fk_sentence_definitionId
FOREIGN KEY (definitionId)
REFERENCES db_dict.definition (id);

INSERT INTO db_dict.word VALUES (NULL, 'test');

INSERT INTO db_dict.definition VALUES (NULL, 'n.', 'n. > chinese', 1);
INSERT INTO db_dict.definition VALUES (NULL, 'v.', 'v. > chinese', 1);

INSERT INTO db_dict.sentence VALUES (NULL, 'e1', 'c1', 1);
INSERT INTO db_dict.sentence VALUES (NULL, 'e2', 'c2', 1);
INSERT INTO db_dict.sentence VALUES (NULL, 'e3', 'c3', 1);

INSERT INTO db_dict.sentence VALUES (NULL, 'e4', 'c4', 2);
INSERT INTO db_dict.sentence VALUES (NULL, 'e5', 'c5', 2);
INSERT INTO db_dict.sentence VALUES (NULL, 'e6', 'c6', 2);

SELECT
  w.english,
  d.partOfSpeech 词性,
  s.english      英语,
  s.chinese      中文
FROM db_dict.word w JOIN db_dict.definition d
  JOIN db_dict.sentence s
    ON w.id = d.wordId AND d.id = s.definitionId;

/*
n.


e1
c1
n.
e2
c2
n.
e3
c3

v.
e1
c1
v.
e2
c2
v.
e3
c3

 */

use scott;

SELECT *
FROM emp where HIREDATE=last_day(HIREDATE);
# last_day(HIREDATE)  就是一个函数

SELECT
  ENAME,
  HIREDATE
FROM emp
WHERE date_sub(current_date, INTERVAL 35 YEAR) > emp.HIREDATE;

SELECT *
FROM emp
WHERE ENAME REGEXP '^[as]';

SELECT *
FROM emp
WHERE ENAME not LIKE '%r%';
# 名字里面包含r的员工信息


SELECT  substr(ENAME ,1,3)   as  'qiansangge'
FROM emp;



SELECT replace(ENAME,'A','a')
FROM emp;

SELECT
  HIREDATE,
  adddate(   HIREDATE,INTERVAL 10 YEAR)  AS '加
  '
FROM emp;



SELECT
  ENAME,
  HIREDATE,
  extract(YEAR  FROM  HIREDATE),
  extract(DAY  FROM  HIREDATE),
  extract(MONTH FROM HIREDATE)
FROM emp
ORDER BY extract(MONTH FROM HIREDATE),extract( YEAR  FROM  HIREDATE);


SELECT
  *
FROM emp
ORDER BY ENAME  ;


SELECT  *
FROM emp
ORDER BY HIREDATE DESC ;

SELECT ENAME,JOB,sal+ifnull(COMM,0)
FROM emp
ORDER BY JOB  DESC ,sal+ifnull(comm,0);


SELECT
  ename,
  round((SAL + ifnull(COMM, 0)) / 30, 4)
FROM scott.emp;


SELECT *
  FROM   emp
WHERE  extract( MONTH  FROM HIREDATE)= 2     or extract( MONTH  FROM HIREDATE)=9;

SELECT
  ENAME,
  datediff
  (current_time,HIREDATE)
FROM   emp;

SELECT
  ENAME,
  HIREDATE,
  date_format(from_days(datediff(current_date, HIREDATE)), '%y year %m month %d day')
#   date_format(from_days(datediff(current_date,HIREDATE)),'year   monyh  day')
FROM emp;

SELECT
  time_to_sec('10:00:00');
SELECT sec_to_time(1233);

SELECT date_format(from_days(datediff(current_date,HIREDATE)),'%y  y  %m  m%d  d')FROM   emp;


SELECT d.DEPTNO  ,d.DNAME
FROM emp  e JOIN dept  d
ON e.DEPTNO = d.DEPTNO;

SELECT *
FROM emp  WHERE sal+ifnull(COMM,0)>(
  SELECT  sal+ifnull(comm,0)
  FROM emp   WHERE ENAME='scott');