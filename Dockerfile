FROM alpine:3.12

LABEL maintainer="Maxim Solodukha <bambook@gmail.com>"

RUN set -x \
    && apk --update --no-cache add \
    openssh-server \
    subversion \
    && rm -rf /var/cache/apk/*

RUN set -x \
    && ssh-keygen -A

WORKDIR /svn

RUN set -x \
    && addgroup --gid 43001 vcs \
    && adduser --uid 43001 --home /svn --disabled-password vcs \
    && addgroup vcs vcs svnusers

RUN set -x \
    && chown -R vcs:vcs /svn

USER vcs

RUN set -x \  
    && mkdir ./.ssh \
    && touch ./.ssh/authorized_keys

RUN set -x \
    && mkdir ./dump

USER root

COPY docker-entrypoint.sh /

ENTRYPOINT ["/docker-entrypoint.sh"]

EXPOSE 22/tcp

CMD ["/usr/sbin/sshd","-D"]
