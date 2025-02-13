# tor.nix

{ pkgs, inputs, lib, ... }:

# Tor browser

{
  environment.systemPackages = with pkgs; [
    tor-browser-bundle-bin
    qbittorrent
    qbittorrent-cli
  ];

  services.tor = {
    client.enable = true;
    settings = {
      UseBridges = true;
      ClientTransportPlugin = "obfs4 exec ${pkgs.obfs4}/bin/lyrebird";
      Bridge = "obfs4 IP:ORPort [fingerprint]";
    };
  };
}
