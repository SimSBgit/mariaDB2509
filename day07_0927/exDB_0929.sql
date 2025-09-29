SHOW DATABASES;

SHOW TABLES;

SELECT * FROM persons;
DROP TABLE persons;

CREATE TABLE Persons(
	ID INT NOT NULL,
	LastName VARCHAR(255) NOT NULL,
	FistName VARCHAR(255) NOT NULL,
	Age int
);

DESC persons;

ALTER TABLE persons MODIFY age INT NOT NULL;

CREATE TABLE persons(
	ID INT NOT NULL,
	LastName VARCHAR(255) NOT NULL,
	FirstName VARCHAR(255),
	Age INT,
	UNIQUE (ID)
);

CREATE TABLE persons(
	ID INT NOT NULL,
	LastName VARCHAR(255) NOT NULL,
	FirstName VARCHAR(255),
	Age int
	CONSTRAINT UC_Person UNIQUE (ID, LastName)
);

CREATE TABLE persons(
	ID INT NOT NULL,
	LastName VARCHAR(255) NOT NULL,
	FirstName VARCHAR(255),
	Age INT,
	PRIMARY KEY (id)
);

CREATE TABLE persons(
	ID INT NOT NULL,
	LastName VARCHAR(255) NOT NULL,
	FirstName VARCHAR(255),
	Age INT,
	CONSTRAINT PK_Person PRIMARY KEY(ID, LastName)
);

CREATE TABLE persons(
	ID INT NOT NULL,
	LastName VARCHAR(255) NOT NULL,
	FirstName VARCHAR(255),
	Age INT
);

ALTER TABLE persons ADD UNIQUE (id);

DROP TABLE persons;
SELECT * FROM persons;
DESC persons;

ALTER TABLE persons ADD CONSTRAINT UC_Person UNIQUE (id,lastname);

SHOW INDEX FROM persons;

ALTER TABLE persons DROP INDEX uc_person;

-- 제약조건 조회 방법
SELECT * FROM information_schema.table_constraints
WHERE TABLE_NAME = 'Persons';

SELECT CONSTRAINT_NAME, constraint_type, TABLE_NAME
FROM information_schema.table_constraints
WHERE TABLE_NAME = 'persons';

SELECT CONSTRAINT_NAME, COLUMN_NAME, ordinal_position
FROM information_schema.key_column_usage
WHERE TABLE_NAME = 'persons'
	AND CONSTRAINT_NAME = 'uc_person';
	
ALTER TABLE persons ADD PRIMARY KEY(id);
ALTER TABLE persons ADD CONSTRAINT PK_Person PRIMARY KEY(ID,LastName);

ALTER TABLE persons DROP PRIMARY KEY;

DESC orders;
SELECT * FROM orders;

CREATE TABLE persons_f(
	personID INT PRIMARY KEY,
	LastName VARCHAR(255) NOT NULL,
	FirstName VARCHAR(255),
	Age INT
);

SELECT * FROM persons_f;
DESC persons_f;
DESC orders_f;

DROP TABLE orders_f;

CREATE TABLE orders_f (
	orderID INT NOT NULL,
	orderNumber INT NOT NULL,
	personID INT,
	PRIMARY KEY(orderID),
	FOREIGN KEY(personID) REFERENCES persons_f(personID)
);

CREATE TABLE orders_f (
	orderID INT NOT NULL,
	orderNumber INT NOT NULL,
	personID INT,
	PRIMARY KEY(orderID),
	CONSTRAINT FK_PersonOrder FOREIGN KEY(personID) 
	REFERENCES persons_f(personID)
);

SHOW INDEX FROM orders_f;

DROP TABLE orders_f;

SELECT * FROM persons_f;
DESC persons_f;
DESC orders_f;

CREATE TABLE orders_f (
	orderID INT NOT NULL,
	orderNumber INT NOT NULL,
	personID INT
);

-- FK 제약조건 이름 미지정
ALTER TABLE orders_f ADD FOREIGN KEY (personID) 
REFERENCES persons_f(personID);

-- FK 제약조건 이름 지정(권장)
ALTER TABLE orders_f ADD CONSTRAINT FK_PersonOrder
FOREIGN KEY (personID) REFERENCES persons_f(personID);

-- 위 SQL로 만든 FK와 인덱스는 아래 구문으로 지우면 안지워짐
ALTER TABLE orders_f DROP FOREIGN KEY personID;
ALTER TABLE orders_f DROP INDEX FK_PersonOrder;

-- 제약조건or인덱스 이름이 부정확할 때는 아래 순서로 지우면 됨.
-- 테이블 제약조건과 index 확인
SHOW CREATE TABLE orders_f;

ALTER TABLE orders_f DROP FOREIGN KEY orders_f_ibfk_1;

ALTER TABLE orders_f DROP INDEX FK_PersonOrder;


------------------------------------------------------

DROP TABLE persons;
DESC persons;

CREATE TABLE persons(
	id INT NOT NULL,
	lastname VARCHAR(255) NOT NULL,
	firstname VARCHAR(255),
	age INT,
	city VARCHAR(255),
	CONSTRAINT chk_person CHECK(age >= 18 AND city = 'sandnes')
);

CREATE TABLE persons(
	id INT NOT NULL,
	lastname VARCHAR(255) NOT NULL,
	firstname VARCHAR(255),
	age INT,
	city VARCHAR(255)
);

ALTER TABLE persons ADD CHECK(age >= 18);

SELECT * FROM information_schema.table_constraints
WHERE TABLE_NAME = 'Persons';

ALTER TABLE persons ADD CONSTRAINT CHK_PersonAge 
CHECK (Age>=18 AND city='Sandnes');

ALTER TABLE persons DROP CONSTRAINT CHK_PersonAge;


