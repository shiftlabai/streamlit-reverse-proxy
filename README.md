# Streamlit via NGINX

This repo contains the demo Streamlit app documented [here](https://docs.streamlit.io/library/get-started/create-an-app), running behind an NGINX reverse proxy.

# Running locally

Start a virtual env using Python 3.9, then:

```
pip3 install -r requirements.txt
streamlit run uber_pickups.py
```

# Running in Docker

To get started, install Docker and docker-compose (Docker for Mac includes docker-compose), then:

```
docker-compose up -d
```

Now navigate to http://localhost:8080/

# Streamlit reverse proxy issues

## Websocket won't connect through Nginx reverse proxy unless you use `localhost`, even over regular HTTP

To demonstrate:

```
docker compose up -d
```

Then try accessing the app via e.g. your Tailscale IP. e.g. http://100.124.117.59:8080. You'll just see an eternal "Please wait..." message in the browser.

NB: This works OK when running streamlit directly (i.e. running `streamlit run xxx.py`), but doesn't work when accessing via Nginx.

## Websocket won't connect when connecting via HTTPS

May or may not be the same problem as above.
