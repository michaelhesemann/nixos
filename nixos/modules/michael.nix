{ pkgs, ... }:

{
  # user conf
  users.users.michael = {
    isNormalUser = true;
    description = "main user";
    initialPassword = "michael";
    extraGroups = [ "networkmanager" "wheel" ];
    openssh.authorizedKeys.keys = [ "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIE4OLzp+BiTyzXu0lP/6PIJjds3kZxqxp0U7j1AKFuwq" ];
    packages = with pkgs; [
      firefox
      librewolf
      thunderbird
      kate
      libreoffice
    ];
  };

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

  programs.git = {
    enable = true;
    config = {
      init = {
        defaultBranch = "main";
      };

      user = {
        name = "Michael Hesemann";
        email = "michael@mhesemann.de";
      };

      core = {
        editor = "nvim";
      };
    };
  };
}
