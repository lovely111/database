DROP DATABASE IF EXISTS db_csdn;
CREATE DATABASE db_csdn;

DROP TABLE IF EXISTS db_csdn.user;
CREATE TABLE db_csdn.user (
  id       INT UNSIGNED AUTO_INCREMENT PRIMARY KEY
  COMMENT 'PK',
  username VARCHAR(191) COMMENT '用户名',
  password VARCHAR(191) COMMENT '密码',
  email    VARCHAR(191) COMMENT '邮箱'
)
  COMMENT '用户表';

# 数据导入 MySQL 数据库
LOAD DATA LOCAL INFILE '/Users/mingfei/Documents/www.csdn.net.sql' INTO TABLE db_csdn.user
FIELDS TERMINATED BY ' # '
LINES TERMINATED BY '\n'
(username, password, email);
# [2016-05-22 16:24:04] 6428632 rows affected in 3m 23s 2ms

SELECT *
FROM db_csdn.user
WHERE id = 601;

-- ------------------------
# 各列值的快速模糊查询
# CREATE INDEX ind_user_username_password_email ON db_csdn.user (username, password, email);
# [2016-05-22 16:42:41] completed in 6m 30s 326ms
# DROP INDEX ind_user_username_password_email ON db_csdn.user;

CREATE INDEX ind_user_username ON db_csdn.user (username)
  COMMENT 'INDEX for username';
CREATE INDEX ind_user_password ON db_csdn.user (password)
  COMMENT 'INDEX for password';
CREATE INDEX ind_user_email ON db_csdn.user (email)
  COMMENT 'INDEX for email';



SELECT *
FROM db_csdn.user
WHERE username LIKE '%some_username%';

SELECT *
FROM db_csdn.user
WHERE password LIKE '%some_password%';

SELECT *
FROM db_csdn.user
WHERE email LIKE '%some_email%';

-- ------------------------
# 排名前十的密码
SELECT
  password,
  count(*)
FROM db_csdn.user
GROUP BY password
ORDER BY 2 DESC
LIMIT 10;
# [2016-05-22 23:08:34] 10 ROWS retrieved STARTING FROM 1 IN 5s 918ms (execution:5s 895ms, fetching:23ms)
/*
123456789	235025
12345678	212751
11111111	76346
dearbook	46054
00000000	34952
123123123	19986
1234567890	17791
88888888	15033
111111111	6995
147258369	5966
*/

-- ------------------------
# 排名前十的邮箱
SELECT
  substr(email, instr(email, '@') + 1, length(email)),
  count(*)
FROM db_csdn.user
GROUP BY 1
ORDER BY 2 DESC
LIMIT 10;
# [2016-05-22 23:38:10] 10 rows retrieved starting from 1 in 1m 13s 96ms (execution: 1m 13s 90ms, fetching: 6ms)
/*
qq.com	1976046
163.com	1766758
126.com	807839
sina.com	351520
yahoo.com.cn	205475
hotmail.com	202930
gmail.com	186830
sohu.com	104724
yahoo.cn	87046
tom.com	72359
*/

-- ------------------------
# 用户名和邮箱名相同的数据
SELECT count(*)
FROM db_csdn.user
WHERE username = substr(email, 1, instr(email, '@') - 1);
# [2016-05-22 23:47:46] 1 row retrieved starting from 1 in 7s 369ms (execution: 7s 358ms, fetching: 11ms)
# 1463650

-- ------------------------
# 密码可能是生日的数据
SELECT count(*)
FROM db_csdn.user
WHERE password REGEXP '^[0-9]{8}$'
      AND mid(password, 1, 4) BETWEEN 1900 AND 2011 -- yyyy [1900, 2011]
      AND mid(password, 5, 2) BETWEEN 1 AND 12 -- mm [1, 12]
      AND mid(password, 7, 2) BETWEEN 1 AND 31 -- dd [1, 31]
      AND password <= 20111221;
# [2016-05-23 00:21:35] 1 row retrieved starting from 1 in 9s 94ms (execution: 9s 88ms, fetching: 6ms)
# 396989

SHOW FULL COLUMNS FROM db_csdn.user;
SHOW INDEX FROM db_csdn.user;