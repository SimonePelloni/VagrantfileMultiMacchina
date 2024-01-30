# Installazione mysql
sudo apt update
sudo apt install mysql-server -y

# Variabili
BINDING_ADDRESS="0.0.0.0"
MYSQL_HOST="10.10.20.10"
MYSQL_DB="test"
MYSQL_USER="test"
MYSQL_PASS="Password&1"

# Creazione utente e db
sudo mysql <<MYSQL_SCRIPT
CREATE DATABASE $MYSQL_DB;
CREATE USER '$MYSQL_USER'@'$MYSQL_HOST' IDENTIFIED BY '$MYSQL_PASS';
GRANT ALL PRIVILEGES ON $MYSQL_DB.* TO '$MYSQL_USER'@'$MYSQL_HOST';
FLUSH PRIVILEGES;
USE $MYSQL_DB
MYSQL_SCRIPT

# Permetto la connessione a tutti gli host
sudo sed -i "s/^bind-address[[:space:]]*=.*/bind-address = $BINDING_ADDRESS/" /etc/mysql/mysql.conf.d/mysqld.cnf
sudo systemctl restart mysql

# Cancello le variabili
unset BINDING_ADDRESS
unset MYSQL_HOST
unset MYSQL_DB
unset MYSQL_USER
unset MYSQL_PASS