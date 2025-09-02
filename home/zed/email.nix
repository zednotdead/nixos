{
  config,
  pkgs,
  ...
}: {
  programs.afew.enable = true;
  programs.alot.enable = true;
  programs.msmtp.enable = true;
  programs.notmuch.enable = true;
  programs.offlineimap.enable = true;
  services.imapnotify.enable = true;
  programs.neomutt.enable = true;
  programs.astroid.enable = true;

  home.packages = with pkgs; [
    thunderbird
    gopass
  ];

  accounts.email.maildirBasePath = ".maildir";
  accounts.email.accounts = {
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
        onNotifyPost = "${pkgs.offlineimap}/bin/offlineimap && ${pkgs.notmuch}/bin/notmuch new && ${pkgs.afew} -n -t -C ~/.config/notmuch/default/config && ${pkgs.libnotify}/bin/notify-send 'New mail arrived'";
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
}
