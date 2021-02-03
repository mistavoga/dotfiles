syntax on
filetype plugin indent on

"color settings
let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
set termguicolors

set noerrorbells
set belloff=all
set tabstop=4 softtabstop=4
set shiftwidth=4
set expandtab
set smartindent
set autoindent
set rnu
set nu
set nowrap
set smartcase
set noswapfile
set nobackup
set undodir=~/.vim/undodir
set undofile
set incsearch
set virtualedit=all
set hidden


call plug#begin('~/.vim/plugged')
"vim default plugins (important)
Plug 'morhetz/gruvbox'
Plug 'lyuts/vim-rtags'
Plug 'tpope/vim-fugitive'
Plug 'junegunn/fzf', {'do': { -> fzf#install() }}
Plug 'junegunn/fzf.vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'mbbill/undotree'
Plug 'mg979/vim-visual-multi' 
Plug 'takac/vim-hardtime'

"webdev essentials
Plug 'ap/vim-css-color'
Plug 'mattn/emmet-vim'
Plug 'digitaltoad/vim-pug'
Plug 'tpope/vim-haml'

"ui customizatons
Plug 'ryanoasis/vim-devicons'
Plug 'preservim/nerdtree'
Plug 'itchyny/vim-gitbranch'
Plug 'bling/vim-bufferline'

"language corner
Plug 'elixir-editors/vim-elixir'
Plug 'mhinz/vim-mix-format'
Plug 'tpope/vim-endwise'

Plug 'SirVer/ultisnips'
let g:UltiSnipsExpandTrigger = '<tab>'
let g:UltiSnipsJumpForwardTrigger = '<tab>'
let g:UltiSnipsJumpBackwardTrigger = '<s-tab>'

Plug 'lervag/vimtex'
let g:tex_flavor='latex'

"writing tools
Plug 'godlygeek/tabular'
Plug 'tpope/vim-markdown'
Plug 'junegunn/goyo.vim'
Plug 'junegunn/limelight.vim'
let g:limelight_conceal_guifg = '#777777'
Plug 'reedes/vim-pencil'
call plug#end()

au BufNewFile,BufRead *.ejs set filetype=html

"colortheme
let g:gruvbox_italic=1
set background=dark
colorscheme gruvbox 

"statusbar 

function! GitBranch()
  return system("git rev-parse --abbrev-ref HEAD 2>/dev/null | tr -d '\n'")
endfunction

function! StatuslineGit()
  let l:branchname = GitBranch()
  return strlen(l:branchname) > 0?'  '.l:branchname.' ':''
endfunction

set statusline=
set statusline+=%#StatusLineNC#
set statusline+=%f\ %w
set statusline+=%{&modified?'+':''}
set statusline+=%{StatuslineGit()}
set statusline+=%=
set statusline+=\ %w%{&ft}
set statusline+=\ %w
set statusline+=\|
set statusline+=\ %w%{&fenc}
set statusline+=\%w
set statusline+=\ %p%%
set statusline+=\ %l:%c
set statusline+=\ 

"Focus mode
autocmd! User GoyoEnter Limelight 0.9
autocmd! User GoyoLeave Limelight!

let mapleader = " "

" Automatically closing
inoremap { {}<Esc>hli
inoremap [ []<Esc>hli
inoremap ( ()<Esc>hli
inoremap " ""<Esc>hli

"fuzzy finding
nnoremap <silent> <C-f> :Files<CR>
nnoremap <silent> <leader>f :Rg<CR>

"buffline shortcuts
nnoremap <leader>p :bprev<CR>
nnoremap <leader>n :bnext<CR>
nnoremap <leader>d :bw<CR>

let NERDTreeShowHidden=1
nmap <F6> :NERDTreeToggle<CR>

nnoremap <leader>u :UndotreeShow<CR>

let g:python3_host_prog = '/home/nivoga/.pyenv/versions/3.8.5/envs/neovim3/bin/python'



