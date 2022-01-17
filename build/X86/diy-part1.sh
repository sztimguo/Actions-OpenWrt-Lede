#!/bin/bash
#
# Copyright (c) 2019-2020 P3TERX <https://github.com/hjp521/OpenWrt-mi3p>
#
# This is free software, licensed under the MIT License.
# See /LICENSE for more information.

# File name: diy-part1.sh
# Description: OpenWrt DIY script part 1 (Before Update feeds)

# Uncomment a feed source
# sed -i 's/^#\(.*helloworld\)/\1/' feeds.conf.default

# Add a feed source
# sed -i '$a src-git helloworld https://github.com/fw876/helloworld' feeds.conf.default
# sed -i '$a src-git kenzok https://github.com/kenzok8/openwrt-packages' feeds.conf.default
# sed -i '$a src-git small https://github.com/kenzok8/small' feeds.conf.default

# 修改IP项的EOF于EOF之间请不要插入其他扩展代码，可以删除或注释里面原本的代码
cat >$NETIP <<-EOF
uci set network.lan.ipaddr='192.168.1.5'                                    # IPv4 地址(openwrt后台地址)
uci set network.lan.netmask='255.255.255.0'                             # IPv4 子网掩码
uci set network.lan.gateway='192.168.1.1'                                 # IPv4 网关
uci set network.lan.broadcast='192.168.1.255'                           # IPv4 广播
uci set network.lan.dns='211.136.150.66 223.5.5.5'                    # DNS(多个DNS要用空格分开)
uci set network.lan.delegate='0'                                                 # 去掉LAN口使用内置的 IPv6 管理
uci commit network                                                                    # 不要删除跟注释,除非上面全部删除或注释掉了
uci set dhcp.lan.ignore='1'                                                          # 关闭DHCP功能
uci commit dhcp                                                                          # 跟‘关闭DHCP功能’联动,同时启用或者删除跟注释
uci set system.@system[0].hostname='OpenWrt-MI'               # 修改主机名称为OpenWrt-MI
EOF

cat >$WEBWEB <<-EOF
#!/bin/bash
[[ ! -f /mnt/network ]] && chmod +x /etc/networkip && source /etc/networkip
cp -Rf /etc/config/network /mnt/network
uci set argon.@global[0].bing_background=0
uci commit argon
rm -rf /etc/networkip
rm -rf /etc/webweb.sh
exit 0
EOF

echo "diy-part1.sh已执行完毕！"
