{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    # `lib.hiPrio` is used to avoid potential conflict with `coreutils-full`
    (lib.hiPrio pkgs.uutils-coreutils-noprefix)
  ];
}
