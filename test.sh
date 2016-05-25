
#set -x
DB="norayr_matyan"
TITLE="մարտի մեկ, հավաք"
OUT="out.txt"
truncate -s 0 $OUT

#execute the query and take 4th line, id of the post out of the output.
ID=`mysql -uroot -D ${DB} -p -e "SELECT ID FROM wp_posts where post_title='${TITLE}' and post_status='publish';" | awk '{if (! ((FNR + 2) % 4)) { print }}'`

echo "id=$ID"

LIST=`mysql -uroot -D ${DB} -p -e "SELECT guid FROM wp_posts where post_parent='${ID}' and post_type='attachment';"`


for i in $LIST
do
  echo $i
  str0='<a href="'
  str1='"><img src="'
  str2='-300x200.jpg"/></a><br>'
  str3="${i%.*}"
  if [ "$i" != "guid" ]
  then
    line="${str0}${i}${str1}${str3}${str2}"
    echo $line >> $OUT
  fi
done


