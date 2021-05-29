# Download and save
echo "Mengunduh pingplus!"
curl -sLko "/root/pingplus.sh" "https://github.com/sachnun/pingplus-openwrt/raw/main/bash/pingplus.sh"
chmod +x "/root/pingplus.sh"

# Set Autostart
echo "Konfigurasi pingplus autostart!"
sed -i "/pingplus.sh/d" /etc/rc.local
sed -i "s/exit 0/$(echo "screen -AmdS pingplus /root/pingplus.sh" | sed 's/\//\\\//g')\nexit 0/g" /etc/rc.local

# Running
echo "Menjalankan pingplus!"
kill $(screen -list | grep pingplusr | awk -F '[.]' {'print $1'})
screen -AmdS pingplus /root/pingplus.sh

echo "" && echo "Berhasil." && exit
