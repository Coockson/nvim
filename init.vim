" --- Neovim custom config ---
"  Author: Coockson
"


" --- Custom Lua plugins ---

lua require('linters/python_black')
lua require('linters/terraform_fmt')
lua require('foundation/refresh_change')
lua require('foundation/autocomment')
lua require('foundation/terminal')
lua require('git/commit')

" --- Basic editor configs ---

:set number
:set autoindent
:set tabstop=4
:set shiftwidth=4
:set smarttab
:set softtabstop=4
:set mouse=a
:set updatetime=50
:set laststatus=3
:set splitbelow
:set winbar=%=%m\ %f
:let mapleader=" "
:let g:airline#extensions#tabline#enabled = 1

if has("unnamedplus")
    set clipboard=unnamedplus
else
    set clipboard=unnamed
endif


" --- External Plugins ---
"  Use :PlugInstall to install the listed plugins

call plug#begin()

Plug 'http://github.com/tpope/vim-surround' " Surrounding ysw)
Plug 'https://github.com/preservim/nerdtree' " NerdTree
Plug 'Xuyuanp/nerdtree-git-plugin' " SHow git changes in nerdtree
Plug 'https://github.com/airblade/vim-gitgutter' " Show changes in editor
Plug 'https://github.com/tpope/vim-commentary' " For Commenting gcc & gc
" Plug 'https://github.com/vim-airline/vim-airline' " Status bar
Plug 'https://github.com/lifepillar/pgsql.vim' " PSQL Pluging needs :SQLSetType pgsql.vim
Plug 'https://github.com/ap/vim-css-color' " CSS Color Preview
Plug 'https://github.com/rafi/awesome-vim-colorschemes' " Retro Scheme
Plug 'https://github.com/neoclide/coc.nvim', {'branch': 'release'}  " Auto Completion
Plug 'https://github.com/ryanoasis/vim-devicons' " Developer Icons
Plug 'https://github.com/preservim/tagbar' " Tagbar for code navigation
Plug 'https://github.com/terryma/vim-multiple-cursors' " CTRL + N for multiple cursors
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'https://github.com/tpope/vim-fugitive'
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install' }
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.5' }
Plug 'fannheyward/telescope-coc.nvim'
Plug 'tomasiser/vim-code-dark' " VS Code colorscheme
Plug 'MunifTanjim/nui.nvim'
Plug 'nvim-lualine/lualine.nvim'
Plug 'https://github.com/Coockson/ipynb.nvim'
Plug 'https://github.com/Coockson/popterminal.nvim'

set encoding=UTF-8

call plug#end()



" ------ Keybindings ------

" mapping : to ; because I use ISO keyboard layout
nnoremap ; :
vnoremap ; :

" mapping § to ESC for my TKL keyboard
noremap <expr> § "\<Esc>"
inoremap <expr> § "\<Esc>"

" Mapping window movements to leader
nnoremap <Leader>ww :winc w<CR>
nnoremap <Leader>wl :winc l<CR>
nnoremap <Leader>wh :winc h<CR>
nnoremap <Leader>wj :winc j<CR>
nnoremap <Leader>wk :winc k<CR>

" Moving the windows
nnoremap <Leader>wH <c-w>H
nnoremap <Leader>wJ <c-w>J
nnoremap <Leader>wK <c-w>K
nnoremap <Leader>wL <c-w>L

" Move beginning and end
nnoremap <Leader>s ^
vnoremap <Leader>s ^
nnoremap <Leader>l $
vnoremap <Leader>l $

" Make TAB indent in normal mode
nnoremap <Leader>. >>
vnoremap <Leader>. >>
nnoremap <Leader>, <<
vnoremap <Leader>, <<

" Comment shortcuts
nnoremap <Leader>cb :AutoComment<CR>
nnoremap <Leader>cv :AutoUncomment<CR>
nnoremap <Leader>cc :CommentSingleLine<CR>
nnoremap <Leader>cx :UncommentSingleLine<CR>
vnoremap <Leader>cb :AutoComment<CR>
vnoremap <Leader>cv :AutoUncomment<CR>
vnoremap <Leader>cc :CommentSingleLine<CR>
vnoremap <Leader>cx :UncommentSingleLine<CR>

" Find files using Telescope command-line sugar.
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>
nnoremap <Leader>gs <cmd>Telescope git_status<cr>
nnoremap <Leader>gb <cmd>Telescope git_branches<cr>
nnoremap <Leader>gh <cmd>Telescope git_commits<cr>
nnoremap <Leader>s <cmd>Telescope current_buffer_fuzzy_find<cr>

" Working with tabs
nnoremap <Tab> gt
nnoremap <Leader><Tab> gT

" Mark line and jump to mark
nnoremap <Leader>m mx
nnoremap <Leader>mm 'x

