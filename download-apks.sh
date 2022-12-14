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
  curl --silent "$apiUrl" | grep browser_ | cut -d\" -f4
}

getBromiteWebViewUrl() {
  local owner repo apiUrl
  apiUrl="https://api.github.com/repos/bromite/bromite/releases/latest"
  curl --silent "$apiUrl" | "$(getGrepBin)" --only-matching --perl-regexp 'https:\/\/.+arm64_SystemWebView\.apk'
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

BiliRoamingUrl=$(getReleaseUrl "Xposed-Modules-Repo" "me.iacn.biliroaming")
echo "BiliRoamingUrl: $BiliRoamingUrl"

ZhiLiaoUrl=$(getReleaseUrl "Xposed-Modules-Repo" "com.shatyuka.zhiliao")
echo "ZhiLiaoUrl: $ZhiLiaoUrl"

BilibiliChinaUrl="https://dl.hdslb.com/mobile/latest/android64/iBiliPlayer-bili.apk"
echo "BilibiliChinaUrl: $BilibiliChinaUrl"

BaiduUrl="https://www.wandoujia.com/apps/39899/download/dot"
echo "BaiduUrl: $BaiduUrl"

BromiteWebViewUrl=$(getBromiteWebViewUrl)
echo "BromiteWebViewUrl: $BromiteWebViewUrl"

ChineseConsulateUrl="https://app-download-1301220764.cos.ap-beijing.myqcloud.com/com.gov.mfa.release.apk"
echo "ChineseConsulateUrl: $ChineseConsulateUrl"

ALHZDocId="$(curl --silent https://alhs.live/ | "$(getGrepBin)" --perl-regexp --only-matching '(?<=<script>var info=).+(?=;var)' | jq '.link | map(select(.name | contains("APP"))) | first | .target' | "$(getGrepBin)" --perl-regexp --only-matching '(?<=file\/)[^"]+')"
ALHZUrl="https://docs.zohopublic.com.cn/downloaddocument.do?docId=$ALHZDocId&docExtn=apk"
echo "????????????Url: $ALHZUrl"

DeepSleepUrl=$(getReleaseUrl "Jasper-1024" "DeepSleep")
echo "DeepSleepUrl: $DeepSleepUrl"

# Download
echo "Downloading APKs..."
parallel \
  --jobs 8 \
  --keep-order \
  --line-buffer \
  sh -c ::: \
  "curl --silent --location \"$VancedMicroGUrl\" --output fdroid/repo/Vanced_MicroG.apk" \
  "curl --silent --location \"$RevancedNonRootUrl\" --output fdroid/repo/Revanced_Nonroot.apk" \
  "curl --silent --location \"$FairMailUrl\" --output fdroid/repo/Fair_Mail.apk" \
  "curl --silent --location \"$AnyWebViewUrl\" --output fdroid/repo/Any_Web_View.apk" \
  "curl --silent --location \"$AppSettingsRebornUrl\" --output fdroid/repo/App_Settings_Reborn.apk" \
  "curl --silent --location \"$PixelifyGooglePhotosUrl\" --output fdroid/repo/Pixelify_Google_Photos.apk" \
  "curl --silent --location \"$WechatXUrl\" --output fdroid/repo/WechatX.apk" \
  "curl --silent --location \"$XposedSmsCodeUrl\" --output fdroid/repo/Xposed_SMS_Code.apk" \
  "curl --silent --location \"$BiliRoamingUrl\" --output fdroid/repo/Bili_Roaming.apk" \
  "curl --silent --location \"$ZhiLiaoUrl\" --output fdroid/repo/Zhi_Liao.apk" \
  "curl --silent --location \"$BilibiliChinaUrl\" --output fdroid/repo/Bilibili_China.apk" \
  "curl --silent --location \"$BaiduUrl\" --output fdroid/repo/Baidu.apk" \
  "curl --silent --location \"$BromiteWebViewUrl\" --output fdroid/repo/Bromite_WebView.apk" \
  "curl --silent --location \"$ChineseConsulateUrl\" --output fdroid/repo/Chinese_Consulate.apk" \
  "curl --silent --location \"$ALHZUrl\" --output fdroid/repo/alhz.apk" \
  "curl --silent --location \"$DeepSleepUrl\" --output fdroid/repo/Deep_Sleep.apk"

# Report
sleep 0.1 # Sleep to allow parallel to finish
echo "Downloaded APKs:"
ls -lh "$BASEDIR"/fdroid/repo/*.apk
