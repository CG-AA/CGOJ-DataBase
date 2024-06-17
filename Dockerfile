FROM mysql:latest

ENV MYSQL_ROOT_PASSWORD=replace_me

# Copy custom MySQL configuration
COPY my.cnf /etc/mysql/conf.d/

# Copy the SQL script to initialize the database
COPY init.sql /docker-entrypoint-initdb.d/

EXPOSE 45802:3306