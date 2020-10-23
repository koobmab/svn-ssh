#!/bin/sh

set -e

REPO=${SVN_REPO_NAME:-repo}

if [[ ! -d ${REPO} ]]; then
        echo "Creating repo..."
        svnadmin create ${REPO}
        echo "Done."
else
        echo "Found repo."
fi

