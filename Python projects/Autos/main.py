import psycopg2

conn = psycopg2.connect(
    host='localhost',
    port=54320,
    dbname='my_database',
    user='postgres',
    password='my_password',
)
cur = conn.cursor()

cur.execute("SELECT * FROM concesionaria;")
result = cur.fetchone()
print(result)
conn.commit()
cur.close()
conn.close()