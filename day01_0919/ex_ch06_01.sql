USE sqlDB;

SELECT * FROM userTbl;
SELECT * FROM buyTbl;

SELECT * FROM userTbl WHERE NAME = '김경호';

SELECT userID, name FROM userTbl WHERE birthYear >= 1970 AND height >= 182;

SELECT NAME, height FROM userTbl WHERE height >= 180 AND height <= 183;

SELECT NAME, mDate FROM userTbl ORDER BY mDate;

ALTER TABLE userTbl DROP PRIMARY KEY;
ALTER TABLE userTbl DROP INDEX;
ALTER TABLE userTbl DROP FOREIGN KEY ;

SHOW INDEX FROM userTbl;

SELECT *
FROM information_schema.KEY_COLUMN_USAGE
WHERE TABLE_NAME = 'userTbl';











