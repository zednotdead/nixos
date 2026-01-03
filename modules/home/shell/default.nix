{
  pkgs,
  lib,
  config,
  inputs,
  perSystem,
  ...
}:
let
  gitUser = {
    name = "Zuzanna Żołnierowicz";
    email = "zuzanna@zolnierowi.cz";
  };
in
{
  imports = [
    inputs.nix-index-database.homeModules.nix-index
  ];

  home.packages = with pkgs; [
    macchina
    hyfetch
    nix-search-cli
    kubectl
    krew
    viddy
    zellij
    kubectx
    lazyssh
    devenv
    perSystem.nix-auth.default
    megacmd
  ];

  programs = {
    nix-index-database.comma.enable = true;
    lazygit.enable = true;
    fzf.enable = true;
    mergiraf.enable = true;
    delta = {
      enable = true;
      enableGitIntegration = true;
    };
    git = {
      enable = true;
      package = pkgs.gitFull;
      settings.user = gitUser;
    };
    jujutsu = {
      enable = true;
      settings.user = gitUser;
    };
    nh = {
      enable = true;
      clean.enable = true;
      clean.extraArgs = "--keep-since 4d --keep 3";
      flake = "$HOME/nixos";
    };
    fd.enable = true;
    ripgrep.enable = true;
    btop.enable = true;
    chawan = {
      enable = true;
      settings = {
        buffer.images = true;
      };
    };

    nix-search-tv = {
      enable = true;
      enableTelevisionIntegration = true;
      settings = {
        render_docs_indexes = {
          nvf = "https://notashelf.github.io/nvf/options.html";
        };
      };
    };

    yazi = {
      enable = true;
      enableFishIntegration = true;
      enableNushellIntegration = true;
    };

    fish = {
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
        gaa = ''
          ${pkgs.git}/bin/git add --all
        '';
        tvnix = ''
          	  ${pkgs.television}/bin/tv nix-search-tv
          	'';
      };
      shellInit = ''
        set fish_greeting
        bind ctrl-h backward-kill-word
      '';
      interactiveShellInit = ''
        tv init fish | source
      '';
      plugins = with pkgs.fishPlugins; [
        {
          name = "bangbang";
          inherit (bang-bang) src;
        }
      ];
      shellAliases = {
        zel = "${pkgs.zellij}/bin/zellij";
        k = "${pkgs.kubectl}/bin/kubectl";
        spf = "${pkgs.superfile}/bin/superfile";
      };
    };

    zellij = {
      enable = true;
      settings = {
        theme = config.scheme.slug;
        show_startup_tips = false;
      };
      themes = {
        "${config.scheme.slug}" = with config.scheme.withHashtag; {
          themes = {
            "${config.scheme.slug}" = {
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

    pay-respects = {
      enable = true;
      enableFishIntegration = true;
      enableNushellIntegration = true;
    };

    starship = {
      enable = true;
      enableFishIntegration = true;
      enableNushellIntegration = true;
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
          "$nix_shell"
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

    mise = {
      enable = true;
      enableFishIntegration = true;
      enableNushellIntegration = true;
    };

    gh-dash.enable = true;
    gh = {
      enable = true;
      gitCredentialHelper.enable = true;
    };

    zoxide = {
      enable = true;
      enableFishIntegration = true;
      enableNushellIntegration = true;
    };

    television = {
      enable = true;
      enableFishIntegration = false;
    };

    k9s = {
      enable = true;
    };

    superfile = {
      enable = true;
      hotkeys = {
        confirm = [
          "enter"
          "right"
          "l"
        ];
        quit = [
          "q"
          "esc"
        ];

        # movement
        list_up = [
          "up"
          "k"
        ];
        list_down = [
          "down"
          "j"
        ];
        page_up = [
          "pgup"
          ""
        ];
        page_down = [
          "pgdown"
          ""
        ];

        # file panel control
        create_new_file_panel = [
          "n"
          ""
        ];
        close_file_panel = [
          "w"
          ""
        ];
        next_file_panel = [
          "tab"
          "L"
        ];
        previous_file_panel = [
          "shift+left"
          "H"
        ];
        toggle_file_preview_panel = [
          "f"
          ""
        ];
        open_sort_options_menu = [
          "o"
          ""
        ];
        toggle_reverse_sort = [
          "R"
          ""
        ];

        # change focus
        focus_on_process_bar = [
          "p"
          ""
        ];
        focus_on_sidebar = [
          "s"
          ""
        ];
        focus_on_metadata = [
          "m"
          ""
        ];

        # create file/directory and rename
        file_panel_item_create = [
          "ctrl+n"
          ""
        ];
        file_panel_item_rename = [
          "ctrl+r"
          ""
        ];

        # file operations
        copy_items = [
          "ctrl+c"
          ""
        ];
        cut_items = [
          "ctrl+x"
          ""
        ];
        paste_items = [
          "ctrl+v"
          "ctrl+w"
          ""
        ];
        delete_items = [
          "ctrl+d"
          "delete"
          ""
        ];

        # compress and extract
        extract_file = [
          "ctrl+e"
          ""
        ];
        compress_file = [
          "ctrl+a"
          ""
        ];

        # editor
        open_file_with_editor = [
          "e"
          ""
        ];
        open_current_directory_with_editor = [
          "E"
          ""
        ];

        # other
        pinned_directory = [
          "P"
          ""
        ];
        toggle_dot_file = [
          "."
          ""
        ];
        change_panel_mode = [
          "v"
          ""
        ];
        open_help_menu = [
          "?"
          ""
        ];
        open_command_line = [
          ":"
          ""
        ];
        open_spf_prompt = [
          ">"
          ""
        ];
        copy_path = [
          "ctrl+p"
          ""
        ];
        copy_present_working_directory = [
          "c"
          ""
        ];
        toggle_footer = [
          "F"
          ""
        ];

        # Typing hotkeys (can conflict with all hotkeys)
        confirm_typing = [
          "enter"
          ""
        ];
        cancel_typing = [
          "ctrl+c"
          "esc"
        ];

        # Normal mode hotkeys (can conflict with other modes cannot conflict with global hotkeys)
        parent_directory = [
          "h"
          "left"
          "backspace"
        ];
        search_bar = [
          "/"
          ""
        ];

        # Select mode hotkeys (can conflict with other modes cannot conflict with global hotkeys)
        file_panel_select_mode_items_select_down = [
          "shift+down"
          "J"
        ];
        file_panel_select_mode_items_select_up = [
          "shift+up"
          "K"
        ];
        file_panel_select_all_items = [
          "A"
          ""
        ];
      };
      settings = {
        theme = "oxocarbondark";
        editor = "${pkgs.neovim}/bin/neovim";
        dir_editor = "${pkgs.neovim}/bin/neovim";
        auto_check_update = false;
        cd_on_quit = false;
        default_file_open_preview = true;
        show_image_preview = true;
        show_panel_footer_info = true;
        file_size_use_si = true;
        default_directory = ".";
        default_sort_type = 0;
        sort_order_reversed = false;
        case_sensitive_sort = false;
        debug = false;
        ignore_missing_fields = true;

        code_previewer = "bat";
        nerdfont = true;
        transparent_background = false;
        file_preview_width = 0;
        sidebar_width = 20;

        border_top = "─";
        border_bottom = "─";
        border_left = "│";
        border_right = "│";
        border_top_left = "╭";
        border_top_right = "╮";
        border_bottom_left = "╰";
        border_bottom_right = "╯";
        border_middle_left = "├";
        border_middle_right = "┤";

        metadata = true;
        enable_md5_checksum = false;
        zoxide_support = true;
      };
      themes = {
        oxocarbondark = with config.scheme.withHashtag; {
          code_syntax_highlight = "oxocarbon-dark";
          file_panel_border = base03;
          sidebar_border = base03;
          footer_border = base03;
          file_panel_border_active = base0B;
          sidebar_border_active = base0B;
          footer_border_active = base0B;
          modal_border_active = base00;
          full_screen_bg = base00;
          file_panel_bg = base00;
          sidebar_bg = base00;
          footer_bg = base00;
          modal_bg = base00;
          full_screen_fg = base05;
          file_panel_fg = base05;
          sidebar_fg = base05;
          footer_fg = base05;
          modal_fg = base05;
          cursor = base06;
          correct = base0B;
          error = base08;
          hint = base0D;
          cancel = base09;
          gradient_color = [
            base0B
            base0E
          ];
          directory_icon_color = base0D;
          file_panel_top_directory_icon = base0B;
          file_panel_top_path = base0D;
          file_panel_item_selected_fg = base0B;
          file_panel_item_selected_bg = base00;
          sidebar_title = base0D;
          sidebar_item_selected_fg = base0B;
          sidebar_item_selected_bg = base00;
          sidebar_divider = base04;
          modal_cancel_fg = base02;
          modal_cancel_bg = base00;
          modal_confirm_fg = base02;
          modal_confirm_bg = base00;
          help_menu_hotkey = base00;
          help_menu_title = base05;
        };
      };
    };

    pistol.enable = true;

    tealdeer = {
      enable = pkgs.stdenv.isLinux;
      enableAutoUpdates = true;
    };

    newsboat = {
      enable = pkgs.stdenv.isLinux;
      extraConfig = ''
        urls-source "miniflux"
        miniflux-url "https://miniflux.zed.gay"
        miniflux-login "me@zed.gay"
        miniflux-passwordeval "sh -c 'cat ${config.age.secrets.newsboat-password.path}'"
      '';
    };

    nix-your-shell = {
      enable = true;
      enableFishIntegration = true;
      enableNushellIntegration = true;
    };

    direnv = {
      enable = true;
      enableNushellIntegration = true;
      silent = true;
    };

    nushell = {
      enable = true;
      configFile.source = ./config.nu;
      shellAliases = {
        zel = "${pkgs.zellij}/bin/zellij";
        k = "${pkgs.kubectl}/bin/kubectl";
        spf = "${pkgs.superfile}/bin/superfile";
        gpu = "${pkgs.git}/bin/git push";
        gpl = "${pkgs.git}/bin/git pull";
        gaa = "${pkgs.git}/bin/git add --all";
      };
    };

    carapace = {
      enable = true;
      enableNushellIntegration = true;
    };
  };

  services.gpg-agent = {
    enable = true;
    enableFishIntegration = true;
    enableNushellIntegration = true;
  };
}
