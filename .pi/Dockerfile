FROM node:24-trixie-slim

RUN apt-get update
RUN apt-get install -y --no-install-recommends \
        bash \
        ca-certificates \
        curl \
        fd-find \
        git \
        python3 \
        python3-pip \
        python3-venv \
        r-base \
        r-cran-tidyverse \
        r-cran-data.table \
        ripgrep \
        vim
RUN  rm -rf /var/lib/apt/lists/*
RUN npm install -g --ignore-scripts @earendil-works/pi-coding-agent

WORKDIR /workspace
ENTRYPOINT ["pi"]
