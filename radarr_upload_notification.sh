#!/bin/bash

# Set date variable - do not touch
date=$(date -u +"%Y-%m-%dT%T.000Z")

# Set your TMDb API Key - leave the quotes around
tmdb_api="yourTMDBapiKEY"

# Set your OMDb API Key - leave the quotes around
omdb_api="yourOMDBapiKEY"

# Set Discord webhook url - leave the quotes around
webhook_url="yourDISCORDwebhookURL"

# Set author name and icon image - leave the quotes arund
author_name="A movie was just downloaded!"
author_icon="https://www.copellihairstylist.eu/wp-content/uploads/2019/05/np-830x950.jpg"

# Set footer imge url and text - leave the quotes around
footer_url="https://img2.goodfon.com/wallpaper/nbig/9/fb/natalie-portman-natali-4983.jpg"
footer_text="Plex Movies"

# Set bot username - leave the quotes around
bot_username="Radarr"

# Get TMDb ID from IMDb ID - do not touch
tmdbid_url=$(curl -s "http://api.themoviedb.org/3/find/"${radarr_movie_imdbid}"?api_key="${tmdb_api}"&external_source=imdb_id" | jq -r '.movie_results[] | .id')

# Get poster path for thumbnail (/fakelink.png) - do not touch
posterr_path=$(curl -s "https://api.themoviedb.org/3/movie/"${tmdbid_url}"?api_key="${tmdb_api}"&language=en-US" | jq -r '.poster_path' | tr -d '"')

# Get poster image - do not touch
posterurl="https://image.tmdb.org/t/p/w500"${posterr_path}""

# Get movie description - do not touch
description_movie=$(curl -s "https://api.themoviedb.org/3/movie/"${tmdbid_url}"?api_key="${tmdb_api}"&language=en-US" | jq -r '.overview' | tr -d '"')

# Get IMDb page link - do not touch
imdb_page="["${radarr_movie_imdbid}"](https://www.imdb.com/title/"${radarr_movie_imdbid}"/)"

# Get release year - do not touch
release_year=$(curl -s "http://www.omdbapi.com/?apikey="${omdb_api}"&i="${radarr_movie_imdbid}"" | jq -r '.Year')

# Check if movie is upgrade or not - do not touch
if [ "$radarr_isupgrade" == "True" ]; then
    movie_upgrade="true"
else
    movie_upgrade="false"
fi

   curl -H "Content-Type: application/json" -X POST -d '{ "username": "'"${bot_username}"'", "embeds": [{
    "title": "'"${radarr_movie_title} (${release_year})"'",
    "description": "'"${description_movie}"'",
    "color": 12787793,
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
        "value": "'"${radarr_moviefile_scenename}"'"
      },
      {
        "name": "quality",
        "value": "'"${radarr_moviefile_quality}"'",
        "inline": true
      },
      { 
        "name": "upgrade",
        "value": "'"${movie_upgrade}"'",
        "inline": true
      },
      {
        "name": "IMDb Page",
        "value": "'"${imdb_page}"'",
        "inline": true 
      }]
  }] 
}' "${webhook_url}"
