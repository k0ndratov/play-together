# PlayTogether

PlayTogether is an application for conveniently gathering friends to play games together.

## Technologies

Rails: 8.0.1

Rack: 3.1.9

Ruby: 3.4.1 (+YJIT +PRISM)

## Running in Dev Mode

To start in Docker, run the following command:

```bash
./dev.sh
```

To install telegram webhook

```bash
curl -X POST "https://api.telegram.org/bot<YOUR_BOT_TOKEN>/setWebhook" -d "url=<YOUR_NGROK_HTTPS_URL>/telegram_bot/webhook"
```
