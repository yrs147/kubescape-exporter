# Docker build

## Build your own Docker image

Run the following command:

```bash
docker buildx build -t kubescape-exporter -f build/Dockerfile --load .
```