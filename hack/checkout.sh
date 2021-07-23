#!/usr/bin/env bash

set -o errexit
set -o nounset
set -o pipefail

if [[ "$#" -lt 1 ]]; then
    echo "${0} release: checkout to expected patch release"
    exit 2
fi

source "$(dirname "${BASH_SOURCE}")/helper.sh"
cd "${ROOT}"

RELEASE="$1"

BASE_RELEASE=$(helper::config::get_base_release $RELEASE)
PATCHES=$(helper::config::get_patches $RELEASE)

echo "Release ${BASE_RELEASE} patches ($(echo ${PATCHES} | tr ' ' ',')) as release ${RELEASE}"

PATCH_LIST=$(helper::config::get_patch ${PATCHES})

./hack/git_fetch_tag.sh ${BASE_RELEASE}
if [[ "${PATCH_LIST}" != "" ]]; then
    ./hack/git_patch.sh ${PATCH_LIST}
fi

cd "${WORKDIR}" && git tag -f "${RELEASE}"
