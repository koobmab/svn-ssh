#!/bin/sh

set -e

if [[ ! -z "${TZ}" ]]; then
	cp /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
fi

if [[ ! -a ./ssh/authorized_keys ]]; then

	if [[ -z "${SSHUSER_PUB_KEY}" ]]; then
		echo "ENV VAR SSHUSER_PUB_KEY not found."
		exit 1
	fi

        echo "Adding PUB KEY to authorized keys..."
        echo $SSHUSER_PUB_KEY > ./.ssh/authorized_keys
        chmod 700 ./.ssh
        chmod 600 ./.ssh/authorized_keys
        echo "Done."
else
        echo "Found authorized_keys. Nothing to do."
fi

if [[ ! -d ${REPO} ]]; then
        echo "Creating repo..."
        svnadmin create ${REPO}
        echo "Done."
else
        echo "Found repo. Nothing to do."
fi

chown -R 43001:43001 .

echo "Entrypoint Done."

echo "REPO=$REPO"

exec "$@"
