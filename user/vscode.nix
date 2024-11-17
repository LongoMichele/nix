{ config, lib, pkgs, userSettings, ... }:
{
  programs.vscode = {
    enable = true;
    package = pkgs.vscode.fhs;
    enableUpdateCheck = false;
    enableExtensionUpdateCheck = false;
    mutableExtensionsDir = true;

    extensions = (with pkgs.vscode-extensions; [
      pkief.material-icon-theme
      mhutchie.git-graph
      jnoortheen.nix-ide
      zhuangtongfa.material-theme
      eamodio.gitlens
      alefragnani.project-manager
      aaron-bond.better-comments
      editorconfig.editorconfig
      usernamehw.errorlens
      dbaeumer.vscode-eslint
      esbenp.prettier-vscode

      # ========== Manual installation Required ============ #
      # The following extensions are not in pkgs.X
      # They will need to be installed manually
      # ==================================================== #
      # exodiusstudios.comment-anchors
      # rvest.vs-code-prettier-eslint
      # killalau.vscode-liquid-snippets
      # shopify.theme-check-vscode
      # sissel.shopify-liquid
    ]);

    userSettings = {
      "git.autofetch" = true;
   
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
        formatOnSave = true;
      };

      "[liquid]" = {
        "editor.defaultFormatter" = "Shopify.theme-check-vscode";
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
      {
        key = "shift+alt+f";
        command = "editor.action.formatDocument";
        when = "editorHasDocumentFormattingProvider && editorTextFocus && !editorReadonly && !inCompositeEditor";
      }
    ];
  };
}
