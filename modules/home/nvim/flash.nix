{...}: {
  programs.nixvim.plugins.flash.enable = true;

  programs.nixvim.keymaps = [
    {
      action.__raw = ''
        function()
          require("flash").jump()
        end
      '';
      key = ";";
      mode = ["n" "o" "x"];
      options.desc = "Flash";
    }
    {
      action.__raw = ''
        function()
          require("flash").remote()
        end
      '';
      key = "r";
      mode = ["o"];
      options.desc = "Remote Flash";
    }
    {
      action.__raw = ''
        function()
          require("flash").treesitter_search()
        end
      '';
      key = "R";
      mode = ["o" "x"];
      options.desc = "Treesitter Search";
    }
    {
      action.__raw = ''
        function()
          require("flash").toggle()
        end
      '';
      key = "<c-s>";
      mode = ["c"];
      options.desc = "Toggle Flash Search";
    }
  ];
}
