STOCK_HOME="/app/stock/lazy-noob"
STOCK_DUMP="$STOCK_HOME/data"
WORK_DIR="$STOCK_HOME/WORK"

rm -rf $WORK_DIR/split*
#CREATING INPUT FILE
awk 'NR<=100' $STOCK_HOME/input/total_stock_list.txt > $WORK_DIR/split1
awk 'NR>=101 && NR<=200' $STOCK_HOME/input/total_stock_list.txt > $WORK_DIR/split2
awk 'NR>=201 && NR<=300' $STOCK_HOME/input/total_stock_list.txt > $WORK_DIR/split3
awk 'NR>=301 && NR<=400' $STOCK_HOME/input/total_stock_list.txt > $WORK_DIR/split4
awk 'NR>=401 && NR<=500' $STOCK_HOME/input/total_stock_list.txt > $WORK_DIR/split5
awk 'NR>=501 && NR<=600' $STOCK_HOME/input/total_stock_list.txt > $WORK_DIR/split6
awk 'NR>=601 && NR<=700' $STOCK_HOME/input/total_stock_list.txt > $WORK_DIR/split7

