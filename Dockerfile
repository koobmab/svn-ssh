FROM alpine:3.12

LABEL maintainer="Maxim Solodukha <bambook@gmail.com>"

RUN apk --update --no-cache add openssh-server subversion && \
    rm -rf /var/cache/apk/*

RUN ssh-keygen -A

RUN mkdir /svn

RUN adduser --home /svn --disabled-password vcs vcs && \
    addgroup vcs svnusers

WORKDIR /svn

RUN chown -R vcs:vcs /svn

USER vcs

RUN mkdir ./.ssh && \
    touch ./.ssh/authorized_keys

RUN mkdir ./dump

RUN svnadmin create ${SVN_REPO_NAME:-repo}

USER root

#ssh-keygen -t rsa -b 4096 -f  /etc/ssh/ssh_host_key

EXPOSE 22

CMD ["/usr/sbin/sshd","-D"]
