{ lib, pkgs, flakeRoot, ... }:
let
  aliases = {
    # Utility
    ".." = "cd ..";
    c = "clear &&";
    cc = "clear";
    la = "ls -oAFgh";
    cla = "clear && ls -oAFgh";

    # Git
    gstatus = "git status";
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
  programs = {
    bash = {
      enable = lib.mkDefault false;
      shellAliases = aliases;
    };

    zsh = {
      enable = true;
      shellAliases = aliases;
      plugins = [
        {
          name = "powerlevel10k-config";
          src = ./p10k;
          file = "p10k.zsh";
        }
        {
          name = "zsh-powerlevel10k";
          src = "${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/";
          file = "powerlevel10k.zsh-theme";
        }
      ];
      initExtra = "source ${flakeRoot}/home/utility/shell/p10k";
    };
  };
}
