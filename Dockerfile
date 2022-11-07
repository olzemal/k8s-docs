FROM alpine:latest as generate

RUN apk add git go g++ make npm

ARG K8S_RELEASE

RUN \
  git clone "https://github.com/gohugoio/hugo.git" /hugo && \
  cd /hugo && \
  CGO_ENABLED=1 go build -o ./hugo --tags extended && \
  mv ./hugo /usr/local/bin/hugo && \
  hugo help && cd /

RUN \
  git clone "https://github.com/kubernetes/website.git" /website && \
  cd /website && \
  git switch "release-$K8S_RELEASE" && \
  git submodule update --init --recursive --depth 1

RUN \
  cd /website && \
  npm ci && make build

FROM nginx:latest
COPY --from=generate /website/public /usr/share/nginx/html
