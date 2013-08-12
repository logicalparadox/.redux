""" Setups pathogen loading
runtime! autoload/pathogen.vim
silent! call pathogen#helptags()
silent! call pathogen#runtime_append_all_bundles()

""" Change mapleader
let mapleader=","

""" Basic Configuration
set autochdir
set autoindent
set autowrite
set backspace=indent,eol,start
set bs=2
set cursorline
set equalalways
set expandtab
set foldmethod=syntax
set foldminlines=5
set hlsearch
set laststatus=2
set lcs=tab:›\ ,trail:·,eol:¬,nbsp:_
set list
set mouse=a
set nocompatible
set nowrap
set number
set showcmd
set shiftwidth=2
set showfulltag
set showmode
set smartindent
set splitbelow
set splitright
set tabstop=2
set undolevels=1000
set virtualedit=onemore

""" Paste toggle (,p)
set pastetoggle=<leader>p
map <leader>p :set invpaste paste?<CR>

""" Options

filetype on
syn on

""" Hard code tabs in Makefiles
autocmd FileType make setlocal noexpandtab

""" Strip whitespace on save for these files
autocmd FileType c,cpp,javahp,javascript autocmd BufWritePre <buffer> :%s/\s\+$//e

""" Theme optsion
colorscheme distinguished

""" Indent/unident block (,]) (,[)
nnoremap <leader>] >i{<CR>
nnoremap <leader>[ <i{<CR>

""" Remap command key
nnoremap ; :

cmap w!! %!sudo tee > /dev/null %

""" Clear search highlighting
nnoremap <silent> <Leader>/ :nohlsearch<CR>

set noerrorbells visualbell t_vb=
autocmd GUIEnter * set visualbell t_vb=

""" Remap movement keys for windows
map <c-j> <c-w>j
map <c-k> <c-w>k
map <c-l> <c-w>l
map <c-h> <c-w>h

""" http://jeetworks.org/node/89
function! s:MoveLineUp()
  call <SID>MoveLineOrVisualUp(".", "")
endfunction

function! s:MoveLineDown()
  call <SID>MoveLineOrVisualDown(".", "")
endfunction

function! s:MoveVisualUp()
  call <SID>MoveLineOrVisualUp("'<", "'<,'>")
  normal gv
endfunction

function! s:MoveVisualDown()
  call <SID>MoveLineOrVisualDown("'>", "'<,'>")
  normal gv
endfunction

function! s:MoveLineOrVisualUp(line_getter, range)
  let l_num = line(a:line_getter)
  if l_num - v:count1 - 1 < 0
    let move_arg = "0"
  else
    let move_arg = a:line_getter." -".(v:count1 + 1)
  endif
  call <SID>MoveLineOrVisualUpOrDown(a:range."move ".move_arg)
endfunction

function! s:MoveLineOrVisualDown(line_getter, range)
  let l_num = line(a:line_getter)
  if l_num + v:count1 > line("$")
    let move_arg = "$"
  else
    let move_arg = a:line_getter." +".v:count1
  endif
  call <SID>MoveLineOrVisualUpOrDown(a:range."move ".move_arg)
endfunction

function! s:MoveLineOrVisualUpOrDown(move_arg)
  let col_num = virtcol(".")
  execute "silent! ".a:move_arg
  execute "normal! ".col_num."|"
endfunction

" Arrow key remapping:
" Up/Dn = move line up/dn
" Left/Right = indent/unindent
function! SetArrowKeysAsTextShifters()
  " Normal mode
  nnoremap <silent> <Left>   <<
  nnoremap <silent> <Right>  >>
  nnoremap <silent> <Up>     <Esc>:call <SID>MoveLineUp()<CR>
  nnoremap <silent> <Down>   <Esc>:call <SID>MoveLineDown()<CR>

  " Visual mode
  vnoremap <silent> <Left>   <gv
  vnoremap <silent> <Right>  >gv
  vnoremap <silent> <Up>     <Esc>:call <SID>MoveVisualUp()<CR>
  vnoremap <silent> <Down>   <Esc>:call <SID>MoveVisualDown()<CR>

  " Insert mode
  inoremap <silent> <Left>   <C-D>
  inoremap <silent> <Right>  <C-T>
  inoremap <silent> <Up>     <C-O>:call <SID>MoveLineUp()<CR>
  inoremap <silent> <Down>   <C-O>:call <SID>MoveLineDown()<CR>
endfunction

call SetArrowKeysAsTextShifters()
