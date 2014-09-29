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
    Plugin 'gmarik/vundle'

    """ Local bundles (and only bundles in this file!) {{{{
        if filereadable($HOME."/.vimrc.bundles")
            source $HOME/.vimrc.bundles
        endif
    """ }}}

    """ Plugins {{{

        " Theme stuff
        Plugin 'w0ng/vim-hybrid'
        Plugin 'itchyny/lightline.vim'

        " Ease of use
        Plugin 'Lokaltog/vim-easymotion'
        Plugin 'scrooloose/nerdtree'
        Plugin 'scrooloose/nerdcommenter'
        Plugin 'junegunn/goyo.vim'

        " Bells
        Plugin 'tpope/vim-fugitive'
        Plugin 'Valloric/YouCompleteMe'
        Plugin 'SirVer/ultisnips'
        Plugin 'majutsushi/tagbar'

        " Language support
        Plugin 'digitaltoad/vim-jade'
        Plugin 'jelera/vim-javascript-syntax'
        Plugin 'wting/rust.vim'
        Plugin 'justinmk/vim-syntax-extra'
        Plugin 'dart-lang/dart-vim-plugin'
        Plugin 'plasticboy/vim-markdown'
        Plugin 'honza/dockerfile.vim'
        Plugin 'fatih/vim-go'

    """ }}}

    """ Installing plugins the first time {{{
        if has_vundle == 0
            echo "Installing Plugins, please ignore key map error messages"
            echo ""
            :PluginInstall
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

""" Statusline ?
set statusline=%<%f\ %h%m%r%{fugitive#statusline()}%=%-14.(%l,%c%V%)\ %P

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

" disable Background Color Erase (BCE) so that color schemes
" render properly when inside 256-color tmux and GNU screen.
" see also http://snk.tuxfamily.org/log/vim-256color-bce.html
if &term =~ '256color'
  set t_ut=
endif

""" Paste toggle (,p)
set pastetoggle=<leader>p
map <leader>p :set invpaste paste?<CR>

""" Options

filetype on
filetype plugin on
syntax on

""" Colums
if exists('+colorcolumn')
  set colorcolumn=80
else
  au BufWinEnter * let w:m2=matchadd('ErrorMsg', '\%>80v.\+', -1)
endif

""" Hard code tabs in Makefiles
autocmd FileType make setlocal noexpandtab

""" Strip whitespace on save for these files
autocmd FileType c,cpp,javahp,javascript autocmd BufWritePre <buffer> :%s/\s\+$//e

""" Theme optsion
colorscheme hybrid

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

""" GO
let g:go_fmt_fail_silently = 1
let g:go_fmt_command = "gofmt"


au FileType go nmap gd <Plug>(go-def)
au FileType go nmap <Leader>s <Plug>(go-def-split)
au FileType go nmap <Leader>v <Plug>(go-def-vertical)
au FileType go nmap <Leader>t <Plug>(go-def-tab)

au FileType go nmap <Leader>i <Plug>(go-info)

au FileType go nmap  <leader>r  <Plug>(go-run)
au FileType go nmap  <leader>b  <Plug>(go-build)

au FileType go nmap <Leader>d <Plug>(go-doc)

""" Ultisnips

function! g:UltiSnips_Complete()
    call UltiSnips#ExpandSnippetOrJump()
    if g:ulti_expand_or_jump_res == 0
        if pumvisible()
            return "\<C-N>"
        else
            return "\<TAB>"
        endif
    endif

    return ""
endfunction

function! g:UltiSnips_Reverse()
    call UltiSnips#JumpBackwards()
    if g:ulti_jump_backwards_res == 0
        return "\<C-P>"
    endif

    return ""
endfunction


if !exists("g:UltiSnipsJumpForwardTrigger")
    let g:UltiSnipsJumpForwardTrigger = "<tab>"
endif

if !exists("g:UltiSnipsJumpBackwardTrigger")
    let g:UltiSnipsJumpBackwardTrigger="<s-tab>"
endif

au BufEnter * exec "inoremap <silent> " . g:UltiSnipsExpandTrigger . " <C-R>=g:UltiSnips_Complete()<cr>"
au BufEnter * exec "inoremap <silent> " . g:UltiSnipsJumpBackwardTrigger . " <C-R>=g:UltiSnips_Reverse()<cr>"
