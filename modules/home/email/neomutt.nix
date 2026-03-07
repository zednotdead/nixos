{
  lib,
  pkgs,
  ...
}:
{
  home.packages = with pkgs; [
    mutt-ics
    monolith
  ];

  home.file.".mailcap" = {
    enable = true;
    text = ''
      text/html;        ${pkgs.chawan}/bin/cha -T text/html; nametemplate=%s.html; needsterminal;
      text/calendar;    ${pkgs.khal}/bin/khal printics; copiousoutput;print=${pkgs.khal}/bin/khal import --batch -a Calendar
      text/x-vcalendar; ${pkgs.khal}/bin/khal printics; copiousoutput;print=${pkgs.khal}/bin/khal import --batch -a Calendar
      application/ics;  ${pkgs.khal}/bin/khal printics; copiousoutput;print=${pkgs.khal}/bin/khal import --batch -a Calendar
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
