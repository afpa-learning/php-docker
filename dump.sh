#!/bin/bash
#Récupère les variables .env
source .env

# Mettre une date au nom du dossier
DATE=$(date +"%Y%m%d")

# Commandes MySQL nécessaires pour faire le backup
MYSQL="docker exec $DOCKER_NUMBER mysql"
MYSQLDUMP="docker exec $DOCKER_NUMBER mysqldump"

# Bases de données MySQL que vous voulez ignorer
SKIPDATABASES="information_schema|performance_schema|mysql|sys"

# Rétention des données (les jours pour garder les backups)
RETENTION=5

# Création d'un nouveau dossier avec la date du jour
mkdir -p "$MYSQL_DUMP_DIR"/"$DATE"

# Donne la liste de toutes les bases des données.
databases=$($MYSQL -u "$MYSQL_USER" -p"$MYSQL_ROOT_PASSWORD" -N -e "SHOW DATABASES;" | grep -Ev "$SKIPDATABASES")

# Copier les bases des données distinctes et fait un fichier sgl pour chaque database.
for db in $databases; do
echo "$db"
$MYSQLDUMP --user="$MYSQL_USER" -p"$MYSQL_ROOT_PASSWORD" --complete-insert --routines --triggers --single-transaction -B "$db" > "$MYSQL_DUMP_DIR/$DATE/$db.sql"
done

# Efface les fichiers plus vieux que votre date de RETENTION
find "$MYSQL_DUMP_DIR"/* -type d -mtime +$RETENTION | xargs rm -rf