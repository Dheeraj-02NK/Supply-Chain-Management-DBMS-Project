Consider the following schema for a Library Database:

BOOK(Book_id, Title, Publisher_Name, Pub_Year)
BOOK_AUTHORS(Book_id, Author_Name)
PUBLISHER(Name, Address, Phone)
BOOK_COPIES(Book_id, Programme_id, No-of_Copies)
BOOK_LENDING(Book_id, Programme_id, Card_No, Date_Out, Due_Date)
LIBRARY_PROGRAMME(Programme_id, Programme_Name, Address)

Write SQL queries to
1. Retrieve details of all books in the library – id, title, name of publisher, authors,
number of copies in each Programme, etc.

2. Get the particulars of borrowers who have borrowed more than 3 books, but
from Jan 2017 to Jun 2017.

3. Delete a book in BOOK table. Update the contents of other tables to reflect this
data manipulation operation.

4. Partition the BOOK table based on year of publication. Demonstrate its working
with a simple query.

5. Create a view of all books and its number of copies that are currently available
in the Library.

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--Create Table PUBLISHER with Primary Key as NAME

CREATE TABLE PUBLISHER
(NAME VARCHAR(20) PRIMARY KEY,
PHONE INTEGER,
ADDRESS VARCHAR(20));

DESC PUBLISHER;

--Create Table BOOK with Primary Key as BOOK_ID and Foreign Key PUB_NAME referring the PUBLISHER table

CREATE TABLE BOOK
(BOOK_ID INTEGER PRIMARY KEY,
TITLE VARCHAR(20),
PUB_YEAR VARCHAR(20),
PUB_NAME VARCHAR(20),
FOREIGN KEY (PUB_NAME) REFERENCES PUBLISHER(NAME) ON DELETE CASCADE);


DESC BOOK;

--Create Table BOOK_AUTHORS with Primary Key as BOOK_ID and AUTHOR_NAME and Foreign Key BOOK_ID referring the BOOK table

CREATE TABLE BOOK_AUTHORS
(AUTHOR_NAME VARCHAR(20),
BOOK_ID INTEGER,
FOREIGN KEY (BOOK_ID) REFERENCES BOOK(BOOK_ID) ON DELETE CASCADE,
PRIMARY KEY(BOOK_ID, AUTHOR_NAME));

DESC BOOK_AUTHORS;

--Create Table LIBRARY_PROGRAMME with Primary Key as PROGRAMME_ID

CREATE TABLE LIBRARY_PROGRAMME
(PROGRAMME_ID INTEGER PRIMARY KEY,
PROGRAMME_NAME VARCHAR(50),
ADDRESS VARCHAR(50));

DESC LIBRARY_PROGRAMME;

--Create Table as BOOK_COPIES with Primary Key as BOOK_ID and PROGRAMME_ID and Foreign Key BOOK_ID and PROGRAMME_ID referring the BOOK and LIBRARY_PROGRAMME tables respectively

CREATE TABLE BOOK_COPIES
(NO_OF_COPIES INTEGER,
BOOK_ID INTEGER,
PROGRAMME_ID INTEGER,
FOREIGN KEY (BOOK_ID) REFERENCES BOOK(BOOK_ID) ON DELETE CASCADE,
FOREIGN KEY(PROGRAMME_ID) REFERENCES LIBRARY_PROGRAMME(PROGRAMME_ID) ON DELETE CASCADE,
PRIMARY KEY (BOOK_ID,PROGRAMME_ID));

DESC BOOK_COPIES;

-- Create Table CARD with Primary Key as CARD_NO

CREATE TABLE CARD
(CARD_NO INTEGER PRIMARY KEY);

DESC CARD;

-- Create Table BOOK_LENDING With Primary Key as BOOK_ID, PROGRAMME_ID and CARD_NO and Foreign key as BOOK_ID, PROGRAMME_ID and CARD_NO referring the BOOK, LIBRARY_PROGRAMME and CARD tables respectively

CREATE TABLE BOOK_LENDING
(BOOK_ID INTEGER,
PROGRAMME_ID INTEGER,
CARD_NO INTEGER,
DATE_OUT DATE,
DUE_DATE DATE,
FOREIGN KEY (BOOK_ID) REFERENCES BOOK(BOOK_ID) ON DELETE CASCADE,
FOREIGN KEY (PROGRAMME_ID) REFERENCES LIBRARY_PROGRAMME(PROGRAMME_ID) ON DELETE CASCADE,
FOREIGN KEY (CARD_NO) REFERENCES CARD(CARD_NO) ON DELETE CASCADE,
PRIMARY KEY (BOOK_ID,PROGRAMME_ID,CARD_NO));

DESC BOOKLENDING;

------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--Inserting records into PUBLISHER table

INSERT INTO PUBLISHER VALUES('SAPNA',912121212,'BANGALORE');
INSERT INTO PUBLISHER VALUES('PENGUIN',921212121,'NEW YORK');
INSERT INTO PUBLISHER VALUES('PEARSON',913131313,'HYDERABAD');
INSERT INTO PUBLISHER VALUES('OZONE',931313131,'CHENNAI');
INSERT INTO PUBLISHER VALUES('PLANETZ',914141414,'BANGALORE');

SELECT * FROM PUBLISHER;

--------------------------

--Inserting records into BOOK table

