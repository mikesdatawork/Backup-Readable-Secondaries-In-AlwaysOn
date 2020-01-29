![MIKES DATA WORK GIT REPO](https://raw.githubusercontent.com/mikesdatawork/images/master/git_mikes_data_work_banner_01.png "Mikes Data Work")        

# Backup Readable Secondaries In AlwaysOn
**Post Date: August 18, 2016**        



## Contents    
- [About Process](##About-Process)  
- [SQL Logic](#SQL-Logic)  
- [Build Info](#Build-Info)  
- [Author](#Author)  
- [License](#License)       

## About-Process

<p>Question:
For AlwaysOn… Can you backup readable secondary replicas?
Answer:
Full Database Backups? NO
Transaction Log Backups? YES
Here's what happens whenever you try to run Full Database Backups for readable secondaries in an SQL AlwaysOn environment. In this scenario we have Sharepoint 2013 databases residing in an SQL 2014 AlwaysOn environment. I'm basically running a full database backup to disk. Nothing crazy here.</p>

![Backup Error](https://mikesdatawork.files.wordpress.com/2016/08/image0012.png "Readable Secondaries")
 
I get these errors:
This BACKUP or RESTORE command is not supported on a database mirror or secondary replica.
Msg 3013, Level 16, State 1, Line 1
BACKUP DATABASE is terminating abnormally.
Msg 3059, Level 16, State 1, Line 2
This BACKUP or RESTORE command is not supported on a database mirror or secondary replica.
Msg 3013, Level 16, State 1, Line 2
BACKUP DATABASE is terminating abnormally.
Msg 3059, Level 16, State 1, Line 3
This BACKUP or RESTORE command is not supported on a database mirror or secondary replica.
Msg 3013, Level 16, State 1, Line 3
BACKUP DATABASE is terminating abnormally.
Msg 3059, Level 16, State 1, Line 4
This BACKUP or RESTORE command is not supported on a database mirror or secondary replica.
Msg 3013, Level 16, State 1, Line 4
BACKUP DATABASE is terminating abnormally.
Msg 3059, Level 16, State 1, Line 5
This BACKUP or RESTORE command is not supported on a database mirror or secondary replica.
Here's what happens whenever you try to run transaction log backups. IT WORKS.

![Transaction Log Backups Work](https://mikesdatawork.files.wordpress.com/2016/08/image0021.png "Working Log Backups")
 
So there you have it.
Full Database Backups DO NOT WORK, however; Transaction Log Backups work perfectly normal.
If you need to write up a process to check if the database server is primary, then you can use something like this:      


## SQL-Logic
```SQL

use master;
set nocount on
 
if exists(select is_local, role_desc from sys.dm_hadr_availability_replica_states where role = 1 and role_desc = 'PRIMARY') 
    begin
        print 'This server [' + upper(@@servername) + '] is the primary.'
        backup database [MyDatabase] to disk = 'E:\MyPath\MyDatabase.bak'
    end
```

![If Exists Backup](https://mikesdatawork.files.wordpress.com/2016/08/image003.png "If Exists Backup")
 


[![WorksEveryTime](https://forthebadge.com/images/badges/60-percent-of-the-time-works-every-time.svg)](https://shitday.de/)

## Build-Info

| Build Quality | Build History |
|--|--|
|<table><tr><td>[![Build-Status](https://ci.appveyor.com/api/projects/status/pjxh5g91jpbh7t84?svg?style=flat-square)](#)</td></tr><tr><td>[![Coverage](https://coveralls.io/repos/github/tygerbytes/ResourceFitness/badge.svg?style=flat-square)](#)</td></tr><tr><td>[![Nuget](https://img.shields.io/nuget/v/TW.Resfit.Core.svg?style=flat-square)](#)</td></tr></table>|<table><tr><td>[![Build history](https://buildstats.info/appveyor/chart/tygerbytes/resourcefitness)](#)</td></tr></table>|

## Author

[![Gist](https://img.shields.io/badge/Gist-MikesDataWork-<COLOR>.svg)](https://gist.github.com/mikesdatawork)
[![Twitter](https://img.shields.io/badge/Twitter-MikesDataWork-<COLOR>.svg)](https://twitter.com/mikesdatawork)
[![Wordpress](https://img.shields.io/badge/Wordpress-MikesDataWork-<COLOR>.svg)](https://mikesdatawork.wordpress.com/)

     
## License
[![LicenseCCSA](https://img.shields.io/badge/License-CreativeCommonsSA-<COLOR>.svg)](https://creativecommons.org/share-your-work/licensing-types-examples/)

![Mikes Data Work](https://raw.githubusercontent.com/mikesdatawork/images/master/git_mikes_data_work_banner_02.png "Mikes Data Work")

