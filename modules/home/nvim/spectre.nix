{ ... }:
let
  prefix = "<Space>";
in
{
  programs.nixvim.plugins.spectre = {
    enable = true;
  };

  programs.nixvim.keymaps = [
    {
      action.__raw = ''
        function()
          require("spectre").toggle()
        end
      '';
      key = "${prefix}fr";
      options.desc = "Find and replace";
    }
  ];
}
