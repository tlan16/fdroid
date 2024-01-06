#!/usr/bin/env bash

# prerequisite
BASEDIR=$(realpath "$(dirname "$0")")
cd "$BASEDIR" || exit 1
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
FanQieURL=$(getReleaseUrl "Xposed-Modules-Repo" "com.hx.fanqie" | "$(getGrepBin)" --perl-regexp "fanqie-.+\.apk$")
echo "FanQieURL: $FanQieURL"
FanQieXposedURL=$(getReleaseUrl "Xposed-Modules-Repo" "com.hx.fanqie" | "$(getGrepBin)" --perl-regexp "fanqie_xposed.+\.apk$")
echo "FanQieXposedURL: $FanQieXposedURL"

YoutubeURL=$(getReleaseUrl "tlan16" "revanced-magisk-module" | "$(getGrepBin)" --perl-regexp "youtube-revanced-.+\.apk$")
echo "YoutubeURL: $YoutubeURL"

YoutubeMusicURL=$(getReleaseUrl "tlan16" "revanced-magisk-module" | "$(getGrepBin)" --perl-regexp "music-revanced-.+v8a\.apk$")
echo "YoutubeMusicURL: $YoutubeMusicURL"

MicroGURL=$(getReleaseUrl "TeamVanced" "VancedMicroG")
echo "MicroGURL: $MicroGURL"

FairMailUrl=$(getReleaseUrl "M66B" "FairEmail")
echo "FairMailUrl: $FairMailUrl"

AnyWebViewUrl=$(getReleaseUrl "Xposed-Modules-Repo" "com.thinkdifferent.anywebview")
echo "AnyWebViewUrl: $AnyWebViewUrl"

AppSettingsRebornUrl=$(getReleaseUrl "Xposed-Modules-Repo" "ru.bluecat.android.xposed.mods.appsettings")
echo "AppSettingsRebornUrl: $AppSettingsRebornUrl"

PixelifyGooglePhotosUrl=$(getReleaseUrl "Xposed-Modules-Repo" "balti.xposed.pixelifygooglephotos")
echo "PixelifyGooglePhotosUrl: $PixelifyGooglePhotosUrl"

WechatUrl="https://www.wandoujia.com/apps/596157/download/dot"
echo "WechatUrl: $WechatUrl"

WechatXUrl=$(getReleaseUrl "Xposed-Modules-Repo" "com.fkzhang.wechatxposed")
echo "WechatXUrl: $WechatXUrl"

KnoxPatchUrl=$(getReleaseUrl "Xposed-Modules-Repo" "io.mesalabs.knoxpatch" | "$(getGrepBin)" --perl-regexp "\.[0-9]\.apk$")
echo "KnoxPatchUrl: $KnoxPatchUrl"

HideMyAppListUrl=$(getReleaseUrl "Xposed-Modules-Repo" "com.tsng.hidemyapplist")
echo "HideMyAppListUrl: $HideMyAppListUrl"

ForceDarkUrl=$(getReleaseUrl "Xposed-Modules-Repo" "moe.henry_zhr.force_dark")
echo "ForceDarkUrl: $ForceDarkUrl"

XposedSmsCodeUrl=$(getReleaseUrl "Xposed-Modules-Repo" "com.github.tianma8023.xposed.smscode")
echo "XposedSmsCodeUrl: $XposedSmsCodeUrl"

BiliRoamingUrl=$(getReleaseUrl "Xposed-Modules-Repo" "me.iacn.biliroaming")
echo "BiliRoamingUrl: $BiliRoamingUrl"

ZhiLiaoUrl=$(getReleaseUrl "Xposed-Modules-Repo" "com.shatyuka.zhiliao")
echo "ZhiLiaoUrl: $ZhiLiaoUrl"

BilibiliChinaUrl="https://dl.hdslb.com/mobile/latest/iBiliPlayer-html5_app_bili.apk"
echo "BilibiliChinaUrl: $BilibiliChinaUrl"

BaiduUrl="https://www.wandoujia.com/apps/39899/download/dot"
echo "BaiduUrl: $BaiduUrl"

BaiduPanUrl="https://www.wandoujia.com/apps/280851/download/dot"
echo "BaiduPanUrl: $BaiduPanUrl"

BromiteWebViewUrl=$(getBromiteWebViewUrl)
echo "BromiteWebViewUrl: $BromiteWebViewUrl"

ChineseConsulateUrl="https://app-download-1301220764.cos.ap-beijing.myqcloud.com/com.gov.mfa.release.apk"
echo "ChineseConsulateUrl: $ChineseConsulateUrl"

