# media.nix

{ pkgs, inputs, lib, ... }:

# Media daemons and controllers

{
  home.packages = with pkgs; [
    # Audio controls
    pavucontrol
    playerctl
    pulsemixer
    # Image viewer
    imv
    # GPU readout
    nvtopPackages.full
    # Video tools
    libva-utils
    vdpauinfo
    vulkan-tools
    glxinfo
  ];

  services.mpd = {
    enable = true;
    musicDirectory = "~/Music";
    extraConfig = ''
      audio_output {
        type "pulse"
        name "PulseAudio"
      }
    '';
  };
}

