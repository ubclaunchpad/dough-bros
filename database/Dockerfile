FROM mysql:latest

ENV MYSQL_ROOT_PASSWORD=root
ENV MYSQL_DATABASE=doughBros_db
ENV MYSQL_USER=user
ENV MYSQL_PASSWORD=root

COPY ./sproc/* /docker-entrypoint-initdb.d/
COPY ./tables/* /docker-entrypoint-initdb.d/
COPY mockData.sql /docker-entrypoint-initdb.d/~mockData.sql