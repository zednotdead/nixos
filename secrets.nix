let
  zed = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIHPDS0RMrfWeAyKBgN0XCQh7NEEMZc2j14h7hL5NJ9Kp zed@panoramix";
in {
  "secrets/newsboat.age".publicKeys = [zed];
  "secrets/restic.age".publicKeys = [zed];
  "secrets/restic-password.age".publicKeys = [zed];
}
