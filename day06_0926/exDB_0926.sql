SHOW DATABASES;

USE exDB;

SELECT * FROM products;
SELECT * FROM orderdetails;

-- Any = 해당 조건절이 참인 값이 하나라도 있으면 true 반환.
SELECT ProductName FROM products WHERE productid = 
ANY (SELECT ProductID from orderdetails WHERE quantity = 10);

SELECT count(ProductID) from orderdetails WHERE quantity = 10 GROUP BY ProductID;

SELECT productname FROM products WHERE productid =
ANY (SELECT productid FROM orderdetails WHERE quantity > 99);

SELECT count(ProductID) from orderdetails WHERE quantity >99 GROUP BY ProductID;

SELECT productname FROM products WHERE productid =
ANY (SELECT productid FROM orderdetails WHERE quantity > 1000);

-- All <=> Distinct 와 반대.
SELECT ALL productname FROM products WHERE TRUE;

-- = ALL (서브쿼리) --> 서브쿼리의 결과가 메인쿼리의 결과와 모두 같아야 함.
SELECT productname FROM products WHERE productid =
ALL (SELECT productid FROM orderdetails WHERE quantity = 10);

SELECT productid FROM orderdetails WHERE quantity = 10;

-- insert into select
SELECT * FROM customers;
SELECT * FROM suppliers;

INSERT INTO Customers (CustomerName, City, Country)
SELECT SupplierName, City, Country FROM suppliers;

INSERT INTO customers 
(customername, contactname, address, city, postalcode, country)
SELECT SupplierName, ContactName, Address, City, PostalCode, Country 
FROM Suppliers;

INSERT INTO Customers (CustomerName, City, Country)
SELECT SupplierName, City, Country FROM Suppliers
WHERE Country='Germany';

-- is null / is not null
SELECT * FROM customers WHERE contactname IS NULL;
SELECT * FROM customers WHERE customerid IS NULL;

-- case

SELECT orderid, quantity,
case
	when quantity > 30 then 'The quantity is greater than 30'
	when quantity = 30 then 'The quantity is 30'
	ELSE 'The quantity is under 30'
END AS QuantityText
FROM orderdetails;

SELECT customername, city, country
FROM customers
ORDER BY 
(case
	when city IS NULL then country
	ELSE city
END);

-- 예제에 사용할 테이블 임시 테이블 생성
CREATE TABLE if NOT exists product(
	P_id INT,
	ProductName VARCHAR(10),
	UnitPrice DECIMAL,
	UnitsInStock INT,
	UnitsOnOrder INT
);

DROP TABLE if EXISTS product;

INSERT INTO product(p_id, productname, unitprice, unitsinstock, unitsonorder) 
VALUES
(1, 'Jarlsberg', 10.45, 16, 15),
(2, 'Mascarpone', 32.56, 23, null),
(3, 'Grogonzola', 15.67, 9 ,20);

SELECT * FROM product;

-- ifnull() / coalesce() = null이 있을 때, null을 0으로 넣고 계산 실행.
SELECT productname, unitprice * (unitsinstock + unitsonorder) FROM product;

SELECT productname, unitprice * (unitsinstock + IFNULL(unitsonorder, 0))
FROM product;

SELECT productname, unitprice * (unitsinstock + coalesce(unitsonorder, 0))
FROM product;

CREATE TABLE Persons (
    PersonID int,
    LastName varchar(255),
    FirstName varchar(255),
    Address varchar(255),
    City varchar(255)
);

SELECT * FROM persons;

CREATE TABLE TestTable AS SELECT customername, contactname FROM customers;
CREATE TABLE TestTable2 AS SELECT customername, contactname FROM customers;

SELECT * FROM testtable;
SELECT * FROM testtable2;

-- drop / truncate
DROP TABLE testtable;
TRUNCATE TABLE testtable2;

-- alter add / drop column
ALTER TABLE customers ADD Email VARCHAR(255);
ALTER TABLE customers DROP COLUMN email;

SELECT * FROM customers;

-- desc = describe 
DESC customers;
DESCRIBE customers;


ALTER TABLE persons ADD DateOfBirth DATE;
DESC persons;
SELECT * FROM persons;

-- modify column -> 열의 데이터 타입 변경.
ALTER TABLE persons MODIFY COLUMN dateofbirth YEAR;
ALTER TABLE persons DROP COLUMN dateofbirth;



