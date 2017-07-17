# Makkachin Bot
A Discord bot built using [discordrb](https://github.com/meew0/discordrb), for use in a private server. Can create a 'writing sprint' event for users to work on creative writing projects, with the ability for users to opt-in to be notified of the sprint start and end. Makkachin can also fetch cat and dog gifs using the Giphy API, thanks to [giphy](https://github.com/sebasoga/giphy), and tell you her opinion on steamed buns.

## How to use

1. Set up a 'config.yaml' file as indicated in the 'example_config' file
```
token: <YOUR DISCORD BOT TOKEN>
client_id: <YOUR DISCORD APP CLIENT ID>
makka_emoji: <ID OF AN EMOJI ABOUT STEAMED BUNS>
sprinting_role: <A ROLE FOR BEING @-MENTIONED FOR WRITING SPRINTS>
```

2. For Mac/Linux
```
$ ./makkachin.sh
```

3. For Windows
```
$ ./makkachin.bat
```

4. To see all available commands, simply @-mention the bot in your server.
