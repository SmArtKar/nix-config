# git.nix

{ pkgs, inputs, lib, ... }:

# Git and Jujutsu VCSs imports

{
  home.packages = with pkgs; [
    git-credential-manager
  ];

  programs.git = {
    enable = true;
    userName = "SmArtKar";
    userEmail = "master.of.bagets@gmail.com";
    
    extraConfig = {
      init.defaultBranch = "master";
    };
    
    extraConfig = {
      credential = {
        helper = "manager store";
        "https://github.com".username = "SmArtKar";
        credentialStore = "cache";
      };
    };
  };

  programs.jujutsu = {
    enable = true;
    settings = {
      user.name = "SmArtKar";
      user.email = "master.of.bagets@gmail.com";
    };
  };
}
