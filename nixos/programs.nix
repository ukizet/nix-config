{ config, lib, pkgs, ... }:

{
  programs = {
    steam = {
      enable = true;
      gamescopeSession.enable = true;
    };
    gamemode.enable = true;
    nix-ld.enable = true;
    nh = {
      enable = true;
      clean.enable = true;
      clean.extraArgs = "--keep-since 4d --keep 3";
      flake = "/home/sas/nix-config";
    };
    nvf = {
      enable = true;
      settings.vim = {
        viAlias = false;
        vimAlias = true;
        lsp.enable = true;
        options = {
          shiftwidth = 2;
          tabstop = 2;
        };
        languages = {
          nix = {
            enable = true;
            lsp.enable = true;
            treesitter.enable = true;
          };
          rust.enable = true;
          python.enable = true;
          markdown.enable = true;
          ts.enable = true;
        };
        telescope.enable = true;
        autopairs.nvim-autopairs.enable = true;
        autocomplete.nvim-cmp.enable = true;
        fzf-lua.enable = true;
        filetree.neo-tree.enable = true;
        keymaps = [
          {
            key    = "<leader>e";               
            mode   = ["n"];                     
            action = "<cmd>Neotree toggle<CR>"; 
            desc   = "Toggle Neo-Tree";         
            silent = true;
          }
        ];
      };
    };
    zsh.enable = true;
    hyprland.enable = true;
    gpu-screen-recorder.enable = true;
  };
}
