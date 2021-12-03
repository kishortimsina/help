STOCK_HOME="/app/stock/lazy-noob"
STOCK_DUMP="$STOCK_HOME/data"
WORK_DIR="$STOCK_HOME/WORK"
SPLIT_FILE_LOCATION="$WORK_DIR/split4"
_date=$(date '+%m%d%y_%H:%M')
while read line; do
    ENDPOINT="https://www.marketwatch.com/investing/stock/${line}" && echo $ENDPOINT 
    VALUE=$(curl -s $ENDPOINT | grep '<meta name="price" content="' | cut -d'"' -f4 | cut -c 2-)
    printf "%s\t%s\n" "$_date" "$VALUE"  >> $STOCK_DUMP/${line}.STOCK
 done < $SPLIT_FILE_LOCATION
