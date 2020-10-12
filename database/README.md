# Docker Compose + MySQL Setup & Instructions:

*Note: In the docker-compose.yml, make sure the volume is pointing at the corresponding workspace paths!!*

### Setup:
1. cd into workspace folder
2. docker-compose up —> (docker ps OR docker images, to check status/images)
3. New Terminal —> docker exec -it doughBros_db bash
4. mysql -uroot -p<password> (OR mysql -uroot -p —> then enter password next line)

### Mount Any .SQL Files:
5. mysql -uroot -p<password> <databaseDest> < <SQLFileLoc>
Ex. mysql -uroot -proot doughBros_db < /dockerInit/init.sql —> (Into “doughBros_db” from the docker volume folder “dockerInit”, file init.sql)

### Using MySQL:
1. SHOW DATABASES; —> 4 default created database + our databases (Ex. “doughBros_db”)
2. USE doughBros_db;
3. SHOW TABLES; 
4. <INSERT SQL QUERY> (EX. SELECT * FROM users;)