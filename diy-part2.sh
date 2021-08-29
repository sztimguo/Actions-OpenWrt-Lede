#!/bin/bash

# echo '修改默认LAN口IP'
# sed -i 's/192.168.1.1/192.168.1.2/g' package/base-files/files/bin/config_generate
# 修改IP项的EOF于EOF之间请不要插入其他扩展代码，可以删除或注释里面原本的代码
cat >$NETIP <<-EOF
uci set network.lan.ipaddr='192.168.1.2'                                    # IPv4 地址(openwrt后台地址)
uci set network.lan.netmask='255.255.255.0'                             # IPv4 子网掩码
uci set network.lan.gateway='192.168.1.1'                                 # IPv4 网关
uci set network.lan.broadcast='192.168.1.255'                           # IPv4 广播
uci set network.lan.dns='223.5.5.5 211.136.150.66'                    # DNS(多个DNS要用空格分开)
uci set network.lan.delegate='0'                                                 # 去掉LAN口使用内置的 IPv6 管理
uci commit network                                                                    # 不要删除跟注释,除非上面全部删除或注释掉了
uci set dhcp.lan.ignore='1'                                                          # 关闭DHCP功能
uci commit dhcp                                                                          # 跟‘关闭DHCP功能’联动,同时启用或者删除跟注释
uci set system.@system[0].hostname='OpenWrt-123'               # 修改主机名称为OpenWrt-123
EOF

# 选择argon为默认主题
sed -i 's/luci-theme-bootstrap/luci-theme-argon/g' feeds/luci/collections/luci/Makefile

# 设置密码为空
sed -i '/CYXluq4wUazHjmCDBCqXF/d' $ZZZ



pushd package/lean

# Add luci-app-ssr-plus
git clone --depth=1 https://github.com/fw876/helloworld
cat > helloworld/luci-app-ssr-plus/root/etc/ssrplus/black.list << EOF
github.com
openwrt.org
google.com
youtube.com
services.googleapis.cn
googleapis.cn
heroku.com
githubusercontent.com 
EOF
cat > helloworld/luci-app-ssr-plus/root/etc/ssrplus/white.list << EOF
apple.com
microsoft.com
dyndns.com
douyucdn.cn
douyucdn2.cn
youku.com
qq.com
iqiyi.com
bilibili.com
baidu.com
weibo.com
jd.com
taobao.com
tmall.com
iqiyi.com
55188.com
ifeng.com
taoguba.com.cn
xuangubao.com
cls.cn
10jqka.com.cn
eastmoney.com
jrj.com.cn
p5w.net
stcn.com
zqrb.cn
hexun.com
guziyuan.cn
xueqiu.com
zhihu.com
jin10.com
qcc.com
right.com.cn
koolshare.cn
znds.com
EOF

popd



# Clone community packages to package/community
mkdir package/community
pushd package/community

# Add luci-app-diskman
git clone --depth=1 https://github.com/lisaac/luci-app-diskman
mkdir parted
cp luci-app-diskman/Parted.Makefile parted/Makefile

# Add luci-app-serverchan
git clone --depth=1 https://github.com/tty228/luci-app-serverchan

# Add luci-app-onliner (need luci-app-nlbwmon)
git clone --depth=1 https://github.com/rufengsuixing/luci-app-onliner

# Add luci-theme-argon
git clone --depth=1 -b 18.06 https://github.com/jerrykuku/luci-theme-argon
rm -rf ../lean/luci-theme-argon

git clone --depth=1 https://github.com/kenzok8/openwrt-packages
rm -rf ./openwrt-packages/luci-app-jd-dailybonus
rm -rf ./openwrt-packages/luci-app-serverchan
rm -rf ./openwrt-packages/luci-app-ssr-plus
rm -rf ./openwrt-packages/luci-theme-argon_new
rm -rf ./openwrt-packages/naiveproxy
rm -rf ./openwrt-packages/tcping

git clone --depth=1 https://github.com/kenzok8/small
rm -rf ./small/shadowsocks-rust
rm -rf ./small/shadowsocksr-libev
rm -rf ./small/v2ray-core
rm -rf ./small/v2ray-plugin
rm -rf ./small/xray-core
rm -rf ./small/xray-plugin

#svn co https://github.com/roacn/Actions-OpenWrt-Lede/trunk/root/usr/share/passwall/rules rules
#cp -r rules/* luci-app-passwall/root/usr/share/passwall/rules
cp -r rules/direct_ip luci-app-passwall/root/usr/share/passwall/rules/direct_ip
cp -r rules/direct_host luci-app-passwall/root/usr/share/passwall/rules/direct_host
cp -r rules/proxy_host luci-app-passwall/root/usr/share/passwall/rules/proxy_host

popd



# Add luci-app-dockerman
# git clone --depth=1 https://github.com/lisaac/luci-lib-docker
# git clone --depth=1 https://github.com/lisaac/luci-app-dockerman
svn co https://github.com/lisaac/luci-app-dockerman/trunk/applications/luci-app-dockerman package/luci-app-dockerman
svn co https://github.com/lisaac/luci-lib-docker/trunk/collections/luci-lib-docker package/luci-lib-docker
if [ -e feeds/packages/utils/docker-ce ];then
sed -i '/dockerd/d' package/luci-app-dockerman/Makefile
sed -i 's/+docker/+docker-ce/g' package/luci-app-dockerman/Makefile
fi
