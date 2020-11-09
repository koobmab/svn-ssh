FROM alpine:3.12

LABEL maintainer="Maxim Solodukha <bambook@gmail.com>"

RUN set -x \
    && apk --update --no-cache add \
    openssh-server \
    openssh-sftp-server \
    subversion \
    tzdata 

RUN set -x \
    && ssh-keygen -A \
    && sed -i s/^#PasswordAuthentication\ yes/PasswordAuthentication\ no/ /etc/ssh/sshd_config

ARG SVNDIR=/svn

ARG SSHUSER=svnuser

ENV REPO=repo

ENV SSHUSER_PUB_KEY=""

ENV TZ=UTC

RUN set -x \
    && addgroup --gid 43001 $SSHUSER \
    && adduser --uid 43001 --home $SVNDIR --disabled-password -G $SSHUSER $SSHUSER \
    && addgroup $SSHUSER svnusers \
    && echo "$SSHUSER:`head -c 30 /dev/urandom | base64`" | chpasswd 

WORKDIR $SVNDIR

COPY authorized_keys.example ./

RUN set -x \
    && mkdir ./.ssh

COPY ./docker-entrypoint.sh /

ENTRYPOINT ["/docker-entrypoint.sh"]

EXPOSE 22/tcp

CMD ["/usr/sbin/sshd","-D"]
