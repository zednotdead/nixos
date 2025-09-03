let
  zed = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIHPDS0RMrfWeAyKBgN0XCQh7NEEMZc2j14h7hL5NJ9Kp";
  system = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFxfoVyqwApxu1n8StoUFrJEn8zxPTNT8V1AFSMim2/h";
in {
  "secrets/newsboat.age".publicKeys = [zed system];
  "secrets/restic.age".publicKeys = [zed system];
  "secrets/restic-password.age".publicKeys = [zed system];
  "secrets/zed-password.age".publicKeys = [zed system];
}
