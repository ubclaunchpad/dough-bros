Docker Compose + MySQL Setup & Instructions:

Note: In the docker-compose.yml, make sure the volume is pointing at the corresponding workspace paths!!

Setup:
1. cd into workspace folder
2. docker-compose up —> (docker ps OR docker images, to check status/images)
3. New Terminal —>  cd into workspace folder
4. docker exec -it doughbros_db_1 bash
5. mysql -uroot -p<password> (OR mysql -uroot -p —> then enter password next line)

Mount Any .SQL Files:
6. mysql -uroot -p<password> doughBros_db < /doughBrosDB/usersDB.sql —> (Into “doughBros_db” from the docker volume folder “doughBrosDB”, file usersDB.sql)
7. See Step 5

Using MySQL:
1. SHOW DATABASES; —> 4 default created database + our databases (Ex. “doughBros_db”)
2. USE doughBros_db;
3. SHOW TABLES; 
4. <INSERT SQL QUERY> (EX. SELECT * FROM users;)