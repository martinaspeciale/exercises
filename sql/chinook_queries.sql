-- 🟢 Level 1 — SELECT Basics

-- 1. Show the first 10 artists
SELECT * FROM Artist
LIMIT 10;

-- 2. Show all album titles and their artist names
SELECT al.Title AS Album, ar.Name AS Artist
FROM Album al
JOIN Artist ar ON al.ArtistId = ar.ArtistId;

-- 3. List all customers from Italy
SELECT FirstName, LastName, Country
FROM Customer
WHERE Country = 'Italy';

-- 4. Show the number of invoices per billing country
SELECT BillingCountry, COUNT(*) AS InvoiceCount
FROM Invoice
GROUP BY BillingCountry
ORDER BY InvoiceCount DESC;

-- 5. List the names of the 5 most expensive tracks
SELECT Name, UnitPrice
FROM Track
ORDER BY UnitPrice DESC
LIMIT 5;


-- 🟡 Level 2 — JOINs & Aggregation

-- 6. Find the total number of albums per artist
SELECT ar.Name AS Artist, COUNT(al.AlbumId) AS AlbumCount
FROM Artist ar
JOIN Album al ON ar.ArtistId = al.ArtistId
GROUP BY ar.Name
ORDER BY AlbumCount DESC;

-- 7. List each invoice with the customer's full name and total amount
SELECT i.InvoiceId, c.FirstName || ' ' || c.LastName AS Customer, i.Total
FROM Invoice i
JOIN Customer c ON i.CustomerId = c.CustomerId;

-- 8. Find the most common genre in the Track table
SELECT g.Name AS Genre, COUNT(*) AS TrackCount
FROM Track t
JOIN Genre g ON t.GenreId = g.GenreId
GROUP BY g.Name
ORDER BY TrackCount DESC
LIMIT 1;


-- 🟠 Level 3 — Subqueries & Nested Analysis

-- 9. Show customers who have spent more than $40
SELECT c.FirstName, c.LastName, SUM(i.Total) AS TotalSpent
FROM Customer c
JOIN Invoice i ON c.CustomerId = i.CustomerId
GROUP BY c.CustomerId
HAVING TotalSpent > 40
ORDER BY TotalSpent DESC;

-- 10. Find the top 3 customers by total amount spent
SELECT c.FirstName, c.LastName, SUM(i.Total) AS TotalSpent
FROM Customer c
JOIN Invoice i ON c.CustomerId = i.CustomerId
GROUP BY c.CustomerId
ORDER BY TotalSpent DESC
LIMIT 3;
