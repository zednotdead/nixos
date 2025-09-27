{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    pkgs.librewolf
  ];
}
