FROM debian

EXPOSE 1313

RUN \
  addgroup --gid 1000 hugo && \
  useradd -d /home/hugo/ -g hugo -m -u 1000 hugo && \
  mkdir /site


RUN \
  apt-get update &&\
  apt-get install -y curl&&\
  apt-get clean

RUN \
  curl -sL -o/var/cache/apt/archives/hugo.deb https://github.com/gohugoio/hugo/releases/download/v0.71.0/hugo_0.71.0_Linux-64bit.deb  && dpkg -i /var/cache/apt/archives/hugo.deb && \
  curl -sL -o/var/cache/apt/archives/hugo_extended.deb https://github.com/gohugoio/hugo/releases/download/v0.71.0/hugo_extended_0.71.0_Linux-64bit.deb  && dpkg -i /var/cache/apt/archives/hugo_extended.deb


USER hugo

WORKDIR /home/hugo/site

COPY . /home/hugo/site

ENTRYPOINT /usr/local/bin/hugo serve
