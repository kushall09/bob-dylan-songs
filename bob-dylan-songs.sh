#!/bin/sh
#get Bob Dylan's Song name from the official site using pup 


site=$(curl -s curl 'https://www.bobdylan.com/songs/' --compressed -H 'User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:121.0) Gecko/20100101 Firefox/121.0')
songname=$(echo $site | pup 'span.song text{}' | shuf -n 1)


# source
SRC="https://vid.puffyan.us"

#print the song name before playing


# make youtube search query
query="$(printf '%s' "$songname by bob dylan song audio" | tr ' ' '+' )"

# search on invidous (youtube) instance for video id to make a url
video_id="$(curl -s "$SRC/search?q=$query" | grep -Eo "watch\?v=.{11}" | head -n 1)"
youtube_url="https://youtube.com/$video_id"

#notify about the selection
echo "Now Playing: $songname"
title=$(yt-dlp --get-title "$youtube_url")
notify-send "Playing: " "$title"

# get url for bestaudio stream from the youtube video
audio_url="$(yt-dlp -f bestaudio --get-url "$youtube_url")"


mpv $audio_url

# Get youtube video title for system notification
