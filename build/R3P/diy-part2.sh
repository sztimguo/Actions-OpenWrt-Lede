#!/bin/bash

# echo '修改默认LAN口IP'
# sed -i 's/192.168.1.1/192.168.1.5/g' package/base-files/files/bin/config_generate

echo "修改默认LAN口IP，及相应的局域网设置，详细见diy-part1.sh设置"
sed -i "/exit 0/i\chmod +x /etc/webweb.sh && source /etc/webweb.sh" $ZZZ

# 设置密码为空
sed -i '/CYXluq4wUazHjmCDBCqXF/d' $ZZZ

# 选择argon为默认主题
# sed -i 's/luci-theme-bootstrap/luci-theme-argon/g' feeds/luci/collections/luci/Makefile

# 更换 opkg 源
# echo "sed -i 's#https://mirrors.cloud.tencent.com/lede/snapshots#https://xxxxxxxx#g' /etc/opkg/distfeeds.conf" >> package/lean/default-settings/files/zzz-default-settings

# echo '小米路由器Pro，修改Bdata分区可写，ssh永久开启专用，平时须保持read-only状态！！！'
# svn co https://github.com/roacn/Actions-OpenWrt-Lede/trunk/files/target/linux/ramips/dts dts
# cp -f dts/mt7621_xiaomi_mi-router-3-pro.dts target/linux/ramips/dts/mt7621_xiaomi_mi-router-3-pro.dts

if [ ! -d package/lean ];then
  mkdir -p package/lean
fi
pushd package/lean

# Add luci-app-diskman
#echo "Add luci-app-diskman"
#rm -rf ./luci-app-diskman
#svn co https://github.com/roacn/openwrt-packages/trunk/luci-app-diskman

# Add luci-app-onliner (need luci-app-nlbwmon)
#echo "Add luci-app-onliner (need luci-app-nlbwmon)"
#svn co https://github.com/roacn/openwrt-packages/trunk/luci-app-onliner/Makefile

#echo "Add luci-app-passwall"
#rm -rf ./luci-app-passwall
#svn co https://github.com/roacn/openwrt-packages/trunk/luci-app-passwall
#svn co https://github.com/roacn/openwrt-packages/trunk/brook
#svn co https://github.com/roacn/openwrt-packages/trunk/chinadns-ng
#svn co https://github.com/roacn/openwrt-packages/trunk/hysteria
#svn co https://github.com/roacn/openwrt-packages/trunk/kcptun
#svn co https://github.com/roacn/openwrt-packages/trunk/naiveproxy
#svn co https://github.com/roacn/openwrt-packages/trunk/pdnsd-alt
#svn co https://github.com/roacn/openwrt-packages/trunk/shadowsocks-rust
#svn co https://github.com/roacn/openwrt-packages/trunk/shadowsocksr-libev
#svn co https://github.com/roacn/openwrt-packages/trunk/simple-obfs
#svn co https://github.com/roacn/openwrt-packages/trunk/trojan-go
#svn co https://github.com/roacn/openwrt-packages/trunk/trojan-plus
#svn co https://github.com/roacn/openwrt-packages/trunk/trojan
#svn co https://github.com/roacn/openwrt-packages/trunk/v2ray-core
#svn co https://github.com/roacn/openwrt-packages/trunk/v2ray-geodata
#svn co https://github.com/roacn/openwrt-packages/trunk/v2ray-plugin
#svn co https://github.com/roacn/openwrt-packages/trunk/xray-plugin
#svn co https://github.com/roacn/openwrt-packages/trunk/xray-core

#echo "Passwall setup"
#svn co https://github.com/roacn/Actions-OpenWrt-Lede/trunk/files/usr/share/passwall/rules rules
#cp -r ./rules/* ./openwrt-packages/luci-app-passwall/root/usr/share/passwall/rules
#cp -r ./rules/direct_ip ./openwrt-packages/luci-app-passwall/root/usr/share/passwall/rules/direct_ip
#cp -r ./rules/direct_host ./openwrt-packages/luci-app-passwall/root/usr/share/passwall/rules/direct_host
#cp -r ./rules/proxy_host ./openwrt-packages/luci-app-passwall/root/usr/share/passwall/rules/proxy_host

echo "Add luci-app-turboacc"
svn co  https://github.com/coolsnowwolf/lede/trunk/package/lean/luci-app-turboacc
svn co  https://github.com/coolsnowwolf/lede/trunk/package/lean/pdnsd-alt
svn co  https://github.com/coolsnowwolf/lede/trunk/package/lean/dnsforwarder
svn co  https://github.com/coolsnowwolf/lede/trunk/package/lean/shortcut-fe

# 以下为添加主题部分
# Add luci-theme-argon
#echo "Add luci-theme-argon"
#rm -rf ./luci-theme-argon
#git clone --depth=1 -b master https://github.com/jerrykuku/luci-theme-argon

# Add luci-theme-argonne
#echo "Add luci-theme-argonne"
#svn co https://github.com/kenzok8/openwrt-packages/trunk/luci-theme-argonne

# Add luci-app-argonne-config
#echo "Add luci-app-argonne-config"
#svn co https://github.com/kenzok8/openwrt-packages/trunk/luci-app-argonne-config

popd

echo "diy-part2.sh已执行完毕！"
