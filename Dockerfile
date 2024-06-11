FROM gitea/gitea:1.22.0

ARG dep="asciidoctor freetype freetype-dev gcc g++ libpng libffi-dev pandoc-cli py-pip python3-dev py3-pip py3-setuptools py3-docutils jupyter-notebook jupyter-notebook-pyc"
USER root 
WORKDIR /data
RUN apk update && apk --no-cache add ${dep} \
 && apk upgrade \
 && git config --global core.excludesfile '/data/git/.gitignore' \
 && chown -R git:0 /data && chmod -R 770 /data \
 && chmod 664 /etc/passwd \
 && ln -sf /data/git/.gitconfig /.gitconfig

USER git
WORKDIR /data/git
