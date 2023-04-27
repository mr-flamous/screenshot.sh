#!/bin/bash

if [[ "$1" != "-c" ]]; then
	flameshot gui -c
fi

# -s: save and upload to x0.at
if [[ "$1" == "-s" ]]; then
	IMAGEPATH="$HOME/Documents/Screenshot/"
	IMAGENAME="$(date +'%d_%m_%Y-%H_%M_%S_%3N')"
	FILE="$IMAGEPATH$IMAGENAME.png"
	xclip -t image/png -sel clip -o > "$FILE"           
	URL=$(curl -F "file=@$FILE" https://x0.at/ 2>/dev/null)
	printf "%s" "$URL" | xclip -sel clip
	echo "$URL"
	notify-send "Screenshot copied" "$URL"
# -c: copy data from clipboard and upload to x0.at
elif [[ "$1" == "-c" ]]; then
	URL=$(xclip -t image/png -sel clip -o | curl -F "file=@-" https://x0.at/ 2>/dev/null)
	printf "%s" "$URL" | xclip -sel clip
	echo "$URL"
	notify-send "Data copied" "$URL"
fi
