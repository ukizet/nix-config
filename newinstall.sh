curl "https://raw.githubusercontent.com/ukizet/nix-config/ryzen-5/nixos/disk-config.nix" -o ~/disk-config.nix &&
echo "Downloaded disk-config.nix..."
sudo nix --experimental-features "nix-command flakes" run github:nix-community/disko -- --mode disko ~/disk-config.nix
echo "Disk was formatted..."
mount | grep /mnt

sudo nixos-generate-config --root /mnt &&
cd /mnt/etc/nixos &&
sudo mv ~/disk-config.nix /mnt/etc/nixos &&
sudo nixos-install && reboot
