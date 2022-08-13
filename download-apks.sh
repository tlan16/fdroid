#!/usr/bin/env sh

BASEDIR=$(realpath "$(dirname "$0")")
echo "BASEDIR: $BASEDIR"

mkdir -p "$BASEDIR"/fdroid/repo

FairMailUrl=$(curl -s https://api.github.com/repos/M66B/FairEmail/releases/latest | grep browser_ | cut -d\" -f4)

echo "👉 FairMailUrl: $FairMailUrl"

parallel \
  --jobs 4 \
  --keep-order \
  --line-buffer \
  sh -c ::: \
  'curl -L "https://github.com/tlan16/revanced-build/releases/download/latest/vanced-microG.apk" -o fdroid/repo/vanced-microG.apk' \
  'curl -L "https://github.com/tlan16/revanced-build/releases/download/latest/revanced-nonroot.apk" -o fdroid/repo/revanced-nonroot.apk' \
  "curl -L $FairMailUrl -o fdroid/repo/Failmail.apk"

sleep 0.1 # Sleep to allow parallel to finish
echo "🎉 Downloaded APKs:"
ls -lh "$BASEDIR"/fdroid/repo/*.apk
