{...}: {
  programs.nixvim.plugins.treesitter = {
    enable = true;
    settings.ensure_installed = ["lua" "markdown" "markdown_inline"];
    settings.highlight.enable = true;
    settings.indent.enable = true;
  };
  programs.nixvim.plugins.treesitter-textobjects.enable = true;
  programs.nixvim.plugins.ts-autotag = {
    enable = true;
    settings.opts = {
      enable_close = true;
      enable_rename = true;
      enable_close_on_slash = true;
    };
  };
  programs.nixvim.plugins.nvim-autopairs.enable = true;
  programs.nixvim.plugins.indent-blankline.enable = true;
}
