-- Neovim Config
-- Author: Coockson
-- v.0.0.1


-- {{{ Local plugins
require('linters/python_black')
require('linters/terraform_fmt')
require('foundation/refresh_change')
require('foundation/autocomment')
require('foundation/terminal')
require('git/commit')
-- }}}

-- {{{ LSP setup

local lspconfig = require('lspconfig')

lspconfig.lua_ls.setup {
  settings = {
	Lua = {
	  runtime = {
		version = 'LuaJIT',
	  },
	  diagnostics = {
		globals = {
		  'vim',
		  'require'
		},
	  },
	  workspace = {
		library = vim.api.nvim_get_runtime_file("", true),
	  },
	  telemetry = {
		enable = false,
	  },
	},
  },
}

-- LSP languages
require'lspconfig'.pyright.setup{}
require'lspconfig'.terraformls.setup{}
require'lspconfig'.tsserver.setup {}
require'lspconfig'.rust_analyzer.setup{}
require'lspconfig'.gopls.setup{}

-- LSP go to definition and go to resource keybindings
vim.api.nvim_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', { noremap = true, silent = true })
-- LSP accept PUM suggestion with Tab
vim.api.nvim_set_keymap('i', '<Tab>', 'pumvisible() ? "<C-y>" : "<C-g>u<C-t>"', {expr = true})
-- }}}

-- {{{ Basic configs
vim.opt.number = true
vim.opt.autoindent = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.smarttab = true
vim.opt.softtabstop = 4
vim.opt.mouse = "a"
vim.opt.updatetime = 50
vim.opt.laststatus = 3
vim.opt.splitbelow = true
vim.opt.foldmethod = "marker"
vim.g.mapleader = " "
vim.cmd("set winbar=%=%m\\ %f")

-- Yank to system clipboard
if vim.fn.has("unnamedplus") == 1 then
    vim.opt.clipboard = "unnamedplus"
else
    vim.opt.clipboard = "unnamed"
end
-- }}}

-- {{{ External plugins
local Plug = vim.fn['plug#']
vim.call('plug#begin')
Plug 'nvim-tree/nvim-web-devicons'
Plug 'nvim-tree/nvim-tree.lua'
Plug 'https://github.com/airblade/vim-gitgutter' -- Show changes in editor
Plug 'https://github.com/ap/vim-css-color' -- CSS Color Preview
Plug 'https://github.com/rafi/awesome-vim-colorschemes' -- Retro Scheme
Plug 'https://github.com/preservim/tagbar' -- Tagbar for code navigation
Plug('junegunn/fzf', {['do'] = vim.fn['fzf#install']})
Plug( 'iamcco/markdown-preview.nvim', {['do']= vim.fn['cd app && yarn install']})
Plug( 'nvim-treesitter/nvim-treesitter', {['do']= vim.fn[':TSUpdate']})
Plug 'nvim-lua/plenary.nvim'
Plug( 'nvim-telescope/telescope.nvim', { tag= '0.1.5'})
Plug 'tomasiser/vim-code-dark' -- VS Code colorscheme
Plug 'MunifTanjim/nui.nvim'
Plug 'nvim-lualine/lualine.nvim'
Plug 'https://github.com/Coockson/popterminal.nvim'
Plug 'lewis6991/gitsigns.nvim'
Plug( 'rebelot/kanagawa.nvim', { ['as']= 'kanagawa' }) -- Colortheme
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-vsnip'
Plug 'hrsh7th/vim-vsnip'
vim.call('plug#end')
-- }}}

