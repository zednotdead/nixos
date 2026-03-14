{pkgs,...}: {
  programs.tmux = {
    enable = true;
    newSession = true;
    keyMode = "vi";
    customPaneNavigationAndResize = true;
    sensibleOnTop = true;
    plugins = with pkgs.tmuxPlugins; [
      tmux-floax
    ];
  };
}
