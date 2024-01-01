FROM node:21-bookworm

# hadolint ignore=DL3008
RUN set -e; \
    apt-get update; \
    apt-get install -y --no-install-recommends gettext; \
    rm -rf /var/lib/apt/lists/*

ARG branch=master

ENV NODE_ENV production
WORKDIR /opt/magic_mirror

RUN set -x \
    && echo "cloning MagicMirror" \
    && git clone --depth 1 -b ${branch} https://github.com/MagicMirrorOrg/MagicMirror.git . \
    && echo "copying stock modules to /opt" \
    && cp -R modules /opt/default_modules \
    && echo "copying stock config to /opt" \
    && cp -R config /opt/default_config \
    && echo "installing dependencies" \
    && npm install --no-fund --no-audit --unsafe-perm --no-update-notifier

COPY mm-docker-config.js docker-entrypoint.sh ./

EXPOSE 8080
ENTRYPOINT ["./docker-entrypoint.sh"]
CMD ["node", "serveronly"]
