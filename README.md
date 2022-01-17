# OpenWrt 在线集成自动编译.
![license](https://img.shields.io/github/license/roacn/Actions-OpenWrt-Lede?color=ff69b4)
![N1_plus](https://github.com/roacn/Actions-OpenWrt-Lede/workflows/N1_Plus/badge.svg)
![N1_mini](https://github.com/roacn/Actions-OpenWrt-Lede/workflows/N1_Mini/badge.svg)
![R3P](https://github.com/roacn/Actions-OpenWrt-Lede/workflows/R3P-closed/badge.svg?)
![x86](https://github.com/roacn/Actions-OpenWrt-Lede/workflows/lede-x86-64/badge.svg?)
![code-size](https://img.shields.io/github/languages/code-size/roacn/Actions-OpenWrt-Lede?color=blueviolet)




[Read the details in my blog (in Chinese) | 中文教程](https://p3terx.com/archives/build-openwrt-with-github-actions.html)

## 使用教程:
X86 编译固件后台地址：192.168.1.2 密码:空

Phicomm N1 编译固件后台地址：192.168.1.2 密码:password

Xiaomi R3P 编译固件后台地址：192.168.1.5 密码:空


#### 源码来源：

[![Lean](https://img.shields.io/badge/package-Lean-blueviolet.svg?style=flat&logo=appveyor)](https://github.com/coolsnowwolf/lede) 
[![Lienol](https://img.shields.io/badge/passwall-openwrt-blueviolet.svg?style=flat&logo=appveyor)](https://github.com/xiaorouji/openwrt-passwall) 
[![esir](https://img.shields.io/badge/AutoBuild-esir-red.svg?style=flat&logo=appveyor)](https://github.com/esirplayground/AutoBuild-OpenWrt)
[![P3TERX](https://img.shields.io/badge/Actions-P3TERX-success.svg?style=flat&logo=appveyor)](https://github.com/P3TERX/Actions-OpenWrt)

##### 固件发布:

[![GitHub release (latest by date)](https://img.shields.io/github/v/release/roacn/Actions-OpenWrt-Lede?style=for-the-badge&label=下载&&color=00aa66)](https://github.com/roacn/Actions-OpenWrt-Lede/releases/latest)

##### 说明:
支持自动定制固件, 自动调整依赖及生成配置文件, 无需上传配置. 兼容 [coolsnowwolf/lede](https://github.com/coolsnowwolf/lede) 以及 OpenWrt trunk.

同时支持自动合并推送上游提交 (也就是自动更新), 直接把`build-openwrt.yml`放入`.github/workflows/`即可 (默认上游为 coolsnowwolf/lede, 高级玩家请自行改写).
