-- Tables:
-- information_schema.tables
-- pg_indexes (PostgreSQL metadata)
--
-- Problem:
-- List all user-created tables in the current database that have **no 
indexes** defined.
-- Return: schema_name, table_name.

SELECT
  t.table_schema,
  t.table_name
FROM information_schema.tables t
LEFT JOIN pg_indexes i
  ON t.table_name = i.tablename
  AND t.table_schema = i.schemaname
WHERE t.table_schema NOT IN ('pg_catalog', 'information_schema')
  AND t.table_type = 'BASE TABLE'
  AND i.indexname IS NULL
ORDER BY t.table_schema, t.table_name;

