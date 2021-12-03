STOCK_HOME="/app/stock/lazy-noob"
STOCK_DUMP="$STOCK_HOME/data"
BACKUP_DIR="/app/backup"

_date=$(date '+%m%d%y')
#tar -czvf ${BACKUP_DIR}/Backup$_{_date}.tar.gz ${BACKUP_DIR}
tar -czvf /app/backup/Backup_${_date}.tar.gz -c /app/stock/lazy-noob/data
