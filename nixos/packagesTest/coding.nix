{
  pkgs,
  pkgs-stable,
  inputs,
  ...
}: {
  environment.systemPackages =
    (with pkgs; [
      # coding
      wl-clipboard # neovim requiring this
      vscodium-fhs
      zed-editor
      code-cursor
      wget
      podman-compose
    ])
    ++ (with pkgs-stable; [
      ]);
}
