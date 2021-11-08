#!/bin/bash
truncate -s 0 file2.txt
filename="$1"
n="$2"
count=0
count1=0
while read line; do

if [[ $line != "*** START OF THIS PROJECT GUTENBERG EBOOK ALICE IN WONDERLAND ***" ]];then
    ((count++))  
else
savecount=$((count+1))
fi
if [[ $line != "*** END OF THIS PROJECT GUTENBERG EBOOK ALICE IN WONDERLAND ***" ]];then
    ((count1++))
else
savecount1=$((count1+1)) 
fi
done < $filename
sed -n " ${savecount} , ${savecount1}p " $filename > temp.txt
sed -i ' 1d;$d ' temp.txt

for word in $(
  cat temp.txt | \
  tr '[:upper:]' '[:lower:]' | \
  tr -d '[:punct:]' | \
  tr -d  '/'
)
do
  words=$(sed -e 's/[^[:alpha:]]/ /g' temp.txt | tr '\n' " " |  tr -s " "  | tr " " '\n'| tr 'A-Z' 'a-z'  | sort | uniq -c | sort -nr | nl | head -n $n;)
  echo -e "$words\n" >> file2.txt
	awk '{ print $3, $2}' file2.txt
	rm file2.txt temp.txt 
	exit
done
