STOCK_HOME="/app/stock/lazy-noob"
STOCK_DUMP="$STOCK_HOME/data"
WORK_DIR="$STOCK_HOME/WORK"

################################ DATA RETENTION PERIOD ########################################
# RETENTION PERIOD CALCULATIONS
# 1 DAY = 95 
# 1 MONTHS = 95 * 21 = 1195
# 3 MONTHS = 5985
# 6 MONTHS = 11970
# 1 YEAR = 23940
RETENTION_PERIOD="10"

###############################################################################################
for i in `ls $STOCK_DUMP| grep STOCK`;do
        echo $i
done
