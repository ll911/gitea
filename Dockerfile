FROM pandoc/alpine-latex

ARG DISTBIN="https://github.com/go-gitea/gitea/releases/download/v${VER}/gitea-${VER}-linux-amd64"

USER root 
WORKDIR /app
RUN apk upate && apk --no-cache add asciidoctor \
    bash ca-certificates \
    curl \
    gettext \
    git \
    linux-pam \
    openssh \
    s6 \
    sqlite \
    su-exec \
    tzdata \
    gnupg freetype freetype-dev gcc g++ git libpng python-dev py-pip python3-dev py3-pip build-base libffi-dev openssl-dev python-dev krb5-dev linux-headers zeromq-dev \
 && adduser -S git \
 && chown -R git:0 /app && chmod -R 770 /app \
 && curl -L -J --header "Accept: application/tar+gzip, application/x-gzip, application/octet-stream" -o /usr/local/bin/gitea ${DISTBIN} \
 && chmod 755 /usr/local/bin/gitea \
 && mkdir -p /app/gitea && chown -R git:0 /app/gitea && chmod -R 775 /app/gitea \
 && mkdir -p /data/git && chown -R git:0 /data/git && chmod -R 775 /data \
 && pip3 install --no-cache-dir -U pip setuptools \
 && pip3 install --no-cache-dir kiwisolver==1.1.0 jupyter matplotlib==3.2.1 docutils \
 && git config --global core.excludesfile '/data/git/.gitignore' \
 && ln -sf /usr/local/bin/gitea /app/gitea/gitea \
 && ln -sf /data/git/.gitconfig /.gitconfig
# ln -sf /data /app/gitea/data \
# ln -sf /log /app/gitea/log \

ENV PATH=/app/gitea:$PATH
USER git
WORKDIR /data/git
