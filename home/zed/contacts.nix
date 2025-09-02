{
  config,
  pkgs,
  ...
}: {
  programs.vdirsyncer.enable = true;
  services.vdirsyncer.enable = true;
  programs.khard.enable = true;

  home.packages = with pkgs; [
    gopass
  ];

  accounts.contact.basePath = ".contacts";
  accounts.contact.accounts = {
    "Mailbox" = {
      khard = {
        enable = true;
        addressbooks = [
          "Collected addresses"
          "Global address book"
          "Contacts"
        ];
      };
      vdirsyncer = {
        enable = true;
        collections = [
          ["Contacts" "32" "Contacts"]
          ["Collected addresses" "41" "Collected addresses"]
          ["Global address book" "6" "Global address book"]
        ];
      };
      remote = {
        type = "carddav";
        url = "https://dav.mailbox.org";
        userName = "zbigniew@zolnierowi.cz";
        passwordCommand = [
          "${pkgs.gopass}/bin/gopass"
          "cat"
          "mailbox"
        ];
      };
      local = {
        type = "filesystem";
      };
    };
  };
}
