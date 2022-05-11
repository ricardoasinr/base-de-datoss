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


def crearEquipo():
    print("------------------")
    print("Registrar equipamiento: ")
    codequipo = input("Registre el codigo del equipo: ")
    descripcion = input("Descripcion: ")
    precio = input("Precio: ")
    print("------------------")
    try:
        a = f"insert into equipo values('{codequipo}', '{descripcion}', '{precio}')"
        print(a)
        cursor.execute(a)
        connection.commit()
        print("\n")
        print("------------------")
        print("Equipo registrado")
        print("------------------")
        print("\n")
    except:
        print("No se pudo registrar")

def crearTipoEquipo():
    print("------------------")
    print("Registre el tipo de equipo: ")

    Codmodelo = input("*Modelo: ")
    Codequipo = input("*Registre el codigo del equipo: ")
    Tipoequipo = input("Descripcion: ")
    print("------------------")
    try:
        a = f"insert into tipoequipo values('{Codmodelo}', '{Codequipo}', '{Tipoequipo}')"
        print(a)
        cursor.execute(a)
        connection.commit()
        print("\n")
        print("------------------")
        print("Registrado")
        print("------------------")
        print("\n")
    except:
        print("No se pudo registrar")

def crearVehiculo():
    print("------------------")
    print("Registrando un nuevo vehiculo: ")
    NroChasis = input("Numero de chasis: ")
    NITCS = input("*NIT de la concesionaria: ")
    CodModelo = input("Codigo modelo: ")
    Color = input("Color: ")
    print("Por favor introcir de la siguiente manera '20190518' = 18/5/2019 ")
    FechaFabricacion = input("Fecha: ")
    LugarFabricacion = input("Lugar de fabricacion: ")
    Descuento = input("Descuento: ")
    estado = "En Stock"

    print("------------------")
    try:
        a = f"insert into automovil values('{NroChasis}', '{NITCS}', '{CodModelo}', '{Color}', '{FechaFabricacion}', '{LugarFabricacion}', '{Descuento}', '{estado}')"
        print(a)
        cursor.execute(a)
        connection.commit()
        print("\n")
        print("------------------")
        print("Auto registrado correctamente")
        print("------------------")
        print("\n")
    except:
        print("No se pudo registrar el auto")

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

def verificarEstado(chasis):
    cursor = connection.cursor()
    cursor.execute("SELECT nrochasis, Estado FROM automovil")
    disponibilidad = 0
    c = chasis
    #cursor.execute("select nrochasis from automovil ")
    row = 0
    rows = cursor.fetchall()
    for row in rows:
        if ((row[0] == int(c)) and (row[1] == ('En Stock'))):
            print("Chasis: " + str(row[0]) + " | Estado: " + row[1])
            print("El auto se encuentra disponible")
            disponibilidad = 1
       
    if(disponibilidad == 0):
        print("El auto NO se encuentra disponible")
        disponibilidad = 0

    print("------------------")

    print("\n")
    return (disponibilidad)

def realizarVenta():
    chasiss = input('Ingrese el numero de chasis para verificar disponibilidad: ')
    a = verificarEstado(chasiss)
    
    if(a==1):
        print("La venta puede seguir adelante")
    else:
        crearVehiculo()
        respEq = input("Desea registra un equipo extra? Si/No")
        if(respEq == "Si"):
            crearEquipo()


        respTeq = input("Desea registra un tipo equipo extra? Si/No ")
        if (respTeq == "Si"):
           crearTipoEquipo()



        respVenta = input("Desea realizar la venta? Si/No ")
        if(respVenta == 'Si'):
            print("Iniciando proceso de venta: ")
        else:
            print("Gracias por el registro, vuelva pronto ")





#Creando la conexion
try:
    connection=psycopg2.connect(
        host='localhost',
        port=5432,
        dbname='postgres',
        user='postgres',
        password='password',
    )
    print("Conexion segura")
    print("------------------")


#Llamando a la tabla vendedor
    #llamarTabla("automovil")

    cursor = connection.cursor()
    cursor.execute("SELECT * FROM vendedor;")
    row = 0
    rows = cursor.fetchall()

    for row in rows:
        print("Codigo: " + row[0], " | Nombre: "+ row[3], " | Telefono: "+ row[4])

    print("------------------")
    print("\n")
    row=0
#Verificando automoviles
# Verficando estado del vehiculo para realizar la venta
    realizarVenta()


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
