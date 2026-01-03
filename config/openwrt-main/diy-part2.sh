#!/bin/bash
set -e

# ========== 默认 LAN IP ==========
sed -i 's/192.168.1.1/192.168.5.1/g' \
package/base-files/files/bin/config_generate

# ========== eth0 -> WAN，其余 -> LAN ==========
sed -i '/config interface '\''lan'\''/,+5d' \
package/base-files/files/bin/config_generate

sed -i '/config interface '\''wan'\''/,+5d' \
package/base-files/files/bin/config_generate

cat >> package/base-files/files/bin/config_generate << 'EOF'

uci set network.lan=interface
uci set network.lan.proto='static'
uci set network.lan.ipaddr='192.168.5.1'
uci set network.lan.netmask='255.255.255.0'
uci set network.lan.device='br-lan'

uci add_list network.@device[0].ports='eth1'
uci add_list network.@device[0].ports='eth2'
uci add_list network.@device[0].ports='eth3'

uci set network.wan=interface
uci set network.wan.proto='dhcp'
uci set network.wan.device='eth0'
EOF

# ========== 默认主题 ==========
sed -i 's/luci-theme-bootstrap/luci-theme-argon/g' \
feeds/luci/collections/luci/Makefile

# ========== Docker 开机自启 ==========
mkdir -p package/base-files/files/etc/docker
echo '{ "registry-mirrors": ["https://dockerproxy.com"] }' \
> package/base-files/files/etc/docker/daemon.json
