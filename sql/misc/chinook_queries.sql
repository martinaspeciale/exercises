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


-- 🟣 Level 4 — Advanced SQL

-- 11. Rank customers by total spending using a window function
SELECT 
  c.FirstName || ' ' || c.LastName AS Customer,
  SUM(i.Total) AS TotalSpent,
  RANK() OVER (ORDER BY SUM(i.Total) DESC) AS SpendingRank
FROM Customer c
JOIN Invoice i ON c.CustomerId = i.CustomerId
GROUP BY c.CustomerId;

-- 12. Show each track and indicate if it's "Expensive" (>€1) or "Cheap"
SELECT 
  Name,
  UnitPrice,
  CASE 
    WHEN UnitPrice > 1.00 THEN 'Expensive'
    ELSE 'Cheap'
  END AS PriceCategory
FROM Track
ORDER BY UnitPrice DESC;

-- 13. Show each customer's most recent invoice
SELECT *
FROM Invoice i
WHERE i.InvoiceDate = (
  SELECT MAX(i2.InvoiceDate)
  FROM Invoice i2
  WHERE i2.CustomerId = i.CustomerId
);

-- 14. Use a subquery in SELECT to count total purchases per customer
SELECT 
  c.FirstName || ' ' || c.LastName AS Customer,
  (SELECT COUNT(*) FROM Invoice i WHERE i.CustomerId = c.CustomerId) AS InvoiceCount
FROM Customer c
ORDER BY InvoiceCount DESC
LIMIT 10;

-- 15. Find the most purchased track (by total quantity)
SELECT 
  t.Name AS Track,
  SUM(il.Quantity) AS TotalSold
FROM InvoiceLine il
JOIN Track t ON il.TrackId = t.TrackId
GROUP BY il.TrackId
ORDER BY TotalSold DESC
LIMIT 1;


-- 🟢 Level 5 — CTEs, Views, and Indexing (Chinook Advanced)

-- 16. 🧱 CTE: Find top 5 genres by total revenue
WITH GenreSales AS (
  SELECT 
    g.Name AS Genre,
    SUM(il.UnitPrice * il.Quantity) AS Revenue
  FROM InvoiceLine il
  JOIN Track t ON il.TrackId = t.TrackId
  JOIN Genre g ON t.GenreId = g.GenreId
  GROUP BY g.Name
)
SELECT * 
FROM GenreSales
ORDER BY Revenue DESC
LIMIT 5;

-- 17. 🧱 CTE: Find each customer's average invoice value
WITH AvgInvoice AS (
  SELECT 
    CustomerId,
    AVG(Total) AS AvgInvoiceAmount
  FROM Invoice
  GROUP BY CustomerId
)
SELECT 
  c.FirstName || ' ' || c.LastName AS Customer,
  a.AvgInvoiceAmount
FROM AvgInvoice a
JOIN Customer c ON a.CustomerId = c.CustomerId
ORDER BY a.AvgInvoiceAmount DESC
LIMIT 10;

-- 18. 👓 Create a view for total spending per customer
CREATE VIEW IF NOT EXISTS CustomerSpending AS
SELECT 
  c.CustomerId,
  c.FirstName || ' ' || c.LastName AS Customer,
  SUM(i.Total) AS TotalSpent
FROM Customer c
JOIN Invoice i ON c.CustomerId = i.CustomerId
GROUP BY c.CustomerId;
-- on query 
SELECT * FROM CustomerSpending
ORDER BY TotalSpent DESC
LIMIT 5;

-- 19. ⚙️ Create an index on InvoiceLine(TrackId) to speed up joins
CREATE INDEX IF NOT EXISTS idx_invoice_line_track ON InvoiceLine(TrackId);
-- on queries like 
SELECT t.Name, COUNT(*) 
FROM InvoiceLine il
JOIN Track t ON il.TrackId = t.TrackId
GROUP BY t.TrackId;

-- 20. 👁 View: Top 10 highest-priced tracks with album and artist
CREATE VIEW IF NOT EXISTS TopPricedTracks AS
SELECT 
  t.Name AS Track,
  t.UnitPrice,
  al.Title AS Album,
  ar.Name AS Artist
FROM Track t
JOIN Album al ON t.AlbumId = al.AlbumId
JOIN Artist ar ON al.ArtistId = ar.ArtistId
ORDER BY t.UnitPrice DESC
LIMIT 10;
-- run 
SELECT * FROM TopPricedTracks;
