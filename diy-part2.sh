#!/bin/bash

# echo '修改默认LAN口IP'
# sed -i 's/192.168.1.1/192.168.1.2/g' package/base-files/files/bin/config_generate

# 选择argon为默认主题
sed -i 's/luci-theme-bootstrap/luci-theme-argon/g' feeds/luci/collections/luci/Makefile


# Clone community packages to package/community
mkdir package/community
pushd package/community

# Add luci-app-diskman
echo "Add luci-app-diskman"
git clone --depth=1 https://github.com/lisaac/luci-app-diskman
mkdir parted
cp luci-app-diskman/Parted.Makefile parted/Makefile

# Add luci-app-onliner (need luci-app-nlbwmon)
echo "Add luci-app-onliner (need luci-app-nlbwmon)"
git clone --depth=1 https://github.com/rufengsuixing/luci-app-onliner

# Add luci-app-serverchan
echo "Add luci-app-serverchan"
git clone --depth=1 https://github.com/tty228/luci-app-serverchan

#add apps
echo "Clone kenzok8/openwrt-packages"
git clone --depth=1 https://github.com/kenzok8/openwrt-packages
rm -rf ./openwrt-packages/luci-app-jd-dailybonus
rm -rf ./openwrt-packages/luci-app-serverchan
rm -rf ./openwrt-packages/luci-app-ssr-plus
rm -rf ./openwrt-packages/luci-theme-argon_new
rm -rf ./openwrt-packages/naiveproxy
rm -rf ./openwrt-packages/tcping

echo "Clone  kenzok8/small"
git clone --depth=1 https://github.com/kenzok8/small
rm -rf ./small/shadowsocks-rust
rm -rf ./small/shadowsocksr-libev
rm -rf ./small/v2ray-core
rm -rf ./small/v2ray-plugin
rm -rf ./small/xray-core
rm -rf ./small/xray-plugin

#passwall setup
echo "Passwall setup"
svn co https://github.com/roacn/Actions-OpenWrt-Lede/trunk/files/root/usr/share/passwall/rules rules
cp -r ./rules/* ./openwrt-packages/luci-app-passwall/root/usr/share/passwall/rules
#cp -r ./rules/direct_ip ./openwrt-packages/luci-app-passwall/root/usr/share/passwall/rules/direct_ip
#cp -r ./rules/direct_host ./openwrt-packages/luci-app-passwall/root/usr/share/passwall/rules/direct_host
#cp -r ./rules/proxy_host ./openwrt-packages/luci-app-passwall/root/usr/share/passwall/rules/proxy_host

# Add luci-app-ssr-plus
echo "Add  luci-app-ssr-plus"
git clone --depth=1 https://github.com/fw876/helloworld
svn co https://github.com/roacn/Actions-OpenWrt-Lede/trunk/files/root/etc/ssrplus ssrplus
cp -r ./ssrplus/* ./helloworld/luci-app-ssr-plus/root/etc/ssrplus

# Add luci-theme-argon
echo "Add luci-theme-argon"
git clone --depth=1 -b 18.06 https://github.com/jerrykuku/luci-theme-argon
rm -rf ../lean/luci-theme-argon

#add new theme jj
echo "Add new theme jj"
git clone --depth=1 https://github.com/netitgo/luci-theme-jj.git

popd



# Add luci-app-dockerman and setup
echo "Add luci-app-dockerman and setup"
svn co https://github.com/lisaac/luci-app-dockerman/trunk/applications/luci-app-dockerman package/luci-app-dockerman
svn co https://github.com/lisaac/luci-lib-docker/trunk/collections/luci-lib-docker package/luci-lib-docker
if [ -e feeds/packages/utils/docker-ce ];then
sed -i '/dockerd/d' package/luci-app-dockerman/Makefile
sed -i 's/+docker/+docker-ce/g' package/luci-app-dockerman/Makefile
fi
