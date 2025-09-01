{
  pkgs,
  lib,
  config,
  ...
}: {
  home.packages = with pkgs; [
    fastfetch
    nix-search-cli
    kubectl
    viddy
    zellij
    nix-search-tv
    kubectx
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
    shellInit = ''
      set fish_greeting
    '';
    shellAliases = {
      zel = "${pkgs.zellij}/bin/zellij";
      k = "${pkgs.kubectl}/bin/kubectl";
    };
  };

  programs.zellij = {
    enable = true;
    settings = {
      theme = "oxocarbon-dark";
    };
    themes = {
      oxocarbon-dark = with config.scheme.withHashtag; {
        themes = {
          oxocarbon-dark = {
            fg = base05;
            bg = base02;
            black = base00;
            red = base08;
            green = base0B;
            yellow = base0A;
            blue = base0D;
            magenta = base0E;
            cyan = base0C;
            white = base05;
            orange = base09;
          };
        };
      };
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
    settings = {
      add_newline = false;
      format = lib.concatStrings [
        "$username"
        "$hostname"
        "$directory"
        "$git_branch"
        "$git_state"
        "$git_status"
        "$kubernetes"
        "$cmd_duration"
        "$line_break"
        "$python"
        "$character"
      ];
      scan_timeout = 10;
      character = {
        success_symbol = "[❯](purple)";
        error_symbol = "[❯](red)";
        vimcmd_symbol = "[❮](green)";
      };

      git_branch = {
        format = "[$branch]($style)";
        style = "bright-black";
      };

      git_status = {
        style = "cyan";
        modified = " !×$\{count}";
        ahead = " ⇡×$\{count}";
        behind = " ⇣×$\{count}";
        diverged = " ⇡×$\{ahead_count} ⇣×$\{behind_count}";
        staged = " +×$\{count}";
        untracked = " ?×$\{count}";
        stashed = "";
        deleted = " ✘×$\{count}";
        format = "[$all_status$ahead_behind]($style)";
      };

      git_state = {
        format = "\([$state( $progress_current/$progress_total)]($style)\) ";
        style = "bright-black";
      };

      kubernetes = {
        disabled = false;
        symbol = "☸ ";
        format = " [$symbol$context( \($namespace\))]($style)";
        style = "cyan bold";
      };

      cmd_duration = {
        format = " [$duration]($style) ";
        style = "yellow";
      };

      python = {
        format = "[$virtualenv]($style) ";
        style = "bright-black";
      };
    };
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

  xdg.configFile."television/cable/nix.toml".text = ''
    [metadata]
    name = "nix"
    requirements = ["nix-search-tv"]

    [source]
    command = "nix-search-tv print"

    [preview]
    command = "nix-search-tv preview {}"
  '';

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
