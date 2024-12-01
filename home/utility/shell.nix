{ config, lib, pkgs, ... }:
let
  aliases = {
    # Utility
    ".." = "cd ..";
    c = "clear &&";
    cc = "clear";
    la = "ls -oAFgh";
    cla = "clear && ls -oAFgh";

    # Git
    gstash = "git add . && git stash";
    gpull = "git pull";
    gcheck = "git checkout";
    gadd = "git add .";
    gcommit = "git commit";
    gmerge = "git merge";
    gpush = "git push";
    gmaster = "git checkout master";
    gmain = "git checkout main";
    gdev = "git checkout develop";

    # Shopify
    spull = "shopify theme pull";
    spush = "shopify theme push";
    sdev = "shopify theme dev";
  };
in {
  programs.bash = {
    enable = lib.mkDefault false;
    shellAliases = aliases;
  };

  programs.zsh = {
    enable = true;
    shellAliases = aliases;
  };
}
