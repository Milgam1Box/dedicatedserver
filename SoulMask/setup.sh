#!/usr/bin/env bash

set -euo pipefail

if [[ "${EUID}" -ne 0 ]]; then
  echo "This script must be run as root. Example: sudo bash $0"
  exit 1
fi

if [[ -r /etc/os-release ]]; then
  . /etc/os-release
  if [[ "${ID:-}" != "ubuntu" || "${VERSION_ID:-}" != "22.04" ]]; then
    echo "Warning: This draft is intended for Ubuntu 22.04 LTS."
  fi
fi

ARCH="$(dpkg --print-architecture)"
if [[ "${ARCH}" != "amd64" ]]; then
  echo "Warning: This draft is intended for Ubuntu 22.04 LTS x86_64 (amd64). Current arch: ${ARCH}"
fi

export DEBIAN_FRONTEND=noninteractive

echo "[1/5] Enabling multiverse and i386 architecture..."
add-apt-repository -y multiverse
dpkg --add-architecture i386
apt-get update

echo "[2/5] Installing required packages..."
apt-get install -y steamcmd nano netfilter-persistent iptables screen

echo "[3/5] Installing app 3017300 with SteamCMD..."
steamcmd +login anonymous +app_update 3017300 validate +quit

echo "[4/5] Opening UDP firewall ports..."
open_udp_port() {
  local port="$1"

  if iptables -C INPUT -p udp --dport "${port}" -j ACCEPT 2>/dev/null; then
    echo "UDP ${port} is already allowed."
  else
    iptables -A INPUT -p udp --dport "${port}" -j ACCEPT
    echo "Allowed UDP ${port}."
  fi
}

open_udp_port 7777
open_udp_port 27015
open_udp_port 1888

echo "[5/5] Saving firewall rules persistently..."
netfilter-persistent save
netfilter-persistent reload

echo "Completed."
