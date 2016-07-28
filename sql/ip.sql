CREATE DATABASE db_ip;

DROP TABLE db_ip.ip;
CREATE TABLE db_ip.ip (
  id     INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  start  BIGINT(12),
  end    BIGINT(12),
  adress VARCHAR(255)
);

ALTER TABLE db_ip.ip
    CHANGE adress address VARCHAR(255);

SELECT *
FROM db_ip.ip;

TRUNCATE TABLE db_ip.ip;

-- IPV4 11.11.2.111

# SELECT *
# FROM db_ip.ip
# WHERE some_ip BETWEEN start AND end;