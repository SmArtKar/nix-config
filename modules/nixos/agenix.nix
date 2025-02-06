# agenix.nix

{ pkgs, inputs, system, config, lib, ... }:

# Agenix secrets management

{
  imports = [
    inputs.agenix.nixosModules.default
  ];

  environment.systemPackages = [ 
    inputs.agenix.packages."${system}".default
  ];

  age.identityPaths = [
    "/etc/ssh/ssh_host_ed25519_key"
  ];
}
