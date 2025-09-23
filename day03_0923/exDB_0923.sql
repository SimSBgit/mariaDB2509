USE exdb;

SELECT * FROM customers;

-- Update
UPDATE customers 
SET contactname = 'Alfred Schmidt', city = 'frankfurt'
WHERE CustomerID = 1;

UPDATE customers
SET postalcode = '00000'
WHERE country = 'Mexico';

DELETE FROM customers WHERE customername = 'Alfreds Futterkiste';

-- Limit
SELECT * FROM customers LIMIT 3;
SELECT * FROM customers LIMIT 3 OFFSET 3;
SELECT * FROM customers WHERE country = 'germany' LIMIT 3;
SELECT * FROM customers ORDER BY country LIMIT 3;

SELECT * FROM products;

-- min / max
SELECT MIN(price) AS smallestprice FROM products;
SELECT MAX(price) as largestprice FROM products;

-- count / average / sum
SELECT COUNT(*) FROM products;
SELECT COUNT(productid) FROM products;

SELECT AVG(price) AS 평균가격 FROM products;

DESCRIBE orderdetails;
SELECT * FROM orderdetails;

SELECT SUM(quantity) AS SUM FROM orderdetails;

-- like
SELECT * FROM customers WHERE customername LIKE 'a%';
SELECT * FROM customers WHERE customername LIKE '%a';
SELECT * FROM customers WHERE customername LIKE '%or%';
SELECT * FROM customers WHERE customername LIKE '_r%';
SELECT * FROM customers WHERE customername LIKE 'a__%';
SELECT * FROM customers WHERE contactname LIKE 'a%o';
SELECT * FROM customers WHERE customername NOT LIKE 'a%';

SELECT * FROM customers WHERE city LIKE 'ber%';
SELECT * FROM customers WHERE city LIKE '%es%';
SELECT * FROM customers WHERE city LIKE '_ondon';
SELECT * FROM customers WHERE city LIKE 'L_n_on';

-- in
SELECT * FROM customers WHERE country IN ('germany', 'france', 'uk');
SELECT * FROM customers WHERE country NOT IN ('germany', 'france', 'uk'); 

SELECT * FROM suppliers;
SELECT country FROM suppliers;
SELECT * FROM customers WHERE country IN (SELECT country FROM suppliers);
-- 아래는 in에서  국가 중복 제거
SELECT DISTINCT country FROM customers WHERE country IN (SELECT country FROM suppliers);
SELECT COUNT(DISTINCT country) FROM customers WHERE country IN (SELECT country FROM suppliers);

-- between
SELECT * FROM products WHERE price BETWEEN 10 AND 20;
SELECT * FROM products WHERE price NOT BETWEEN 10 AND 20;

SELECT * FROM products WHERE price 
BETWEEN 10 AND 20 AND categoryid NOT IN (1,2,3);

SELECT * FROM products WHERE productname 
BETWEEN 'carnarvon tigers' AND 'mozzarella di giovanni'
ORDER BY productname;

SELECT * FROM products WHERE productname 
BETWEEN 'carnarvon tigers' AND 'chef anton''s cajun seasonging'
ORDER BY productname;

SELECT * FROM products WHERE productname 
NOT BETWEEN 'carnarvon tigers' AND 'mozzarella di giovanni'
ORDER BY productname;

SELECT * FROM orders WHERE orderdate 
BETWEEN '1996-07-01' AND '1996-07-31';

-- as
SELECT customerid AS id, customername AS customer FROM customers;

SELECT customername AS customer, 
contactname AS "contact person" FROM customers;

SELECT customername, CONCAT_WS
(', ', address, postalcode, city, country) as address FROM customers;

SELECT * from customers;
SELECT * from orders;

SELECT * FROM customers AS c, orders AS o;

SELECT o.orderid, o.orderdate, c.customername
FROM customers AS c, orders AS o
WHERE c.CustomerName='Around the Horn' AND c.CustomerID=o.CustomerID;



