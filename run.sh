#!/usr/bin/env sh

set -e
exec env TMPDIR=$XDG_CACHE_HOME zypak-wrapper joplin "$@"
