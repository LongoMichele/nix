{ pkgs, ... }:
let
  toLua = str: "lua << EOF\n${str}\nEOF\n";
  toLuaFile = file: "lua << EOF\n${builtins.readFile file}\nEOF\n";
in {
  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
    defaultEditor = true;
    extraLuaConfig = ''
      vim.cmd("set number")
      vim.cmd("set expandtab")
      vim.cmd("set tabstop=2")
      vim.cmd("set softtabstop=2")
      vim.cmd("set shiftwidth=2")

      vim.g.mapleader = "\\"

      vim.opt.termguicolors = true
      vim.cmd [[
        highlight Normal guibg=none
        highlight NonText guibg=none
        highlight LineNr guibg=none
        highlight SignColumn guibg=none
        highlight EndOfBuffer guibg=none
      ]]
    '';
    plugins = with pkgs.vimPlugins; [
      {
        plugin = onedark-nvim;
        config = "colorscheme onedark";
      }
      {
        plugin = telescope-nvim;
        config = toLuaFile ./plugins/telescope.lua;
      }
      {
        plugin = (nvim-treesitter.withPlugins (p: [
          p.tree-sitter-nix
          p.tree-sitter-vim
          p.tree-sitter-bash
          p.tree-sitter-lua
          p.tree-sitter-json
        ]));
        config = toLuaFile ./plugins/treesitter.lua;
      }
      {
        plugin = neo-tree-nvim;
        config = toLuaFile ./plugins/neotree.lua;
      }
      nvim-web-devicons
      {
        plugin = lualine-nvim;
        config = toLuaFile ./plugins/lualine.lua;
      }

      neodev-nvim
      nvim-cmp
      cmp-nvim-lsp
      telescope-ui-select-nvim
      {
        plugin = nvim-lspconfig;
        config = toLuaFile ./plugins/lsp.lua;
      }

      {
        plugin = none-ls-nvim;
        config = toLuaFile ./plugins/nonels.lua;
      }
    ];
    extraPackages = with pkgs; [
      ripgrep

      # LSP
      lua-language-server
      nil
      statix
      nixpkgs-fmt

      # none-ls
      stylua
      nodePackages.prettier
      nodePackages.eslint
      nodePackages.typescript-language-server
    ];
  };
}
