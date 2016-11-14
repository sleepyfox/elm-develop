# Elm development
This is a simple `make` and `Docker`-based development environment for playing with [#Elm-lang](http://elm-lang.org/). The image is based on [node:7-slim](https://hub.docker.com/_/node/) and [Elm](http://elm-lang.org/) v0.18.0

To build your own copy of the image, simply:
```bash
	make build-latest
```

To bring up a REPL:
```bash
	make repl
```

To do interactive development you'll want to use the elm-reactor with:
```bash
    make reactor
```

Simples!

# License
This work is licensed under a CC-BY-SA-NC-4.0 license as specified in the supplied LICENSE file.
