{ ... }:
let
  leader = "<Space>";
in
{
  programs.nixvim.plugins.barbar = {
    enable = true;
    keymaps =
      let
        prefix = "${leader}t";
      in
      {
        closeAllButCurrentOrPinned.key = prefix + "o";
        next.key = "gt";
        previous.key = "gT";
        pick.key = prefix + "t";
        pickDelete.key = prefix + "d";
      };
    settings = {
      focus_on_close = "previous";
    };
  };
  programs.nixvim.plugins.airline = {
    enable = true;
    settings = {
      theme = "base16";
    };
  };
}
