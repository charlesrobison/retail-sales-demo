import duckdb
import sqlite3

# Load data into DuckDB
duckdb_conn = duckdb.connect('exports/retail_demo.duckdb')

# Read CSVs (adjust paths if needed)
duckdb_conn.execute("CREATE OR REPLACE TABLE agg_customer_sales_summary AS SELECT * FROM read_csv_auto('exports/agg_customer_sales_summary.csv')")
duckdb_conn.execute("CREATE OR REPLACE TABLE fct_sales AS SELECT * FROM read_csv_auto('exports/fct_sales.csv')")
duckdb_conn.execute("CREATE OR REPLACE TABLE dim_customers AS SELECT * FROM read_csv_auto('exports/dim_customers.csv')")

# Connect to SQLite
sqlite_conn = sqlite3.connect('exports/retail_demo.sqlite')

# Export each DuckDB table into SQLite
for table in ["agg_customer_sales_summary", "fct_sales", "dim_customers"]:
    df = duckdb_conn.execute(f"SELECT * FROM {table}").df()
    df.to_sql(table, sqlite_conn, if_exists='replace', index=False)

sqlite_conn.close()
duckdb_conn.close()

print("✅ Export completed! SQLite database created at exports/retail_demo.sqlite")