ALHZDocId="$(curl --silent https://alhs.live/ | "$(getGrepBin)" --perl-regexp --only-matching '(?<=<script>var info=).+(?=;var)' | jq '.link | map(select(.name | contains("APP"))) | first | .target' | "$(getGrepBin)" --perl-regexp --only-matching '(?<=file\/)[^"]+')"
ALHZUrl="https://docs.zohopublic.com.cn/downloaddocument.do?docId=$ALHZDocId&docExtn=apk"
echo "艾利浩斯Url: $ALHZUrl"

DeepSleepUrl=$(getReleaseUrl "Jasper-1024" "DeepSleep")
echo "DeepSleepUrl: $DeepSleepUrl"

AndroidFakerUrl=$(getReleaseUrl "Android1500" "AndroidFaker")
echo "AndroidFakerUrl: $AndroidFakerUrl"

AdGuardUrl="https://download.adguard.com/d/18672/adguard.apk"
echo "AdGuardUrl: $AdGuardUrl"

TWRPUrl="https://eu.dl.twrp.me/twrpapp/me.twrp.twrpapp-26.apk"
echo "TWRPUrl: $TWRPUrl"

SkvalexUrl=$(getReleaseUrl "skvalex" "callrecorder")
echo "SkvalexUrl: $SkvalexUrl"

# Download
echo "Downloading APKs..."
parallel \
  --jobs 8 \
  --keep-order \
  --line-buffer \
  sh -c ::: \
  "curl --silent --location \"$YoutubeURL\" --output fdroid/repo/Youtube_Revanced.apk" \
  "curl --silent --location \"$YoutubeMusicURL\" --output fdroid/repo/YT_Music_Revanced.apk" \
  "curl --silent --location \"$MicroGURL\" --output fdroid/repo/migrog.apk" \
  "curl --silent --location \"$FairMailUrl\" --output fdroid/repo/Fair_Mail.apk" \
  "curl --silent --location \"$AnyWebViewUrl\" --output fdroid/repo/Any_Web_View.apk" \
  "curl --silent --location \"$AppSettingsRebornUrl\" --output fdroid/repo/App_Settings_Reborn.apk" \
  "curl --silent --location \"$PixelifyGooglePhotosUrl\" --output fdroid/repo/Pixelify_Google_Photos.apk" \
  "curl --silent --location \"$WechatUrl\" --output fdroid/repo/Wechat.apk" \
  "curl --silent --location \"$WechatXUrl\" --output fdroid/repo/WechatX.apk" \
  "curl --silent --location \"$XposedSmsCodeUrl\" --output fdroid/repo/Xposed_SMS_Code.apk" \
  "curl --silent --location \"$BiliRoamingUrl\" --output fdroid/repo/Bili_Roaming.apk" \
  "curl --silent --location \"$ZhiLiaoUrl\" --output fdroid/repo/Zhi_Liao.apk" \
  "curl --silent --location \"$BilibiliChinaUrl\" --output fdroid/repo/Bilibili_China.apk" \
  "curl --silent --location \"$BaiduUrl\" --output fdroid/repo/Baidu.apk" \
  "curl --silent --location \"$BaiduPanUrl\" --output fdroid/repo/BaiduPan.apk" \
  "curl --silent --location \"$BromiteWebViewUrl\" --output fdroid/repo/Bromite_WebView.apk" \
  "curl --silent --location \"$ChineseConsulateUrl\" --output fdroid/repo/Chinese_Consulate.apk" \
  "curl --silent --location \"$ALHZUrl\" --output fdroid/repo/alhz.apk" \
  "curl --silent --location \"$DeepSleepUrl\" --output fdroid/repo/Deep_Sleep.apk" \
  "curl --silent --location \"$AdGuardUrl\" --output fdroid/repo/AD_Guard.apk" \
  "curl --silent --location \"$TWRPUrl\" --output fdroid/repo/TWRP.apk" \
  "curl --silent --location \"$KnoxPatchUrl\" --output fdroid/repo/Knox_Patch.apk" \
  "curl --silent --location \"$HideMyAppListUrl\" --output fdroid/repo/Hide_My_App_List.apk" \
  "curl --silent --location \"$ForceDarkUrl\" --output fdroid/repo/Force_Dark.apk" \
  "curl --silent --location \"$AndroidFakerUrl\" --output fdroid/repo/Android_Faker.apk" \
  "curl --silent --location \"$SkvalexUrl\" --output fdroid/repo/Skvalex_Callrecorder.apk" \
  "curl --silent --location \"$FanQieURL\" --output fdroid/repo/FanQie.apk" \
  "curl --silent --location \"$FanQieXposedURL\" --output fdroid/repo/FanQieXposedURL.apk"


# Unzip archives
./parts/revolute/extract.sh
cp "$BASEDIR"/parts/revolute/revolut-7-30-3.apk "$BASEDIR"/fdroid/repo/Revolut.apk

# Report
sleep 0.1 # Sleep to allow parallel to finish
echo "Downloaded APKs:"
ls -lh "$BASEDIR"/fdroid/repo/*.apk
