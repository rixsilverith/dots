local keymap = function(mode, keys, action, opts)
    opts = opts or { noremap = true, silent = true }
    vim.api.nvim_set_keymap(mode, keys, action, opts)
end

vim.g.mapleader = ' '

keymap('i', '<Esc>', '<nop>') -- disable <Esc> on insert mode
keymap('n', '<cr>', '<nop>') -- disable <enter> on normal mode

keymap('n', '<leader>q', ':q<cr>')
keymap('n', '<leader>wq', ':wq<cr>')
keymap('n', '<leader>w', ':up<cr>') -- save buffer only if modified
keymap('n', '<leader>bq', ':bd<cr>') -- close current buffer

keymap('i', 'jk', '<Esc>') -- fast insert -> normal mode

-- replace visual selection
keymap('x', '<leader>ss', "y:%s/<C-r>0//gI<Left><Left><Left>", { noremap = true })
-- replace search result
keymap('n', '<leader>ss', [[:%s/<C-r><C-w>/<C-r><C-w>/gI<Left><Left><Left>]], { noremap = true })

keymap('n', 'J', 'mzJ`z') -- prevent cursor movement upon joining lines
keymap('x', 'p', '"_dP') -- prevent yank register override upon pasting
keymap({ 'n', 'v' }, '<leader>d', '"_d') -- delete to void register

keymap('n', '<leader>dg', ':ToggleDiag<cr>') -- LSP diagnostics toggle
keymap('n', '<leader>csh', ':noh<cr>') -- unhighlight search

-- move selected lines around
keymap('v', 'J', ":m '>+1<CR>gv=gv")
keymap('v', 'K', ":m '<-2<CR>gv=gv")

-- next/previous search result, but center it vertically
keymap('n', 'n', 'nzzzv')
keymap('n', 'N', 'Nzzzv')

-- keep cursor centered when moving half-page up and down
keymap('n', '<C-d>', '<C-d>zz')
keymap('n', '<C-u>', '<C-u>zz')

-- use ctrl-[hjkl] to move to between splits
keymap('n', '<C-h>', ':wincmd h<cr>')
keymap('n', '<C-j>', ':wincmd j<cr>')
keymap('n', '<C-k>', ':wincmd k<cr>')
keymap('n', '<C-l>', ':wincmd l<cr>')

keymap('n', '<leader>fs', ':Telescope git_files<cr>')
keymap('n', '<leader>ff', ':Telescope find_files<cr>')

keymap('n', '<leader>tv', ':botright vnew <Bar> :terminal<cr>')
keymap('n', '<leader>th', ':botright new <Bar> :terminal<cr>')

keymap('t', '<Esc>', '<C-\\><C-n>')
keymap('t', 'jk', '<Esc>')

