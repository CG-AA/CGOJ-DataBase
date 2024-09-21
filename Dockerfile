FROM mysql:9.0.1-oraclelinux9

ENV MYSQL_ROOT_PASSWORD=replace_me

# Copy custom MySQL configuration
COPY my.cnf /etc/mysql/conf.d/

# Copy the SQL script to initialize the database
COPY init.sql /docker-entrypoint-initdb.d/

EXPOSE 45802:3306

# docker build -t cgdb .
# docker run --rm -it -p 45802:3306  cgdb