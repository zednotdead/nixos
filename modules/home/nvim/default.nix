{
  inputs,
  pkgs,
  config,
  ...
}:
{
  imports = [
    inputs.nixvim.homeModules.nixvim
    ./bars.nix
    ./completion.nix
    ./edgy.nix
    ./flash.nix
    ./format.nix
    ./keymaps.nix
    ./lsp.nix
    ./session.nix
    ./spectre.nix
    ./tree.nix
    ./treesitter.nix
  ];

  programs.nixvim =
    let
      leader = "<Space>";
      groups = [
        [
          "<leader>p"
          "projects"
        ]
        [
          "<leader>t"
          "tabs"
        ]
        [
          "<leader>f"
          "find"
        ]
        [
          "<leader>l"
          "LSP"
        ]
        [
          "<leader>g"
          "terminal"
        ]
      ];
    in
    {
      enable = true;
      globals.mapleader = leader;
      opts = {
        termguicolors = true;
        number = true;
        relativenumber = true;
        signcolumn = "number";
        fillchars = {
          eob = " ";
        };
        background = "dark";
        undodir = "vim.fn.stdpath(\"data\") .. \"/undo\"";
        foldcolumn = "1";
        foldlevel = 99;
        foldlevelstart = 99;
        foldenable = true;
        shiftwidth = 2;
      };
      colorschemes.oxocarbon.enable = config.scheme.slug == "oxocarbon-dark";
      colorschemes.base16 = {
        enable = config.scheme.slug != "oxocarbon-dark";
        colorscheme = config.scheme.slug;
      };
      filetype = {
        extension = {
          njk = "html";
          webc = "html";
          vert = "glsl";
          frag = "glsl";
        };
      };
      plugins = {
        web-devicons = {
          enable = true;
        };
        alpha = {
          enable = true;
          theme = "dashboard";
        };
        which-key = {
          enable = true;
          settings.preset = "helix";
          settings.win.wo.winblend = 75;
          luaConfig.post = ''
            local wk = require("which-key")
            wk.add({
          ''
          + builtins.toString (
            builtins.map (
              x:
              let
                key = builtins.elemAt x 0;
                group = builtins.elemAt x 1;
              in
              ''{ "${key}", group = "${group}" },''
            ) groups
          )
          + "})";
        };
        noice = {
          enable = true;
          settings.views.cmdline_popup = {
            border = {
              style = "none";
              padding = [
                2
                3
              ];
            };
            filter_options = { };
            win_options = {
              winhighlight = "NormalFloat:NormalFloat;FloatBorder:FloatBorder";
            };
          };
        };
        snacks = {
          enable = true;
          settings = {
            bigfile.enabled = true;
            indent.enabled = true;
            lazygit.enabled = true;
            quickfile.enabled = true;
            picker.enabled = true;
            rename.enabled = true;
            scope.enabled = true;
            scroll.enabled = true;
            statuscolumn.enabled = true;
            win.enabled = true;
            words.enabled = true;
            terminal.enabled = true;
          };
        };
        nvim-surround.enable = true;
        gitsigns.enable = true;
        illuminate.enable = true;

        nvim-ufo.enable = true;
        nvim-ufo.setupLspCapabilities = true;

        comment = {
          enable = true;
          settings = {
            toggler = {
              line = "${leader}${leader}${leader}";
              block = "${leader}${leader}b";
            };
            opleader = {
              line = "${leader}${leader}";
              block = "${leader}b";
            };
          };
        };

        spider.enable = true;
      };
      extraPlugins = with pkgs.vimPlugins; [
        vim-airline-themes
      ];
    };
}
