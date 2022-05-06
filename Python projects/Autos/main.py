import psycopg2


def comp(t):
    llamandoTabla = "SELECT * FROM "+str(t)
    print(llamandoTabla)
    return str(llamandoTabla)


def llamarTabla(tabla):
    nombreTabla=comp(tabla)
    cursor = connection.cursor()
    cursor.execute(nombreTabla)
    row = cursor.fetchone()
    print(row)
    rows = cursor.fetchall()

    for row in rows:
        print(row)

   




try:
    connection=psycopg2.connect(
        host='localhost',
        port=54320,
        dbname='my_database',
        user='postgres',
        password='my_password',
    )
    print("Conexion segura")
    llamarTabla("vendedor")
    print("\n")
    llamarTabla("concesionaria")

    
except Exception as e:
    print(e)
