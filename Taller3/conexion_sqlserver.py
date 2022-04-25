import pyodbc

try:
    conexion = pyodbc.connect('DRIVER={SQL Server};SERVER=DESKTOP-1KCUJN2;DATABASE=Chinook;UID=Johnny;PWD=12345')
   
    print("Conexión exitosa.")

    # Insertar datos 
    with conexion.cursor() as cursor:
        consulta = "INSERT INTO Album VALUES (?, ?, ?);"
        cursor.execute(consulta, (1945, "God's fall", 275))
        cursor.execute(consulta, (1994, "Requiem", 275))
        cursor.execute(consulta, (2017, "Sunny Days", 275))
        cursor.execute(consulta, (2014, "Superpowers", 275))    

    # Consulta de Empleado 
    with conexion.cursor() as cursor:
        cursor.execute("SELECT EmployeeId, FirstName, City FROM Employee;")
        Employee = cursor.fetchall()

        for empleado in Employee:
            print(empleado)
    # Actualizar datos
    with conexion.cursor() as cursor:

        consulta = "UPDATE Album SET Title = ? WHERE AlbumId = ?;"
        nuevo_album = "KaiKaiKitan"
        id_nuevo = 346
        cursor.execute(consulta, (nuevo_album, id_nuevo))
    conexion.commit()

    # Eliminar datos
    with conexion.cursor() as cursor:

        consulta = "DELETE FROM Album WHERE AlbumId = ?;"
        AlbumId = 1945
        cursor.execute(consulta, (AlbumId))

    conexion.commit()



except Exception as ex:
    print("Error durante la conexión: {}".format(ex))
finally:
    conexion.close()  # Se cerró la conexión a la BD.
    print("La conexión ha finalizado.")
