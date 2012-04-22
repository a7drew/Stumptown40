USE [master]
GO

IF  EXISTS (SELECT * FROM sys.server_principals WHERE name = N'Stumptown40')
DROP LOGIN [Stumptown40]
GO

IF  EXISTS (SELECT name FROM sys.databases WHERE name = N'Stumptown40')
ALTER DATABASE [Stumptown40] SET SINGLE_USER WITH ROLLBACK IMMEDIATE
GO

IF  EXISTS (SELECT name FROM sys.databases WHERE name = N'Stumptown40')
ALTER DATABASE [Stumptown40] SET SINGLE_USER
GO

IF  EXISTS (SELECT name FROM sys.databases WHERE name = N'Stumptown40')
EXEC msdb.dbo.sp_delete_database_backuphistory @database_name = N'Stumptown40'
GO

IF  EXISTS (SELECT name FROM sys.databases WHERE name = N'Stumptown40')
DROP DATABASE [Stumptown40]
GO

CREATE DATABASE [Stumptown40]
GO

-- EXEC sp_addlogin 'login', 'password', 'defaultDatabase'
EXEC sp_addlogin 'Stumptown40', 'password', 'Stumptown40'
GO

USE Stumptown40
GO

-- sp_grantdbaccess 'login', 'username'
EXEC sp_grantdbaccess 'Stumptown40', 'Stumptown40'
GO

-- sp_addrolemember 'RoleName', 'MemberName'
EXEC sp_addrolemember 'db_owner', 'Stumptown40'
GO