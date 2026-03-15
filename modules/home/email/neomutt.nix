{
  lib,
  pkgs,
  ...
}:
let
  khal = lib.getExe' pkgs.khal "khal";
  monolith-bin = lib.getExe pkgs.monolith;
  chawan = lib.getExe pkgs.chawan;
in
{
  home.packages = with pkgs; [
    mutt-ics
    monolith
  ];

  home.file.".mailcap" = {
    enable = true;
    text = ''
      text/html;        ${monolith-bin} %s -ajvFo - | ${chawan} -T text/html; nametemplate=%s.html; needsterminal;
      text/calendar;    ${khal} printics; copiousoutput;print=${khal} import --batch -a Calendar
      text/x-vcalendar; ${khal} printics; copiousoutput;print=${khal} import --batch -a Calendar
      application/ics;  ${khal} printics; copiousoutput;print=${khal} import --batch -a Calendar
    '';
  };

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
