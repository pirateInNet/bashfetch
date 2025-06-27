#!/bin/bash

echo "$(whoami)@$(hostname)"
echo ""
echo "OS: $(. /etc/os-release; echo $NAME) $(uname -m)"
echo "Host: $(cat /sys/class/dmi/id/product_name | sed 's/ *$//') ($(cat /sys/class/dmi/id/product_version))"
echo "Kernel: $(uname -s) $(uname -r)"
uptime -p | sed 's/up/Uptime:/'
echo "Packages: $(pacman -Qq | wc -l) (pacman)[$(grep '^Branch =' /etc/pacman-mirrors.conf | cut -d' ' -f3 || echo stable)]"
echo "Shell: $(basename "$SHELL") $BASH_VERSION"
echo "CPU: $(grep -m1 'model name' /proc/cpuinfo | cut -d: -f2 | sed 's/^ //') ($(grep -c '^processor' /proc/cpuinfo)) @ $(awk -F: '/cpu MHz/ {printf "%.2f", $2/1000; exit}' /proc/cpuinfo) GHz"
i=1
lspci | grep -E 'VGA|3D' | while read -r line; do
  gpu=$(echo "$line" | cut -d ':' -f3- | sed 's/^ //; s/ (rev.*//')
  echo "GPU $i: $gpu"
  i=$((i+1))
done
echo "Wifi adapter: $(lspci | grep -i 'network' | cut -d ':' -f3- | sed 's/^ //')"
echo "Locale: $LANG"
