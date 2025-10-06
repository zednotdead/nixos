{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    bottles
    protonup-qt
    protontricks
  ];
}
