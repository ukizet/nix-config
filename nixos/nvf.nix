{pkgs, ...}: {
  programs.nvf = {
    enable = true;
    settings.vim = {
      theme = {
        enable = true;
        name = "catppuccin";
        style = "mocha";
        transparent = true;
      };
      viAlias = false;
      vimAlias = true;
      options = {
        shiftwidth = 2;
        tabstop = 2;
      };
      lsp = {
        enable = true;
        formatOnSave = true;
        inlayHints.enable = true;
        trouble.enable = true;
      };
      languages = {
        enableFormat = true;
        enableTreesitter = true;
        nix = {
          enable = true;
          extraDiagnostics.enable = true;
        };
        rust.enable = true;
        python.enable = true;
        markdown.enable = true;
        ts = {
          enable = true;
          format.type = "biome";
        };
        html.enable = true;
        css.enable = true;
        tailwind.enable = true;
      };
      telescope.enable = true;
      autopairs.nvim-autopairs.enable = true;
      autocomplete.nvim-cmp.enable = true;
      fzf-lua.enable = true;
      utility.oil-nvim.enable = true;
      keymaps = [
        {
          key = "<leader>e";
          mode = ["n"];
          action = "<cmd>Oil<CR>";
          desc = "Toggle Oil (explorer)";
          silent = true;
        }
      ];
    };
  };
}
