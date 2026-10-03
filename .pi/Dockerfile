FROM node:24-trixie-slim

RUN apt-get update \
  && apt-get install -y --no-install-recommends bash fd-find ca-certificates git ripgrep \
  && rm -rf /var/lib/apt/lists/*
RUN npm install -g --ignore-scripts @earendil-works/pi-coding-agent

WORKDIR /workspace
ENTRYPOINT ["pi"]
