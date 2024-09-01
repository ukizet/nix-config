curl "https://raw.githubusercontent.com/ukizet/nix-config/stable(24.05)/nixos/disk-config.nix" -o ~/disk-config.nix &&
echo "Downloaded disk-config.nix..."
sudo nix --experimental-features "nix-command flakes" run github:nix-community/disko -- --mode disko ~/disk-config.nix
echo "Disk was formatted..."
mount | grep /mnt
sleep 5
read -n 1 -s -r -p "Press any key to generate config..."

sudo nixos-generate-config --no-filesystems --root /mnt &&
cd /mnt/etc/nixos &&
sudo mv ~/disk-config.nix /mnt/etc/nixos &&
curl "https://raw.githubusercontent.com/ukizet/nix-config/stable(24.05)/freshinstall/configuration.nix" -o /mnt/etc/nixos/configuration.nix
read -n 1 -s -r -p "Press any key to install nixos..."
sudo nixos-install && reboot
