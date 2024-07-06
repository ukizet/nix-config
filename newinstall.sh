curl "https://raw.githubusercontent.com/ukizet/nix-config/stable(24.05)/nixos/disk-config.nix" -o ~/disk-config.nix &&
sudo nix --experimental-features "nix-command flakes" run github:nix-community/disko -- --mode disko ~/disk-config.nix && 
read -n 1 -s -r -p "Press any key to generate config and install nixos..."
sudo nixos-generate-config --root /mnt && sudo nixos-install
