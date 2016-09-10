# docker-latex2png
Docker container for converting Latex documents to PNGs

## Building
```sh
$ docker build -t xtansia/latex2png .
```

## Usage
Run the container
```sh
$ docker run -dt --name latex2png xtansia/latex2png
```

This exposes a very simple HTTP server on port 8080 of the container.
Which can be used by POSTing the LaTeX to it with no path, ie. to `http://<container_ip>:8080/`.
- On Success
  * Response is the PNG image
  * Status code is 200
- On Time Out
  * Response is `Timed Out`
  * Status code is 408
- On Failure
  * Response is the LaTeX error log
  * Status code is 400
```sh
$ cat << EOF >hello_world.tex
\documentclass[varwidth,border=1pt]{standalone}
\begin{document}
  Hello World
\end{document}
EOF
$ curl -d @hello_world.tex -o hello_world.png 'http://<container_ip>:8080/'
```

You can also directly execute latex2png within the container, piping the latex to stdin.
- On Success
  * PNG image is written to stdout
  * Exit code is 0
- On Time Out
  * `Timed Out` is written to stderr
  * Exit code is 124
- On Failure
  * LaTeX error log is written to stderr
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
