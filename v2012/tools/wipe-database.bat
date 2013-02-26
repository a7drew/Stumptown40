osql -S %1 -E -n -i ..\sql\create-database.sql
osql -S %1 -E -n -i ..\sql\create-tables.sql
pause