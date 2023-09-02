local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not vim.loop.fs_stat(lazypath) then
    vim.api.nvim_echo({ { "Cloning and installing lazy.nvim", "Bold" } }, true, {})

    local lazyrepo = "https://github.com/folke/lazy.nvim.git"
    vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
end
vim.opt.rtp:prepend(lazypath)

local disabled_runtime_plugins = {
    "2html_plugin",
    "tohtml",
    "getscript",
    "getscriptPlugin",
    "gzip",
    "logipat",
    "netrw",
    "netrwPlugin",
    "netrwSettings",
    "netrwFileHandlers",
    "matchit",
    "tar",
    "tarPlugin",
    "rrhelper",
    "spellfile_plugin",
    "vimball",
    "vimballPlugin",
    "zip", "zipPlugin",
    "tutor",
    "rplugin",
    "syntax",
    "synmenu",
    "optwin",
    "compiler",
    "bugreport",
    "ftplugin",
}

local lazy_opts = {
    defaults = { lazy = true },
    performance = {
        rtp = { disabled_plugins = disabled_runtime_plugins, },
    },
}

local plugins = {
    'nvim-lua/plenary.nvim',
    { 'tpope/vim-fugitive', cmd = "Git" },
    { 'editorconfig/editorconfig-vim', event = "VeryLazy" },
    {
        'norcalli/nvim-colorizer.lua', event = "VeryLazy",
        config = function() require('colorizer').setup() end
    },
    {
        'stevearc/aerial.nvim', opts = {},
        keys = { { '<leader>ae', ':AerialToggle!<cr>', mode = 'n', silent = true } },
        config = function()
            require('aerial').setup({
                on_attach = function(bufnr)
                    vim.keymap.set('n', '<leader>{', ':AerialPrev<cr>', { buffer = bufnr, silent = true })
                    vim.keymap.set('n', '<leader>}', ':AerialNext<cr>', { buffer = bufnr, silent = true })
                end
            })
        end
    },
    { 'f-person/git-blame.nvim', event = "VeryLazy", },
    { 'tzachar/highlight-undo.nvim', opts = {}, event = "VeryLazy" },
    {
        'kylechui/nvim-surround', version = '*', event = 'InsertEnter', opts = {},
        dependencies = 'nvim-treesitter/nvim-treesitter-textobjects',
    },
    {
        'numToStr/Comment.nvim', opts = {},
        dependencies = { 'JoosepAlviste/nvim-ts-context-commentstring' },
        keys = {
            { "gcc", mode = "n", desc = "Comment toggle current line" },
            { "gc", mode = { "n", "o" }, desc = "Comment toggle linewise" },
            { "gc", mode = "x", desc = "Comment toggle linewise (visual)" },
            { "gbc", mode = "n", desc = "Comment toggle current block" },
            { "gb", mode = { "n", "o" }, desc = "Comment toggle blockwise" },
            { "gb", mode = "x", desc = "Comment toggle blockwise (visual)" },
        },
    },
    {
        'stefanlogue/hydrate.nvim', event = "VeryLazy",
        opts = { minute_interval = 30 }
    },
    {
        "lukas-reineke/indent-blankline.nvim",
        enabled = false,
        event = "VeryLazy",
        opts = {
            indent_blankline_enabled = false,
            filetype_exclude = {
                "help", "terminal", "lazy", "lspinfo", "TelescopePrompt", "TelescopeResults", "mason"
            },
            buftype_exclude = { "terminal" },
            show_trailing_blankline_indent = true,
            show_first_indent_level = false,
            show_current_context = false,
            show_current_context_start = false
        },
    },
    {
        "andweeb/presence.nvim",
        enable = false,
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
        keys = { { "<leader>U", ":UndotreeToggle<cr>", mode = "n", noremap = true, silent = true } }
    },
    {
        'akinsho/bufferline.nvim', version = "*", dependencies = 'nvim-tree/nvim-web-devicons',
        event = { 'BufReadPost', 'BufNewFile' }, opts = {}
    },
    {
        'nvim-lualine/lualine.nvim',
        event = { 'BufReadPost', 'BufNewFile' },
        dependencies = { 'nvim-tree/nvim-web-devicons' },
        opts = {
            options = {
                component_separators = '',
                section_separators = ''
            },
            sections = {
                lualine_x = {
                    'encoding',
                    { 'fileformat', symbols = { unix = 'unix' } },
                    { 'filetype', colored = false }
                }
            }
        },
    },
    {
        'stevearc/oil.nvim', opts = {}, dependencies = { "nvim-tree/nvim-web-devicons" },
        keys = { { "<leader>-", ":Oil<cr>", mode = "n", noremap = true, silent = true } },
        opts = {
            columns = { 'permissions', 'size', 'mtime' } ,
            skip_confirm_for_simple_edits = true,
        }
    },
    {
        'lewis6991/gitsigns.nvim', event = "BufReadPre",
        opts = {
            signs = {
                add = { text = "│" },
                change = { text = "│" },
                delete = { text = "󰍵" },
                topdelete = { text = "‾" },
                changedelete = { text = "~" },
                untracked = { text = "│" },
            },
        },
    },
    {
        "jose-elias-alvarez/null-ls.nvim", ft = { "python", "sh" },
        dependencies = { "mason.nvim" },
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
        cmd = "Telescope",
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
        keys = {
            { '<leader>a', mode = 'n', function() require('harpoon.mark').add_file() end },
            { '<C-e>',     mode = 'n', function() require('harpoon.ui').toggle_quick_menu() end },
        },
        config = function()
            local ui = require('harpoon.ui')

            vim.keymap.set('n', '<C-t>', function() ui.nav_file(1) end)
            vim.keymap.set('n', '<C-y>', function() ui.nav_file(2) end)
        end
    },
    {
        "nvim-treesitter/nvim-treesitter",
        event = { 'BufReadPre', "BufNewFile" },
        cmd = { "TSInstall", "TSBufEnable", "TSBufDisable", "TSModuleInfo" },
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
        event = { 'BufReadPre', "BufNewFile" },
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
        event = { "BufReadPre", "BufNewFile" },
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
                ['<CR>'] = cmp.mapping.confirm({
                    behavior = cmp.ConfirmBehavior.Insert, select = true
                }),

                ['<C-f>'] = cmp_action.luasnip_jump_forward(),
                ['<C-b>'] = cmp_action.luasnip_jump_backward(),
            }

            require('luasnip.loaders.from_vscode').lazy_load({ paths = vim.fn.stdpath "config" .. "/snippets" })

            cmp.setup({
                mapping = cmp_mappings,
                preselect = 'item',
                completion = { completeopt = 'menu,menuone,noinsert' },
                experimental = { ghost_text = true },
                formatting = {
                    format = function(entry, vim_item)
                        vim_item.menu = ({
                            nvim_lsp = '[LSP]',
                            nvim_lua = '[LSP]',
                            luasnip = '[Snippet]',
                            buffer = '[Buffer]',
                            path = '[Path]',
                            ['vim-dadbod-completion'] = '[DB]',
                        })[entry.source.name]
                        return vim_item
                    end,
                },
                sources = {
                    { name = "nvim_lsp" },
                    { name = "luasnip" },
                    { name = "buffer" },
                    { name = "nvim_lua" },
                    { name = "path" },
                    { name = 'vim-dadbod-completion' }
                },
                snippet = {
                    expand = function(args) require('luasnip').lsp_expand(args.body) end
                }
            })
            cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done())
        end
    },
    {
        'WhoIsSethDaniel/toggle-lsp-diagnostics.nvim',
        cmd = "ToggleDiag",
        config = function()
            require('toggle_lsp_diagnostics').init({ start_on = true })
        end
    },
    {
        "folke/trouble.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        keys = {
            { '<leader>xw', ':TroubleToggle workspace_diagnostics<cr>', mode = 'n', silent = true },
            { '<leader>xd', ':TroubleToggle document_diagnostics<cr>', mode = 'n', silent = true },
        },
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
        event = "VeryLazy",
        config = function(_, opts)
            vim.keymap.set('n', '<leader>dbp', ':DapToggleBreakpoint<cr>', { silent = true })
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
        'kristijanhusak/vim-dadbod-ui',
        dependencies = {
            'tpope/vim-dadbod',
            'kristijanhusak/vim-dadbod-completion'
        },
        keys = { { '<leader>dbA', ':DBUIToggle<cr>', mode = 'n', silent = true } }
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
    {
        'rose-pine/neovim', name = 'rose-pine',
        config = function() vim.cmd('colorscheme rose-pine') end,
        lazy = false,
        priority = 1000
    },
    { 'embark-theme/vim', name = 'embark' },
    { 'rainglow/vim' }
}

require("lazy").setup(plugins, lazy_opts)

