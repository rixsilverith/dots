" URL: http://vim.wikia.com/wiki/Example_vimrc
" ------------------------------------------------
" The following options and commands enable some very useful features in Vim,
" that no user should have to live without.

" Attempt to determine the type of a file based on its name and possibly its
" contents. This allows intelligent auto-indenting for each filetype, and for
" plugins that are filetype specific.
filetype indent plugin on

" Set 'nocompatible' to ward off unexpected things that your distro might have
" made aswell as sanely reset options when re-sourcing .vimrc
set nocompatible

" Set encoding to 'UTF-8'.
set encoding=utf8

" Enable syntax highlighting.
syntax on

" The 'hidden' option allows one to re-use the same window and switch from an
" unsaved buffer without saving it first. Also allows one to keep an undo
" history for multiple files when re-using the same window in this way. Note
" that using persistent undo also lets you undo in multiple files even in the
" same window, but is less efficient and is actually designed for keeping undo
" history after closing Vim entirely. Vim will complain if you try to quit
" without saving, and swap files will keep you safe if your computer crashes.
set hidden
" Alternatives to 'hidden' include:
" set confirm
" set autowriteall

" Better command-line completion.
set wildmenu

" Allow backspacing over autoindent, line breaks and start of insert action.
set backspace=indent,eol,start

" When opening a new line and no filetype-specific indenting is enabled, keep
" the same indent as the line you're currently on.
set autoindent

" Stop certain movements from always going to the first character of a line.
" set nostartline

" Display the cursor position on the last line of the screen or in the status
" line of a window.
set ruler

" Always display the status line, even if only one window is displayed.
set laststatus=2

" Instead of failing a command because of unsaved changes, raise a dialogue
" asking if you wish to save changed files.
set confirm

" Enable the use of the mouse for all modes.
set mouse=a

" Set the command window height to 2 lines, to avoid many cases of having to
" press <Enter> to continue.
" set cmdheight=2

" Display line numbers on the left.
set number

" Display relative line numbers on the left, instead of absolute numbers.
" set relativenumber

" Quickly time out on keycodes, but never time out on mappings.
set notimeout ttimeout ttimeoutlen=200

" Use <F11> to toggle between 'paste' and 'nopaste'.
set pastetoggle=<F11>

" Use 4 spaces instead of tabs for indentation. With this setup, 'tabstop'
" should not be changed from its default value.
set shiftwidth=4
set shiftround
set softtabstop=4
set expandtab

set visualbell
set showcmd

" set wrap
" set colorcolumn=80

" set incsearch
" set showmatch

" Highlight searches. (This can be toggled by using <C-L>).
set hlsearch

" Use case insensitive search, except when using capital letters.
set ignorecase
set smartcase

" Modelines have historically been a source of security vulnerabilities. As
" such, it may be a good idea to disable them and use the securemodelines
" script, <http://www.vim.org/scripts/script.php?script_id=1876>.
" set nomodeline

set autoread

if has('nvim')
    set inccommand="nosplit"
endif

" ------------------------------------------------------------
" Mappings
" ------------------------------------------------------------
let mapleader = ","
noremap <leader>w :w<cr>
noremap <leader>wq :wq<cr>
noremap <leader>vc :VimtexCompile
noremap <leader>gs :CoCSearch
noremap <leader>fs :Files<cr>
noremap <leader><cr> <cr><c-w>h:q<cr>

" ------------------------------------------------------------
" This next section is about plugin settings, commands and scripts that may be
" useful in one way or another. To install a plugin, write:
" Plug 'author/repo', where `repo` is the name of the repository in GitHub and 
" `author` is the name of the user owning that repo. Then, go to command mode
" and run :PlugInstall
" ------------------------------------------------------------

" Autoinstall 'vim-plug' if it's not installed yet.
if has('nvim')
    if empty(glob('~/.config/nvim/autoload/plug.vim'))
        silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
            \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
        autocmd VimEnter * PlugInstall
    endif
else
    if empty(glob('~/.vim/autoload/plug.vim'))
        silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
            \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
        autocmd VimEnter * PlugInstall
    endif
endif

if has('nvim')
    call plug#begin('~/.config/nvim/plug.vim')
else
    call plug#begin('~/.vim/plug.vim')
endif
" Use ':Files' to look for a file to open.
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
" Add JavaScript support.
Plug 'pangloss/vim-javascript'
" Add TypeScript support.
Plug 'leafgarland/typescript-vim'
" Use IntelliJ.
" Plug 'neoclide/coc.nvim', { 'branch' : 'release' }
" Some decorations for the bottom status bar.
Plug 'vim-airline/vim-airline'

Plug 'tpope/vim-surround'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-unimpaired'
" Plug 'scrooloose/nerdtree', { 'on' : 'NERDTreeToggle' }

" Plug 'rafi/awesome-vim-colorschemes'
" Plug 'dylanaraps/wal'

Plug 'sirver/ultisnips'
    let g:UltiSnipsExpandTrigger = '<tab>'
    let g:UltiSnipsJumpForwardTrigger = '<tab>'
    let g:UltiSnipsJumpBackwardTrigger = '<s-tab>'

Plug 'lervag/vimtex'
    let g:tex_flavor='latex'
    let g:vimtex_view_method='zathura'
    let g:vimtex_quickfix_mode=1
    let g:vimtex_view_forward_search_on_start=0
    if has('nvim')
        let g:vimtex_compiler_progname='nvr'
    endif

Plug 'KeitaNakamura/tex-conceal.vim'
    set conceallevel=0
    let g:tex_conceal='abdmg'
    hi Conceal ctermbg=none

Plug 'arcticicestudio/nord-vim'
call plug#end()

let g:coc_global_extensions = [ 'coc-tsserver' ]
let g:airline_powerline_fonts = 1

nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
:imap ii <Esc>

" Check spelling.
" setlocal spell
" set spelllang=en_gb
" inoremap <C-l> <c-g>u<Esc>[s1z=`]a<c-g>u

" set guifont=Sauce\ Code\ Pro\ Medium\ Nerd\ Font\ Complete\ Mono\ 12 
colorscheme nord
set background=dark
" let g:onedark_termcolors=16
" colorscheme flattened_dark


