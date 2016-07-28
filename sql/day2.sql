USE demo;

DESC demo.user;

INSERT INTO demo.user VALUES (NULL, 'asdf@test.com', '李斯', '123', 'M', 18, 1.7, 5000, '1998-1-1');
INSERT INTO demo.user (id, password) VALUES (NULL, '123');
INSERT INTO demo.user (password) VALUES ('123');

UPDATE demo.user
SET password = 'test';

UPDATE demo.user
SET password = '123', email = 'tester@test.com'
WHERE id = 4;

DELETE FROM demo.user
WHERE sex IS NOT NULL;

SELECT *
FROM demo.user;

USE scott;

SHOW TABLES;

DESC scott.emp;
DESC scott.dept;
DESC scott.salgrade;

SELECT *
FROM scott.emp;

SELECT
  EMPNO,
  ENAME,
  SAL
FROM scott.emp;

SELECT DISTINCT JOB
FROM emp;

SELECT count(*)
FROM emp;

SELECT
  EMPNO,
  ENAME,
  HIREDATE,
  JOB,
  SAL
FROM emp
WHERE sal > 1000 OR JOB = 'salesman';


SELECT *
FROM emp
ORDER BY JOB DESC, ENAME DESC; -- ASCend DESCend

# user:scoot
# pwd:tiger

SELECT *
FROM emp
LIMIT 0, 3; -- offset 偏移量， count

SELECT *
FROM emp
WHERE ENAME NOT LIKE '%a%';

SELECT *
FROM emp
WHERE ENAME RLIKE '[a-b]';

SELECT *
FROM emp
WHERE JOB NOT IN ('manager', 'salesman', 'clerk');

SELECT *
FROM emp
WHERE SAL NOT BETWEEN 1100 AND 1600;

SELECT e.ENAME '员工 姓名'
FROM emp AS e;

SELECT *
FROM emp
WHERE COMM IS NULL;

UPDATE emp
SET COMM = NULL
WHERE ename = 'allen';

SELECT
  ENAME,
  SAL + ifnull(COMM, 0)
FROM emp;

SELECT *
FROM emp;

DESC emp;