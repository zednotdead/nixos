{ pkgs, ... }:
{
  home.packages = with pkgs; [
    youtube-tui
  ];

  programs.mpv = {
    enable = true;
    scripts = with pkgs.mpvScripts; [
      sponsorblock
      uosc
    ];
  };
}
