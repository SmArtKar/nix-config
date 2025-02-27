# configuration.nix

{ config, pkgs, lib, inputs, ... }:

let
  username = "smartkar";
  userDescription = "SmArtKar";
  userDir = "/home/${username}";
  hostName = "SmArtKar-Ruby";
  timeZone = "Europe/Budapest";
in {
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./../../modules/nixos/hyprland.nix
      ./../../modules/nixos/stylix.nix
      ./../../modules/nixos/agenix.nix
      ./../../modules/nixos/vial.nix
      ./../../modules/nixos/tor.nix
      ./../../modules/nixos/gaming.nix
    ];

  nix.nixPath = [ "nixpkgs=${inputs.nixpkgs}" ];

  nix.daemonIOSchedClass = lib.mkDefault "idle";
  nix.daemonCPUSchedPolicy = lib.mkDefault "idle";
  nix.settings.max-jobs = 16;
  services.hercules-ci-agent = {
    settings.concurrentTasks = 4;
  };
  # put the service in top-level slice
  # so that it's lower than system and user slice overall
  # instead of only being lower in system slice
  systemd.services.nix-daemon.serviceConfig.Slice = "-.slice";

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Set your time zone.
  time.timeZone = timeZone;

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_GB.UTF-8";
    LC_IDENTIFICATION = "en_GB.UTF-8";
    LC_MEASUREMENT = "en_GB.UTF-8";
    LC_MONETARY = "en_GB.UTF-8";
    LC_NAME = "en_GB.UTF-8";
    LC_NUMERIC = "en_GB.UTF-8";
    LC_PAPER = "en_GB.UTF-8";
    LC_TELEPHONE = "en_GB.UTF-8";
    LC_TIME = "en_GB.UTF-8";
  };

  # Enable the X11 windowing system.
  services.xserver.enable = true;
 
  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  services.xserver.videoDrivers = [ "modesetting" ];
  services.xserver.deviceSection = ''
    Option "DRI" "2"
    Option "TearFree" "true"
  '';

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  security.polkit.enable = true;
  security.pam.services.swaylock = {};
  security.pam.services.hyprlock = {};
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
    #media-session.enable = true;
  };

  # Enable touchpad support.
  services.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users."${username}" = {
    isNormalUser = true;
    description = userDescription;
    home = userDir;
    extraGroups = [ "networkmanager" "wheel" "libvirtd" ];
    packages = with pkgs; [
      firefox
      # thunderbird
    ];
    shell = pkgs.nushell;
  };

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  # List packages installed in system profile.
  environment.systemPackages = with pkgs; [

  ];

  # Some programs need SUID wrappers, can be configured further or are started in user sessions.
  programs.mtr.enable = true;
  /*
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };
  */

  # Enable bluetooth and bluetooth controls
  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;
  services.blueman.enable = true;

  networking = {
    hostName = hostName;
    networkmanager.enable = true;
    firewall = {
      allowedTCPPortRanges = [
        {
          from = 8060;
          to = 8090;
        }
        {
          from = 1714; 
          to = 1764;
        }
      ];
      allowedUDPPortRanges = [
        {
          from = 8060;
          to = 8090;
        }
        {
          from = 1714; 
          to = 1764;
        }
      ];
    };
  };

  hardware.graphics = {
    enable = true;
    extraPackages = with pkgs; [
      vpl-gpu-rt
      intel-media-driver
      intel-vaapi-driver
      libvdpau-va-gl
      vaapiIntel
      vaapiVdpau
      intel-ocl
      intel-compute-runtime
    ];
  };

  # List services that you want to enable:
  # Enable the OpenSSH daemon.
  services.openssh = {
    enable = true;
    settings = {
      AllowUsers = null;
      UseDns = true;
      X11Forwarding = true;
      PermitRootLogin = "no";
    };
    hostKeys = [
      {
        bits = 4096;
        path = "/etc/ssh/ssh_host_rsa_key";
        type = "rsa";
      }
      {
        path = "/etc/ssh/ssh_host_ed25519_key";
        type = "ed25519";
      }
    ];
  };
  programs.ssh.startAgent = true;

  services.flatpak.enable = true;
  nixpkgs.config.allowUnfree = true;
  services.gvfs.enable = true;

  home-manager = {
    extraSpecialArgs = { inherit inputs; };
    users = {
      smartkar = import ./home.nix;
    };
  };

  system.stateVersion = "24.11";

  environment.sessionVariables = {
    LIBVA_DRIVER_NAME = "iHD";
  };

  # Automatic updating
  system.autoUpgrade = {
    enable = true;
    dates = "weekly";
  };

  # Automatic cleanup
  nix.settings.auto-optimise-store = true;
  programs.nh = {
    enable = true;
    clean.enable = true;
    clean.extraArgs = "--keep-since 3d --keep 3";
    flake = "/etc/nixos";
  };

  environment.sessionVariables = {
    FLAKE = "/etc/nixos";
    NIX_REMOTE = "daemon";
  };
}
