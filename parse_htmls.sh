#!/bin/bash

missed_files=( 150 197 )


patterns=$(echo ${missed_files[@]}| sed -e 's/\([0-9]*\)/\1|/g' | tr -d '[:blank:]')
patterns=${patterns::-1}

ls ~/Downloads/[0-9][0-9][0-9]*.html | grep -v -E "$patterns" > tmp_html_files.txt;

while IFS="" read -r html_file || [ -n "$html_file" ]
do 
  score=`cat $html_file | sed 's/<\/span>/\n/g'  | grep -m 1 'id="sscore' | sed 's/^[^>]*>//g' | sed 's/[[:blank:]]//g'`

  fname=`basename "$html_file"`
  num=`echo $fname | tr '/_' ' ' | awk '{print $1}'`
  url=`echo $fname | tr '/_' ' ' | awk '{print $2}'`

  if [ -z "$score" ]
  then
    echo $num $url -
  else
    echo $num $url $score
  fi
done < tmp_html_files.txt
