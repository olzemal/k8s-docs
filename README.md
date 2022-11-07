# k8s-docs

Dockerfile and k8s deployment to host the k8s docs on premise.

## Quickstart
```
docker build --build-arg K8S_RELEASE="1.19" -t k8s-docs:v1.19 .
kubectl apply -f k8s-docs.yaml
```
