## Rebuilding the system

In the root directory (with flake.nix file): `sudo nixos-rebuild switch --flake .`, this command will rebuilt whole nixos system and switch to created generation. Or, if you still don't have flakes: `sudo nixos-rebuild switch`.

Git needs to track all files in root directory, otherwise nix will give errors.

## New install of nixos

Let's asume that you would use minimum nixos iso.

`curl "https://raw.githubusercontent.com/ukizet/nix-config/stable(24.05)/newinstall.sh" -o ~/newinstall.sh && chmod +x newinstall.sh && ./newinstall.sh`

On each new installation either generate new hardware-configuration.nix and push it to github, or [use disko for this](https://github.com/nix-community/disko/blob/master/docs/quickstart.md#step-7-complete-the-nixos-installation).

If you formatted disk with disko, it will be better to generate nixos-config like this: `nixos-generate-config --no-filesystems --root /mnt`, [and then add disko configs to configuration.nix](https://github.com/nix-community/disko/blob/master/docs/quickstart.md#step-7-complete-the-nixos-installation)

`ssh-keygen -t ed25519 -C "ukikatuki@gmail.com" && eval "$(ssh-agent -s)" && ssh-add ~/.ssh/id_ed25519 && cat ~/.ssh/id_ed25519.pub` and then add result to github ssh keys

## Useful links
- https://nixos.org/manual/nixos/stable/
- https://nixos.org/manual/nix/stable/introduction
- https://nixos.org/guides/nix-pills/06-our-first-derivation
- https://home-manager-options.extranix.com/
- https://zero-to-nix.com/
- https://edolstra.github.io/pubs/phd-thesis.pdf
- [disko](https://github.com/nix-community/disko)
  - https://github.com/nix-community/disko/blob/master/docs/quickstart.md
- https://github.com/NixOS/nixpkgs
- [declarative gnome config](https://hoverbear.org/blog/declarative-gnome-configuration-in-nixos/)