" Plugin development
nnoremap <Leader>5 :source %<CR>

" Tab for writing suggested autocomplete
" inoremap <silent><expr> <Tab> coc#pum#visible() ? coc#_select_confirm() : "<TAB>"
" inoremap <silent><expr> <C-r>:call CocActionAsync('showSignatureHelp')<CR>

" NERTree toggles
nnoremap <Leader>n :NERDTreeToggle<CR>
nnoremap <Leader>t :PopTerminal<CR>
tnoremap <Esc> <C-\><C-n>

" GOTO Definition
nnoremap <Leader>p :call CocActionAsync('jumpDefinition')<CR>
nnoremap <Leader>o <C-o><CR>


" See git files
nnoremap <Leader>gc :GitCommit<CR>

" COPY
" copy selected to clipboard
vnoremap <C-c> "+y<CR>
" copy entire file to clipboard
nnoremap <C-c> "+y<CR>

" See git changes

" nnoremap <C-c> :bd<CR>
nnoremap <C-s> :TerminalVSplit zsh<CR>



:set completeopt-=preview " For No Previews

:set rtp^="/Users/dkmukhco/.opam/default/share/ocp-indent/vim"

" --- Colorschemes ---

" ----------------------------- VS Code theme related settings -------------------------------------
:colorscheme codedark																			  "-
:set t_Co=256																					  "-
:set t_ut=																						  "-
" If you don't like many colors and prefer the conservative style of the standard Visual Studio   "-
let g:codedark_conservative=1																      "-
" Activates italicized comments (make sure your terminal supports italics)						  "-
let g:codedark_italics=1																		  "-
" Make the background transparent																  "-
let g:codedark_transparent=1																	  "-
" If you have vim-airline, you can also enable the provided theme                                 "-
let g:airline_theme = 'codedark'																  "-
" --------------------------------------------------------------------------------------------------

" :colorscheme solarized-osaka

" set termguicolors     " enable true colors support
" let ayucolor="mirage"   " for dark version of theme
" colorscheme ayu

" :colorscheme jellybeans
" :colorscheme wombat256mod
" :colorscheme gruvbox
" :colorscheme onedark
" :colorscheme PaperColor

" --- Global variables ---

let g:NERDTreeMouseMode=3
let g:NERDTreeDirArrowExpandable="+"
let g:NERDTreeDirArrowCollapsible="~"
let g:NERDTreeMinimalMenu=1
let NERDTreeShowHidden=1
let g:neoterm_size=16
let g:Terminal_StartMessages = 0
let g:python3_host_prog = '/Users/dkMuKhCo/.pyenv/versions/neovim3/bin/python'



" MarkdownPreview set default theme (dark or light)
" By default the theme is define according to the preferences of the system
let g:mkdp_theme = 'dark'


" ----- Highlights (treesitter) -----

lua << EOF
	require("nvim-treesitter.configs").setup({
		ensure_installed = { "terraform", "hcl", "python", "yaml", "javascript", "typescript", "lua", "vim", "json", "html", "tsx" },
		ignore_install = { "markdown" },
		sync_install = false,
		auto_install = true,
		highlight = {
			enable = true,
		},
	})
EOF


" Enable copy to clipboard for windows with WSL
lua << EOF
	if vim.fn.has('wsl') == 1 then
		vim.api.nvim_create_autocmd('TextYankPost', {
			group = vim.api.nvim_create_augroup('Yank', { clear = true }),
			callback = function()
				vim.fn.system('clip.exe', vim.fn.getreg('"'))
			end,
		})
	end
EOF

" Telescope settings

lua << EOF
	require('telescope').load_extension('coc')
EOF

lua << EOF
	require('lualine').setup()
EOF

lua << EOF
 	require('popterminal')
EOF

" lua << EOF
" 	require('ipynb')
" EOF

" --- Coc Keybindings ---
"  Copied from https://github.com/neoclide/coc.nvim

" Next two is to make Coc selections visible in dark themes
:hi CocMenuSel ctermbg=darkgrey ctermfg=yellow
:hi CocSearch ctermfg=blue


" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved
set signcolumn=yes

" Use tab for trigger completion with characters ahead and navigate
" NOTE: There's always complete item selected by default, you may want to enable
" no select by `"suggest.noselect": true` in your configuration file
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config
inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1) :
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

" Make <CR> to accept selected completion item or notify coc.nvim to format
" <C-g>u breaks current undo, please make your own choice
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window
nnoremap <silent> K :call ShowDocumentation()<CR>

function! ShowDocumentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call feedkeys('K', 'in')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code
xmap <leader>r  <Plug>(coc-format-selected)
nmap <leader>r  <Plug>(coc-format-selected)
