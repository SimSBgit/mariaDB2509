CREATE DATABASE hrdtest;

USE hrdtest;

CREATE TABLE bookTable(
	BookId INT PRIMARY KEY,
	BookTitle VARCHAR(255) NOT NULL,
	Author VARCHAR(100),
	Publisher VARCHAR(50),
	Price INT,
	PublishYear YEAR,
	CONSTRAINT checkedPrice CHECK(Price >= 0)
);

CREATE TABLE memberTable(
	MemberID INT PRIMARY KEY,
	NAME VARCHAR(20) NOT NULL,
	Phone VARCHAR(20),
	Address VARCHAR(255)
);

CREATE TABLE rentalTable(
	RentalID INT PRIMARY KEY,
	MemberID INT,
	BookID INT,
	RentDate DATE,
	ReturnDate DATE,
	CONSTRAINT FK_book FOREIGN KEY(BookID) REFERENCES bookTable(BookID),
	CONSTRAINT FK_member FOREIGN KEY(memberID) REFERENCES memberTable(memberID)
);

DESC bookTable;
DESC rentalTable;
DESC memberTable;

INSERT INTO bookTable (BookId, BookTitle, Author, Publisher, Price, PublishYear)
VALUES
(1, '콩쥐팥쥐', '작가1', '출판사1', 10000, 2020),
(2, '팥죽 할머니와 호랑이', '작가2', '출판사2', 20000, 2019),
(3, '빨간 부채 파란 부채', '작가3', '출판사3', 15000, 2022);

INSERT INTO rentalTable(RentalID, MemberID, BookID, RentDate, ReturnDate)
VALUES
(1, 3, 3, '2025-05-01', null),
(2, 1, 2, '2025-05-03', '2025-05-07'),
(3, 2, 1, '2025-05-10', null);

INSERT INTO memberTable(MemberID, NAME, Phone, Address)
VALUES
(1, '둘리', '010-1111-2222', '서울'),
(2, '홍길동', '010-5555-6666', '한양'),
(3, '고길동', '010-9999-8888', '서울');

SELECT * FROM bookTable;
SELECT * FROM rentalTable;
SELECT * FROM memberTable;

DROP TABLE bookTable;
DROP TABLE rentalTable;
DROP TABLE memberTable;

SHOW INDEX FROM bookTable;
SHOW INDEX FROM rentalTable;
SHOW INDEX FROM memberTable;

-- 1
SELECT BookTitle `2020년부터 출판된 도서` FROM bookTable WHERE YEAR(PublishYear) >= 2020;

-- 2
SELECT b.BookTitle `홍길동 대출도서목록`
FROM rentalTable r INNER JOIN bookTable b ON r.BookID=b.BookID
INNER JOIN memberTable m ON r.memberID=m.memberID 
WHERE m.NAME = '홍길동';

-- 3
SELECT b.BookTitle FROM bookTable b 
INNER JOIN rentalTable r ON b.BookID=r.BookID
WHERE r.ReturnDate IS NULL 
GROUP BY b.BookID, b.BookTitle;

-- 4
SELECT b.BookTitle `미반납 도서`, COUNT(r.RentalID) AS `대출 횟수` 
FROM booktable b LEFT join rentaltable r ON r.BookID=b.BookID 
group BY b.BookID, b.BookTitle ORDER BY b.BookID;

-- 5
SELECT BookTitle `가장 비싼 도서` FROM bookTable 
WHERE price = (SELECT MAX(price) FROM bookTable);


