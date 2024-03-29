This repo contains the demo Streamlit app documented [here](https://docs.streamlit.io/library/get-started/create-an-app), running behind a [Traefik](https://traefik.io/traefik/) reverse proxy.

# Rationale

Streamlit doesn't support running under HTTPS, but you might want to do that. One way to achieve this is to use a reverse proxy, and enable HTTPS on the proxy server. The user's browser connects to the proxy over HTTPS. The proxy server terminates the HTTPS connection and forwards requests over HTTP to Streamlit. Responses from Streamlit go via the proxy, back to the user.

```
┌────────────┐           ┌─────────┐           ┌─────────────┐
│            │──────────▶│         │──────────▶│             │
│  Browser   │   HTTPS   │  Proxy  │   HTTP    │  Streamlit  │
│            │◀ ─ ─ ─ ─ ─│         │◀ ─ ─ ─ ─ ─│             │
└────────────┘           └─────────┘           └─────────────┘


 ──────────▶  Request

 ◀ ─ ─ ─ ─ ─  Response
 ```

 ## Is this secure?

Yes, as long as the connection between the proxy and Streamlit is over a trusted network, i.e. not the open Internet. For example, if the proxy and Streamlit are running inside the same Kubernetes cluster, or running on the same physical host, then this is a good approach.

# Instructions

1. Install [mkcert](https://github.com/FiloSottile/mkcert#installation)
2. In the root directory of this repo, run:

    ```
    mkcert -cert-file streamlit-demo.pem -key-file streamlit-demo-key.pem localhost.dev.shiftlab.ai
    ```

    (`localhost.dev.shiftlab.ai` resolves to 127.0.0.1, just like `localhost`. But using this alias means we can avoid using https://localhost, since doing so in most modern browsers will cause them to redirect all subsequent traffic to that domain to HTTPS. That creates problems any time you want to run some other service over plain HTTP. See [here](https://stackoverflow.com/q/25277457) for more.)

3. Bring up the docker services.

    ```
    docker compose up -d
    ```

4. Visit https://localhost.dev.shiftlab.ai/
