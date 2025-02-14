#!/usr/bin/env bash
set -eo pipefail

function try_validate_zip() {
  local apk
  apk="$1"
  echo "Validating $apk"
  unzip -t -qq "$apk"
}

function try_validate_resources_arsc() {
  local apk
  apk="$1"
  echo "Validating resources.arsc in $apk"
  unzip -Z1 "$apk" | grep -qw 'resources.arsc'
}

for apk in ./fdroid/repo/*.apk; do
  # Delete the file if it's not a valid zip file
  if ! try_validate_zip "$apk"; then
    rm -vf "$apk"
  fi
done
