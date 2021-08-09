#!/usr/bin/env bash

set -o errexit
set -o nounset
set -o pipefail

source "$(dirname "${BASH_SOURCE}")/helper.sh"
cd "${ROOT}"

./hack/pkg_rpm.sh kubectl amd64,arm64,arm,ppc64le,s390x