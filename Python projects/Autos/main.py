import psycopg2


def llamarTabla(t):
    nombreTabla = str(t)
    cursor = connection.cursor()
    cursor.execute(nombreTabla)
    row = cursor.fetchone()
    print(row)
    rows = cursor.fetchall()

    for row in rows:
        print(row)

    connection.commit()
    cursor.close()
    connection.close()


try:
    connection=psycopg2.connect(
        host='localhost',
        port=54320,
        dbname='my_database',
        user='postgres',
        password='my_password',
    )
    print("Conexion segura")
    llamarTabla("SELECT * FROM vendedor;")
    
except Exception as e:
    print(e)
