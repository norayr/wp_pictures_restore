set -x
DB="norayr_matyan"
TITLE="ասք հայաստանի հպարտ բուրժուաների մասին"
OUT="out.txt"
IMG_PATH="/export/http/www/norayr.am/htdocs/weblog/wp-content/uploads"
SIZE=300
truncate -s 0 $OUT

#execute the query and take 4th line, id of the post out of the output.
ID=`mysql -uroot -D ${DB} -p -e "SELECT ID FROM wp_posts where post_title='${TITLE}' and post_status='publish';" | awk '{if (! ((FNR + 2) % 4)) { print }}'`
#ID=10130
echo "id=$ID"

LIST=`mysql -uroot -D ${DB} -p -e "SELECT guid FROM wp_posts where post_parent='${ID}' and post_type='attachment';"`

for i in $LIST
do
  echo $i
  if [ "$i" != "guid" ]
  then
    str0='<a href="'
    str1='"><img src="'
    str2="${i%.*}"
    year=`echo $i | awk -F "/" {' print $7 '}`
    month=`echo $i | awk -F "/" {' print $8 '}`
    file=`echo $i | awk -F "/" {' print $9 '}`
    nfile="${file%.*}"
    vfile="${nfile}1"
    sfx0=`ls $IMG_PATH/$year/$month/ | grep $nfile | grep $SIZE | grep -v 150`
	#take part before last dot
	sfx1="${sfx0%.*}"
	#take part after last hyphen
	sfx=${sfx1##*-}
    str3='.png"/></a><br>'
    str5="-${sfx}${str3}"
    line="${str0}${i}${str1}${str2}${str5}"
    echo $line >> $OUT
  fi
done

sed -i 's/norayr.arnet.am/norayr.am/g' $OUT
