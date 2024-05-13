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
  curl --silent "$apiUrl" | "$(getGrepBin)" browser_ | cut -d\" -f4
}

# Prepare URLs
FacebookURL=$(getReleaseUrl "revanced-apks" "build-apps" | "$(getGrepBin)" --perl-regexp "facebook-revanced-.+-all.apk")
echo "FacebookURL: $FacebookURL"

YtMusicURL=$(getReleaseUrl "revanced-apks" "build-apps" | "$(getGrepBin)" --perl-regexp "music-anddea-.+-arm64-v8a.apk")
echo "YtMusicURL: $YtMusicURL"

RedditURL=$(getReleaseUrl "revanced-apks" "build-apps" | "$(getGrepBin)" --perl-regexp "\/reddit-revanced-.+-all.apk")
echo "RedditURL: $RedditURL"

VscoURL=$(getReleaseUrl "revanced-apks" "build-apps" | "$(getGrepBin)" --perl-regexp "vsco-revanced-.+-arm64-v8a.apk")
echo "VscoURL: $VscoURL"

YoutubeURL=$(getReleaseUrl "revanced-apks" "build-apps" | "$(getGrepBin)" --perl-regexp "youtube-anddea-.+-all.apk")
echo "YoutubeURL: $YoutubeURL"

NekoBoxURL=$(getReleaseUrl "MatsuriDayo" "NekoBoxForAndroid" | "$(getGrepBin)" --perl-regexp "arm64-v8a\.apk$")
echo "NekoBoxURL: $NekoBoxURL"

DeltaURL=$(getReleaseUrl "Delta-Icons" "android" | "$(getGrepBin)" --perl-regexp "\d+.apk$")
echo "DeltaURL: $DeltaURL"

v2rayNGURL=$(getReleaseUrl "2dust" "v2rayNG" | "$(getGrepBin)" --perl-regexp "v2rayNG_\d+\.\d+\.\d+\.apk$")
echo "v2rayNGURL: $v2rayNGURL"

FanQieURL=$(getReleaseUrl "Xposed-Modules-Repo" "com.hx.fanqie" | "$(getGrepBin)" --perl-regexp "fanqie-.+\.apk$")
echo "FanQieURL: $FanQieURL"
FanQieXposedURL=$(getReleaseUrl "Xposed-Modules-Repo" "com.hx.fanqie" | "$(getGrepBin)" --perl-regexp "fanqie_xposed.+\.apk$")
echo "FanQieXposedURL: $FanQieXposedURL"

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

BilibiliChinaUrl="https://dl.hdslb.com/mobile/latest/android64/iBiliPlayer-bili.apk"
echo "BilibiliChinaUrl: $BilibiliChinaUrl"

BaiduUrl="$(curl --silent "https://mo.baidu.com/txl/" | "$(getGrepBin)" --only-matching --extended-regexp "https:\\\/\\\/downpack\.baidu\.com\\\/baidusearch_AndroidPhone_.+.apk")"
echo "BaiduUrl: $BaiduUrl"

BaiduPanUrl="http://pan.baidu.com./wap/jumpdownload"
echo "BaiduPanUrl: $BaiduPanUrl"

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
  "curl --silent --location \"$FacebookURL\" --output fdroid/repo/Facebook.apk" \
  "curl --silent --location \"$YtMusicURL\" --output fdroid/repo/YtMusic.apk" \
  "curl --silent --location \"$RedditURL\" --output fdroid/repo/Reddit.apk" \
  "curl --silent --location \"$VscoURL\" --output fdroid/repo/Vsco.apk" \
  "curl --silent --location \"$YoutubeURL\" --output fdroid/repo/Youtube.apk" \
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
  "curl --silent --location \"$BaiduPanUrl\" --output fdroid/repo/BaiduPan.apk" \
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
  "curl --silent --location \"$FanQieXposedURL\" --output fdroid/repo/FanQieXposedURL.apk" \
  "curl --silent --location \"$v2rayNGURL\" --output fdroid/repo/v2rayNG.apk" \
  "curl --silent --location \"$NekoBoxURL\" --output fdroid/repo/NekoBox.apk" \
  "curl --silent --location \"$DeltaURL\" --output fdroid/repo/Delta.apk"

# Report
sleep 0.1 # Sleep to allow parallel to finish
echo "Downloaded APKs:"
ls -lh "$BASEDIR"/fdroid/repo/*.apk
