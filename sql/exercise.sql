# PART I
# 1. 查找部门 30 中员工的详细信息
SELECT *
FROM scott.emp
WHERE DEPTNO = 30;
# 2. 找出从事 clerk 工作的员工的编号、姓名、部门号
SELECT
  EMPNO,
  ENAME,
  DEPTNO
FROM emp
WHERE JOb = 'clerk';
# 3. 检索出奖金多于基本工资的员工信息
SELECT *
FROM emp
WHERE comm > sal; -- null
# 4. 检索出奖金多于基本工资 30% 员工信息
SELECT *
FROM emp
WHERE COMM > SAL * 0.3;
# 5. 希望看到10部门的经理或者 20 部门的职员 clerk 的信息
SELECT *
FROM emp
WHERE (DEPTNO = 10 AND JOB = 'manager') OR (DEPTNO = 20 AND JOB = 'clerk');
# 6. 找出 10 部门的经理、20 部门的职员或者既不是经理也不是职员但是高于 2000 元的员工信息
SELECT *
FROM emp
WHERE (DEPTNO = 10 AND JOB = 'manager') OR (DEPTNO = 20 AND JOB = 'clerk') OR
      (JOB <> 'manager' AND JOB <> 'clerk' AND emp.SAL + ifnull(COMM, 0) > 2000);
# 7. 找出获得奖金的员工的工作
SELECT
  JOB,
  COMM
FROM emp
WHERE COMM IS NOT NULL AND emp.COMM > 0;
# 8. 找出奖金少于100或者没有获得奖金的员工的信息
SELECT
  JOB,
  COMM
FROM emp
WHERE COMM IS NULL OR COMM < 100;
# 9. 查找员工雇佣日期是当月的最后一天雇佣的
SELECT *
FROM emp
WHERE HIREDATE = last_day(HIREDATE);
# 10. 检索出雇佣年限超过 35 年的员工信息
SELECT *
FROM emp
WHERE date_sub(current_date, INTERVAL 28 YEAR) > emp.HIREDATE;

SELECT datediff(current_date, '2000-1-1');
# 11. 找出姓名以 A、B、S 开始的员工信息
SELECT *
FROM emp
WHERE ENAME REGEXP '^[abs]';
# 12. 找到名字长度为 4 个字符的员工信息
SELECT *
FROM emp
WHERE length(ENAME) = 4;
# 13. 名字中不包含 R 字符的员工信息
SELECT *
FROM emp
WHERE ENAME NOT LIKE '%r%';
# 14. 找出员工名字的前3个字符
SELECT substr(ENAME, 1, 3)
FROM emp;
# 15. 将名字中 A 改为 a
SELECT replace(ENAME, 'a', 'A')
FROM emp;
# 16. 将员工的雇佣日期拖后10年
SELECT
  HIREDATE,
  date_add(HIREDATE, INTERVAL 10 YEAR)
FROM emp;
# 17. 返回员工的详细信息并按姓名排序
SELECT *
FROM emp
ORDER BY ENAME;
# 18. 返回员工的信息并按员工的工作年限降序排列
SELECT *
FROM emp
ORDER BY HIREDATE;
# 19. 返回员工的信息并按工作降序、工资升序排列
SELECT *
FROM emp
ORDER BY JOB DESC, sal + ifnull(COMM, 0);
# 20. 返回员工的姓名、雇佣年份和月份，并按月份和雇佣日期排序
SELECT
  ENAME,
  HIREDATE,
  extract(YEAR FROM HIREDATE),
  extract(MONTH FROM HIREDATE)
FROM emp
ORDER BY extract(MONTH FROM HIREDATE), extract(DAY FROM HIREDATE);
# 21. 计算员工的日薪，每月按30天
SELECT round((SAL + ifnull(COMM, 0)) / 30, 2)
FROM emp;
# 22. 找出2月份雇佣的员工
SELECT *
FROM emp
WHERE extract(MONTH FROM HIREDATE) = 2;
# 23. 至今为止，员工被雇佣的天数
SELECT datediff(current_date, HIREDATE)
FROM emp;
# 24. 找出姓名中包含 A 的员工信息
SELECT *
FROM emp
WHERE ENAME LIKE '%a%';
# 25. 计算出员工被雇佣了多少年、多少月、多少日
SELECT datediff(current_date, HIREDATE)
FROM emp;

SELECT from_days(1234);

SELECT date_format('2016-5-21', '%Y 年 %m 月 %d 日');

SELECT date_format(from_days(datediff(current_date, HIREDATE)), '%y 年 %m 月 %d 日')
FROM emp;

