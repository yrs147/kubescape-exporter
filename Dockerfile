# FROM --platform=$BUILDPLATFORM golang:1.16.3-alpine3.13 AS builder
FROM golang:1.20-alpine

ENV GO111MODULE=on \
    CGO_ENABLED=0 

# Set the working directory inside the container
WORKDIR /work

# Copy the source code into the container
COPY . /work/

# Build the Go application with the build argument
RUN go build -o tagbuilder .

# Expose the port that the web application will listen on
EXPOSE 8080

WORKDIR /root

ENTRYPOINT [ "kubescape-exporter" ]




