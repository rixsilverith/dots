set number " Display line numbers on the left. Use number relativenumber for relative numbers.

" set colorcolumn=81
set laststatus=2
" When opening a new line and no filetype-specific indenting is enabled, keep
" the same indent as the line you're currently on.
set autoindent
set smartindent

" Use 4 spaces instead of tabs for indentation. When this is enabled, 'tabstop'
" should not be changed from its default value.
set shiftwidth=4
set softtabstop=4
set shiftround
set expandtab
set smarttab
" set tabstop=4
" set showtabline=4

" The 'hidden' option allows one to reuse the same window and switch from an
" unsaved buffer without saving it first. Also allows keeping an undo history
" for multiple files when re-using the same window this way. Note that
" persistent undo also lets you undo multiple files even in the same window,
" but it is less efficient and is actually designed for keeping undo history
" after closing NeoVim entirely. NeoVim will complain if you try to quit
" without saving, and swap files will keep you safe if your computer crashes.
set hidden
" Allow backspacing over autoindent, line breaks and start of insert action.
set backspace=indent,eol,start

set showcmd
set nowrap

" Highlight searches (this behaviour can be toggled by using <C-L>)
set hlsearch

" Display the cursor position on the last line of the screen or in the status
" line of a window.
set ruler
" Enable the use of mouse for all modes.
set mouse=a
" set cursorline
set splitbelow
set splitright

" Use case-insensitive search, except when using capital letters.
set ignorecase
set smartcase

set clipboard=unnamedplus

set background=dark
set autochdir

set autoread

" Attempt to determine the type of a file based on its name and posibly its
" contents. This allows intelligent auto-indenting for each filetype, and for
" plugins that are filetype specific.
filetype indent plugin on
" Set encoding to UTF-8.
set encoding=utf-8
set fileencoding=utf-8
" Enable syntax highlighting.
syntax on