# PART II
# 1. 返回拥有员工的部门名、部门号
SELECT
  d.DEPTNO,
  d.DNAME
FROM emp e JOIN dept d
    ON e.DEPTNO = d.DEPTNO;
# 2. 工资多于 scott 的员工信息
SELECT *
FROM emp
WHERE sal + ifnull(COMM, 0) > (
  SELECT sal + ifnull(COMM, 0)
  FROM emp
  WHERE ENAME = 'scott'
);
# 3. 返回员工和所属经理的姓名
SELECT
  e1.ENAME,
  e2.ENAME
FROM emp e1 JOIN emp e2
    ON e1.MGR = e2.EMPNO;
# 4. 返回雇员的雇佣日期早于其经理雇佣日期的员工及其经理姓名
SELECT
  e1.ENAME,
  e2.ENAME
FROM emp e1 JOIN emp e2
    ON e1.MGR = e2.EMPNO
WHERE e1.HIREDATE < e2.HIREDATE;
# 5. 返回员工姓名及其所在的部门名称
SELECT
  e.ENAME,
  d.DNAME
FROM emp e JOIN dept d
    ON e.DEPTNO = d.DEPTNO;
# 6. 返回从事 clerk 工作的员工姓名和所在部门名称
SELECT
  e.ENAME,
  d.DNAME
FROM emp e JOIN dept d
    ON e.DEPTNO = d.DEPTNO
WHERE e.JOB = 'clerk';
# 7. 返回部门号及其本部门的最低工资
SELECT
  DEPTNO,
  min(sal + ifnull(COMM, 0))
FROM emp
GROUP BY DEPTNO;
# 8. 返回销售部 sales 所有员工的姓名
SELECT ENAME
FROM emp
WHERE DEPTNO = (
  SELECT DEPTNO
  FROM dept
  WHERE DNAME = 'sales'
);
# 9. 返回工资多于平均工资的员工
SELECT *
FROM emp
WHERE sal + ifnull(COMM, 0) > (
  SELECT avg(sal + ifnull(COMM, 0))
  FROM emp
);
# 10. 返回与 scott 从事相同工作的员工
SELECT *
FROM emp
WHERE JOB = (
  SELECT JOB
  FROM emp
  WHERE ENAME = 'scott'
);
# 11. 返回与30部门员工工资水平高于的员工姓名与工资
SELECT
  ENAME,
  sal + ifnull(COMM, 0)
FROM emp
WHERE sal + ifnull(COMM, 0) > (
  SELECT avg(sal + ifnull(COMM, 0))
  FROM emp
  WHERE DEPTNO = 30
);
# 12. 返回工资高于30部门所有员工工资水平的员工信息
# 13. 返回部门号、部门名、部门所在位置及其每个部门的员工总数
SELECT
  d.DEPTNO,
  d.DNAME,
  d.LOC,
  count(*)
FROM emp e JOIN dept d
    ON e.DEPTNO = d.DEPTNO
GROUP BY e.DEPTNO;
# 14. 返回员工的姓名、所在部门名及其工资
SELECT
  e.ENAME,
  d.DNAME,
  e.SAL + ifnull(e.COMM, 0)
FROM emp e JOIN dept d
    ON e.DEPTNO = d.DEPTNO;
# 15. 返回雇员表中不在同一部门但是从事相同工作的员工信息
SELECT
  e1.ENAME,
  e2.ENAME
FROM emp e1, emp e2
WHERE e1.DEPTNO <> e2.DEPTNO AND e1.JOB = e2.JOB;
# 16. 返回员工的详细信息，包括部门名
SELECT
  e.*,
  d.DNAME
FROM emp e JOIN dept d
    ON e.DEPTNO = d.DEPTNO;
# 17. 返回员工工作及其从事此工作的最低工资
SELECT
  JOB,
  min(sal + ifnull(COMM, 0))
FROM emp
GROUP BY JOB;
# 18. 返回不同部门经理的最低工资
SELECT
  DEPTNO,
  min(sal + ifnull(COMM, 0))
FROM emp
WHERE JOB = 'salesman'
GROUP BY DEPTNO;
# 19. 计算出员工的年薪，并且以年薪排序
SELECT
  ENAME,
  (sal + ifnull(COMM, 0)) * 12
FROM emp
ORDER BY 2;
# 20. 返回工资处于第4级别的员工的姓名
SELECT e.ENAME
FROM emp e JOIN salgrade s
    ON e.SAL BETWEEN s.LOSAL AND s.HISAL
WHERE s.GRADE = 4;


SELECT
  deptno,
  avg(sal)
FROM emp
GROUP BY DEPTNO
HAVING avg(sal) < 2000;