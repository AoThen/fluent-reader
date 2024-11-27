FROM alpine/git AS base

ARG TAG=latest
RUN git clone https://github.com/yang991178/fluent-reader.git && \
    cd fluent-reader && \
    ([[ "$TAG" = "latest" ]] || git checkout ${TAG}) && \
    rm -rf .git

FROM node:alpine AS build

WORKDIR /fluent-reader
COPY --from=base /git/fluent-reader .
RUN npm install &&  && \
    export COREPACK_ENABLE_STRICT=0 && \
    npm run build


    
    

FROM lipanski/docker-static-website

COPY --from=build /fluent-reader/dist .