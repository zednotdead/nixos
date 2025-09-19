{...}: let
  leader = "<Space>";
in {
  programs.nixvim.keymaps = [
    {
      action.__raw = ''
        function()
          vim.cmd([[nohlsearch]])
        end
      '';
      key = "${leader}<Esc>";
      options.desc = "Clear screen";
    }
    {
      action.__raw = ''
        function()
          Snacks.lazygit()
        end
      '';
      key = "${leader}gg";
      options.desc = "Lazygit";
    }
    {
      action.__raw = ''
        function()
          Snacks.terminal.toggle("$SHELL", { auto_close = true, win = { position = "bottom" } })
        end
      '';
      key = "${leader}gt";
      options.desc = "Terminal";
    }
    {
      action.__raw = ''
        function()
          Snacks.picker.git_files({ untracked = true })
        end
      '';
      key = "${leader}fi";
      options.desc = "Find files";
    }
    {
      action.__raw = ''
        function()
          Snacks.picker.git_grep({ untracked = true })
        end
      '';
      key = "${leader}ff";
      options.desc = "Live grep";
    }
  ];
}
