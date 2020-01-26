# best-discord-notifications
Fancy Discord notifications for Radarr and Sonarr (bash) - **a special thanks goes to JoseP, for the base code and helping with the final touches!**
> P.S. Only Radarr notifications are available at the moment

------------

These are separate notifications for Grab and Download/Upgrade events in Radarr, so you need to set options accordingly in Settings > Connect.

To set up these notification you will need:
1. TMDb (The Movie DataBase) API Key (free)
2. OMDb (Open Movie DataBase) API Key (free one is valid for 1000 requests per day)
3. Discord webhook

If you don't want to make any modifications to the script, you will need to fill all the requested variables in the `script.sh` file. If you don't, the script won't run.

------------

To get the script ready, just download the folder to your server, store it in a path reachable from your Radarr docker, `chmod +x` the file and you're good to go!

------------

------------

![Example of a notification](https://i.imgur.com/9UaDzjV.png "Example of a grab admin notification")

![Example of a notification](https://i.imgur.com/OoaM43x.png "Example of a grab users notification")

![Example of a notification](https://i.imgur.com/i9IJCir.png "Example of a download notification")
