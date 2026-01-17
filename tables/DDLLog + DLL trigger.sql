
CREATE TABLE dbo.DDLLog (
    LogID INT IDENTITY(1,1) PRIMARY KEY,
    EventTime DATETIME DEFAULT GETDATE(),
    EventType NVARCHAR(100),
    EventDDL NVARCHAR(MAX),
    EventXML XML,
    DatabaseName NVARCHAR(255),
    SchemaName NVARCHAR(255),
    ObjectName NVARCHAR(255),
    HostName NVARCHAR(255),
    IPAddress NVARCHAR(50),
    ProgramName NVARCHAR(255),
    LoginName NVARCHAR(255),
    UserName NVARCHAR(255)
);

CREATE TRIGGER [ddl_log_trigger]
ON DATABASE
FOR 
    CREATE_TABLE, ALTER_TABLE, DROP_TABLE,
    CREATE_VIEW, ALTER_VIEW, DROP_VIEW,
    CREATE_PROCEDURE, ALTER_PROCEDURE, DROP_PROCEDURE,
    CREATE_FUNCTION, ALTER_FUNCTION, DROP_FUNCTION,
    CREATE_TRIGGER, ALTER_TRIGGER, DROP_TRIGGER,
    CREATE_INDEX, ALTER_INDEX, DROP_INDEX,
    CREATE_SCHEMA, ALTER_SCHEMA, DROP_SCHEMA,
    CREATE_TYPE, DROP_TYPE,
    CREATE_SYNONYM, DROP_SYNONYM
AS
BEGIN
    SET NOCOUNT ON;
    
    DECLARE @EventData XML = EVENTDATA();
    DECLARE @IPAddress NVARCHAR(50);
    
    -- Pobranie adresu IP (dla SQL Server 2008+)
    SELECT @IPAddress = client_net_address
    FROM sys.dm_exec_connections
    WHERE session_id = @@SPID;
    
    INSERT INTO dbo.DDLLog (
        EventTime,
        EventType,
        EventDDL,
        EventXML,
        DatabaseName,
        SchemaName,
        ObjectName,
        HostName,
        IPAddress,
        ProgramName,
        LoginName,
        UserName
    )
    VALUES (
        GETDATE(),
        @EventData.value('(/EVENT_INSTANCE/EventType)[1]', 'NVARCHAR(100)'),
        @EventData.value('(/EVENT_INSTANCE/TSQLCommand)[1]', 'NVARCHAR(MAX)'),
        @EventData,
        @EventData.value('(/EVENT_INSTANCE/DatabaseName)[1]', 'NVARCHAR(255)'),
        @EventData.value('(/EVENT_INSTANCE/SchemaName)[1]', 'NVARCHAR(255)'),
        @EventData.value('(/EVENT_INSTANCE/ObjectName)[1]', 'NVARCHAR(255)'),
        HOST_NAME(),
        ISNULL(@IPAddress, ''),
        PROGRAM_NAME(),
        SUSER_SNAME(),
        CURRENT_USER
    );
END;