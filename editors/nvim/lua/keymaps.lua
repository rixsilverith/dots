local keymap = function(mode, shortcut, command)
  vim.api.nvim_set_keymap(mode, shortcut, command, { noremap = true, silent = true })
end

vim.g.mapleader = ' '

keymap('n', '<leader>w', ':up<cr>') -- save buffer only if modified
keymap('n', '<leader>wq', ':wq<cr>')
keymap('n', '<leader>q', ':q<cr>')
keymap('n', '<leader>bq', ':bd<cr>') -- close current buffer
keymap('n', '<leader>fs', ':Telescope git_files<cr>')
keymap('n', '<leader>ff', ':Telescope find_files<cr>')

-- move selected lines around
keymap('v', 'J', ":m '>+1<CR>gv=gv")
keymap('v', 'K', ":m '<-2<CR>gv=gv")

-- make cursor stay in position when joining lines
keymap('n', 'J', 'mzJ`z')

-- prevent copy buffer override when pasting
keymap('x', '<leader>p', "\"_dP")
-- delete to void register
keymap('n', '<leader>d', "\"_d")
keymap('v', '<leader>d', "\"_d")

-- keep cursor centered when moving half-page up and down
keymap('n', '<C-d>', '<C-d>zz')
keymap('n', '<C-u>', '<C-u>zz')

keymap('n', '<leader>tv', ':botright vnew <Bar> :terminal<cr>')
keymap('n', '<leader>th', ':botright new <Bar> :terminal<cr>')
-- keymap('n', '<leader>cc', ':sp | terminal make run_% <cr>')
keymap('t', '<Esc>', '<C-\\><C-n>')
keymap('t', 'jk', '<Esc>')

-- Use ctrl-[hjkl] to move to between splits
keymap('n', '<C-h>', ':wincmd h<cr>')
keymap('n', '<C-j>', ':wincmd j<cr>')
keymap('n', '<C-k>', ':wincmd k<cr>')
keymap('n', '<C-l>', ':wincmd l<cr>')

keymap('i', 'jk', '<Esc>')
keymap('i', '<Esc>', '<nop>') -- Disable <Esc> on insert mode
keymap('n', '<cr>', '<nop>') -- Disable <enter> on normal mode

-- Edit neovim configuration in a vertical split
keymap('n', '<leader>ev', ':vsplit $MYVIMRC<cr>')
-- Reload neovim configuration
keymap('n', '<leader>sv', ':source $MYVIMRC<cr>')

-- Go to next or previous search and center the result
keymap('n', 'n', 'nzzzv')
keymap('n', 'N', 'Nzzzv')

-- LSP diagnostics toggle bindings
keymap('n', '<leader>dg', '<cmd> ToggleDiag <cr>')

keymap('n', '<leader>csh', ':noh<cr>')

