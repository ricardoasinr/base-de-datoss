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

def crearVendedor():
    print("------------------")
    print("Creando nuevos vendedores: ")

    codigoV = input("Inserte el codigo del vendedor: ")
    nitcsV = input("Inserte el NIT de la concesionaria: ")
    nitofV = input("Inserte NIT del servicio oficial: ")
    nombreV = input("Inserte el nombre del vendedor: ")
    telfV = input("Inserte el numero del vendedor: ")
    emailV = input("Inserte el email del vendedor: ")

    print("------------------")
    try:
        a = f"insert into vendedor values('{codigoV}', '{nitcsV}', '{nitofV}', '{nombreV}', '{telfV}', '{emailV}')"
        print(a)
        cursor.execute(a)
        connection.commit()
        print("\n")
        print("------------------")
        print("Vendedor creado correctamente")
        print("------------------")
        print("\n")
    except:
        print("No se pudo crear el vendedor")

def crearTabla():
    nombreTabla = input("Nombre de la tabla: ")
    n = nombreTabla
    #s = str(n)
    try:

        cursor = connection.cursor()
        c = f"create table {n} (nombre varchar(30), correo varchar(30), email varchar(30))"
        cursor.execute(c)
        cursor.close()
        connection.commit()
    except (Exception, psycopg2.DatabaseError) as error:
        print(error)
    finally:
        if connection is not None:
            connection.close()

def eliminarTabla(nombreTabla):
    n = nombreTabla
    try:

        cursor = connection.cursor()
        c = f"drop table {n}"
        cursor.execute(c)
        cursor.close()
        connection.commit()
        print("Eliminada correctamente")
    except (Exception, psycopg2.DatabaseError) as error:
        print(error)
    finally:
        if connection is not None:
            connection.close()

#Creando la conexion
try:
    connection=psycopg2.connect(
        host='localhost',
        port=54321,
        dbname='postgres',
        user='postgres',
        password='my_password',
    )
    print("Conexion segura")
    print("------------------")


#Llamando a la tabla vendedor
    #llamarTabla("vendedor")
    cursor = connection.cursor()
    cursor.execute("SELECT * FROM vendedor;")
    row = 0
    rows = cursor.fetchall()

    for row in rows:
        print("Codigo: " + row[0], " | Nombre: "+ row[3], " | Telefono: "+ row[4])
    print("------------------")
    print("\n")


    cursor.callproc('ListaVendedores')

    row = cursor.fetchone()

    while row is not None:
        print(row)
        row = cursor.fetchone()



#Creando un nuevo vendedor:
    #crearVendedor()
    #--------------------------
#Creando tabla
    #crearTabla()
    #--------------------------
#Eliminando tabla
    #nombreTabla = input("Nombre de la tabla: ")
    #eliminarTabla(nombreTabla)



    
except Exception as e:
    print(e)

finally:
    connection.close()
    print("\n")
    print("------------------")
    print("Conexion finalizada")
