# SQL Exercises

This folder contains SQL practice queries using multiple sample databases stored in the `db/` directory. These exercises are intended for learning and showcasing SQL skills with real-world-style datasets.

## 🗃️ Databases Used (in `db/` folder)

- **chinook.db** – A digital music store database. Tables include `Artist`, `Album`, `Track`, `Invoice`, `Customer`.
  - Source: [Chinook Database](https://www.timestored.com/data/sample/chinook.db)

- **northwind.db** – Classic inventory/order management database. Tables include `Products`, `Orders`, `Employees`, `Customers`.
  - Source: [Northwind for SQLite](https://www.timestored.com/data/sample/northwind_small.sqlite)

- **sakila.db** – Video rental database with film metadata, customers, rentals, payments, and staff.
  - Source: [Sakila SQLite port](https://www.timestored.com/data/sample/sakila.db)

## 📄 How to Use

1. Open the `.db` files using a SQLite extension in Visual Studio Code:
   - Recommended: `SQLite` by alexcvzz

2. Run queries from the `.sql` files:
   - `chinook_queries.sql` – queries for `chinook.db`
   - `northwind_queries.sql` – queries for `northwind.db`
   - `sakila_queries.sql` – queries for `sakila.db`

3. Modify or extend queries to explore advanced SQL concepts like:
   - JOINs
   - GROUP BY & Aggregations
   - Subqueries
   - Window functions

