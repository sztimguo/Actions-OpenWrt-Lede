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
uci delete network.wan                                                               # 删除wan口
uci delete network.wan6                                                             # 删除wan6口
uci set network.lan=interface                                                     # lan口接口 
uci set network.lan.device='br-lan'                                            # lan口设备
uci set network.lan.type='bridge'                                               # lan口桥接
uci set network.lan.proto='static'                                               # lan口静态IP
uci set network.lan.ipaddr='192.168.1.5'                                    # IPv4 地址(openwrt后台地址)
uci set network.lan.netmask='255.255.255.0'                             # IPv4 子网掩码
uci set network.lan.gateway='192.168.1.1'                                 # IPv4 网关
uci set network.lan.broadcast='192.168.1.255'                           # IPv4 广播
uci set network.lan.dns='211.136.150.66 223.5.5.5'                    # DNS(多个DNS要用空格分开)
uci set network.lan.delegate='0'                                                 # 去掉LAN口使用内置的 IPv6 管理
uci set network.lan.ifname='lan1 lan2 lan3 wan'                        # 设置物理接口为lan1 lan2 lan3 wan
uci set network.lan.mtu='1492'                                                   # lan口mtu设置为1492
uci delete network.lan.ip6assign                                                 #接口→LAN→IPv6 分配长度——关闭，恢复uci set network.lan.ip6assign='64'
uci commit network
uci delete dhcp.lan.ra                                                                  # 路由通告服务，设置为“已禁用”
uci delete dhcp.lan.ra_management                                           # 路由通告服务，设置为“已禁用”
uci delete dhcp.lan.dhcpv6                                                         # DHCPv6 服务，设置为“已禁用”
uci set dhcp.lan.ignore='1'                                                          # 关闭DHCP功能
uci set dhcp.@dnsmasq[0].filter_aaaa='1'                                   # DHCP/DNS→高级设置→解析 IPv6 DNS 记录——禁止
uci set dhcp.@dnsmasq[0].cachesize='0'                                    # DHCP/DNS→高级设置→DNS 查询缓存的大小——设置为'0'
uci add dhcp domain
uci set dhcp.@domain[0].name='mi'                                           # 网络→主机名→主机目录——“mi”
uci set dhcp.@domain[0].ip='192.168.1.5'                                  # 对应IP解析——192.168.1.5
uci add dhcp domain
uci set dhcp.@domain[1].name='cdn.jsdelivr.net'                       # 网络→主机名→主机目录——“cdn.jsdelivr.net”
uci set dhcp.@domain[1].ip='104.16.86.20'                                 # 对应IP解析——'104.16.86.20'
uci commit dhcp
uci delete firewall.@defaults[0].syn_flood                                 # 防火墙→SYN-flood 防御——关闭；默认开启
uci set firewall.@defaults[0].fullcone='1'                                     # 防火墙→FullCone-NAT——启用；默认关闭
uci commit firewall
uci set dropbear.@dropbear[0].Port='8822'                                # SSH端口设置为'8822'
uci commit dropbear
uci set system.@system[0].hostname='MI'                                 # 修改主机名称为MI
sed -i 's/\/bin\/login/\/bin\/login -f root/' /etc/config/ttyd       # 设置ttyd免帐号登录，如若开启，进入OPENWRT后可能要重启一次才生效
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
