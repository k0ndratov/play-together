# PlayTogether

@JustPlayTogetherWithFriendsBot

PlayTogether is an application for conveniently gathering friends to play games together.

## Technologies

Rails: 8.0.1

Rack: 3.1.9

Ruby: 3.4.1 (+YJIT +PRISM)

RSpec 3.13

rspec-rails 7.1.1

## Running in Dev Mode

Create `.env` file with telegram bot token.
Take the example file `.env.sample`

To install telegram webhook

```bash
curl -X POST "https://api.telegram.org/bot<YOUR_BOT_TOKEN>/setWebhook" -d "url=<YOUR_NGROK_HTTPS_URL>/telegram_bot/webhook"
```

## Supported Commands

Will return a random popular game from Steam over the last 2 weeks
```
/random_game_name
```

Will return a ID and username of the user
```
/user_info
```
