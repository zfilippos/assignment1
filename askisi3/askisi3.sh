read -p "Enter n number for words: " n
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
done < Alice.txt
sed -n " ${savecount} , ${savecount1}p " Alice.txt > Alice1.txt
sed -i ' 1d;$d ' Alice1.txt

for word in $(
  cat Alice1.txt | \
  tr '[:upper:]' '[:lower:]' | \
  tr -d '[:punct:]' | \
  tr -d  '/'
)
do
  words=$(sed -e 's/[^[:alpha:]]/ /g' Alice1.txt | tr '\n' " " |  tr -s " " | tr " " '\n'| tr 'A-Z' 'a-z'  | sort | uniq -c | sort -nr | nl | head -n $n;)
  echo "$words"
	exit
done 
