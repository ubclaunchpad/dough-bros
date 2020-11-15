# Docker Compose + MySQL Setup & Instructions:

*Note: In the docker-compose.yml, make sure the volume is pointing at the corresponding workspace paths!!*

* /database/data/doughBros_db contains all local testing data and tables, not included in git repository

### Setup:
1. cd into root folder
2. To start application server and mysql: `docker-compose up -d`
3. Access docker container bash terminal: `docker exec -it doughBros_db bash`

### Mount Any .SQL Files:
5. `mysql -uroot -p<password> <databaseDest> < <SQLFileLoc>`
Ex. `mysql -uroot -proot doughBros_db < /docker-entrypoint-initdb.d/'~init.sql'` —> (Into container “doughBros_db” from the docker volume folder “dockerInit”, file init.sql)

6. Enter `exit` to exit terminal
7. To stop containers: `docker-compose down`

### Populate Local Database With .SQL dump
1. From docker container, access mySQL terminal: `mysql -uroot -p doughBros_db`
2. In mysql terminal: `USE doughBros_db`
3. Source the .sql file location: `SOURCE <SQLFileLoc>`
Ex. `SOURCE /docker-entrypoint-initdb.d/'~init.sql'` —> (Into container “doughBros_db” from the docker volume folder “dockerInit”, file init.sql)

### Using MySQL:
1. SHOW DATABASES; —> 4 default created database + our databases (Ex. “doughBros_db”)
2. USE doughBros_db;
3. SHOW TABLES; 
4. DESC <TABLE>;
4. <INSERT SQL QUERY> (EX. SELECT * FROM users;)

### Note
- Remember to delete the /data folder if changes have been made to any SQL file in order to rebuild the image with updated changes at entrypoint