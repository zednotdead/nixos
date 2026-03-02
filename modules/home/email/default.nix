{
  pkgs,
  config,
  ...
}: {
  imports = [
    ./neomutt.nix
  ];
  programs = {
    notmuch = {
      enable = true;
      new.tags = ["new"];
    };
    mbsync.enable = true;

    afew = {
      enable = true;
      extraConfig = ''
        [SpamFilter]
        [KillThreadsFilter]
        [ListMailsFilter]
        [ArchiveSentMailsFilter]
        [FolderNameFilter]
        maildir_separator = /
        [InboxFilter]
      '';
    };
  };

  services.imapnotify.enable = true;
  services.mbsync = {
    enable = true;
    # preExec = "${config.xdg.configHome}/mbsync/preExec";
    postExec = "${config.xdg.configHome}/mbsync/postExec";
    frequency = "*:0/30";
  };

  xdg.configFile."mbsync/postExec" = {
    text = ''
      #!${pkgs.stdenv.shell}

      export NOTMUCH_CONFIG=${config.xdg.configHome}/notmuch/default/config

      ${pkgs.notmuch}/bin/notmuch new
      ${pkgs.afew}/bin/afew -C $NOTMUCH_CONFIG --tag --new -v
    '';
    executable = true;
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
          enable = true;
          create = "both";
          expunge = "both";
          patterns = ["*"];
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

        imapnotify = {
          enable = true;
          onNotifyPost = "systemctl --user start mbsync";
        };

        msmtp.enable = true;
        notmuch = {
          enable = true;
          neomutt = {
            enable = true;
            virtualMailboxes = [
              {
                name = "All unread";
                query = "tag:inbox and tag:unread";
              }
              {
                name = "Inbox";
                query = "tag:inbox and tag:INBOX and tag:private";
              }
              {
                name = "Unread";
                query = "tag:inbox and tag:unread and tag:private";
              }
              {
                name = "Newsletters";
                query = "tag:inbox and tag:INBOX.Newsletters and tag:private";
              }
            ];
          };
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
        mbsync = {
          enable = true;
          create = "both";
          expunge = "both";
          patterns = ["*" "![Gmail]*" "[Gmail]/Sent Mail" "[Gmail]/Starred"];
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
        folders.inbox = "INBOX";
        imap.host = "imap.gmail.com";
        smtp.host = "smtp.gmail.com";

        imapnotify = {
          enable = true;
          onNotifyPost = "systemctl --user start mbsync";
        };

        msmtp.enable = true;

        notmuch.enable = true;
        notmuch.neomutt.enable = true;

        neomutt.enable = true;
      };
    };
  };
}
