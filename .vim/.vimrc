
"vimconf is not ci-compatible
set nocompatible

""" Automatically make needed files and folders on first run
""" If you don't run *nix you're on your own (as in remove this) {{{
    call system("mkdir -p $HOME/.vim/{backuplugin,undo}")
    if !filereadable($HOME . "/.vimrc.bundles") | call system("touch $HOME/.vimrc.bundles") | endif
    if !filereadable($HOME . "/.vimrc.first") | call system("touch $HOME/.vimrc.first") | endif
    if !filereadable($HOME . "/.vimrc.last") | call system("touch $HOME/.vimrc.last") | endif
""" }}}

""" Vundle plugin manager {{{
    """ Automatically setting up Vundle, taken from
    """ http://www.erikzaadi.com/2012/03/19/auto-installing-vundle-from-your-vimrc/ {{{
        let has_vundle=1
        if !filereadable($HOME."/.vim/bundle/vundle/README.md")
            echo "Installing Vundle..."
            echo ""
            silent !mkdir -p $HOME/.vim/bundle
            silent !git clone https://github.com/gmarik/vundle $HOME/.vim/bundle/vundle
            let has_vundle=0
        endif
    """ }}}

    """ Initialize Vundle {{{
        filetype off                                " required to init
        set rtp+=$HOME/.vim/bundle/vundle/          " include vundle
        call vundle#rc()                            " init vundle
    """ }}}

    " Recursive vundle, omg!
    Bundle 'gmarik/vundle'

    """ Local bundles (and only bundles in this file!) {{{{
        if filereadable($HOME."/.vimrc.bundles")
            source $HOME/.vimrc.bundles
        endif
    """ }}}

    " Bundles
    Bundle 'Lokaltog/vim-easymotion'
    Bundle 'scrooloose/nerdtree'
    Bundle 'Lokaltog/vim-distinguished'
    Bundle 'moll/vim-node'

    """ }}}
    """ Installing plguins the first time {{{
        if has_vundle == 0
            echo "Installing Bundles, please ignore key map error messages"
            echo ""
            :BundleInstall
        endif
    """ }}}
""" }}} 

""" Local beginning config, only use for prerequisites as it will be
""" overwritten by anything below {{{{
    if filereadable($HOME."/.vimrc.first")
        source $HOME/.vimrc.first
    endif
""" }}}

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

""" F Key Mappings
nnoremap <silent> <F7>  :NERDTreeToggle<CR>

""" NERDTree Options
map <leader>e :NERDTreeFind<CR>
nmap <leader>nt :NERDTreeFind<CR>
let NERDTreeMinimalUI=1
let NERDTreeShowBookmarks=1
let NERDTreeIgnore=['\.pyc', '\~$', '\.swo$', '\.swp$', '\.git', '\.hg', '\.svn', '\.bzr']
let NERDTreeChDirMode=0
let NERDTreeQuitOnOpen=1
let NERDTreeShowHidden=1
let NERDTreeKeepTreeInNewTab=1

""" EasyMotion
let g:EasyMotion_leader_key = 'm'
