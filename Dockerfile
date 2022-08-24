FROM gitea/gitea:1.17.1

ARG dep="asciidoctor freetype freetype-dev gcc g++ libpng libffi-dev py-pip python3-dev py3-pip"
USER root 
WORKDIR /data
RUN apk update && apk --no-cache add ${dep} \
 && apk upgrade \
 && pip3 install --no-cache-dir -U pip setuptools \
 && pip3 install --no-cache-dir jupyter docutils \
 && git config --global core.excludesfile '/data/git/.gitignore' \
 && chown -R git:0 /data && chmod -R 770 /data \
 && chmod 664 /etc/passwd \
 && ln -sf /data/git/.gitconfig /.gitconfig

USER git
WORKDIR /data/git
