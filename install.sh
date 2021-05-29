# Download and save
echo -e "Mengunduh pingplus!"
curl -sLko "/root/pingplus.sh" "https://github.com/sachnun/pin
gplus-openwrt/raw/main/bash/pingplus.sh"

# Set Autostart
echo -e "Konfigurasi pingplus autostart!"
sed -i "/pingplus.sh/d" /etc/rc.local
sed -i "s/exit 0/$(echo "screen -AmdS pingplus /root/pingplus.sh" | sed 's/\//\\\//g')\nexit 0/g" /etc/rc.local

# Running
echo -e "Menjalankan pingplus!"
screen -AmdS pingplus /root/pingplus.sh

echo -e "" && echo -e "Berhasil." && exit
