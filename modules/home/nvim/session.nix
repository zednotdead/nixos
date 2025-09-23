{ ... }:
let
  prefix = "<Space>p";
in
{
  programs.nixvim.plugins.auto-session = {
    enable = true;
  };

  programs.nixvim.keymaps = [
    {
      action = "<Cmd>AutoSession search<CR>";
      key = "${prefix}p";
      options.desc = "Switch project";
      options.silent = true;
    }
    {
      action = "<Cmd>AutoSession save<CR>";
      key = "${prefix}s";
      options.desc = "Save project";
      options.silent = true;
    }
  ];
}
