# best-discord-notifications
Fancy Discord notifications for Radarr and Sonarr (bash) - **a special thanks goes to JoseP, for the base code and helping with the final touches!**

------------

These are separate notifications for Grab and Download/Upgrade events in Radarr, while only Downloa/Upgrade events in Sonarr, so you need to set options accordingly in Settings > Connect.

To set up these notification you will need:
1. TMDb (The Movie DataBase) API Key (free)
2. OMDb (Open Movie DataBase) API Key (free one is valid for 1000 requests per day)
3. Discord webhook

If you don't want to make any modifications to the script, you will need to fill all the requested variables in the `script.sh` file. If you don't, the script won't run.

------------

To get the script ready, just download the folder to your server, store it in a path reachable from your Radarr docker, `chmod +x` the file and you're good to go!

------------

------------

![Example of a notification](https://i.imgur.com/sMdsDSs.png "Example of a radarr grab admin notification")

![Example of a notification](https://i.imgur.com/9yI2pGP.png "Example of a radarr grab users notification")

![Example of a notification](https://i.imgur.com/lDwrhK2.png "Example of a radarr download admin notification")

![Example of a notification](https://i.imgur.com/oyHOyWG.png "Example of a radarr download users notification")

![Example of a notification](https://i.imgur.com/QcKu4eq.png "Example of a sonarr download admin notification")

![Example of a notification](https://i.imgur.com/NcnZoxG.png "Example of a sonarr download users notification")
