# Streamlit via NGINX

This repo contains the demo Streamlit app documented [here](https://docs.streamlit.io/library/get-started/create-an-app), running behind an NGINX reverse proxy.

# Running in Docker

To get started, install Docker and docker-compose (Docker for Mac includes docker-compose), then:

```
docker-compose up -d
```

Now navigate to http://localhost:8080/ to view the app via the NGINX proxy, or http://localhost:8051 to connect directly to the Streamlit app.

# Streamlit reverse proxy issues

## Websocket won't connect through Nginx reverse proxy unless you use `localhost`, even over regular HTTP

If you're using a host other than `localhost` (or one of the other options explicitly [whitelisted in Streamlit](https://github.com/streamlit/streamlit/blob/dd9084523e365e637443ea351eaaaa25f52d8412/lib/streamlit/server/server_util.py#L101)), you need to set Streamlit's `browser.serverAddress` config value, otherwise attempts to connect to the web socket endpoint (`/stream`) will be rejected with a 403 error.

You can set the `browser.serverAddress` config value by [passing it as an argument](https://docs.streamlit.io/library/advanced-features/configuration) to the `streamlit` command, or by setting the `STREAMLIT_BROWSER_SERVER_ADDRESS` environment variable. (You should use the environment variable approach if you're using docker compose.)

For example, if you've aliased `foo.bar` to `localhost` and want to use that domain name, you need to do:

```
export STREAMLIT_BROWSER_SERVER_ADDRESS=foo.bar
docker-compose up -d
```
