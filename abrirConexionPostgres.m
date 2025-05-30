function conn = abrirConexionPostgres()
    % Añade el driver JDBC si no está ya cargado
    jarPath = 'C:\Users\USER\OneDrive\Documentos\MATLAB\proyectosalud\postgresql-42.6.0.jar';
    if ~any(strcmp(javaclasspath('-dynamic'), jarPath))
        javaaddpath(jarPath);
    end

    % Datos de conexión
    dbname = 'proyectosalud1';
    username = 'proyectosalud1_user';
    password = 'wKwT0xKbup5FwyDZLoJSt0gnwXUN9XxK';
    server = 'dpg-d0mjt7e3jp1c738doscg-a.oregon-postgres.render.com';
    port = '5432';

    jdbcString = sprintf('jdbc:postgresql://%s:%s/%s', server, port, dbname);
    jdbcDriver = 'org.postgresql.Driver';

    % Crear conexión
    conn = database(dbname, username, password, jdbcDriver, jdbcString);

    if ~isopen(conn)
        error('No se pudo conectar a la base de datos.');
    end
end