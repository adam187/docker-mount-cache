# FROM ubuntu:22.04 as build
# ENV DEBIAN_FRONTEND=noninteractive
# RUN \
#   --mount=type=cache,target=/var/cache/apt,sharing=locked \
#   --mount=type=cache,target=/var/lib/apt,sharing=locked \
#   rm -f /etc/apt/apt.conf.d/docker-clean && \
#   echo 'Binary::apt::APT::Keep-Downloaded-Packages "true";' >/etc/apt/apt.conf.d/keep-cache && \
#   apt-get update && \
#   apt-get install -y gcc

# FROM build as runner

# RUN echo "Hello, world!"

FROM node:18.17.0-alpine as builder-node

WORKDIR /usr/src/app

RUN yarn cache dir
RUN pwd 

COPY . .

RUN --mount=type=cache,target=/usr/local/share/.cache/yarn/v6,sharing=locked yarn install --frozen-lockfile --production

RUN \
    --mount=type=cache,target=/usr/src/app/.next/cache,sharing=locked \
    tree /usr/src/app/.next/cache && \
    yarn build && \
    tree /usr/src/app/.next/cache && \
    pwd
