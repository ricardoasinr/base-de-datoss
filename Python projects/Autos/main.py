import psycopg2


def crearVendedor():
    print("------------------")
    print("Creando nuevos vendedores: ")

    codigoV = input("Inserte el codigo del vendedor: ")
    nitcsV = input("Inserte el NIT de la concesionaria: ")
    nitofV = input("Inserte NIT del servicio oficial: ")
    nombreV = input("Inserte el nombre del vendedor: ")
    telfV = input("Inserte el numero del vendedor: ")
    emailV = input("Inserte el email del vendedor: ")
    cursor = connection.cursor()
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
    cursor = connection.cursor()
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
    cursor = connection.cursor()
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
    except NameError :
        print(NameError.name)
        print("No se pudo registrar")


def crearVehiculo():
    print("------------------")
    print("Registrando un nuevo vehiculo: ")
    NroChasis = input("Numero de chasis: ")
    NITCS = input("*NIT de la concesionaria: ")
    CodModelo = input("*Codigo modelo: ")
    Color = input("Color: ")
    print("Por favor introcir de la siguiente manera '20190518' = 18/5/2019 ")
    FechaFabricacion = input("Fecha: ")
    LugarFabricacion = input("Lugar de fabricacion: ")
    Descuento = input("Descuento: ")
    estado = "En Stock"
    cursor = connection.cursor()
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
    except Exception as e:
        print(e)
        print("No se pudo registrar el auto")

def crearModelo():

    print("------------------")
    print("Registrando un nuevo Modelo: ")
    codmodelo = input("Codigo del modelo: ")
    marca = input("Marca: ")
    NroPuertas = input("Puertas: ")
    cilindradas = input("Cilindradas: ")
    NroRuedas = input("Numero de ruedas: ")
    Procedencia = input("Lugar de fabricacion: ")
    CodPasajeros = input("Cantidad de pasajeros: ")
    cursor = connection.cursor()
    print("------------------")
    try:

        a = f"insert into modelo values('{codmodelo}', '{marca}', '{NroPuertas}', '{cilindradas}', '{NroRuedas}', '{Procedencia}', '{CodPasajeros}')"
        print(a)
        cursor.execute(a)
        connection.commit()
        print("\n")
        print("------------------")
        print("Modelo registrado correctamente")
        print("------------------")
        print("\n")
    except Exception as e:
        print(e)
        print("No se pudo registrar el modelo")

def mostrarVendedores():
    cursor = connection.cursor()
    cursor.execute("SELECT * FROM vendedor;")
    row = 0
    rows = cursor.fetchall()
    for row in rows:
        print("Codigo: " + row[0], " | Nombre: " + row[3], " | Telefono: " + row[4])

    print("------------------")
    print("\n")

def comp(t):
    llamandoTabla = "SELECT * FROM " + str(t)
    print(llamandoTabla)
    return str(llamandoTabla)
def llamarTabla(tabla):
    nombreTabla = comp(tabla)
    cursor = connection.cursor()
    cursor.execute(nombreTabla)
    row = cursor.fetchone()
    print(row)
    rows = cursor.fetchall()

    for row in rows:
        print(row)
def crearTabla():
    nombreTabla = input("Nombre de la tabla: ")
    n = nombreTabla
    # s = str(n)
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
def registroVenta():
    cursor = connection.cursor()
    print("------------------")
    exitosa = 0
    print("Registrando venta: ")
    Factura = input("Factura: ")
    codvendedor = input("*Codigo del vendedor: ")
    print("Por favor introcir de la siguiente manera '20190518' = 18/5/2019 ")
    Fecha = input("Fecha [Hoy]: ")
    Lugar = input("Lugar: ")
    CostoVenta = input("Costo: ")
    MetodoDePago = input("Metodo de pago: ")
    print("------------------")
    try:
        a = f"insert into venta values('{Factura}', '{codvendedor}', '{Fecha}', '{Lugar}', '{CostoVenta}', '{MetodoDePago}')"
        print(a)
        cursor.execute(a)
        connection.commit()
        exitosa = 1
        print("\n")
        print("------------------")
        print("Venta registrada correctamente")
        print("------------------")
        print("\n")
    except:
        print("No se pudo registrar la venta")
        exitosa = 0

    return exitosa

def actualizandoEstado(chasis):
    try:
        cursor = connection.cursor()
        a = f"update automovil set Estado = 'Vendido' where NroChasis = '{chasis}'"
        print(a)
        cursor.execute(a)
        connection.commit()
        print("\n")
        print("------------------")
        print("El estado del auto vendido ha sido cambiado")
        print("La compra del auto ha sido exitosa!")
        print("------------------")
        print("\n")
    except:
        print("No se pudo cambiar el estado")

def realizarVenta():
    cursor = connection.cursor()
    chasiss = input('Ingrese el numero de chasis para verificar disponibilidad: ')
    a = verificarEstado(chasiss)

    if(a==1):
        print("La venta puede seguir adelante")
        v = registroVenta()
        if(v==1):
            print("Cambiando el estado del vehiculo a Vendido")
            actualizandoEstado(chasiss)
        else:
            print("No se pudo efectuar la compra")
    else:
        repMod = input("Desea registrar un nuevo modelo? Si/No: ")
        if(repMod == "Si"):
            crearModelo()

        repV = input("Desea registrar un nuevo vehiculo? Si/No: ")
        if (repV == "Si"):
            crearVehiculo()

        respEq = input("Desea registra un equipo extra? Si/No: ")
        if(respEq == "Si"):
            crearEquipo()


        respTeq = input("Desea registra un tipo equipo extra? Si/No: ")
        if (respTeq == "Si"):
           crearTipoEquipo()



        respVenta = input("Desea realizar la venta? Si/No ")
        if(respVenta == 'Si'):
            print("Iniciando proceso de venta: ")
            chasisAComprar = input("Ingrese nuevamente el numero de chasis del auto que desea comprar: ")
            v = registroVenta()
            if (v == 1):
                print("Cambiando el estado del vehiculo a Vendido")
                actualizandoEstado(chasisAComprar)
            else:
                print("No se pudo efectuar la compra")
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
#Verificando automoviles
# Verficando estado del vehiculo para realizar la venta
    #realizarVenta()
#Creando un nuevo vendedor:
    #crearVendedor()
    #--------------------------
#Creando tabla
    #crearTabla()
    #--------------------------
#Eliminando tabla
    #nombreTabla = input("Nombre de la tabla: ")
    #eliminarTabla(nombreTabla)

    print("Bienvenido")
    print("1. Realizar una venta ")
    print("2. Ver los vendedores ")
    print("3. Registrar un vendedor")
    print("4. Registrar un nuevo modelo")
    print("5. Ver modelos")
    s = input("Seleccione una opcion: ")
    if(s == "1"):
        realizarVenta()

except Exception as e:
    print(e)

finally:
    connection.close()

    print("------------------")
    print("Conexion finalizada")
