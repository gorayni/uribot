#/bin/bash    

COUNTER=1
while IFS="" read -r url || [ -n "$url" ]
do

  url=`echo "$url" | tr '[:upper:]' '[:lower:]'`  
  file_id=`printf "%03d\n" $COUNTER`
  dest_file=~/Downloads/$file_id"_"`echo $url | tr '/' '+' `"_main.html"
  let COUNTER=COUNTER+1
  if [ -f "$dest_file" ]; then
    continue
  fi

  [ -e ~/Downloads/main.html ] && rm ~/Downloads/main.html
  
  #if wget --spider https://www.$url 2>/dev/null; then
  #   full_http_address="https://www."$url
  #else
  #   full_http_address="http://www."$url
  #fi
  #wget --spider $full_http_address 2>/dev/null
  #if [[ $? -ne 0 ]]; then     
     full_http_address="$url"
  #fi
  WID=`xdotool search "Mozilla Firefox" | head -1`

  xdotool windowactivate --sync $WID
  sleep 1
  xdotool key --clearmodifiers ctrl+l
  sleep 1
  printf '%s\n' "$full_http_address"
  xdotool type "$full_http_address"
  xdotool key Return;
  sleep 4;
  xdotool mousemove 3545 100 click 1 & sleep 2

  xdotool mousemove 3500 140 click 3 & sleep 1
  xdotool key Down
  xdotool key Return
  sleep 1
  xdotool key Return
  sleep 2
  mv ~/Downloads/main.html "$dest_file"
  sleep 1

  xdotool key Print
  sleep 4
  xdotool type "$file_id"
  xdotool key Return

  sleep 1
done < 500websites.txt
