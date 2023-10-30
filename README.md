![screenshot](screenshot.png)

Custom Kasm Workspace images for quick linux enviornments.

```
git clone https://github.com/cscosu/workspace
cd workspace
docker compose up --build
```

or in one command

```
docker run --rm --privileged -d -p 6901:6901 ghcr.io/cscosu/workspace
```

Then navigate to https://localhost:6901 and accept the self signed certificate.

Limitations:

- No audio
