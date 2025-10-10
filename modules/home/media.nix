{ pkgs, ... }:
{
  home.packages = with pkgs; [
    ytfzf
    video-trimmer
  ];

  programs.yt-dlp = {
    enable = true;
    settings = {
      embed-subs = true;
    };
  };

  programs.mpv = {
    enable = true;
    scripts = with pkgs.mpvScripts; [
      sponsorblock
      uosc
    ];
  };
}
