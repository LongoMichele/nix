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
      zhuangtongfa.material-theme
      eamodio.gitlens
      alefragnani.project-manager
      aaron-bond.better-comments
      # exodiusstudios.comment-anchors
      editorconfig.editorconfig
      usernamehw.errorlens
      dbaeumer.vscode-eslint
      esbenp.prettier-vscode
      # rvest.vs-code-prettier-eslint
    ]);

    userSettings = {
      workbench = {
        iconTheme = "material-icon-theme";
        colorTheme = "One Dark Pro Darker";
        sideBar.location = "right";
        startupEditor = "none";
      };

      editor = {
        semanticHighlighting.enabled = false;
        minimap.enabled = false;
        renderWhitespace = "all";
        fontFamily = "Fira Code";
        fontLigatures = true;
      };
    };

    keybindings = [
      {
        key = "ctrl+[Semicolon]";
        command = "workbench.action.terminal.toggleTerminal";
      }
      {
        key = "shift+alt+down";
        command = "editor.action.copyLinesDownAction";
        when = "editorTextFocus && !editorReadonly";
      }
      {
        key = "shift+alt+up";
        command = "editor.action.copyLinesUpAction";
        when = "editorTextFocus && !editorReadonly";
      }
      {
        key = "ctrl+7";
        command = "editor.action.commentLine";
        when = "editorTextFocus && !editorReadonly";
      }
    ];
  };
}
