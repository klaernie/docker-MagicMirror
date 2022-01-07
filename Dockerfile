FROM node:12-buster

# hadolint ignore=DL3008
RUN set -e; \
    apt-get update; \
    apt-get install -y --no-install-recommends gettext; \
    rm -rf /var/lib/apt/lists/*

ARG branch=master

ENV NODE_ENV production
WORKDIR /opt/magic_mirror

RUN git clone --depth 1 -b ${branch} https://github.com/MichMich/MagicMirror.git . \
    && cp -R modules /opt/default_modules \
    && cp -R config /opt/default_config \
    && npm install --unsafe-perm --silent

COPY mm-docker-config.js docker-entrypoint.sh ./

EXPOSE 8080
ENTRYPOINT ["./docker-entrypoint.sh"]
CMD ["node", "serveronly"]
