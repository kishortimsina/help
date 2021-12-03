STOCK_HOME="/app/stock/lazy-noob"
STOCK_DUMP="$STOCK_HOME/crypto"
WORK_DIR="$STOCK_HOME/WORK"
_date=$(date '+%m%d%y_%H:%M')
for i in BTCUSDT ETHBUSD DOGEBUSD; do
    ENDPOINT="https://api.binance.com/api/v1/ticker/price?symbol=$i" && echo $ENDPOINT
    VALUE=$(curl -s $ENDPOINT | jq .price | xargs)
    printf "%s\t%s\n" "$_date" "$VALUE" >> $STOCK_DUMP/$i
done
