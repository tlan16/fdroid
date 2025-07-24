#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "$0")" || exit 1

7z x 'revolut-7-30-3.apk.7z.001'
cd - || exit 1
