local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

local plugins = {
    'nvim-lua/plenary.nvim',
    "lewis6991/impatient.nvim",
    "tpope/vim-fugitive",
    "editorconfig/editorconfig-vim",
    {
        'kylechui/nvim-surround', version = '*', event = 'VeryLazy',
        config = function() require('nvim-surround').setup({}) end
    },
    'nvim-treesitter/nvim-treesitter-textobjects',
    {
        'numToStr/Comment.nvim', opts = {},
    },
    'JoosepAlviste/nvim-ts-context-commentstring',
    {
        'stefanlogue/hydrate.nvim',
        opts = { minute_interval = 30 }
    },
    { "lukas-reineke/indent-blankline.nvim",
        event = "VeryLazy",
        opts = function()
            local opts = {
                indentLine_enabled = 1,
                filetype_exclude = {
                    "help", "terminal", "lazy", "lspinfo", "TelescopePrompt", "TelescopeResults", "mason"
                },
                buftype_exclude = { "terminal" },
                show_trailing_blankline_indent = false,
                show_first_indent_level = false,
                show_current_context = true,
                show_current_context_start = true
            }
            return opts
        end,
        config = function(_, opts)
            require('indent_blankline').setup(opts)
        end
    },
    {
        "andweeb/presence.nvim",
        config = function()
            require('presence').setup({ neovim_image_text = "Neovim" })
        end
    },
    {
        "windwp/nvim-autopairs",
        event = 'InsertEnter', opts = {}
    },
    {
        "mbbill/undotree",
        config = function()
            vim.keymap.set('n', '<leader>u', vim.cmd.UndotreeToggle)
        end
    },
    {
        'akinsho/bufferline.nvim', version = "*", dependencies = 'nvim-tree/nvim-web-devicons',
        config = function() require('bufferline').setup({}) end
    },
    {
        'nvim-lualine/lualine.nvim',
        dependencies = { 'nvim-tree/nvim-web-devicons' },
        config = function()
            local opts = {
                options = {
                    component_separators = '',
                    section_separators = ''
                }
            }
            require('lualine').setup(opts)
        end
    },
    {
        'stevearc/oil.nvim', opts = {}, dependencies = { "nvim-tree/nvim-web-devicons" },
        config = function()
            vim.keymap.set('n', '-', '<cmd>Oil<cr>', { desc = 'Open parent directory' })

            require('oil').setup({
                columns = { 'permissions', 'size', 'mtime' }
            })
        end
    },
    {
        'lewis6991/gitsigns.nvim',
        opts = function()
            local opts = {
                signs = {
                    add = { text = "│" },
                    change = { text = "│" },
                    delete = { text = "󰍵" },
                    topdelete = { text = "‾" },
                    changedelete = { text = "~" },
                    untracked = { text = "│" },
                },
            }
            return opts
        end,
        config = function(_, opts)
            require('gitsigns').setup(opts)
        end
    },
    {
        "jose-elias-alvarez/null-ls.nvim",
        event = "VeryLazy",
        ft = {"python", "sh"},
        opts = function()
            local null_ls = require('null-ls')
            local opts = {
                sources = {
                    null_ls.builtins.diagnostics.mypy,
                    null_ls.builtins.diagnostics.ruff,
                    null_ls.builtins.diagnostics.shellcheck
                }
            }
            return opts
        end
    },
    {
        'nvim-telescope/telescope.nvim', tag = '0.1.2',
        dependencies = { 'nvim-lua/plenary.nvim' },
        opts = function()
            local options = {
                defaults = {
                    vimgrep_arguments = {
                        "rg",
                        "-L",
                        "--color=never",
                        "--no-heading",
                        "--with-filename",
                        "--line-number",
                        "--column",
                        "--smart-case",
                    },
                    prompt_prefix = "   ",
                    selection_caret = "  ",
                    entry_prefix = "  ",
                    initial_mode = "insert",
                    selection_strategy = "reset",
                    sorting_strategy = "ascending",
                    layout_strategy = "horizontal",
                    layout_config = {
                        horizontal = {
                            prompt_position = "top",
                            preview_width = 0.55,
                            results_width = 0.8,
                        },
                        vertical = {
                            mirror = false,
                        },
                        width = 0.87,
                        height = 0.80,
                        preview_cutoff = 120,
                    },
                    file_sorter = require("telescope.sorters").get_fuzzy_file,
                    file_ignore_patterns = { "node_modules" },
                    generic_sorter = require("telescope.sorters").get_generic_fuzzy_sorter,
                    path_display = { "truncate" },
                    winblend = 0,
                    border = {},
                    borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
                    color_devicons = true,
                    set_env = { ["COLORTERM"] = "truecolor" }, -- default = nil,
                    file_previewer = require("telescope.previewers").vim_buffer_cat.new,
                    grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
                    qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new,
                    -- Developer configurations: Not meant for general override
                    buffer_previewer_maker = require("telescope.previewers").buffer_previewer_maker,
                    mappings = {
                        n = { ["q"] = require("telescope.actions").close },
                    },
                },
            }
            return options
        end
    },
    {
        'theprimeagen/harpoon',
        config = function()
            local mark = require('harpoon.mark')
            local ui = require('harpoon.ui')

            vim.keymap.set('n', '<leader>a', mark.add_file)
            vim.keymap.set('n', '<C-e>', ui.toggle_quick_menu)

            vim.keymap.set('n', '<C-t>', function() ui.nav_file(1) end)
            vim.keymap.set('n', '<C-y>', function() ui.nav_file(2) end)
        end
    },
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        config = function ()
            local configs = require("nvim-treesitter.configs")

            configs.setup({
                ensure_installed = { "c", "cpp", "python", "bash", "rust", "elixir", "latex" },
                sync_install = false,
                highlight = { enable = true },
                auto_install = true,
                indent = { enable = true },
            })
        end
    },
    {
        "nvim-treesitter/nvim-treesitter-context",
        config = function()
            require'treesitter-context'.setup{
                enable = true, -- Enable this plugin (Can be enabled/disabled later via commands)
                max_lines = 0, -- How many lines the window should span. Values <= 0 mean no limit.
                trim_scope = 'outer', -- Which context lines to discard if `max_lines` is exceeded. Choices: 'inner', 'outer'
                min_window_height = 0, -- Minimum editor window height to enable context. Values <= 0 mean no limit.
                patterns = { -- Match patterns for TS nodes. These get wrapped to match at word boundaries.
                -- For all filetypes
                -- Note that setting an entry here replaces all other patterns for this entry.
                -- By setting the 'default' entry below, you can control which nodes you want to
                -- appear in the context window.
                default = {
                    'class',
                    'function',
                    'method',
                    'for',
                    'while',
                    'if',
                    'switch',
                    'case',
                    'interface',
                    'struct',
                    'enum',
                },
                -- Patterns for specific filetypes
                -- If a pattern is missing, *open a PR* so everyone can benefit.
                tex = {
                    'chapter',
                    'section',
                    'subsection',
                    'subsubsection',
                },
                haskell = {
                    'adt'
                },
                rust = {
                    'impl_item',

                },
                terraform = {
                    'block',
                    'object_elem',
                    'attribute',
                },
                scala = {
                    'object_definition',
                },
                vhdl = {
                    'process_statement',
                    'architecture_body',
                    'entity_declaration',
                },
                markdown = {
                    'section',
                },
                elixir = {
                    'anonymous_function',
                    'arguments',
                    'block',
                    'do_block',
                    'list',
                    'map',
                    'tuple',
                    'quoted_content',
                },
                json = {
                    'pair',
                },
                typescript = {
                    'export_statement',
                },
                yaml = {
                    'block_mapping_pair',
                },
            },
            exact_patterns = {
                -- Example for a specific filetype with Lua patterns
                -- Treat patterns.rust as a Lua pattern (i.e "^impl_item$" will
                -- exactly match "impl_item" only)
                -- rust = true,
            },

            -- [!] The options below are exposed but shouldn't require your attention,
            --     you can safely ignore them.

            zindex = 20, -- The Z-index of the context window
            mode = 'cursor',  -- Line used to calculate context. Choices: 'cursor', 'topline'
            -- Separator between context and content. Should be a single character string, like '-'.
            -- When separator is set, the context will only show up when there are at least 2 lines above cursorline.
            separator = nil,
        }
        end
    },
    {
        "williamboman/mason.nvim",
        cmd = { "Mason", "MasonInstall", "MasonInstallAll", "MasonUninstall", "MasonUninstallAll", "MasonLog" },
        opts = {
            ensure_installed = {
                "mypy", "ruff",
                "debugpy",
                "pyright",
                "clangd",
                "rust-analyzer"
            }
        },
        config = function(_, opts)
            require('mason').setup(opts)

            vim.api.nvim_create_user_command("MasonInstallAll", function()
                vim.cmd("MasonInstall " .. table.concat(opts.ensure_installed, " "))
            end, {})
            vim.g.mason_binaries_list = opts.ensure_installed
        end
    },
    {
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v2.x',
        dependencies = {
            -- LSP Support
            {'neovim/nvim-lspconfig'},             -- Required
            {'williamboman/mason.nvim'},           -- Optional
            {'williamboman/mason-lspconfig.nvim'}, -- Optional
            -- Autocompletion
            {'hrsh7th/nvim-cmp'},     -- Required
            {'hrsh7th/cmp-nvim-lsp'}, -- Required
            {'L3MON4D3/LuaSnip'},     -- Required
            {'hrsh7th/cmp-buffer'},
            {'hrsh7th/cmp-path'},
            {'saadparwaiz1/cmp_luasnip'}
        },
        config = function()
            -- require('lsp')
            local lsp = require('lsp-zero')
            lsp.preset('recommended')

            lsp.on_attach(function(client, bufnr) lsp.default_keymaps({buffer = bufnr}) end)
            lsp.setup()

            local cmp = require('cmp')
            local cmp_action = require('lsp-zero').cmp_action()
            local cmp_autopairs = require('nvim-autopairs.completion.cmp')

            local cmp_mappings = {
                ['<CR>'] = cmp.mapping.confirm({select = false}),

                ['<C-f>'] = cmp_action.luasnip_jump_forward(),
                ['<C-b>'] = cmp_action.luasnip_jump_backward(),
            }

            cmp.setup({
                mapping = cmp_mappings,
                preselect = 'item',
                completion = { completeopt = 'menu,menuone,noinsert' },
                experimental = { ghost_text = true }
            })
            cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done())
        end
    },
    {
        'WhoIsSethDaniel/toggle-lsp-diagnostics.nvim',
        config = function()
            require('toggle_lsp_diagnostics').init({ start_on = true })
        end
    },
    {
        "folke/trouble.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        config = function()
            vim.keymap.set("n", "<leader>xx", function() require("trouble").open() end)
            vim.keymap.set("n", "<leader>xw", function() require("trouble").open("workspace_diagnostics") end)
            vim.keymap.set("n", "<leader>xd", function() require("trouble").open("document_diagnostics") end)
            vim.keymap.set("n", "<leader>xq", function() require("trouble").open("quickfix") end)
            vim.keymap.set("n", "<leader>xl", function() require("trouble").open("loclist") end)
            vim.keymap.set("n", "gR", function() require("trouble").open("lsp_references") end)
        end
    },
    {
        'rcarriga/nvim-dap-ui',
        event = "VeryLazy",
        dependencies = 'mfussenegger/nvim-dap',
        config = function()
            local dap = require('dap')
            local dapui = require('dapui')
            dapui.setup()
            dap.listeners.after.event_initialized['dapui_config'] = function() dapui.open() end
            dap.listeners.before.event_terminated['dapui_config'] = function() dapui.close() end
            dap.listeners.before.event_exited['dapui_config'] = function() dapui.close() end
        end
    },
    {
        'mfussenegger/nvim-dap',
        config = function(_, opts)
            vim.keymap.set('n', '<leader>db', '<cmd> DapToggleBreakpoint <cr>')
        end
    },
    {
        'mfussenegger/nvim-dap-python',
        ft = 'python',
        dependencies = {
            'mfussenegger/nvim-dap',
            'rcarriga/nvim-dap-ui'
        },
        config = function(_, opts)
            local path = "~/.local/share/nvim/mason/packages/debugpy/venv/bin/python"
            require('dap-python').setup(path)
            vim.keymap.set('n', '<leader>dpr', function() require('dap-python').test_method() end)
        end
    },
    {
        "lervag/vimtex",
        config = function()
            vim.g.tex_flavor = 'latex'
            vim.g.vimtex_view_method = 'zathura'
            vim.g.vimtex_quickfix_mode = 1
            vim.g.vimtex_view_forward_search_on_start = 0
            vim.g.vimtex_compiler_progname = 'nvr'
        end
    },
    { 'rose-pine/neovim', name = 'rose-pine', config = function() vim.cmd('colorschem rose-pine') end },
    { 'embark-theme/vim', name = 'embark' },
    { 'rainglow/vim' }
}

require("lazy").setup(plugins)

