
USE exDB;

SHOW TABLES;

SELECT * FROM orders;
SELECT * FROM customers;
SELECT * FROM shippers;

-- inner join
-- 테이블 2개 
SELECT c.CustomerID ,o.OrderID, c.CustomerName, o.OrderDate 
FROM orders AS o INNER JOIN customers AS c ON o.CustomerID=c.CustomerID;

-- 테이블 3개
SELECT o.OrderID, c.CustomerID, c.CustomerName, s.ShipperName 
FROM orders AS o 
INNER JOIN customers AS c ON o.CustomerID = c.CustomerID
INNER JOIN shippers AS s ON o.ShipperID = s.ShipperID;

-- left join
SELECT c.CustomerID, o.OrderID, c.CustomerName FROM customers c 
LEFT JOIN orders o ON c.CustomerID = o.CustomerID
ORDER BY c.CustomerID;

-- right join
SELECT * FROM employees;
SELECT * FROM orders;

SELECT e.EmployeeID, o.OrderID, e.LastName, e.FirstName FROM orders o 
RIGHT JOIN employees e ON o.EmployeeID = e.EmployeeID
ORDER BY o.EmployeeID;

-- cross join
SELECT * FROM customers;
SELECT * FROM orders;

SELECT c.CustomerID, c.CustomerName, o.OrderID 
FROM customers c CROSS JOIN orders o;

SELECT c.CustomerID, c.CustomerName, o.OrderID 
FROM customers c CROSS JOIN orders o
WHERE c.CustomerID=o.CustomerID;

-- self join

-- 같은 도시에 사는 모든 고객들을 도시별로 나열(중복 발생).
SELECT A.CustomerID, B.CustomerID, 
A.CustomerName AS CustomerName1, 
B.CustomerName AS CustomerName2, 
A.City A도시, B.City B도시
FROM customers A, customers B
WHERE A.CustomerID <> B.CustomerID
AND A.City = B.City ORDER BY A.City;

-- union
SELECT * FROM customers;
SELECT * FROM suppliers;

-- 고객과 공급처의 모든 도시 나열(중복 제거)
SELECT city FROM customers
UNION 
SELECT city FROM suppliers ORDER BY city;

-- 고객과 공급처의 모든 독일 도시 나열(중복제거)
SELECT City, Country FROM customers WHERE country='Germany'
UNION
SELECT City, country FROM suppliers WHERE country='Germany'
ORDER BY city;

-- 모든 고객과 모든 공급처 나열
SELECT 'Customer' AS TYPE, ContactName, City, Country FROM customers
UNION
SELECT 'Supplier', ContactName, City, Country FROM suppliers;

-- union all

SELECT city FROM customers
UNION ALL
SELECT city FROM suppliers ORDER BY city;

SELECT city, country FROM customers WHERE country='Germany'
UNION all
SELECT city, country FROM suppliers WHERE country='Germany' 
ORDER BY city;









