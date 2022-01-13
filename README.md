# Streamlit via NGINX

This repo contains the demo Streamlit app documented [here](https://docs.streamlit.io/library/get-started/create-an-app), running behind an NGINX reverse proxy.

# Running under HTTPS

To run under HTTPS on your own machine:

1. Install [mkcert](https://github.com/FiloSottile/mkcert#installation)
2. Edit your `/etc/hosts` file and add the following.

    ```
    127.0.0.1 secure.localhost
    ```

    (Adding this local alias means we can avoid using https://localhost, since doing so in most modern browsers will cause them to redirect all subsequent traffic to that domain to HTTPS. That creates problems any time you want to run some other service over plain HTTP. See [here](https://stackoverflow.com/q/25277457) for more.)

3. In the root directory of this repo, run:

    ```
    mkcert -cert-file streamlit-demo.pem -key-file streamlit-demo-key.pem secure.localhost
    ```

4. Now bring up the docker services. Note that we need to set the `STREAMLIT_BROWSER_SERVER_ADDRESS` environment variable to our new server domain, since we're no longer using `localhost`, which is [whitelisted in Streamlit](https://github.com/streamlit/streamlit/blob/dd9084523e365e637443ea351eaaaa25f52d8412/lib/streamlit/server/server_util.py#L103).

    ```
    STREAMLIT_BROWSER_SERVER_ADDRESS=secure.localhost docker-compose up -d
    ```

5. Visit https://secure.localhost:8081/

# Streamlit reverse proxy issues

## Websocket won't connect through Nginx reverse proxy unless you use `localhost`, even over regular HTTP

If you're using a host other than `localhost` (or one of the other options explicitly [whitelisted in Streamlit](https://github.com/streamlit/streamlit/blob/dd9084523e365e637443ea351eaaaa25f52d8412/lib/streamlit/server/server_util.py#L101)), you need to set Streamlit's `browser.serverAddress` config value, otherwise attempts to connect to the web socket endpoint (`/stream`) will be rejected with a 403 error.

You can set the `browser.serverAddress` config value by [passing it as an argument](https://docs.streamlit.io/library/advanced-features/configuration) to the `streamlit` command, or by setting the `STREAMLIT_BROWSER_SERVER_ADDRESS` environment variable. (You should use the environment variable approach if you're using docker compose.)

For example, if you've aliased `foo.bar` to `localhost` and want to use that domain name, you need to do:

```
export STREAMLIT_BROWSER_SERVER_ADDRESS=foo.bar
docker-compose up -d
```
