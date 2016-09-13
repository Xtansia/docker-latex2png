# docker-pngifier
Docker container for rendering various formats to PNGs.
Currently has support for:
- LaTeX
- ABC music notation
- Gnuplot

## Building
```sh
$ docker build -t xtansia/pngifier .
```

## Configuration
The render timeout duration is controlled by the `RENDER_TIMEOUT` environment variable, which defaults to `10s`.

## Usage
Run the container
```sh
$ docker run -dt --name pngifier xtansia/pngifier
```

This exposes a very simple HTTP server on port 8080 of the container.
Which can be used by POSTing the document to it where the path is the format name, ie. to `http://<container_ip>:8080/<latex|abc|gnuplot>`.
- On Success
  * Response is the PNG image
  * Status code is 200
- On Time Out
  * Response is `Timed Out`
  * Status code is 408
- On Failure
  * Response is the error log
  * Status code is 400
```sh
$ cat << EOF >hello_world.tex
\documentclass[varwidth,border=1pt]{standalone}
\begin{document}
  Hello World
\end{document}
EOF
$ curl --data-binary @hello_world.tex -o hello_world.png 'http://<container_ip>:8080/latex'
```

You can also directly execute the <format>2png commands within the container, piping the document to stdin.
- On Success
  * PNG image is written to stdout
  * Exit code is 0
- On Failure
  * Error log is written to stderr
  * Exit code is 1
```sh
$ cat << EOF >hello_world.tex
\documentclass[varwidth,border=1pt]
\begin{document}
  Hello World
\end{document}
EOF
$ docker exec -i latex2png latex2png < hello_world.tex > hello_world.png
```

## Security
I make no guarantees as to how secure this container is, 
so feed it random documents at your own risk. 
Though to the best of my knowledge the only real 
risk is reading files within the container through 
import/include abilities of the various languages.