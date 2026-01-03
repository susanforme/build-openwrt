#!/bin/bash
set -e

# ========== 第三方 feeds ==========
echo "src-git kenzo https://github.com/kenzok8/openwrt-packages" >> feeds.conf.default
echo "src-git small https://github.com/kenzok8/small" >> feeds.conf.default

# ========== 更新 feeds ==========
./scripts/feeds update -a
./scripts/feeds install -a

# ========== Clash / MosDNS / Lucky ==========
./scripts/feeds install luci-app-openclash
./scripts/feeds install mosdns luci-app-mosdns
./scripts/feeds install lucky luci-app-lucky

# ========== 网络 / 多拨 / NAT ==========
./scripts/feeds install luci-app-mwan3
./scripts/feeds install luci-app-natmap
./scripts/feeds install luci-app-syncdial

# ========== 广告 / 证书 / 定时 ==========
./scripts/feeds install luci-app-adguardhome
./scripts/feeds install luci-app-acme
./scripts/feeds install luci-app-taskplan
./scripts/feeds install luci-app-timedreboot

# ========== 系统 / 磁盘 / 流量 ==========
./scripts/feeds install luci-app-diskman
./scripts/feeds install luci-app-wrtbwmon
./scripts/feeds install luci-app-netspeedtest

# ========== Docker ==========
./scripts/feeds install luci-app-dockerman

# ========== 虚拟化 ==========
./scripts/feeds install open-vm-tools

# ========== 主题 ==========
./scripts/feeds install luci-theme-argon
