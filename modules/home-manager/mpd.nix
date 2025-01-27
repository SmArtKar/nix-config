# mpd.nix

{ pkgs, inputs, lib, ... }:

# Music player daemon and controller

{
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

