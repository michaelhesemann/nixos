{ config, lib, pkgs, ... }:

{
  imports = [
    <nixos-wsl/modules>
    ../../modules/docker.nix
  ];

  wsl.enable = true;
  wsl.defaultUser = "nixos";
  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  environment.systemPackages = with pkgs; [
    git
    btop
    htop
  ];

  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    defaultEditor = true;
    configure = {
      customRC = ''
        set number
        set backspace=indent,eol,start
        set mouse=
        set relativenumber
        set tabstop=4
        set softtabstop=4
        set shiftwidth=4
        set expandtab
        set smartindent
        set nowrap
        set noswapfile
        set nobackup
        set undofile
        set undodir=~/.config/nvim/undodir
        set nohlsearch
        set incsearch
        set scrolloff=8
        set updatetime=50
        set colorcolumn=80

        let g:mapleader = " "
        let g:netrw_browse_split = 0
        let g:netrw_banner = 0
        let g:netrw_browse_split = 0

        nnoremap <leader>pv :Ex<CR>
        nnoremap <leader>k :cnext<CR>zz
        nnoremap <leader>j :cprev<CR>zz

        nnoremap <C-d> <C-d>zz
        nnoremap <C-u> <C-u>zz
        nnoremap n nzzzv
        nnoremap N Nzzzv

        nnoremap <leader>x :execute 'silent !chmod +x %'<CR> | redraw!
        nnoremap <leader>s :%s/<C-r><C-w>/<C-r><C-w>/gI<Left><Left><Left>
        nnoremap <leader>u :UndotreeToggle<CR>:UndotreeFocus<CR>

        lua << ENDOFLUA
        local mark = require("harpoon.mark")
        local ui = require("harpoon.ui")

        vim.keymap.set("n", "<leader>a", mark.add_file)
        vim.keymap.set("n", "<C-e>", ui.toggle_quick_menu)
        vim.keymap.set("n", "<C-h>", function() ui.nav_file(1) end)
        vim.keymap.set("n", "<C-j>", function() ui.nav_file(2) end)
        vim.keymap.set("n", "<C-k>", function() ui.nav_file(3) end)
        vim.keymap.set("n", "<C-l>", function() ui.nav_file(4) end)
        ENDOFLUA
      '';

      packages.myVimPackage = with pkgs.vimPlugins; {
        start = [ undotree vim-nix harpoon plenary-nvim which-key-nvim vim-peekaboo vim-surround vim-repeat ];
      };
    };
  };

  system.stateVersion = "23.11";
}