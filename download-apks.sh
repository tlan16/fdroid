#!/usr/bin/env bash

# prerequisite
BASEDIR=$(realpath "$(dirname "$0")")
echo "BASEDIR: $BASEDIR"
mkdir -p "$BASEDIR"/fdroid/repo

getGrepBin() {
#  use ggrep if available
  if which ggrep >/dev/null 2>&1; then
    echo "ggrep"
  else
    echo "grep"
  fi
}

getReleaseUrl() {
  local owner repo apiUrl
  owner="$1"
  repo="$2"
  apiUrl="https://api.github.com/repos/$owner/$repo/releases/latest"
  curl -s "$apiUrl" | grep browser_ | cut -d\" -f4
}

getBromiteWebViewUrl() {
  local owner repo apiUrl
  apiUrl="https://api.github.com/repos/bromite/bromite/releases/latest"
  curl -s "$apiUrl" | "$(getGrepBin)" --only-matching --perl-regexp 'https:\/\/.+arm64_SystemWebView\.apk'
}

# Prepare URLs
VancedMicroGUrl="https://github.com/tlan16/revanced-build/releases/download/latest/vanced-microG.apk"
echo "VancedMicroGUrl: $VancedMicroGUrl"

RevancedNonRootUrl="https://github.com/tlan16/revanced-build/releases/download/latest/revanced-nonroot.apk"
echo "RevancedNonRootUrl: $RevancedNonRootUrl"

FairMailUrl=$(getReleaseUrl "M66B" "FairEmail")
echo "FairMailUrl: $FairMailUrl"

AnyWebViewUrl=$(getReleaseUrl "Xposed-Modules-Repo" "com.thinkdifferent.anywebview")
echo "AnyWebViewUrl: $AnyWebViewUrl"

AppSettingsRebornUrl=$(getReleaseUrl "Xposed-Modules-Repo" "ru.bluecat.android.xposed.mods.appsettings")
echo "AppSettingsRebornUrl: $AppSettingsRebornUrl"

PixelifyGooglePhotosUrl=$(getReleaseUrl "Xposed-Modules-Repo" "balti.xposed.pixelifygooglephotos")
echo "PixelifyGooglePhotosUrl: $PixelifyGooglePhotosUrl"

WechatXUrl=$(getReleaseUrl "Xposed-Modules-Repo" "com.fkzhang.wechatxposed")
echo "WechatXUrl: $WechatXUrl"

XposedSmsCodeUrl=$(getReleaseUrl "Xposed-Modules-Repo" "com.github.tianma8023.xposed.smscode")
echo "XposedSmsCodeUrl: $XposedSmsCodeUrl"

ZhiLiaoUrl=$(getReleaseUrl "Xposed-Modules-Repo" "com.shatyuka.zhiliao")
echo "ZhiLiaoUrl: $ZhiLiaoUrl"

BilibiliChinaUrl="https://dl.hdslb.com/mobile/latest/android64/iBiliPlayer-bili.apk"
echo "BilibiliChinaUrl: $BilibiliChinaUrl"

BaiduUrl="https://www.wandoujia.com/apps/39899/download/dot"
echo "BaiduUrl: $BaiduUrl"

BromiteWebViewUrl=$(getBromiteWebViewUrl)
echo "BromiteWebViewUrl: $BromiteWebViewUrl"

# Download
parallel \
  --jobs 8 \
  --keep-order \
  --line-buffer \
  sh -c ::: \
  "curl -L $VancedMicroGUrl -o fdroid/repo/Vanced_MicroG.apk" \
  "curl -L $RevancedNonRootUrl -o fdroid/repo/Revanced_Nonroot.apk" \
  "curl -L $FairMailUrl -o fdroid/repo/Fair_Mail.apk" \
  "curl -L $AnyWebViewUrl -o fdroid/repo/Any_Web_View.apk" \
  "curl -L $AppSettingsRebornUrl -o fdroid/repo/App_Settings_Reborn.apk" \
  "curl -L $PixelifyGooglePhotosUrl -o fdroid/repo/Pixelify_Google_Photos.apk" \
  "curl -L $WechatXUrl -o fdroid/repo/WechatX.apk" \
  "curl -L $XposedSmsCodeUrl -o fdroid/repo/Xposed_SMS_Code.apk" \
  "curl -L $ZhiLiaoUrl -o fdroid/repo/Zhi_Liao.apk" \
  "curl -L $BilibiliChinaUrl -o fdroid/repo/Bilibili_China.apk" \
  "curl -L $BaiduUrl -o fdroid/repo/Baidu.apk" \
  "curl -L $BromiteWebViewUrl -o fdroid/repo/Bromite_WebView.apk"

# Report
sleep 0.1 # Sleep to allow parallel to finish
echo "Downloaded APKs:"
ls -lh "$BASEDIR"/fdroid/repo/*.apk
