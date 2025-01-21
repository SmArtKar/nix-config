# git.nix

{ pkgs, inputs, lib, ... }:

# Git and Jujutsu VCSs imports

{
  programs.git = {
    enable = true;
    userName = "SmArtKar";
    userEmail = "master.of.bagets@gmail.com";
    
    extraConfig = {
      init.defaultBranch = "master";
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
