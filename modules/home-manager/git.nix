# git.nix

{ pkgs, inputs, lib, ... }:

# Git and Jujutsu VCSs imports

{
  programs.git = {
    enable = true;
    userName = "SmArtKar";
    userEmail = "master.of.bagets@gmail.com";

    defaultBranch = "master";
  };

  programs.jujutsu = {
    enable = true;
  };
}
