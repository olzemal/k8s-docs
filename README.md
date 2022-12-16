# k8s-docs
## Example usage
```Dockerfile
FROM olzemal/k8s-docs:latest

ENV K8S_RELEASE=1.21
ENV LOCAL_URL=localhost

RUN \
  cd /website && \
  git switch "release-$K8S_RELEASE" && \
  sed -ie "s/kubernetes.io/$LOCAL_URL/g" /website/config.toml && \
  sed -ie 's/^disableLanguages = .*$/disableLanguages = ["zh", "ko", "ja", "fr", "it", "es", "pt", "id", "ru", "vi", "pl", "uk", "no", "hi", "pt-br"]/g' /website/config.toml && \
  sed -ie 's/https:/http:/g' /website/config.toml && \
  sed -ie 's/version_menu = "Versions"/version_menu = "a"/g' /website/config.toml && \
  make module-init && \
  make build

RUN \
  cp -r /website/public/* /usr/share/nginx/html/
```
