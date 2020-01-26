# best-discord-notifications
Fancy Discord notifications for Radarr and Sonarr (bash) - **a special thanks goes to JoseP, for the base code and helping with the final touches!**
> P.S. Only Radarr download notification is available at the moment

------------

Radarr notifications at this moment must be set to **"Download/Upgrade"** only - another smaller notification for **"Grab"** will come in the near future.

To set up this notification you will need:
1. TMDb (The Movie DataBase) API Key (free)
2. OMDb (Open Movie DataBase) API Key (free one is valid for 1000 requests per day)
3. Discord webhook

If you don't want to make any modifications to the script, you will need to fill all the requested variables in the `radarr_download_notification.sh`. If you don't, the script won't run.

------------

To get the script ready, just download the folder to your server, store it in a path reachable from your Radarr docker, `chmod +x` the file and you're good to go!

------------

------------

![Example of a notification](https://i.imgur.com/i9IJCir.png "Example of a notification")
