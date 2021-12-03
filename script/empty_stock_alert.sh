STOCK_HOME="/app/stock/lazy-noob"
STOCK_DUMP="$STOCK_HOME/data"
WORK_DIR="$STOCK_HOME/WORK"
MISSING_DATA=""

echo "################################## ANALYZING #########################################"
for i in `ls $STOCK_DUMP| grep STOCK`;do
        echo "Analyzing $i . . . "
        CURRENT_PRICE=$(cat ${STOCK_DUMP}/${i} | tail -1 | awk '{print $2}')
        if [ -z $CURRENT_PRICE ]; then
                MISSING_DATA+="${i} "
        fi
 
done

if [ -n "${MISSING_DATA}" ]; then
   echo "No data for $MISSING_DATA in last hour; Please Check Immediately, or remove stocks list from input/total_stock_list.txt " | mail -s "ALERT: NO DATA in `date "+(%m-%d-%Y_%H:%M)"`" demoo.nooob@gmail.com
   echo "ALERT SENT"
else
  echo " No data is missing, was able to download data for all stock, NOT alerting"
fi
echo "######################################################################################"
