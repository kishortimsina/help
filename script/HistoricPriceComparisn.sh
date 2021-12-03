#/bin/bash
##################################################################################################
############################ 1 trading day is 8hrs * 60 mins = 480 MINS ##########################
############################ X trading day is X*480MINS=? ########################################
##################### TRADING DAYS MON - FRI (5 DAYS) ############################################
##################################################################################################
DAYS_TO_COMPARE=60 ## (20 is 4 trading weeks = 1 month (5 days per week) )
DATA_DOWLOAD_IN_MINS=5 ## ASSUMING DATA IS DOWNLOADED EVERY 5 MIN
MINUTES_TO_ALERT=30
STOCK_HOME="/app/stock/lazy-noob"
WORK_DIR="$STOCK_HOME/WORK" 
STOCK_DUMPS="$STOCK_HOME/data"

#############################################################################
####################### NO CHAGE REQUIRED BELOW THIS LINE ##################
#############################################################################
MINS_TO_COMPARE=$(($DAYS_TO_COMPARE*480))  ## (480 = 1 trading day)
LINES_TO_RETAIN=$(($MINS_TO_COMPARE/$DATA_DOWLOAD_IN_MINS))
echo "DURATION OF ANALYSIS=$MINS_TO_COMPARE MINS; 480 MINS=1 TRADING DAY "
echo "LINES_TO_RETAIN=$LINES_TO_RETAIN MINUTES_TO_ALERT=$MINUTES_TO_ALERT"
echo
rm -rf WORK_DIR/retain_*
for i in `ls /app/stock/lazy-noob/data/ | grep STOCK`;do
#echo "############################# ANALYZING ${i} ##########################################"

alert() {
  echo "$ALERT_MESSAGE" | mail -s "`date "+(%m-%d-%Y_%H:%M): PRICE CHANGE ALERT"`" demoo.nooob@gmail.com

}

    tail -${LINES_TO_RETAIN} ${STOCK_DUMPS}/${i} > ${WORK_DIR}/retain_${i}.txt
    CUR_PRICE=$(tail -1 ${STOCK_DUMPS}/${i})
    MAX_PRICE=$(cat $WORK_DIR/retain_${i}.txt |awk '{print $2}'| sort -nr | head -1) #&& echo MAX_PRICE=$MAX_PRICE
    MIN_PRICE=$(cat $WORK_DIR/retain_${i}.txt |awk '{print $2}'| sort -nr | tail -1) #&& echo MIN_PRICE=$MIN_PRICE
    MAX_TAG=$(grep -n $MAX_PRICE ${STOCK_DUMPS}/${i} | tail -1 | cut -d ":" -f1)
    MIN_TAG=$(grep -n $MIN_PRICE ${STOCK_DUMPS}/${i} | tail -1 | cut -d ":" -f1)
    FILE_SIZE=$(wc -l ${STOCK_DUMPS}/${i} | awk '{print $1}')
    MAX_INCIDENT_OCCURANCE_MINS=$((($FILE_SIZE-$MAX_TAG+1)*5)) # && echo MAX_INCIDENT_OCCURANCE_MINS=$MAX_INCIDENT_OCCURANCE_MINS
    MIN_INCIDENT_OCCURANCE_MINS=$((($FILE_SIZE-$MIN_TAG+1)*5)) # && echo MIN_INCIDENT_OCCURANCE_MINS=$MIN_INCIDENT_OCCURANCE_MINS
    echo "MAX PRICE=$MAX_PRICE MAX POSITION=$MAX_INCIDENT_OCCURANCE_MINS MIN PRICE=$MIN_PRICE MIN POSITION=$MIN_INCIDENT_OCCURANCE_MINS"
   if [ $FILE_SIZE -lt $MINUTES_TO_ALERT ]; then
        echo "$i . . . . NEW STOCK DECTETED, NO DATA TO COMPARE.. EXITING !" && echo
        continue; 
   elif [ $MAX_INCIDENT_OCCURANCE_MINS -lt $MINUTES_TO_ALERT ] && [ $MIN_INCIDENT_OCCURANCE_MINS -lt $MINUTES_TO_ALERT ]; then
        ALERT_MESSAGE="$i IS HIGHLY VOLATILE!!!!!, PLEASE CHECK IMMEDIATELY" && echo $ALERT_MESSAGE
        alert
        continue;
   elif [ $MAX_INCIDENT_OCCURANCE_MINS -lt $MINUTES_TO_ALERT ]; then
                ALERT_MESSAGE="SELL: $i; Reached Peak in $DAYS_TO_COMPARE trading days" && echo $ALERT_MESSAGE
                alert
   elif [ $MIN_INCIDENT_OCCURANCE_MINS -lt $MINUTES_TO_ALERT ]; then
                ALERT_MESSAGE="BUY: $i; Reached Bottom in $DAYS_TO_COMPARE trading days" && echo $ALERT_MESSAGE
                alert
   else
        echo "$i is NEUTRAL IN LAST $MINUTES_TO_ALERT MINS" && echo
   fi
done
