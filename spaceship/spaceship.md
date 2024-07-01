# spaceship

安装 fastlane
gem install fastlane --user-instal

## 操作类型

portal
处理苹果开发者中心的一些操作，操作证书、设备、描述文件等需要用此套api
test_flight
操作app的testflight
tunes
处理appstoreconnect的一些操作，此代码为老版的操作方式，包含api比较全。部分操作可使用 connect_api 采用苹果官方开发的api

## 登录

tunes登录
tunes = Spaceship::Tunes.login('AppID', 'password')

portal登录
portal = Spaceship::Portal.login('AppID', 'password');

## App Store Connect API

不通过Xcode
export SPACESHIP_AVOID_XCODE_API=false
