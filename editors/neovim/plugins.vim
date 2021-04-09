" Autoinstall 'vim-plug' if it's not installed yet
if empty(glob('~/.config/nvim/autoload/plug.vim'))
    silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall
endif

call plug#begin('~/.config/nvim/plugged')
    " Comment code
    Plug 'tpope/vim-commentary'

    if exists('g:vscode')
        " Easy motion for VS Code
        Plug 'asvetliakov/vim-easymotion'
    else
        " Plug 'sheerun/vim-polyglot' " Syntax support for multiple languages
        " Plug 'scrooloose/NERDTree' " File explorer
        Plug 'ryanoasis/vim-devicons' " Cute icons
        " Plug 'neoclide/coc.nvim', {'branch': 'release'} " Intellisense
        Plug 'vim-airline/vim-airline' " Airline bar
        Plug 'vim-airline/vim-airline-themes' " Airline themes
        " Plug 'Yggdroot/indentLine' " Indent guides
        Plug 'mhinz/vim-signify' " Git integration
        Plug 'editorconfig/editorconfig-vim'
        " Plug 'alvan/vim-closetag' " Autoclose tags
        "Plug 'kevinhwang91/rnvimr', { 'do': 'make sync' } " Ranger
        " Fzf
        Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
        Plug 'junegunn/fzf.vim'
        " Plug 'airblade/vim-rooter'
        " Prettier
        "Plug 'prettier/vim-prettier', { 'do': 'yarn install' }
        " Snippets
        "Plug 'sirver/ultisnips'
        "    let g:UltiSnipsExpandTrigger='<tab>'
         "   let g:UltiSnipsJumpForwardTrigger='<tab>'
         "   let g:UltiSnipsJumpBackwardTrigger='<tab>'

        " LaTeX
        Plug 'lervag/vimtex'
            let g:tex_flavor='latex'
            let g:vimtex_view_method='zathura'
            let g:vimtex_quickfix_mode=1
            let g:vimtex_view_forward_search_on_start=0
            let g:vimtex_compiler_progname='nvr'

        Plug 'KeitaNakamura/tex-conceal.vim'
            set conceallevel=0
            let g:tex_conceal='abdmg'
            hi Conceal ctermbg=none
        " Themes
        Plug 'joshdick/onedark.vim'
        Plug 'kaicataldo/material.vim'
        Plug 'tomasiser/vim-code-dark'
        Plug 'ayu-theme/ayu-vim'
        Plug 'dracula/vim', { 'as': 'dracula' }
        Plug 'arcticicestudio/nord-vim'
    endif
call plug#end()