INSERT INTO BOOK VALUES(1,'BASICS OF EXCEL','JAN-2017','SAPNA');
INSERT INTO BOOK VALUES(2,'PROGRAMMING MINDSET','JUN-2018','PLANETZ');
INSERT INTO BOOK VALUES(3,'BASICS OF SQL','SEP-2016','PEARSON');
INSERT INTO BOOK VALUES(4,'DBMS FOR BEGINNERS','SEP-2015','PLANETZ');
INSERT INTO BOOK VALUES(5,'WEB SERVICES','MAY-2017','OZONE');

SELECT * FROM BOOK;

--------------------------

--Inserting records into BOOK_AUTHORS table

INSERT INTO BOOK_AUTHORS VALUES('SRI DEVI',1);
INSERT INTO BOOK_AUTHORS VALUES('DEEPAK',2);
INSERT INTO BOOK_AUTHORS VALUES('PRAMOD',3);
INSERT INTO BOOK_AUTHORS VALUES('SWATHI',4);
INSERT INTO BOOK_AUTHORS VALUES('PRATHIMA',5);

SELECT * FROM BOOK_AUTHORS;

----------------------------

--Inserting records into LIBRARY_PROGRAMME table

INSERT INTO LIBRARY_PROGRAMME VALUES(100,'HSR LAYOUT','BANGALORE');
INSERT INTO LIBRARY_PROGRAMME VALUES(101,'KENGERI','BANGALORE');
INSERT INTO LIBRARY_PROGRAMME VALUES(102,'BANASHANKARI','BANGALORE');
INSERT INTO LIBRARY_PROGRAMME VALUES(103,'SHANKARA NAGAR','MANGALORE');
INSERT INTO LIBRARY_PROGRAMME VALUES(104,'MANIPAL','UDUPI');

SELECT * FROM LIBRARY_PROGRAMME;

-------------------------

--Inserting records into BOOK_COPIES table

INSERT INTO BOOK_COPIES VALUES(10,1,100);
INSERT INTO BOOK_COPIES VALUES(16,1,101);
INSERT INTO BOOK_COPIES VALUES(20,2,102);
INSERT INTO BOOK_COPIES VALUES(6,2,103);
INSERT INTO BOOK_COPIES VALUES(4,3,104);
INSERT INTO BOOK_COPIES VALUES(7,5,100);
INSERT INTO BOOK_COPIES VALUES(3,4,101);

SELECT * FROM BOOK_COPIES;

--------------------------

--Inserting records into BOOK_COPIES table

INSERT INTO CARD VALUES(500);
INSERT INTO CARD VALUES(501);
INSERT INTO CARD VALUES(502);
INSERT INTO CARD VALUES(503);
INSERT INTO CARD VALUES(504);

SELECT * FROM CARD;

--------------------------

--Inserting records into BOOK_LENDING table

INSERT INTO BOOK_LENDING VALUES(1, 100, 501, '2017-01-01','2017-01-31');
INSERT INTO BOOK_LENDING VALUES(3, 104, 501, '2017-01-11','2017-03-01');
INSERT INTO BOOK_LENDING VALUES(2, 103, 501, '2017-02-21','2017-04-21');
INSERT INTO BOOK_LENDING VALUES(4, 101, 501, '2017-03-11','2017-06-11');
INSERT INTO BOOK_LENDING VALUES(1, 101, 504, '2017-04-09','2017-07-08');

SELECT * FROM BOOK_LENDING;

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------

--Retrieve details of all books in the library – id, title, name of publisher, authors,
--number of copies in each Programme, etc. 

SELECT B.BOOK_ID, B.TITLE, B.PUB_NAME, A.AUTHOR_NAME,C.NO_OF_COPIES,L.PROGRAMME_ID
FROM BOOK B, BOOK_AUTHORS A, BOOK_COPIES C, LIBRARY_PROGRAMME L
WHERE B.BOOK_ID=A.BOOK_ID
AND B.BOOK_ID=C.BOOK_ID
AND L.PROGRAMME_ID=C.PROGRAMME_ID;

---------------------------------------------

--Get the particulars of borrowers who have borrowed more than 3 books, but
--from Jan 2017 to Jun 2017. 

SELECT CARD_NO
FROM BOOK_LENDING
WHERE DATE_OUT BETWEEN '2017-01-01' AND '2017-06-01'
GROUP BY CARD_NO
HAVING COUNT(*)>3;

---------------------------------------------

--Delete a book in BOOK table. Update the contents of other tables to reflect this
--data manipulation operation. 

DELETE FROM BOOK
WHERE BOOK_ID=3; 

SELECT * FROM BOOK;

SELECT * FROM BOOK_AUTHORS;

---------------------------------------------

--Partition the BOOK table based on year of publication. Demonstrate its working
--with a simple query. 

CREATE VIEW V_PUBLICATION AS SELECT
PUB_YEAR
FROM BOOK; 

SELECT * FROM V_PUBLICATION;

---------------------------------------------

--Create a view of all books and its number of copies that are currently available
--in the Library.

CREATE VIEW V_BOOKS AS
SELECT B.BOOK_ID, B.TITLE, C.NO_OF_COPIES
FROM
BOOK B, BOOK_COPIES C, LIBRARY_PROGRAMME L
WHERE B.BOOK_ID=C.BOOK_ID
AND C.PROGRAMME_ID=L.PROGRAMME_ID;

SELECT * FROM V_BOOKS;
