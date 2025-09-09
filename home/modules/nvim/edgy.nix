{...}: {
  programs.nixvim.plugins.edgy = {
    enable = true;
    settings = {
      wo.winhighlight = "";
      options = {
        left.size = 30;
        bottom.size = 10;
        right.size = 40;
        top.size = 10;
      };
      bottom = [
        {
          ft = "snacks_terminal";
          filter.__raw = ''
            function(_, win) return vim.api.nvim_win_get_config(win).relative == "" end
          '';
          wo.winhighlight = "";
        }
        {
          ft = "trouble";
          wo.winhighlight = "";
        }
        {
          ft = "qf";
          title = "QuickFix";
        }
        {
          ft = "help";
          size = 20;
          filter.__raw = ''
            function(buf) return vim.bo[buf].buftype == "help" end
          '';
        }
      ];
      left = [
        {
          title = "Neo-tree";
          ft = "neo-tree";
          pinned = true;
          open = "Neotree position=left action=open";
        }
      ];
    };
  };
}
