{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    librewolf-unwrapped
  ];
}
