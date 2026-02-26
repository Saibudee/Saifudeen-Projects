CREATE DATABASE movie_booking;
USE movie_booking;

SELECT * FROM bookings;
SELECT * FROM customers;
SELECT * FROM movies;
SELECT * FROM payments;
SELECT * FROM shows;
SELECT * FROM theatres;

-- 1. Comments
-- Write a comment before a query explaining what it does.
-- This query fetches all movies released in 2024
SELECT * FROM movies
WHERE YEAR(ReleaseDate) = '2024';

-- 2. SELECT & DISTINCT
-- SELECT all columns from the Movies table.
SELECT * FROM movies;

-- SELECT only the Title and Genre of all movies.
SELECT Title,Genre FROM movies;

--  SELECT DISTINCT Genre from the Movies table.
 SELECT DISTINCT Genre FROM movies;

-- 3. WHERE & Operators
-- SELECT all customers from the city "Chennai".
SELECT * FROM customers
WHERE City = "Chennai";

-- SELECT all bookings where SeatsBooked is greater than 3.
SELECT * FROM bookings
WHERE SeatsBooked > 3;

-- SELECT all payments where Status is "Pending".
SELECT * FROM payments
WHERE Status = "Pending";

-- SELECT all movies released between '2023-01-01' and '2024-01-01'.
SELECT * FROM movies
WHERE ReleaseDate BETWEEN '2023-01-01' AND '2024-01-01';

-- SELECT all shows with TicketPrice between 200 and 400.
SELECT * FROM shows
WHERE TicketPrice BETWEEN 200 AND 400;

-- SELECT all customers whose name starts with "C" using LIKE.
SELECT * FROM customers
WHERE Name LIKE "C%";

-- 4. ORDER BY
-- SELECT all movies ordered by ReleaseDate ascending.
SELECT * FROM movies
ORDER BY ReleaseDate ASC;

-- SELECT all bookings ordered by BookingDate descending.
SELECT * FROM bookings
ORDER BY BookingDate DESC;

-- 5. GROUP BY & Aggregates
-- Find total SeatsBooked per customer (Bookings table).
SELECT CustomerID,SUM(SeatsBooked) AS TOTAL_SEATSBOOKED
FROM bookings
GROUP  BY CustomerID;

-- Find total Amount paid per customer (Payments table).
SELECT PaymentID,SUM(Amount) AS TOTAL_AMOUNT_PAID
FROM payments
GROUP BY PaymentID;

-- Find the number of bookings for each show.
SELECT ShowID,COUNT(BookingID) AS NUMBER_OF_BOOKINGS
FROM bookings
GROUP BY ShowID;

-- 6. HAVING
-- Find customers who booked more than 2 shows;
SELECT CustomerID,COUNT(DISTINCT ShowID) AS NumberOfShows
FROM bookings
GROUP BY CustomerID
HAVING COUNT(DISTINCT ShowID) > 2;

-- Find shows where total seats booked > 10.
SELECT ShowID,SUM( DISTINCT SeatsBooked) AS TOTAL_SEATS_BOOKED
FROM bookings
GROUP BY ShowID
HAVING SUM(DISTINCT SeatsBooked) > 10;

-- 7. DELETE
-- DELETE the booking with BookingID = 5.
DELETE FROM bookings
WHERE BookingID = 5;
SELECT * FROM bookings;

-- 8. LIMIT / OFFSET
-- SELECT the first 5 customers using LIMIT.
SELECT * FROM customers
LIMIT 5;

-- SELECT customers skipping the first 5 rows using LIMIT with OFFSET.
SELECT * FROM customers
LIMIT 5 OFFSET 5;

-- 9. Subqueries
-- Find all customers who booked a show with TicketPrice > 400.
SELECT * FROM customers
WHERE CustomerID IN (SELECT CustomerID FROM bookings WHERE ShowID IN (SELECT ShowID FROM shows WHERE TicketPrice > 400));

-- Find movies where the total bookings are more than 10 (use a subquery on Bookings).
SELECT * FROM bookings;
SELECT * FROM movies;
SELECT * FROM shows;

SELECT *
FROM movies
WHERE MovieID IN (SELECT MovieID FROM shows WHERE ShowID IN (SELECT ShowID FROM bookings GROUP BY ShowID HAVING SUM(SeatsBooked) > 10));

-- 10. JOINS (INNER, LEFT, RIGHT)
-- INNER JOIN Customers and Bookings to show customer name and their bookings.
SELECT * FROM customers as c
INNER JOIN bookings as b
ON c.CustomerID = b.BookingID;

-- LEFT JOIN Shows and Movies to list all shows and their movie titles.
SELECT s.ShowID, s.ShowDate, s.TicketPrice, m.MovieID, m.Title
FROM shows AS s
LEFT JOIN movies AS m
ON s.MovieID = m.MovieID;

-- RIGHT JOIN Bookings and Payments to show all payments and associated bookings.
SELECT b.BookingID, b.CustomerID, b.ShowID, b.SeatsBooked,
       p.PaymentID, p.Amount, p.PaymentDate, p.PaymentMethod
FROM Bookings AS b
RIGHT JOIN Payments AS p
ON b.BookingID = p.BookingID;

-- INNER JOIN Shows, Movies, and Theatres to display movie title, theatre name, and show date.
SELECT m.Title,t.Name,s.ShowDate
FROM Shows AS s
INNER JOIN Movies AS m 
ON s.MovieID = m.MovieID
INNER JOIN Theatres AS t 
ON s.TheatreID = t.TheatreID;

-- 11.Advanced
-- Find the total revenue per theatre using JOINs between Shows and Bookings/Payments.
SELECT s.TheatreID, SUM(p.Amount) AS Total_Revenue
FROM Payments AS p
INNER JOIN Bookings AS b
 ON p.BookingID = b.BookingID
INNER JOIN Shows AS s 
ON b.ShowID = s.ShowID
GROUP BY s.TheatreID;












