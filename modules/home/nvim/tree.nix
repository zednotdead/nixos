{ ... }:
let
  leader = "<Space>";
in
{
  programs.nixvim.plugins.neo-tree = {
    enable = true;
    closeIfLastWindow = true;
    autoCleanAfterSessionRestore = true;
    filesystem = {
      filteredItems = {
        hideDotfiles = false;
        hideByPattern = [ ".git" ];
      };
      followCurrentFile = {
        enabled = true;
        leaveDirsOpen = true;
      };
    };
  };

  programs.nixvim.keymaps = [
    {
      action = "<Cmd>Neotree toggle<CR>";
      key = "${leader}<Tab>";
      options.desc = "Show file tree";
    }
  ];
}
