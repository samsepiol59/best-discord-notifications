#!/bin/bash

# Set date variable - do not touch
date=$(date -u +"%Y-%m-%dT%T.000Z")

# Set your TMDb API Key - leave the quotes around
tmdb_api="yourTMDBapiKEY"

# Select only one episode if multiples - do not touch
episode_number=$(echo "$sonarr_episodefile_episodenumbers" | cut -f1 -d",")

# Add zero to episode number - do not touch
if [ "$episode_number" -lt "10" ]; then
    episode_number="0$episode_number"
else
    episode_number="$episode_number"
fi

# Add zero to season number - do not touch
if [ "$sonarr_episodefile_seasonnumber" -lt "10" ]; then
    sonarr_episodefile_seasonnumber="0$sonarr_episodefile_seasonnumber"
else
    sonarr_episodefile_seasonnumber="$sonarr_episodefile_seasonnumber"
fi

# Set Discord webhook url - leave the quotes around
webhook_mine="yourDISCORDwebhookURL"

# Set author name and icon image - leave the quotes arund
author_name="A new episode was just downloaded!"
author_icon="https://www.copellihairstylist.eu/wp-content/uploads/2019/05/np-830x950.jpg"

# Set footer imge url and text - leave the quotes around
footer_url="https://img2.goodfon.com/wallpaper/nbig/9/fb/natalie-portman-natali-4983.jpg"
footer_text="Plex TV Shows"

# Set bot username - leave the quotes around
if [ "$episode_number" == "01" ]; then
    bot_username="TV New Season Download Bot"
else
    bot_username="TV Shows Download Bot"
fi

# Get TMDb ID from IMDb ID - do not touch
tmdbid_url=$(curl -s "https://api.themoviedb.org/3/find/"${sonarr_series_imdbid}"?api_key="${tmdb_api}"&external_source=imdb_id" | jq -r '.tv_results[] | .id')

# Check if tmdb_id is available, if not set to Breaking Bad - do not touch
if [ -z "$tmdbid_url" ]; then
    tmdbid_url="1396"
    broken_url="yes"
else
    tmdbid_url="$tmdbid_url"
    broken_url="no"
fi

# Get poster path for thumbnail (/fakelink.png) - do not touch
posterr_path=$(curl -s "https://api.themoviedb.org/3/tv/"${tmdbid_url}"?api_key="${tmdb_api}"&language=en-US" | jq -r '.poster_path' | tr -d '"')

# Get poster image - do not touch
if [ "$broken_url" == "no" ]; then
    posterurl="https://image.tmdb.org/t/p/w500"${posterr_path}""
else
    posterurl="https://www.hawtcelebs.com/wp-content/uploads/2019/10/natalie-portman-for-new-york-times-october-2019-3.jpg"
fi

# Select only first episode title - do not touch
cut_episode_title=$(echo "$sonarr_episodefile_episodetitles" | cut -f1 -d"|")

# Get episode description - do not touch
if [ "$broken_url" == "no" ]; then
    description_episode=$(curl -s "https://api.themoviedb.org/3/tv/"${tmdbid_url}"/season/"${sonarr_episodefile_seasonnumber}"/episode/"${episode_number}"?api_key="${tmdb_api}"&language=en-US" | jq -r '.overview' | tr -d '"')
else
    description_episode="not available"
fi

# Check episode description - do not touch
if [ -z "$description_episode" ]; then
    description_episode="-"
else
    description_episode="$description_episode"
fi

# Get IMDb page - do not touch
if [ -z "$sonarr_series_imdbid" ]; then
    imdb_page="-"
else
    imdb_page="["${sonarr_series_imdbid}"](https://www.imdb.com/title/"${sonarr_series_imdbid}"/)"
fi

# Next air date - do not touch
next_air_date=$(curl -s "https://api.themoviedb.org/3/tv/"${tmdbid_url}"?api_key="${tmdb_api}"&language=en-US" | jq -r '.next_episode_to_air | .air_date')

# Check if next episode air date is available - do not touch
if [ "$next_air_date" == "null" ]; then
    next_air_date="-"
else
    next_air_date="$next_air_date"
fi

# Check if episode is upgrade or not - do not touch
if [ "$sonarr_isupgrade" == "True" ]; then
    episode_upgrade="true"
else
    episode_upgrade="false"
fi

   curl -H "Content-Type: application/json" -X POST -d '{ "username": "'"${bot_username}"'", "embeds": [{
    "title": "'"${sonarr_series_title} (s${sonarr_episodefile_seasonnumber}e${episode_number})"'",
    "description": "'"${cut_episode_title}"'",
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
        "name": "episode synopsis",
        "value": "'"${description_episode}"'"
      },
      {
        "name": "release name",
        "value": "'"${sonarr_episodefile_scenename}"'"
      },
      {
        "name": "episode",
        "value": "'"s${sonarr_episodefile_seasonnumber}e${episode_number}"'",
        "inline": true
      },
      {
        "name": "air date",
        "value": "'"${sonarr_episodefile_episodeairdates}"'",
        "inline": true
      },
      {
        "name": "upgrade",
        "value": "'"${episode_upgrade}"'",
        "inline": true
      },
      {
        "name": "quality",
        "value": "'"${sonarr_episodefile_quality}"'",
        "inline": true
      },
      {
        "name": "IMDb",
        "value": "'"${imdb_page}"'",
        "inline": true
      },
      {
        "name": "next episode",
        "value": "'"${next_air_date}"'",
        "inline": true
      }]
  }]
}' "${webhook_mine}"
