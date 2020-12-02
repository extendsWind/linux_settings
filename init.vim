
set fileencodings=utf-8,ucs-bom,gb18030,gbk,gb2312,cp936
set termencoding=utf-8
set encoding=utf-8


if empty(glob('~/.vim/plugged'))
   silent !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
"  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif
call plug#begin('~/.vim/plugged')

" Syntax and language specific
Plug 'tpope/vim-git'
Plug 'othree/html5.vim'
Plug 'tpope/vim-markdown'
" Plug 'pangloss/vim-javascript'
" Plug 'mxw/vim-jsx'
" Plug 'hail2u/vim-css3-syntax'
Plug 'vim-scripts/indentpython.vim', { 'for': 'python' }
Plug 'justmao945/vim-clang'

if has('nvim')
  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
endif
" else
"   Plug 'Shougo/deoplete.nvim'
"   Plug 'roxma/nvim-yarp'
"   Plug 'roxma/vim-hug-neovim-rpc'
" endif

" Plug 'wokalski/autocomplete-flow'
" You will also need the following for function argument completion:
" Plug 'Shougo/neosnippet'
" Plug 'Shougo/neosnippet-snippets'


" ## python

" Plug 'w0rp/ale'   " PEP check for python

Plug 'davidhalter/jedi-vim'
 " python-neovim is needed for neovim
 " Completion <C-Space>
 " Goto assignments <leader>g (typical goto function)
 " Goto definitions <leader>d (follow identifier as far as possible, includes imports and statements)
 " Show Documentation/Pydoc K (shows a popup with assignments)
 " Renaming <leader>r
 " Usages <leader>n (shows all the usages of a name)

call plug#end()

set nocompatible
filetype plugin indent on


set guifont=Droid\ Sans\ Mono\ 10

let g:deoplete#enable_at_startup = 1

set mouse=v  " mouse mode just in visual mode

set ts=2
set expandtab
set autoindent
set nu


imap <C-f> <Right>
imap <C-p> <Up>
imap <C-n> <Down>
imap <C-b> <Left>
imap <C-e> <End>
imap <C-a> <Home>
imap <C-d> <Delete>
imap <M-f> <C-Right>
imap <M-b> <C-Left>
