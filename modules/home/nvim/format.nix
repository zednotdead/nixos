{pkgs, ...}: let
  prefix = "<Space>l";
  es_formatters = {
    __unkeyed-1 = "eslint_d";
    __unkeyed-2 = "eslint";
    lsp_format = "fallback";
    timeout_ms = 2000;
    stop_after_first = true;
  };
in {
  home.packages = with pkgs; [
    taplo
    statix
    beautysh
    sqlfluff
    jq
    opentofu
    alejandra
  ];

  programs.nixvim.plugins.conform-nvim = {
    enable = true;
    settings.formatters_by_ft = {
      lua = ["stylua"];
      javascript = es_formatters;
      typescript = es_formatters;
      typescriptreact = es_formatters;
      astro = {
        __unkeyed-1 = "eslint_d";
        __unkeyed-2 = "eslint";
        lsp_format = "fallback";
        stop_after_first = true;
      };
      json = ["jq"];
      rust = ["rustfmt"];
      bash = ["beautysh"];
      sh = ["beautysh"];
      zsh = ["beautysh"];
      sql = ["sqlfluff"];
      toml = ["taplo"];
      terraform = ["terraform_fmt"];
      go = ["goimports" "gofmt"];
      nix = ["alejandra"];
      python = ["ruff"];
    };
    settings.formatters = {
      rustfmt = {
        command = "rustfmt";
        args = ["--edition=2021" "--emit=stdout"];
      };
      terraform_fmt = {
        command = "tofu";
        args = [
          "fmt"
          "-no-color"
          "-"
        ];
      };
    };
  };

  programs.nixvim.keymaps = [
    {
      action.__raw = ''
        function()
          require("conform").format()
        end
      '';
      key = "${prefix}f";
      options.desc = "Format";
    }
  ];
}
