In the root directory (with flake.nix file): `sudo nixos-rebuild switch --flake .`, this command will rebuilt whole nixos system and switch to created generation.
Git needs to track all files in root directory, otherwise nix will give errors.

On each new installation either generate new hardware-configuration.nix and push it to github, or [use disko for this](https://github.com/nix-community/disko/blob/master/docs/quickstart.md#step-7-complete-the-nixos-installation).

`curl "https://raw.githubusercontent.com/ukizet/nix-config/stable(24.05)/newinstall.sh" -o ~/newinstall.sh && chmod +x newinstall.sh && ./newinstall.sh`

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
