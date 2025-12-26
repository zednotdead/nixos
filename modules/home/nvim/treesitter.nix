{ ... }:
{
  programs.nixvim.plugins = {
    treesitter = {
      enable = true;
      folding.enable = true;
      highlight.enable = true;
      indent.enable = true;
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
