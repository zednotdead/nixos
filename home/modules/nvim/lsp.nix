{...}: let
  prefix = "<Space>l";
in {
  programs.nixvim = {
    plugins = {
      lazydev = {
        enable = true;
      };

      neoconf.enable = true;
      typescript-tools.enable = true;
      rustaceanvim.enable = true;
      dropbar.enable = true;
      trouble.enable = true;

      aerial.enable = true;
      tiny-inline-diagnostic.enable = true;
    };

    lsp = {
      servers = {
        nil_ls.enable = true;
        yamlls.enable = true;
        jsonls.enable = true;
        cssls.enable = true;
        dockerls.enable = true;
        eslint.enable = true;
        glsl_analyzer.enable = true;
        html.enable = true;
        just.enable = true;
        slint_lsp.enable = true;
        statix.enable = true;
        basedpyright.enable = true;
        ruff.enable = true;
        tailwindcss.enable = true;
      };

      keymaps = [
        {
          lspBufAction = "code_action";
          key = "ga";
          options.desc = "Code actions";
        }
        {
          lspBufAction = "code_action";
          key = "${prefix}a";
          options.desc = "Code actions";
        }
        {
          lspBufAction = "rename";
          key = "${prefix}r";
          options.desc = "Rename";
        }
        {
          lspBufAction = "hover";
          key = "K";
          options.desc = "Code actions";
        }
        {
          action = "<Cmd>Trouble lsp_definitions toggle focus=false win.position=bottom<CR>";
          key = "gd";
          options.desc = "Definitions";
        }
        {
          action = "<Cmd>Trouble lsp_references toggle focus=false win.position=bottom<CR>";
          key = "gD";
          options.desc = "References";
        }
        {
          action.__raw = "function() vim.diagnostic.open_float() end";
          key = "${prefix}d";
          options.desc = "Diagnostics";
        }
        {
          action = "<Cmd>Trouble diagnostics toggle focus=false win.position=bottom<CR>";
          key = "${prefix}D";
          options.desc = "All diagnostics";
        }
        {
          action = "<Cmd>AerialToggle<CR>";
          key = "${prefix}o";
          options.desc = "Outline";
        }
      ];
    };
  };
}
