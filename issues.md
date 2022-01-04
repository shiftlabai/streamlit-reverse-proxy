# Streamlit reverse proxy issues

## Websocket won't connect through Nginx reverse proxy unless you use `localhost`, even over regular HTTP

To demonstrate:

```
git checkout master
docker compose up -d
```

Then try accessing the app via e.g. your Tailscale IP. e.g. http://100.124.117.59:8080. You'll just see an eternal "Please wait..." message in the browser.

NB: This works OK when running streamlit directly (i.e. running `streamlit run xxx.py`), but doesn't work when accessing via Nginx.

## Websocket won't connect when connecting via HTTPS

May or may not be the same problem as above.