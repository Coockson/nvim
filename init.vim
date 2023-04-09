" --- Neovim custom config ---
"  Author: Coockson
"


" --- Custom Lua plugins ---

lua require('linters/python_black')
lua require('linters/terraform_fmt')
lua require('foundation/refresh_change')
lua require('foundation/autocomment')

" --- Basic editor configs ---

:set number
:set autoindent
:set tabstop=4
:set shiftwidth=4
:set smarttab
:set softtabstop=4
:set mouse=a
:set updatetime=50
:set clipboard+=unnamedplus
:set laststatus=3
:let mapleader=" "


" --- External Plugins ---
"  Use :PlugInstall to install the listed plugins

call plug#begin()

Plug 'http://github.com/tpope/vim-surround' " Surrounding ysw)
Plug 'https://github.com/preservim/nerdtree' " NerdTree
Plug 'Xuyuanp/nerdtree-git-plugin' " SHow git changes in nerdtree
Plug 'https://github.com/airblade/vim-gitgutter' " Show changes in editor
Plug 'https://github.com/tpope/vim-commentary' " For Commenting gcc & gc
Plug 'https://github.com/vim-airline/vim-airline' " Status bar
Plug 'https://github.com/lifepillar/pgsql.vim' " PSQL Pluging needs :SQLSetType pgsql.vim
Plug 'https://github.com/ap/vim-css-color' " CSS Color Preview
Plug 'https://github.com/rafi/awesome-vim-colorschemes' " Retro Scheme
Plug 'https://github.com/neoclide/coc.nvim'  " Auto Completion
Plug 'https://github.com/ryanoasis/vim-devicons' " Developer Icons
Plug 'https://github.com/preservim/tagbar' " Tagbar for code navigation
Plug 'https://github.com/terryma/vim-multiple-cursors' " CTRL + N for multiple cursors
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'https://github.com/tpope/vim-fugitive'
Plug 'https://github.com/iamcco/markdown-preview.nvim'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.1' }

set encoding=UTF-8

call plug#end()



" ------ Keybindings ------

" mapping : to ; because I use ISO keyboard layout
nnoremap ; :
vnoremap ; :

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

" Working with tabs
nnoremap <Tab> gt
nnoremap <Leader><Tab> gT
" Go to tab by number
noremap <leader>1 1gt
noremap <leader>2 2gt
noremap <leader>3 3gt
noremap <leader>4 4gt
noremap <leader>5 5gt
noremap <leader>6 6gt
noremap <leader>7 7gt
noremap <leader>8 8gt
noremap <leader>9 9gt

" Mark line and jump to mark
nnoremap <Leader>m mx
nnoremap <Leader>mm 'x


" Tab for writing suggested autocomplete
" inoremap <silent><expr> <Tab> coc#pum#visible() ? coc#_select_confirm() : "<TAB>"
" inoremap <silent><expr> <C-r>:call CocActionAsync('showSignatureHelp')<CR>

" NERTree toggles
nnoremap <Leader>n :NERDTreeToggle<CR>
nnoremap <Leader>t :terminal<CR>
tnoremap <Esc> <C-\><C-n>

" GOTO Definition
nnoremap <Leader>p :call CocActionAsync('jumpDefinition')<CR>
nnoremap <Leader>o <C-o><CR>


" See git files
" nnoremap <Leader>d :GFiles<CR>
" Search in all files
" nnoremap <Leader>f :Ag<CR>
" See open buffers (editors)
" nnoremap <Leader>b :Buffers<CR>

" COPY
" copy selected to clipboard
vnoremap <C-c> "+y<CR>
" copy entire file to clipboard
nnoremap <C-c> "+y<CR>

" See git changes
nnoremap <Leader>g :GF?<CR>

" nnoremap <C-c> :bd<CR>
nnoremap <C-s> :TerminalVSplit zsh<CR>



:set completeopt-=preview " For No Previews


" --- Colorschemes ---

:colorscheme jellybeans


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

" --- Just Some Notes ---
" :PlugClean :PlugInstall :UpdateRemotePlugins
"
" :CocInstall coc-python
" :CocInstall coc-clangd
" :CocInstall coc-snippets
" :CocCommand snippets.edit... FOR EACH FILE TYPE

" air-line
let g:airline_powerline_fonts = 1

if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif

" airline symbols
let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''
let g:airline_symbols.branch = ''
let g:airline_symbols.readonly = ''
let g:airline_symbols.linenr = ''

" Triger `autoread` when files changes on disk
" https://unix.stackexchange.com/questions/149209/refresh-changed-content-of-file-opened-in-vim/383044#383044
" https://vi.stackexchange.com/questions/13692/prevent-focusgained-autocmd-running-in-command-line-editing-mode
"autocmd FocusGained,BufEnter,CursorHold,CursorHoldI *
"		\ if mode() !~ '\v(c|r.?|!|t)' && getcmdwintype() == '' | checktime | endif
"
"" Notification after file change
"" https://vi.stackexchange.com/questions/13091/autocmd-event-for-autoread
"autocmd FileChangedShellPost *
"  \ echohl WarningMsg | echo "File changed on disk. Buffer reloaded." | echohl None



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
