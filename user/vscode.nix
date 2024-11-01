{ config, lib, pkgs, userSettings, ... }:
{
  programs.vscode = {
    enable = true;
    package = pkgs.vscode.fhs;
    enableUpdateCheck = false;
    enableExtensionUpdateCheck = false;
    mutableExtensionsDir = false;

   
    extensions = (with pkgs.vscode-extensions; [
      pkief.material-icon-theme
      mhutchie.git-graph
      jnoortheen.nix-ide
    ]);

    userSettings = {
      workbench = {
        iconTheme = "material-icon-theme";
        sideBar.location = "right";
      };

      editor = {
        semanticHighlighting.enabled = false;
        minimap.enabled = false;
      };
    };

    keybindings = [
      {
        key = "ctrl+ò";
        command = "workbench.action.terminal.toggleTerminal";
      }
    ];
  };
}
