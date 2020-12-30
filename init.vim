set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath
source ~/.vimrc

let g:mapleader = "\<Space>"

call plug#begin()
Plug 'phanviet/vim-monokai-pro'
Plug 'scrooloose/nerdtree'
Plug 'sheerun/vim-polyglot'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'jiangmiao/auto-pairs'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'tpope/vim-fugitive'
Plug 'ryanoasis/vim-devicons'
Plug 'metakirby5/codi.vim'
"Plug 'dense-analysis/ale'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'heavenshell/vim-jsdoc', { 
  \ 'for': ['javascript', 'javascript.jsx','typescript'], 
  \ 'do': 'make install'
\}


"Plug 'Shougo/deoplete.nvim', {'do': ':UpdateRemotePlugins'}
call plug#end()

syntax enable " Syntax higlighting
set hidden " Keep multiple buffers open
set nowrap " Display long lines
set ruler " Cursor position
set splitbelow " Horizontal split will open below
set splitright " Vertical split will open right
set t_Co=256 " Display 256 colors
set tabstop=2 " a tab is 2 spaces
set smartindent " Smarter indent
set laststatus=0 " Display the status line
set number " Line number
set cursorline " Highlights cursor line
set updatetime=300 " faster completion
set foldmethod=indent " automatic folds on indents

" Appearance
set termguicolors
colorscheme monokai_pro
let g:lightline = {'colorscheme': 'monokai_pro', }


" Airline
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1
let g:airline_section_warning = ''
let g:airline#extensions#tabline#buffer_nr_show = 1

" indent Line
let g:indentLine_setColors = 0
let g:indentLine_char_list = ['|', '¦', '┆', '┊']
let g:indentLine_color_gui = '#9d9d9e'

" fzf-vim
let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-s': 'split',
  \ 'ctrl-v': 'vsplit' }
let g:fzf_colors =
\ { 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Comment'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'Type'],
  \ 'border':  ['fg', 'Ignore'],
  \ 'prompt':  ['fg', 'Character'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment'] }

" Deoplete
let g:deoplete#enable_at_startup = 1

" Remaps 
nmap <leader>kk :NERDTreeToggle<CR>
nmap <leader>nf :NERDTreeFind<CR>
nmap <leader>pp :GFiles<CR>
nmap <leader>ff :Ag<CR>
nmap <leader>vs :vsplit<CR>
nmap <leader>hs :split<CR>
nmap <leader>qq :bd<CR>
" copy to system clipboard
nmap <Leader>y "*y
" paste from system clipboard
nmap <Leader>p "*p
" lists registers
nmap <Leader>rl :registers<CR>

" Conquer of Completion setup
let g:coc_global_extensions = [
  \ 'coc-tsserver',
  \ 'coc-flow'
  \ ]
 "activtes prettier and eslint for project that have it installed
if isdirectory('./node_modules') && isdirectory('./node_modules/prettier')
  let g:coc_global_extensions += ['coc-prettier']
endif

if isdirectory('./node_modules') && isdirectory('./node_modules/eslint')
  let g:coc_global_extensions += ['coc-eslint']
endif

" automatic doc display
function! ShowDocIfNoDiagnostic(timer_id)
  if (coc#float#has_float() == 0)
    silent call CocActionAsync('doHover')
  endif
endfunction

function! s:show_hover_doc()
  call timer_start(500, 'ShowDocIfNoDiagnostic')
endfunction

autocmd CursorHoldI * :call <SID>show_hover_doc()
autocmd CursorHold * :call <SID>show_hover_doc()

" bindings
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> vgd :call CocAction('jumpDefinition', 'vsplit')<cr>
nmap <silent> hgd :call CocAction('jumpDefinition', 'split')<cr>
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gr <Plug>(coc-references)
nnoremap <silent> <space>d :<C-u>CocList diagnostics<cr>
nmap <leader>do <Plug>(coc-codeaction)
nnoremap <silent> <space>s :<C-u>CocList -I symbols<cr>
nmap <leader>rn <Plug>(coc-rename)
" remaps <CR> for correct use in auto complete

inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm() : "\<C-g>u\<CR>"
nnoremap <silent> K :call CocAction('doHover')<CR>
" use <tab> for trigger completion and navigate to the next complete item
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~ '\s'
endfunction

inoremap <silent><expr> <Tab>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<Tab>" :
      \ coc#refresh()



" turn hybrid line numbers on
:set number relativenumber
:set nu rnu

au! BufWritePost $MYVIMRC source %

