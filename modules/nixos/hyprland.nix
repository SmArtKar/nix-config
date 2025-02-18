# hyprland.nix

{ pkgs, inputs, lib, ... }:

# Non-HM part of Hyprland setup

{
  services.xserver.displayManager.gdm = {
    enable = true;
    wayland = true;
  };

  xdg.portal = {
    enable = true;
    xdgOpenUsePortal = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
    config = {
      common.default = ["gtk"];
      hyprland.default = ["gtk" "hyprland"];
    };
  };
  
  # Hyprland package needs to be enabled in config for mandatory components, actual config is done via home
  programs.hyprland.enable = true;
  programs.hyprland.package = inputs.hyprland.packages."${pkgs.system}".hyprland;
  #services.displayManager.defaultSession = "hyprland";
}
