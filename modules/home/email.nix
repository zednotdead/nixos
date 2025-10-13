{ pkgs, ... }:
{
  programs = {
    afew.enable = true;
    msmtp.enable = true;
    notmuch.enable = true;
    offlineimap.enable = true;
    neomutt = {
      enable = true;
      vimKeys = true;
    };
  };

  services = {
    imapnotify.enable = true;
  };

  home.packages =
    with pkgs;
    [
      gopass
    ]
    ++ (pkgs.lib.optionals (pkgs.stdenv.isLinux) [ pkgs.thunderbird ]);

  accounts.email = {
    maildirBasePath = ".maildir";
    accounts = {
      "Mailbox" = {
        primary = true;
        address = "zuzanna@zolnierowi.cz";
        userName = "zbigniew@zolnierowi.cz";
        realName = "Zuzanna Żołnierowicz";
        aliases = [
          "zbigniew@zolnierowi.cz"
          "me@zed.gay"
        ];
        folders = {
          inbox = "INBOX";
        };
        passwordCommand = [
          "${pkgs.gopass}/bin/gopass"
          "cat"
          "mailbox"
        ];
        imap = {
          host = "imap.mailbox.org";
          port = 993;
          tls.enable = true;
        };
        imapnotify = {
          enable = true;
          boxes = [
            "INBOX"
            "INBOX/Newsletters"
          ];
          onNotifyPost = "${pkgs.offlineimap}/bin/offlineimap && ${pkgs.notmuch}/bin/notmuch new && ${pkgs.libnotify}/bin/notify-send 'New mail arrived'";
        };
        offlineimap = {
          enable = true;
        };
        smtp = {
          host = "smtp.mailbox.org";
          port = 465;
          tls.enable = true;
        };
        msmtp = {
          enable = true;
        };
        neomutt = {
          enable = true;
        };
        astroid = {
          enable = true;
        };
        notmuch = {
          enable = true;
          neomutt = {
            enable = true;
          };
        };
      };
    };
  };
}
