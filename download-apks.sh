#!/usr/bin/env bash

# prerequisite
BASEDIR=$(realpath "$(dirname "$0")")
cd "$BASEDIR" || exit 1
echo "BASEDIR: $BASEDIR"
mkdir -p "$BASEDIR"/fdroid/repo

githubAuthArg=''
if [[ -n "$GITHUB_TOKEN" ]]; then
  githubAuthArg="-u tlan16:$GITHUB_TOKEN"
  echo "Using GitHub token for authentication"
fi

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
  # shellcheck disable=SC2086
  curl --fail --silent $githubAuthArg "$apiUrl" \
    | "$(getGrepBin)" browser_ \
    | cut -d\" -f4
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

BaiduPanUrl="http://pan.baidu.com./wap/jumpdownload"
echo "BaiduPanUrl: $BaiduPanUrl"

ChineseConsulateUrl="https://app-download-1301220764.cos.ap-beijing.myqcloud.com/com.gov.mfa.release.apk"
echo "ChineseConsulateUrl: $ChineseConsulateUrl"

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
  --retries 3 \
  --jobs 8 \
  -k --lb \
  sh -c ::: \
  "curl $githubAuthArg --fail --silent --location \"$FacebookURL\" --output fdroid/repo/Facebook.apk" \
  "curl $githubAuthArg --fail --silent --location \"$YtMusicURL\" --output fdroid/repo/YtMusic.apk" \
  "curl $githubAuthArg --fail --silent --location \"$RedditURL\" --output fdroid/repo/Reddit.apk" \
  "curl $githubAuthArg --fail --silent --location \"$VscoURL\" --output fdroid/repo/Vsco.apk" \
  "curl $githubAuthArg --fail --silent --location \"$YoutubeURL\" --output fdroid/repo/Youtube.apk" \
  "curl $githubAuthArg --fail --silent --location \"$FairMailUrl\" --output fdroid/repo/Fair_Mail.apk" \
  "curl $githubAuthArg --fail --silent --location \"$AnyWebViewUrl\" --output fdroid/repo/Any_Web_View.apk" \
  "curl $githubAuthArg --fail --silent --location \"$AppSettingsRebornUrl\" --output fdroid/repo/App_Settings_Reborn.apk" \
  "curl $githubAuthArg --fail --silent --location \"$PixelifyGooglePhotosUrl\" --output fdroid/repo/Pixelify_Google_Photos.apk" \
  "curl $githubAuthArg --fail --silent --location \"$WechatXUrl\" --output fdroid/repo/WechatX.apk" \
  "curl $githubAuthArg --fail --silent --location \"$XposedSmsCodeUrl\" --output fdroid/repo/Xposed_SMS_Code.apk" \
  "curl $githubAuthArg --fail --silent --location \"$BiliRoamingUrl\" --output fdroid/repo/Bili_Roaming.apk" \
  "curl $githubAuthArg --fail --silent --location \"$ZhiLiaoUrl\" --output fdroid/repo/Zhi_Liao.apk" \
  "curl $githubAuthArg --fail --silent --location \"$BilibiliChinaUrl\" --output fdroid/repo/Bilibili_China.apk" \
  "curl $githubAuthArg --fail --silent --location \"$BaiduPanUrl\" --output fdroid/repo/BaiduPan.apk" \
  "curl $githubAuthArg --fail --silent --location \"$ChineseConsulateUrl\" --output fdroid/repo/Chinese_Consulate.apk" \
  "curl $githubAuthArg --fail --silent --location \"$DeepSleepUrl\" --output fdroid/repo/Deep_Sleep.apk" \
  "curl $githubAuthArg --fail --silent --location \"$AdGuardUrl\" --output fdroid/repo/AD_Guard.apk" \
  "curl $githubAuthArg --fail --silent --location \"$TWRPUrl\" --output fdroid/repo/TWRP.apk" \
  "curl $githubAuthArg --fail --silent --location \"$KnoxPatchUrl\" --output fdroid/repo/Knox_Patch.apk" \
  "curl $githubAuthArg --fail --silent --location \"$HideMyAppListUrl\" --output fdroid/repo/Hide_My_App_List.apk" \
  "curl $githubAuthArg --fail --silent --location \"$ForceDarkUrl\" --output fdroid/repo/Force_Dark.apk" \
  "curl $githubAuthArg --fail --silent --location \"$AndroidFakerUrl\" --output fdroid/repo/Android_Faker.apk" \
  "curl $githubAuthArg --fail --silent --location \"$SkvalexUrl\" --output fdroid/repo/Skvalex_Callrecorder.apk" \
  "curl $githubAuthArg --fail --silent --location \"$FanQieURL\" --output fdroid/repo/FanQie.apk" \
  "curl $githubAuthArg --fail --silent --location \"$FanQieXposedURL\" --output fdroid/repo/FanQieXposedURL.apk" \
  "curl $githubAuthArg --fail --silent --location \"$v2rayNGURL\" --output fdroid/repo/v2rayNG.apk" \
  "curl $githubAuthArg --fail --silent --location \"$NekoBoxURL\" --output fdroid/repo/NekoBox.apk" \
  "curl $githubAuthArg --fail --silent --location \"$DeltaURL\" --output fdroid/repo/Delta.apk"

# Report
sleep 0.1 # Sleep to allow parallel to finish
echo "Downloaded APKs:"
ls -lh "$BASEDIR"/fdroid/repo/*.apk
