{...}: {
  programs.nixvim.plugins = {
    treesitter = {
      enable = true;
      settings = {
        ensure_installed = ["lua" "markdown" "markdown_inline"];
        highlight.enable = true;
        indent.enable = true;
      };
    };
    treesitter-textobjects.enable = true;
    ts-autotag = {
      enable = true;
      settings.opts = {
        enable_close = true;
        enable_rename = true;
        enable_close_on_slash = true;
      };
    };
    nvim-autopairs.enable = true;
    indent-blankline.enable = true;
  };
}
