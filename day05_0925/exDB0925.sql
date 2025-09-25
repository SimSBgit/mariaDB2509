USE exdb;

SELECT * FROM customers;
SELECT * FROM products;
SELECT * FROM categories;
SELECT * FROM employees;
SELECT * FROM orderdetails;
SELECT * FROM orders;
SELECT * FROM shippers;
SELECT * FROM suppliers;

SELECT country '나라', COUNT(*) '고객 수' FROM customers GROUP BY country;

SELECT COUNT(customerid), country FROM customers GROUP BY country;

SELECT COUNT(customerid), country FROM customers 
GROUP BY country ORDER BY COUNT(customerid) desc;

SELECT * FROM shippers;
SELECT * FROM orders;

SELECT s.ShipperName, COUNT(o.OrderID) '주문 수량'
FROM orders o LEFT JOIN shippers s ON o.ShipperID = s.ShipperID GROUP BY shippername;

SELECT country, COUNT(customerid) '고객 수' FROM customers GROUP BY country
HAVING COUNT(customerid) > 5;

SELECT country, COUNT(customerid) '고객 수' FROM customers GROUP BY country
HAVING COUNT(customerid) > 5 ORDER BY COUNT(customerid) desc;

SELECT * FROM orders;
SELECT * FROM employees;

SELECT e.LastName, COUNT(o.OrderID) '주문 수'
FROM (orders o INNER JOIN employees e ON o.EmployeeID = e.EmployeeID)
GROUP BY lastname HAVING COUNT(o.OrderID) > 10;

-- 주문 수 총 합계 행 추가
SELECT e.LastName, COUNT(o.OrderID) '주문 수'
FROM (orders o INNER JOIN employees e ON o.EmployeeID = e.EmployeeID)
GROUP BY lastname HAVING COUNT(o.OrderID) > 10
UNION
SELECT '총 합' AS lastname, COUNT(o.OrderID) '주문 수' FROM orders o;

-- where 조건에 맞는 행의 합계를 나타내는 행 추가
SELECT e.LastName, COUNT(o.OrderID) '주문 수량'
FROM orders o INNER JOIN employees e ON o.EmployeeID=e.EmployeeID
WHERE lastname = 'Davolio' OR lastname = 'Fuller'
GROUP BY lastname HAVING COUNT(o.OrderID) > 25
UNION
SELECT '총 합' as LastName, COUNT(o.OrderID) '주문 수량' 
FROM orders o INNER JOIN  employees e ON o.EmployeeID = e.EmployeeID
WHERE lastname = 'Davolio' OR lastname = 'Fuller';

SELECT * FROM suppliers;
SELECT * FROM products;

-- 제품 가격이 20 미만인 공급업체의 이름을 나열
SELECT suppliername FROM suppliers s WHERE EXISTS 
(SELECT productname FROM products p WHERE p.SupplierID=s.SupplierID AND price < 20);

SELECT productname, price, supplierid FROM products WHERE price < 20;

SELECT suppliername, SupplierID FROM suppliers s WHERE EXISTS 
(SELECT productname FROM products p WHERE p.SupplierID=s.SupplierID AND price = 22);

SELECT productname, SupplierID, productid FROM products WHERE price = 22;




