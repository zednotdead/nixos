{pkgs, ...}: {
  home.packages = with pkgs; [
    fastfetch
    nix-search-cli
    kubectl
    viddy
    zellij
  ];

  services.gpg-agent = {
    enable = true;
    enableFishIntegration = true;
  };

  services.ssh-agent = {enable = true;};

  programs.fish = {
    enable = true;
    generateCompletions = true;
    functions = {
      goops = ''
        ${pkgs.git}/bin/git add --all
        ${pkgs.git}/bin/git commit --amend --no-edit --allow-empty
        ${pkgs.git}/bin/git push --force-with-lease
      '';
      gpu = ''
        ${pkgs.git}/bin/git push
      '';
      gpl = ''
        ${pkgs.git}/bin/git pull
      '';
    };
    shellAliases = {
      zel = "${pkgs.zellij}/bin/zellij";
      k = "${pkgs.kubectl}/bin/kubectl";
    };
  };

  programs.pay-respects = {
    enable = true;
    enableFishIntegration = true;
  };

  programs.starship = {
    enable = true;
    enableFishIntegration = true;
    enableTransience = true;
  };

  programs.mise = {
    enable = true;
    enableFishIntegration = true;
  };

  programs.gh = {enable = true;};

  programs.zoxide = {
    enable = true;
    enableFishIntegration = true;
  };

  programs.mcfly = {
    enable = true;
    enableFishIntegration = true;
    fzf = {
      enable = true;
    };
  };

  programs.television = {
    enable = true;
    enableFishIntegration = true;
  };

  programs.k9s = {enable = true;};

  programs.yazi = {
    enable = true;
    enableFishIntegration = true;
  };

  programs.pistol = {
    enable = true;
  };

  programs.tealdeer = {
    enable = true;
    enableAutoUpdates = true;
  };

  services.kdeconnect = {
    enable = true;
    indicator = true;
  };
}
