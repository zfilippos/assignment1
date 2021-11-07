#!/bin/bash
filename='sitelinks.txt'
n=0
flag=0
while read line; do
	URL=$line
	if [[ "$line" =~ \#.* ]];then
		continue
	else
	#for (( ; ; )); do
	HTTP=$(curl -s -o out.html -w '%{http_code}' $URL;)
	if [[ $HTTP -ne 200 && $HTTP -ne 301 ]]; then
		echo "$URL FAILED"
		flag=1
		#exit
	else

	mv new$n.html old$n.html 2> /dev/null

	if [ ! -e "old$n.html" ];then
		curl $URL -L --compressed -s > new$n.html
		echo "$URL INIT"
		#exit
		
	else

	    curl $URL -L --compressed -s > new$n.html
	    DIFF_OUTPUT="$(diff new$n.html old$n.html)"
		    if [ "0" != "${#DIFF_OUTPUT}" ]; then
			 if [ "flag" != "1" ]; then
				echo "$URL Changed"
			 fi   
		    else

			if [ "flag" != "1" ];then
				exit
			fi
		    fi
	fi
	fi

	#done
	fi
let n++
done < sitelinks.txt
