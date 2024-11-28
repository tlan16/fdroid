#!/usr/bin/env bash
set -eo pipefail
#set -x

if [ -z "${CI:-}" ] && [ -f '.env' ]; then
  source .env
fi

# Use gnu utils if available
if [ -d "/opt/homebrew/opt/grep/libexec/gnubin" ]; then
  PATH="/opt/homebrew/opt/grep/libexec/gnubin:$PATH"
fi

getReleaseUrls() {
  local owner repo apiUrl githubAuthArg regex result
  if [[ -n "$GITHUB_TOKEN" ]]; then
    githubAuthArg="-u tlan16:$GITHUB_TOKEN"
  fi

  owner="$1"
  repo="$2"
  regex="$(echo "$3" | xargs)"
  apiUrl="https://api.github.com/repos/$owner/$repo/releases/latest"
  # shellcheck disable=SC2086
  result="$(curl --fail --silent $githubAuthArg "$apiUrl")"
  result="$(echo "$result" | grep browser_)"
  result="$(echo "$result" | cut -d\" -f4)"
  if [[ -n "$regex" ]]; then
    result="$(echo "$result" | grep --perl-regexp "$regex")"
  fi
  echo "$result" | head -n 1
}

echo '' > urls.txt

url=$(getReleaseUrls "AdguardTeam" "AdguardForAndroid" 'https://.+adguard-[0-9]\.[0-9]\.[0-9]-(hotfix|release).apk')
echo "url: $url"
echo "$url" >> urls.txt

# https://github.com/FiorenMas/Revanced-And-Revanced-Extended-Non-Root/releases/download/all/youtube-beta-arm64-v8a-anddea.apk
url=$(getReleaseUrls "FiorenMas" "Revanced-And-Revanced-Extended-Non-Root" 'youtube-beta-arm64-v8a-anddea\.apk')
echo "url: $url"
echo "$url" >> urls.txt

# https://github.com/FiorenMas/Revanced-And-Revanced-Extended-Non-Root/releases/download/all/youtube-music-beta-arm64-v8a-anddea.apk
url=$(getReleaseUrls "FiorenMas" "Revanced-And-Revanced-Extended-Non-Root" 'youtube-music-beta-arm64-v8a.+\.apk')
echo "url: $url"
echo "$url" >> urls.txt

# https://github.com/FiorenMas/Revanced-And-Revanced-Extended-Non-Root/releases/download/all/twitter-beta-piko.apk
url=$(getReleaseUrls "FiorenMas" "Revanced-And-Revanced-Extended-Non-Root" 'twitter-beta-piko\.apk')
echo "url: $url"
echo "$url" >> urls.txt

# https://github.com/FiorenMas/Revanced-And-Revanced-Extended-Non-Root/releases/download/all/reddit-revanced-extended.apk
url=$(getReleaseUrls "FiorenMas" "Revanced-And-Revanced-Extended-Non-Root" 'reddit-revanced-extended\.apk')
echo "url: $url"
echo "$url" >> urls.txt

# https://github.com/FiorenMas/Revanced-And-Revanced-Extended-Non-Root/releases/download/all/bilibili-BiliRoamingM.apk
url=$(getReleaseUrls "FiorenMas" "Revanced-And-Revanced-Extended-Non-Root" 'bilibili-BiliRoamingM\.apk')
echo "url: $url"
echo "$url" >> urls.txt

# https://github.com/FiorenMas/Revanced-And-Revanced-Extended-Non-Root/releases/download/all/fx-file-explorer-indrastorms.apk
url=$(getReleaseUrls "FiorenMas" "Revanced-And-Revanced-Extended-Non-Root" 'fx-file-explorer-indrastorms\.apk')
echo "url: $url"
echo "$url" >> urls.txt

url=$(getReleaseUrls "AdguardTeam" "AdguardForAndroid" 'adguard-.+-release\.apk')
echo "url: $url"
echo "$url" >> urls.txt

url=$(getReleaseUrls "vvb2060" "KeyAttestation" 'KeyAttestation-.+\.apk')
echo "url: $url"
echo "$url" >> urls.txt

url=$(getReleaseUrls "AkaneTan" "Checker")
echo "url: $url"
echo "$url" >> urls.txt

url="https://github.com/rushiranpise/detection/raw/main/Hunter_5.5.0.apk"
echo "url: $url"
echo "$url" >> urls.txt

url="https://github.com/rushiranpise/detection/raw/main/MemoryDetector_2.1.0.apk"
echo "url: $url"
echo "$url" >> urls.txt

url=$(getReleaseUrls "RabehX" "Securify")
echo "url: $url"
echo "$url" >> urls.txt

cat urls.txt

rm -f ./fdroid/*.apk || true
aria2c -i urls.txt -d ./fdroid/repo -j 10 -x 10
