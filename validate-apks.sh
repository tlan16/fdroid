#!/usr/bin/env bash
set -eo pipefail

cd "$(dirname "$0")" || exit 1
docker compose pull fdroid
cd "$(dirname "$0")/fdroid" || exit 1

function try_validate_zip() {
  local apk
  apk="$1"
  echo "Validating $apk"
  unzip -t -qq "$apk"
  docker compose run --quiet-pull --rm --remove-orphans --entrypoint 'uv' fdroid run androguard arsc "$apk" > /dev/null
}

for apk in ./repo/*.apk; do
  # Delete the file if it's not a valid zip file
  if ! try_validate_zip "$apk"; then
    rm -vf "$apk"
  fi
done

cd "$(dirname "$0")" || exit 1
