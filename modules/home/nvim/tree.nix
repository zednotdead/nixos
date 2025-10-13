{ ... }:
let
  leader = "<Space>";
in
{
  programs.nixvim.plugins.neo-tree = {
    enable = true;
    settings = {
      close_if_last_window = true;
      auto_clean_after_session_restore = true;
      filesystem = {
        filtered_items = {
          hide_dotfiles = false;
          hide_by_pattern = [ ".git" ];
        };
        follow_current_file = {
          enabled = true;
          leave_dirs_open = true;
        };
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
