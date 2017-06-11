#!/usr/bin/env bash
set -e

cwd="$( cd "${BASH_SOURCE[0]%/*}" && pwd )"
"$cwd/dist/build/site/site" clean
"$cwd/dist/build/site/site" build
rsync -Havzre 'ssh -p222' --delete _site/ elrod.me:/srv/webmount/ysuswings.org
