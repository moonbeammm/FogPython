#!/bin/sh
set -e

function do_clear_Cache()
{
    FRAMEWORK_DIR=$1
    #echo $FRAMEWORK_DIR

    if [[ ! -d $FRAMEWORK_DIR ]]; then
        echo "Error framework directory" >> $LOG_PATH
        exit 1 
    fi

    CACHE_DIRS=`ls $FRAMEWORK_DIR`
    for CACHE_DIR in $CACHE_DIRS; do
        CACHE_DIR=${FRAMEWORK_DIR}/${CACHE_DIR}
        #echo $CACHE_DIR
        a=`stat -f "%m%t" $CACHE_DIR`
        # b=`echo $a | cut -d '"' -f 2`
        # echo $b
        # e=`date -j -f "%Y-%m-%d %H:%M:%S" $b +%s`
        c=`date +%s` 
        d=`expr $c - $a`
        TWO_DAY=`expr 24 \* 2 \* 60 \* 60`

        if [[ $d -gt $TWO_DAY ]]; then
            e=`du -sh $CACHE_DIR`
            f=`echo $e | cut -d ' ' -f 1`
            g=`du -s $CACHE_DIR`
            h=`echo $g | cut -d ' ' -f 1`
            SUM_SIZE=`expr $SUM_SIZE + $h`
            echo "Delete fileSize:$f file:$CACHE_DIR" >> $LOG_PATH
            #rm -rf $CACHE_DIR
        fi
    done
} 

DATE=`date +%Y-%m-%d\ %H:%M:%S`
LOG_PATH="/Users/chenguang/Desktop/clearCarthageCache.log"
echo $DATE >> $LOG_PATH
echo "---------------BEGIN CLEAR--------------------" >> $LOG_PATH
DIR_PATH="/Users/chenguang/Library/Caches/org.carthage.CarthageKit/DerivedData"
FRAMEWOEK_DIRS=`ls $DIR_PATH`
SUM_SIZE=0
for FRAMEWORK_NAME in $FRAMEWOEK_DIRS; do
    #B前缀的库名
    if [[ $FRAMEWORK_NAME = B* ]]; then
        echo "*****************${FRAMEWORK_NAME}****************" >> $LOG_PATH
        if [ $FRAMEWORK_NAME = "BFC" ]; then
                BFC_FRAMEWORK_DIR=${DIR_PATH}/${FRAMEWORK_NAME}
                BFC_DIRS=`ls $BFC_FRAMEWORK_DIR`
                for BFC_FRAMEWORK in $BFC_DIRS; do
                    FRAMEWORK_DIR=${BFC_FRAMEWORK_DIR}/${BFC_FRAMEWORK}
                    if [[ -d $FRAMEWORK_DIR ]]; then
                        do_clear_Cache $FRAMEWORK_DIR
                    fi
                done
            else
                FRAMEWORK_DIR=${DIR_PATH}/${FRAMEWORK_NAME}
                if [[ -d $FRAMEWORK_DIR ]]; then
                        do_clear_Cache $FRAMEWORK_DIR
                fi
        fi
    fi
done

echo "---------------END CLEAR--------------------" >> $LOG_PATH
echo "Delete Total Size $SUM_SIZE" >> $LOG_PATH