-- {{{ KEYBINDINGS

-- Mapping : to ; because of ISO keyboard layout
vim.api.nvim_set_keymap('n', ';', ':', {noremap = true})
vim.api.nvim_set_keymap('v', ';', ':', {noremap = true})

-- Mapping § to ESC for TKL keyboard
vim.api.nvim_set_keymap('n', '§', '<Esc>', {expr = true})
vim.api.nvim_set_keymap('i', '§', '<Esc>', {expr = true})

-- Mapping window movements to leader
vim.api.nvim_set_keymap('n', '<Leader>ww', ':winc w<CR>', {noremap = true})
vim.api.nvim_set_keymap('n', '<Leader>wl', ':winc l<CR>', {noremap = true})
vim.api.nvim_set_keymap('n', '<Leader>wh', ':winc h<CR>', {noremap = true})
vim.api.nvim_set_keymap('n', '<Leader>wj', ':winc j<CR>', {noremap = true})
vim.api.nvim_set_keymap('n', '<Leader>wk', ':winc k<CR>', {noremap = true})

-- Moving the windows
vim.api.nvim_set_keymap('n', '<Leader>wH', '<C-w>H', {noremap = true})
vim.api.nvim_set_keymap('n', '<Leader>wJ', '<C-w>J', {noremap = true})
vim.api.nvim_set_keymap('n', '<Leader>wK', '<C-w>K', {noremap = true})
vim.api.nvim_set_keymap('n', '<Leader>wL', '<C-w>L', {noremap = true})

-- Move beginning and end
vim.api.nvim_set_keymap('n', '<Leader>s', '^', {noremap = true})
vim.api.nvim_set_keymap('v', '<Leader>s', '^', {noremap = true})
vim.api.nvim_set_keymap('n', '<Leader>l', '$', {noremap = true})
vim.api.nvim_set_keymap('v', '<Leader>l', '$', {noremap = true})

-- Make TAB indent in normal mode
vim.api.nvim_set_keymap('n', '<Leader>.', '>>', {noremap = true})
vim.api.nvim_set_keymap('v', '<Leader>.', '>>', {noremap = true})
vim.api.nvim_set_keymap('n', '<Leader>,', '<<', {noremap = true})
vim.api.nvim_set_keymap('v', '<Leader>,', '<<', {noremap = true})

-- Comment shortcuts
vim.api.nvim_set_keymap('n', '<Leader>cb', ':AutoComment<CR>', {noremap = true})
vim.api.nvim_set_keymap('n', '<Leader>cv', ':AutoUncomment<CR>', {noremap = true})
vim.api.nvim_set_keymap('n', '<Leader>cc', ':CommentSingleLine<CR>', {noremap = true})
vim.api.nvim_set_keymap('n', '<Leader>cx', ':UncommentSingleLine<CR>', {noremap = true})
vim.api.nvim_set_keymap('v', '<Leader>cb', ':AutoComment<CR>', {noremap = true})
vim.api.nvim_set_keymap('v', '<Leader>cv', ':AutoUncomment<CR>', {noremap = true})
vim.api.nvim_set_keymap('v', '<Leader>cc', ':CommentSingleLine<CR>', {noremap = true})
vim.api.nvim_set_keymap('v', '<Leader>cx', ':UncommentSingleLine<CR>', {noremap = true})

-- Find files using Telescope
vim.api.nvim_set_keymap('n', '<leader>ff', '<cmd>Telescope find_files<cr>', {noremap = true})
vim.api.nvim_set_keymap('n', '<leader>fg', '<cmd>Telescope live_grep<cr>', {noremap = true})
vim.api.nvim_set_keymap('n', '<leader>fb', '<cmd>Telescope buffers<cr>', {noremap = true})
vim.api.nvim_set_keymap('n', '<leader>fh', '<cmd>Telescope help_tags<cr>', {noremap = true})
vim.api.nvim_set_keymap('n', '<Leader>gs', '<cmd>Telescope git_status<cr>', {noremap = true})
vim.api.nvim_set_keymap('n', '<Leader>gb', '<cmd>Telescope git_branches<cr>', {noremap = true})
vim.api.nvim_set_keymap('n', '<Leader>gh', '<cmd>Telescope git_commits<cr>', {noremap = true})
vim.api.nvim_set_keymap('n', '<Leader>s', '<cmd>Telescope current_buffer_fuzzy_find<cr>', {noremap = true})

-- Working with tabs
vim.api.nvim_set_keymap('n', '<Tab>', 'gt', {noremap = true})
vim.api.nvim_set_keymap('n', '<Leader><Tab>', 'gT', {noremap = true})

-- Mark line and jump to mark
vim.api.nvim_set_keymap('n', '<Leader>m', 'mx', {noremap = true})
vim.api.nvim_set_keymap('n', '<Leader>mm', "'x", {noremap = true})

-- Plugin development
vim.api.nvim_set_keymap('n', '<Leader>5', ':source %<CR>', {noremap = true})

-- Nvim Tree toggle
vim.api.nvim_set_keymap('n', '<Leader>n', ':NvimTreeToggle<CR>', {noremap = true})
-- Open Pop Terminal
vim.api.nvim_set_keymap('n', '<Leader>t', ':PopTerminal<CR>', {noremap = true})
-- Make ESC go to normal-mode in terminal
vim.api.nvim_set_keymap('t', '<Esc>', '<C-\\><C-n>', {noremap = true})

-- GOTO Definition
vim.api.nvim_set_keymap('n', '<Leader>o', '<C-o><CR>', {noremap = true})

-- See git files
vim.api.nvim_set_keymap('n', '<Leader>gc', ':GitCommit<CR>', {noremap = true})
vim.api.nvim_set_keymap('n', '<Leader>gb', ':Gitsigns blame_line<CR>', {noremap = true})
-- }}}

