{
  pkgs,
  config,
  ...
}:
{
  imports = [
    ./neomutt.nix
  ];
  programs = {
    notmuch = {
      enable = true;
      new.tags = [ "new" ];
    };
    mbsync.enable = true;
    msmtp.enable = true;

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

      new=$(${pkgs.notmuch}/bin/notmuch count tag:new)
      echo "New mail count: $new"

      ${pkgs.afew}/bin/afew -C $NOTMUCH_CONFIG --tag --new -v

      if [ "$new" -ne 0 ]; then
        ${pkgs.libnotify}/bin/notify-send -a "mbsync" "New mail!" "You got $new new messages!"
      fi
    '';
    executable = true;
  };

  home.file.".local/bin/mailsync" = {
    text = ''
      #!${pkgs.stdenv.shell}

      ${pkgs.libnotify}/bin/notify-send -a "mbsync" "Manual sync triggered!" "Synchronizing mail..."
      systemctl start --user mbsync
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
        passwordCommand = "${pkgs.pass}/bin/pass mailbox";
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

        imapnotify = {
          enable = true;
          onNotify = "~/.local/bin/mailsync";
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
        passwordCommand = "${pkgs.pass}/bin/pass gmail";
        mbsync = {
          enable = true;
          create = "both";
          expunge = "both";
          patterns = [
            "*"
            "![Gmail]*"
            "[Gmail]/Sent Mail"
            "[Gmail]/Starred"
          ];
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
          onNotify = "~/.local/bin/mailsync";
        };

        msmtp.enable = true;

        notmuch.enable = true;
        notmuch.neomutt.enable = true;

        neomutt.enable = true;
      };
    };
  };
}
