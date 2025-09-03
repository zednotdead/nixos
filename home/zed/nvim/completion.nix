{...}: {
  programs.nixvim.plugins.blink-cmp = {
    enable = true;
    settings = {
      keymap = {
        preset = "super-tab";
        "<C-.>" = ["snippet_forward"];
        "<C-,>" = ["snippet_backward"];
      };
      appearance.nerd_font_variant = "normal";
      completion = {
        list = {
          selection.preselect = true;
          selection.auto_insert = false;
        };
        documentation.auto_show = false;
        menu.draw.treesitter = ["lsp"];
        menu.draw.columns.__raw = ''
          {
            { "label", "label_description", gap = 1 },
            { "kind_icon", "kind" },
          }
        '';
      };
      sources = {
        default = [
          "lazydev"
          "lsp"
          "path"
          "snippets"
          "buffer"
        ];
        providers.lazydev = {
          name = "LazyDev";
          module = "lazydev.integrations.blink";
          score_offset = 100;
        };
      };
    };
  };

  programs.nixvim.plugins.cmp = {
    enable = true;
    autoEnableSources = true;
  };
}
