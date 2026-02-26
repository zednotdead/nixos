{ lib, pkgs, ... }:
{
  home.packages = with pkgs; [ mutt-ics ];
  programs.neomutt = {
    enable = true;
    unmailboxes = true;
    settings = {
      editor = "nvim";
    };
    extraConfig = lib.concatStrings [
      (builtins.readFile ./colors.muttrc)
      (builtins.readFile ./options.muttrc)
      (builtins.readFile ./binds.muttrc)
    ];
  };
}
