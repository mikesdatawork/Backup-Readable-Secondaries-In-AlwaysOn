
use master;
set nocount on
 
if exists(select is_local, role_desc from sys.dm_hadr_availability_replica_states where role = 1 and role_desc = 'PRIMARY') 
    begin
        print 'This server [' + upper(@@servername) + '] is the primary.'
        backup database [MyDatabase] to disk = 'E:\MyPath\MyDatabase.bak'
    end
