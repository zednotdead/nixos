{
  pkgs,
  config,
  ...
}:
{
  imports = [
    ./neomutt.nix
  ];
  programs.notmuch.enable = true;
  programs.offlineimap.enable = true;
  services.imapnotify.enable = true;

  xdg.configFile."offlineimap/post-fetch" = {
    text = ''
      #!${pkgs.stdenv.shell}

      export NOTMUCH_CONFIG=${config.xdg.configHome}/notmuch/default/config

      ${pkgs.notmuch}/bin/notmuch new
      ${pkgs.afew}/bin/afew -C $NOTMUCH_CONFIG --tag --new -v
      # Remove inbox (lower-case)
      ${pkgs.notmuch}/bin/notmuch tag -inbox -- tag:inbox
      # Remove Inbox tagged message that are not in an Inbox
      ${pkgs.notmuch}/bin/notmuch tag -INBOX -- not folder:private/INBOX and tag:INBOX

      # Count new email
      NEW_EMAIL_COUNT=$(${pkgs.notmuch}/bin/notmuch count "tag:INBOX and tag:$1 and tag:unread")
      ${pkgs.libnotify}/bin/notify-send "Mails synced 📬" "New unread email: $NEW_EMAIL_COUNT"
    '';
    executable = true;
  };

  programs.afew = {
    enable = true;
    extraConfig = ''
      [SpamFilter]
      [KillThreadsFilter]
      [ListMailsFilter]
      [ArchiveSentMailsFilter]
      [FolderNameFilter]
      maildir_separator = .
    '';
  };

  accounts.email = {
    maildirBasePath = ".maildir";

    accounts = {
      "private" = {
        primary = true;
        address = "zuzanna@zolnierowi.cz";
        userName = "zuzanna@zolnierowi.cz";
        realName = "Zuzanna Żołnierowicz";
        aliases = [
          "zbigniew@zolnierowi.cz"
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
        smtp = {
          host = "smtp.mailbox.org";
          port = 465;
          tls.enable = true;
        };

        mbsync = {
          enable = false;
          create = "both";
          expunge = "both";
          patterns = [ "*" ];
          extraConfig = {
            channel = {
              Sync = "All";
            };
            account = {
              Timeout = 120;
              PipelineDepth = 1;
            };
          };
        };

        offlineimap = {
          enable = true;
          postSyncHookCommand = "${config.xdg.configHome}/offlineimap/post-fetch gmail";
        };

        imapnotify = {
          enable = true;
          onNotify = "${pkgs.offlineimap}/bin/offlineimap -a private";
        };

        msmtp.enable = true;
        notmuch = {
          enable = true;
          neomutt.enable = true;
        };
        neomutt.enable = true;
      };
      "gmail" = {
        address = "zbigniew.zolnierowicz@gmail.com";
        userName = "zbigniew.zolnierowicz@gmail.com";
        realName = "Zbigniew Żołnierowicz";
        passwordCommand = [
          "${pkgs.gopass}/bin/gopass"
          "cat"
          "gmail"
        ];
        imap.host = "imap.gmail.com";
        smtp.host = "smtp.gmail.com";

        offlineimap = {
          enable = true;
          postSyncHookCommand = "${config.xdg.configHome}/offlineimap/post-fetch gmail";
        };

        imapnotify = {
          enable = true;
          onNotify = "${pkgs.offlineimap}/bin/offlineimap -a gmail";
        };

        msmtp.enable = true;

        notmuch.enable = true;
        notmuch.neomutt.enable = true;

        neomutt.enable = true;
      };
    };
  };
}
