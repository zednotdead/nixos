{
  config,
  pkgs,
  ...
}: {
  programs.vdirsyncer.enable = true;
  services.vdirsyncer.enable = true;

  programs.khal = {
    enable = true;
    locale = {
      firstweekday = 0;
    };
  };

  home.packages = with pkgs; [
    gopass
  ];

  accounts.calendar.basePath = ".calendar";
  accounts.calendar.accounts = {
    "Mailbox" = {
      name = "Calendar";
      primaryCollection = "Calendar";
      khal = {
        enable = true;
        addresses = [
          "zuzanna@zolnierowi.cz"
          "zbigniew@zolnierowi.cz"
          "me@zed.gay"
        ];
        type = "discover";
      };
      vdirsyncer.enable = true;
      vdirsyncer.collections = [
        ["Tasks" "MzM" "Tasks"]
        ["Calendar" "Y2FsOi8vMC8zMQ" "Calendar"]
        ["Birthdays" "Y2FsOi8vMS8w" "Birthdays"]
      ];
      remote = {
        type = "caldav";
        url = "https://dav.mailbox.org";
        userName = "zbigniew@zolnierowi.cz";
        passwordCommand = [
          "${pkgs.gopass}/bin/gopass"
          "cat"
          "mailbox"
        ];
      };
    };
  };
}
