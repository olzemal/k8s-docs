FROM nginx:alpine

RUN apk add git go g++ make npm

RUN \
  git clone "https://github.com/gohugoio/hugo.git" /hugo && \
  cd /hugo && \
  CGO_ENABLED=1 go build -o ./hugo --tags extended && \
  mv ./hugo /usr/local/bin/hugo && \
  hugo help && cd /

RUN \
  git clone "https://github.com/kubernetes/website.git" /website && \
  cd /website && \
  git submodule update --init --recursive --depth 1 && \
  npm ci && make build

RUN \
  rm -rf /root/* && \
  rm -rf /hugo

RUN \
  mv /website/public/* /usr/share/nginx/html/
