FROM python:3.5
MAINTAINER Thomas Farr <xtansia@xtansia.com>

RUN apt-get update --fix-missing -qq -y \
  && apt-get install -y --no-install-recommends \
    texlive-full \
    poppler-utils \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/*

RUN pip install aiohttp

ADD latex2png latex2png_server /usr/local/bin/
RUN chmod +x /usr/local/bin/latex2png /usr/local/bin/latex2png_server
CMD /usr/local/bin/latex2png_server
EXPOSE 8080
