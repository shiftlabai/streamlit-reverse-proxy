# Streamlit via NGINX

This repo contains the demo Streamlit app documented [here](https://docs.streamlit.io/library/get-started/create-an-app), running behind an NGINX reverse proxy.

To get started, install Docker and docker-compose (Docker for Mac includes docker-compose), then:

```
docker-compose up -d
```

Now navigate to http://localhost:8080/

# Using HTTPS

*This is work in progress. Currently HTTPS calls work, but WSS (secure websocket) calls fail to connect. (simon@, 2021-12-19)*

To test HTTPS on your own machine:

1. Install [mkcert](https://github.com/FiloSottile/mkcert#installation)
2. Edit your `/etc/hosts` file and add the following.

    ```
    127.0.0.1 secure.localhost
    ```

    (Adding this local alias means we can avoid using https://localhost, since doing so in most modern browsers will cause them to redirect all subsequent traffic to that domain to HTTPS. That creates problems any time you want to run some other service over plain HTTP. See [here](https://stackoverflow.com/q/25277457) for more.)

3. In the root directory of this repo, run:

    ```
    mkcert secure.localhost
    ```

4. Now bring up the docker services as before:

    ```
    docker-compose up -d
    ```

5. Visit https://secure.localhost:8081/
