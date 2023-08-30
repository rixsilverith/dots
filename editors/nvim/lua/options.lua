local opt = vim.opt
local g = vim.g

-- See :h <option> for information about an specific option

-- Help force plugins to load correctly
vim.cmd[[
filetype off
filetype plugin indent on
]]

opt.guicursor = ""

opt.syntax = 'on' -- Enable syntax highlighting

opt.number = true
opt.relativenumber = true -- Show relative line numbers

opt.ruler = true -- Display cursor position in the status line
opt.mouse = 'a' -- Enable mouse usage for all modes

opt.hlsearch = true -- Highlight matching search patterns (can be toggled with <C-L>)
opt.incsearch = true -- Enable incremental search
opt.ignorecase = true -- Use case-insensitive search,
opt.smartcase = true -- except when using uppercase letters

opt.splitbelow = true -- Split new pane below
opt.splitright = true -- Split new pane to the right

opt.laststatus = 2 -- Always show status line

-- When opening a new line and no filetype-specific indenting is enabled, keep the
-- same indent as the current line
-- opt.autoindent = true
opt.smartindent = true

opt.tabstop = 4
opt.softtabstop = 4
opt.shiftwidth = 4
-- opt.shiftround = true
opt.expandtab = true
-- opt.smarttab = true

-- opt.textwidth = 95
opt.wrap = false -- Automatically wrap text that extends beyond the screen length

opt.swapfile = true
opt.backup = false
opt.undodir = os.getenv("XDG_CONFIG_HOME") .. "nvim/.undodir"
opt.undofile = true

opt.formatoptions = 'tcqrn1' -- Automatic formatting. See :h fo-table

-- Allow backspacing over autoindent, line breaks and start of insert action
-- This fixes common backspace problems
opt.backspace = 'indent,eol,start'

opt.clipboard = 'unnamedplus' -- Use system clipboard
opt.autochdir = true -- Automatically change directory to where the current file is located
opt.scrolloff = 5 -- Display 5 lines above/below the cursor when scrolling with a mouse
opt.showcmd = true -- Show partial normal mode command on command line and visual mode
opt.cursorline = true -- Highlight current cursor line

opt.fileencoding = 'utf-8' -- Use UTF-8 file encoding

opt.matchpairs:append '<:>' -- Add <> to '%' matchpairs

-- The 'hidden' option allows one to reuse the same window and switch from an unsaved
-- buffer without saving it first. Also allows keeping an undo history for multiple
-- files when reusing the same window this way. Note that persistent undo also lets
-- you undo multiple files even in the same window, but it is less efficient and is
-- actually designed for keeping an undo history after close neovim entirely. Neovim
-- will complain if you try to quit without saving, and swap files will keep you save
-- if the computer crashes
opt.hidden = true

opt.termguicolors = true

opt.updatetime = 50
-- opt.colorcolumn = 80

-- Remove any trailing whitespace in the file
vim.cmd[[ autocmd BufRead,BufWrite * if ! &bin | silent! %s/\s\+$//ge | endif ]]

vim.cmd[[ autocmd VimLeave *.tex !doit code cleantex % ]]

-- Open a file from its last left off position
vim.cmd [[ au BufReadPost * if expand('%:p') !~# '\m/\.git/' && line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif ]]

-- Highlight only characters that go past 89 instead of vertical line
vim.cmd [[
highlight OverLength ctermbg=DarkCyan
call matchadd('OverLength', '\%89v', 100)
call matchadd('ColorColumn', '\%89v', 100)
]]

