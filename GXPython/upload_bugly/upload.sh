#!/usr/bin/env bash


####check arg
if [ ! -n "$1" ]; then
    echo "no input upload file" >&2
    exit 1
fi

if [ ! -f "$1" ]; then
    echo "input file $1 not exist" >&2
    exit 2
fi

###############上传到bugly
by_file="$1"
by_title="$2"
by_description="1.咨询师入驻修改
2.咨询师主页改版
"
by_pid=2
by_secret="1"   #所有人

APPIDKEY=`cat ./upload_bugly/APPIDKEY`
by_app_id=`echo $APPIDKEY | awk -F ":" '{print $1}'`
by_app_key=`echo $APPIDKEY | awk -F ":" '{print $2}'`

echo "curl upload ${by_file}  ......"

output=`curl --insecure -F "file=@${by_file}" -F "app_id=${by_app_id}" -F "pid=${by_pid}" -F "title=${by_title}" -F "description=${by_description}" -F "secret=${by_secret}" "https://api.bugly.qq.com/beta/apiv1/exp?app_key=${by_app_key}"`

###解析curl返回json数据
if test $? -eq 0; then
    echo "curl upload response:"
    echo "${output}"
    url=`python ./upload_bugly/parsejson.py "${output}"`
    if [ -n url ]; then
        if [ -n "$3" ]; then
            logfile="$3"
            ##日志输出
            echo "app for bugly url is : ${url}" >>$logfile
        else
            echo "app for bugly url is : ${url}"
        fi
        ############# 发邮件
        sendmailCfg=`cat ./upload_bugly/sendmail.cfg`
        mailsubject="${by_title} Upload Notifition"
        mailContent="${url} <br><br> ${by_title} <br> ${by_description}"
        cmdstr="python ./upload_bugly/SendmailViaSMTP.py ${sendmailCfg}  --subject=\"${mailsubject}\" --content=\"${mailContent}\""
        echo $cmdstr
        eval $cmdstr
    else
        exit 1
    fi
else
    echo "curl upload fail" >&2
    exit 1
fi

exit 0

