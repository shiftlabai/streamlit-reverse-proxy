# Streamlit via Traefik

This repo contains the demo Streamlit app documented [here](https://docs.streamlit.io/library/get-started/create-an-app), running behind a Traefik reverse proxy.

# Running under HTTPS

To run under HTTPS on your own machine:

1. Install [mkcert](https://github.com/FiloSottile/mkcert#installation)
2. In the root directory of this repo, run:

    ```
    mkcert -cert-file streamlit-demo.pem -key-file streamlit-demo-key.pem localhost.shiftlab.cloud
    ```

    (`localhost.shiftlab.cloud` resolves to 127.0.0.1, just like `localhost`. But using this alias means we can avoid using https://localhost, since doing so in most modern browsers will cause them to redirect all subsequent traffic to that domain to HTTPS. That creates problems any time you want to run some other service over plain HTTP. See [here](https://stackoverflow.com/q/25277457) for more.)

3. Bring up the docker services.

    ```
    docker-compose up -d
    ```

4. Visit https://localhost.shiftlab.cloud/
