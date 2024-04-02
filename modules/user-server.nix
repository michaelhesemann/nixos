{ pkgs, ... }:

{
  # user conf
  users.users.server = {
    isNormalUser = true;
    description = "main user";
    initialPassword = "server";
    extraGroups = [ "wheel" ];
    openssh.authorizedKeys.keys = [ "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIE4OLzp+BiTyzXu0lP/6PIJjds3kZxqxp0U7j1AKFuwq" ];
  };

  users.users.root = {
    openssh.authorizedKeys.keys = [ "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIE4OLzp+BiTyzXu0lP/6PIJjds3kZxqxp0U7j1AKFuwq" ];
  };
}
