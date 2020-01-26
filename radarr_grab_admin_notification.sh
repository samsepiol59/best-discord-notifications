#!/bin/bash

# Set date variable - do not touch
date=$(date -u +"%Y-%m-%dT%T.000Z")

# Set your TMDb API Key - leave the quotes around
tmdb_api="yourTMDBapiKEY"

# Set divider
divider=1073741824

# Set Discord webhook url - leave the quotes around
webhook_mine="yourDISCORDwebhookURL"

# Set author name and icon image - leave the quotes arund
author_name="A movie was just added to the download queue"
author_icon="https://www.copellihairstylist.eu/wp-content/uploads/2019/05/np-830x950.jpg"

# Set footer imge url and text - leave the quotes around
footer_url="https://img2.goodfon.com/wallpaper/nbig/9/fb/natalie-portman-natali-4983.jpg"
footer_text="Plex Movies"

#Set size variable
size_release="$(($radarr_release_size/$divider)).$(( ($radarr_release_size*100/$divider)%100)) GB"

# Set bot username - leave the quotes around
bot_username="Movie Grab Bot"

# Get poster path for thumbnail (/fakelink.png) - do not touch
posterr_path=$(curl -s "https://api.themoviedb.org/3/movie/"${radarr_movie_tmdbid}"?api_key="${tmdb_api}"&language=en-US" | jq -r '.poster_path' | tr -d '"')

# Get poster image - do not touch
posterurl="https://image.tmdb.org/t/p/w500"${posterr_path}""

   curl -H "Content-Type: application/json" -X POST -d '{ "username": "'"${bot_username}"'", "embeds": [{
    "title": "'"Grabbed: ${radarr_movie_title}"'",
    "color": 15044907,
    "timestamp": "'"${date}"'",
    "footer": {
      "icon_url": "'"${footer_url}"'",
      "text": "'"${footer_text}"'"
    },
    "thumbnail": {
      "url": "'"${posterurl}"'"
    },
    "author": {
      "name": "'"${author_name}"'",
      "icon_url": "'"${author_icon}"'"
    },
    "fields": [{
        "name": "release name",
        "value": "'"${radarr_release_title}"'"
      },
      {
        "name": "quality",
        "value": "'"${radarr_release_quality}"'",
        "inline": true
      },
      {
        "name": "release size",
        "value": "'"${size_release}"'",
        "inline": true
      },
      {
        "name": "indexer",
        "value": "'"${radarr_release_indexer}"'",
        "inline": true
      }]
  }]
}' "${webhook_mine}"