-- {{{ Colorscheme

vim.cmd('colorscheme kanagawa')

-- -- Set colorscheme to codedark
-- vim.cmd('colorscheme codedark')
-- 
--     vim.o.termguicolors = true
--     vim.o.background = "dark"
-- -- Set terminal colors to 256
-- vim.api.nvim_set_option('termguicolors', true)
-- 
-- -- Set codedark options
-- vim.g.codedark_conservative = 1    -- Conservative style
-- vim.g.codedark_italics = 1         -- Italicized comments
-- vim.g.codedark_transparent = 1     -- Transparent background
-- }}}

-- {{{ Plugin Configs

require("nvim-treesitter.configs").setup({
	ensure_installed = { "terraform", "hcl", "python", "yaml", "javascript", "typescript", "lua", "vim", "json", "html", "tsx" },
	ignore_install = { "markdown" },
	sync_install = false,
	auto_install = true,
	highlight = {
		enable = true,
	},
})
require('lualine').setup()
require('popterminal')
require("nvim-tree").setup()
require('gitsigns').setup(
	{
		current_line_blame_formatter = '<author>, <author_time:%d-%m-%Y> - <summary>'
	}
)

local cmp = require'cmp'

cmp.setup({
snippet = {
  -- REQUIRED - you must specify a snippet engine
  expand = function(args)
	vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
	-- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
	-- require('snippy').expand_snippet(args.body) -- For `snippy` users.
	-- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
	-- vim.snippet.expand(args.body) -- For native neovim snippets (Neovim v0.10+)
  end,
},
window = {
  -- completion = cmp.config.window.bordered(),
  -- documentation = cmp.config.window.bordered(),
},
mapping = cmp.mapping.preset.insert({
  ['<C-b>'] = cmp.mapping.scroll_docs(-4),
  ['<C-f>'] = cmp.mapping.scroll_docs(4),
  ['<C-Space>'] = cmp.mapping.complete(),
  ['<C-e>'] = cmp.mapping.abort(),
  ['<Tab>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
}),
sources = cmp.config.sources({
  { name = 'nvim_lsp' },
  { name = 'vsnip' }, -- For vsnip users.
  -- { name = 'luasnip' }, -- For luasnip users.
  -- { name = 'ultisnips' }, -- For ultisnips users.
  -- { name = 'snippy' }, -- For snippy users.
}, {
  { name = 'buffer' },
})
})

-- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline({ '/', '?' }, {
mapping = cmp.mapping.preset.cmdline(),
sources = {
  { name = 'buffer' }
}
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(':', {
mapping = cmp.mapping.preset.cmdline(),
sources = cmp.config.sources({
  { name = 'path' }
}, {
  { name = 'cmdline' }
}),
matching = { disallow_symbol_nonprefix_matching = false }
})

-- Set up lspconfig.
local capabilities = require('cmp_nvim_lsp').default_capabilities()
-- Replace <YOUR_LSP_SERVER> with each lsp server you've enabled.
require('lspconfig')['pyright'].setup {
	capabilities = capabilities
}

require('lspconfig')['terraformls'].setup {
	capabilities = capabilities
}

require('lspconfig')['tsserver'].setup {
	capabilities = capabilities
}

require('lspconfig')['rust_analyzer'].setup {
	capabilities = capabilities
}

require('lspconfig')['gopls'].setup {
	capabilities = capabilities
}
--- }}}
