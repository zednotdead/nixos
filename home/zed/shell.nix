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
      sf = "${pkgs.superfile}/bin/superfile";
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

  programs.superfile = {
    enable = true;
    hotkeys = {
      confirm = ["enter" ""];
      quit = ["ctrl+c" ""];
      list_up = ["k" ""];
      list_down = ["j" ""];
      page_up = ["pgup" ""];
      page_down = ["pgdown" ""];
      create_new_file_panel = ["n" ""];
      close_file_panel = ["q" ""];
      next_file_panel = ["tab" ""];
      previous_file_panel = ["shift+tab" ""];
      toggle_file_preview_panel = ["f" ""];
      open_sort_options_menu = ["o" ""];
      toggle_reverse_sort = ["R" ""];
      focus_on_process_bar = ["ctrl+p" ""];
      focus_on_sidebar = ["ctrl+s" ""];
      focus_on_metadata = ["ctrl+d" ""];
      file_panel_item_create = ["a" ""];
      file_panel_item_rename = ["r" ""];
      copy_items = ["y" ""];
      cut_items = ["x" ""];
      paste_items = ["p" ""];
      delete_items = ["d" ""];
      extract_file = ["ctrl+e" ""];
      compress_file = ["ctrl+a" ""];
      open_file_with_editor = ["e" ""];
      open_current_directory_with_editor = ["E" ""];
      pinned_directory = ["P" ""];
      toggle_dot_file = ["." ""];
      change_panel_mode = ["m" ""];
      open_help_menu = ["?" ""];
      open_command_line = [":" ""];
      copy_path = ["Y" ""];
      copy_present_working_directory = ["c" ""];
      toggle_footer = ["ctrl+f" ""];
      confirm_typing = ["enter" ""];
      cancel_typing = ["esc" ""];
      parent_directory = ["-" ""];
      search_bar = ["/" ""];
      file_panel_select_mode_items_select_down = ["J" ""];
      file_panel_select_mode_items_select_up = ["K" ""];
      file_panel_select_all_items = ["A" ""];
    };
  };

  programs.pistol = {
    enable = true;
  };

  programs.tealdeer = {
    enable = true;
    enableAutoUpdates = true;
  };

  programs.newsboat = {
    enable = true;
    extraConfig = ''
    urls-source "miniflux"
    miniflux-url "https://miniflux.zed.gay"
    miniflux-login "me@zed.gay"
    miniflux-passwordeval "sh -c 'cat ${config.age.secrets.newsboat-password.path}'"
    '';
  };
}
