# vial.nix

{ pkgs, inputs, lib, ... }:

# Vial QMK flasher. Cannot be done via HM as it needs udev

{
  environment.systemPackages = with pkgs; [
    vial
  ];

  services.udev = {
    packages = with pkgs; [
      qmk
      qmk-udev-rules 
      qmk_hid
      vial
    ];
    
    extraRules = ''
      KERNEL=="hidraw*", SUBSYSTEM=="hidraw", ATTRS{idVendor}=="e126", ATTRS{idProduct}=="0070", MODE="0660", GROUP="users", TAG+="uaccess", TAG+="udev-acl"
    '';
  };
}
