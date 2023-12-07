"""
" Maintainer:
" 	rdtrob
" Site:
" 	https://robertdoes.com
" Mail:
" 	robert AT robertdoes DOT com
"
" Sections:
" 	=> Vundle
" 	=> General
" 	=> VIM user interface
" 	=> Colors and Fonts
" 	=> Files and Backups
" 	=> Programming specific
" 	=> Text, tabs, indentation
" 	=> Visual Mode
" 	=> Moving around, buffers
" 	=> Status line
" 	=> Editing mappings
" 	=> Vimgrep searching and displaying
" 	=> Spell checking
" 	=> Misc
" 	=> Helper functions
" 	=> EOF
"""

"""
" => Vundle
"""

" Set runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim

" Load plugins
call vundle#begin()

" Let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
Plugin 'tpope/vim-fugitive'
Plugin 'srcery-colors/srcery-vim'
Plugin 'vim-airline/vim-airline'  " vim-airline, powerline replacement, 100% vimscript, no python
Plugin 'vim-airline/vim-airline-themes'
Plugin 'jeffkreeftmeijer/vim-numbertoggle'
Plugin 'ctrlpvim/ctrlp.vim'       " <C-p> fuzzysearch
Plugin 'vim-syntastic/syntastic'
Plugin 'scrooloose/nerdtree'
Plugin 'neomake/neomake'          " Neomake to asynchronously run programs. Check neomake#configure line below 
Plugin 'arcticicestudio/nord-vim'
Plugin 'romainl/apprentice'
Plugin 'haystackandroid/carbonized'
Plugin 'sindrets/diffview.nvim'
Plugin 'airblade/vim-gitgutter'
Plugin 'itchyny/lightline.vim'
Plugin 'Xuyuanp/nerdtree-git-plugin'
Plugin 'ryanoasis/vim-devicons'

"> Go
Plugin 'fatih/vim-go'             " { 'do': ':GoInstallBinaries' }
"Plugin 'neoclide/coc.nvim', {'branch': 'release'}
"Plugin 'mdempsky/gocode'

"> Debugging
Plugin 'mfussenegger/nvim-dap'
Plugin 'leoluz/nvim-dap-go'
Plugin 'rcarriga/nvim-dap-ui'

" All plugins should be added before this line
call vundle#end()

"""
" => General
"""
set history=100
syntax on
filetype off
filetype plugin on
filetype plugin indent on

set nocompatible

" 74 columns is the safest width for most terminals, especially
"   since Vim with line numbering chews up five of them
set textwidth=74

" Avoid most of the 'Hit Enter ...' messages
set shortmess=aoOtI

" Enable omni-completion
set omnifunc=syntaxcomplete#Complete

" Enable folding
set foldmethod=indent
set foldlevel=99

" Set vimscript to never fold
au FileType vim setlocal nofoldenable
au FileType vim set nospell

" Display all the syntax rules for current position, useful
"   when writing vimscript syntax plugins
function! <SID>SynStack()
    if !exists("*synstack")A
        return
    endif
    echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
endfunc

" Start at the last place you were editing
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

" Pane switching
map <C-j> <C-W>j

map <Esc>[B <down>

"Vim-powerline requirement [python-powerline-git]from[AUR]
let $PYTHONPATH='/usr/lib/python3.4/site-packages'

" Enable folding with spacebar
nnoremap <space> za

autocmd VimEnter * NERDTree
autocmd BufEnter * NERDTreeMirror
let NERDTreeShowHidden=1

"CTRL-t to toggle tree view with CTRL-t
nmap <silent> <C-t> :NERDTreeToggle<CR>
""Set F2 to put the cursor to the nerdtree
nmap <silent> <F2> :NERDTreeFind<CR>
"NERDTree controls
"CTRL-t  - Open/Close the files tab
"CTRL-n  - Toggle relative / absolute numbering
"CTRL-ww - Switch between the files tab and the main window
"F2      - Focus cursor to files tab
"<Enter> - open the focused files/directory, duh!
"h,j,k,l - navigate the cursor left, down, up, right respectively
"i       - insert mode, you can start typing in your code.
"<ESC>   - back to default mode, where you can issue commands in vi
":w      - write/save the file, you are editing
":wqa    - save the file, then quit the editor closing vi including the files tab

"NERDTree Advanced controls
":bp - Open previous file/buffer
":bn - Open next file/buffer
":b <filename-part> - Open the file you are looking for without typing the exact filename
":vsp - vertically split the window
":vsp <filename> - open the file in vertical split
":sp - horizontal split
":sp <filename> - open the file in horizontal split

" Set auto read when a file is changed from outside vim
set autoread
au CursorHold * checktime

" Fast saving
nmap <leader>w :w!<cr>

" vim to clipboard
set clipboard=unnamed

" Always use vertical diffs
set diffopt+=vertical

" Relative line number
function! NumberToggle()
    if(&relativenumber == 1)
        set number
    else
        set relativenumber
    endif
endfunc

nnoremap <C-n> :call NumberToggle()<cr>

autocmd InsertEnter * :set number
autocmd InsertLeave * :set relativenumber

"""
" => VIM user interface
"""

" Set 7 lines to the cursor - when moving vertically using j/k
set so=7

" Turn on the wildmenu
set wildmenu

" Ignore compiled files
set wildignore=*.o,*~,*.pyc

" Always show current position
set ruler

" Configure backspace so it acts as it should
set backspace=eol,start,indent
set whichwrap+=<,>,h,l

"""
" => Colors and Fonts
"""

" Set extra options when running in GUI mode
if has("gui_running")
    set guioptions-=T
    set guioptions+=e
    set t_Co=256
    set guitablabel=%M\ %t
endif

if has('gui_running')
    colorscheme carbonized
    set background=dark
else
    colorscheme apprentice
"    "colorscheme nord
"    "set background=dark
"endif

"""
" => Files and Backups
"""

" Turn backup off, since most stuff is in svc anyway
set nobackup
set nowb
set noswapfile

" Use Unix as the standard file type
"set ffs=unix,doc,mac

" Set utf8 as standard encoding and en_US as the standard language
set encoding=UTF-8
set fileencodings=ucs-bom,utf-8,latin1,default

" rpdf convert pdf to text to be able to read in vim
":command! -complete=file -nargs=1 Rpdf :r !pdftotext -nopgbrk <q-args> -
":command! -complete=file -nargs=1 Rpdf :r !pdftotext -nopgbrk <q-args> - |fmt -csw78

" Neomake, conf for Vim/NeoVim to asynchronously run programs
" When writing a buffer (no delay)
call neomake#configure#automake('w')

" When writing a buffer (no delay), and on normal mode changes (after 750ms).
"call neomake#configure#automake('nw', 750)

" When reading a buffer (after 1s), and when writing (no delay).
"call neomake#configure#automake('rw', 1000)

" Full config: when writing or reading a buffer, and on changes in insert and
"   normal mode (after 500ms; no delay when writing).
"call neomake#configure#automake('nrwi', 500)

"""
" => Programming specific
"""

" Playpen integration
" Required webapi-vim to be installed
let g:rust_clip_command = 'xclip -selection clipboard'

" GOlang
" Autocomplete on .
au filetype go inoremap <buffer> . .<C-x><C-o>
autocmd vimleavepre *.go !gofmt -w % " backup if fatih fails
autocmd Filetype go setlocal tabstop=4 shiftwidth=4 softtabstop=4
"let g:go_fmt_command = "goimports" # Run goimports along gofmt on each save     
"let g:go_auto_type_info = 1 # Automatically get signature/type info for object under cursor     

" Set GO path for vim
"let g:go_bin_path = "/usr/bin/go"
"let $GOPATH = $HOME

"""
" => Text, tabs, indentation
"""

filetype indent on

" Always show line numbers, but only in current window. Use :vsp then Ctrl+W
" and HL to move between frames
set number
:au WinEnter * :setlocal number
:au WinLeave * :setlocal nonumber

" Automatically resize vertical splits
:au WinEnter * :set winfixheight
:au WinEnter * :wincmd =

" Set split
set splitbelow
set splitright

" Use spaces instead of tabs
set expandtab

set smarttab

set smartindent

set autoindent

" Set tab = 4 spaces
set tabstop=2
set shiftwidth=2
set softtabstop=2

" Settings for yaml files ( Ansible )
au BufNewFile,BufRead yaml
  \ setlocal ai sw=2 ts=2 et nu cuc
  \ set tabstop=4
  \ set softtabstop=4
  \ set shiftwidth=4
  \ set textwidth=79
  \ set expandtab
  \ set nospell

" Python with virtualenv support
"py3 << EOF
"import os
"import sys
"if 'VIRTUAL_ENV' in os.environ:
"  project_base_dir = os.environ['VIRTUAL_ENV']
"  activate_this = os.path.join(project_base_dir, 'bin/activate_this.py')
"  execfile(activate_this, dict(__file__=activate_this))
"EOF

" Make python code pretty
let python_highlight_all=1

" Full stack dev specific
au BufNewFile,BufRead *.js, *.html, *.css
  \ set tabstop=2
  \ set softtabstop=2
  \ set shiftwidth=2

" Linebreak on 500 characters
set lbr	" set linebreak
set tw=500

set ai " Auto indent
set si " Smart indent
set wrap " Wrap lines

" As much as possible, show last line in display
set display=lastline

" Do not highlight searched string
set nohlsearch

set icon

" For regular expressions turn magic on
set magic

" Show matching brackets when text indicator is over them
set showmatch

" How many tenths of a second to blink when matching brackets
set mat=2

" Disable annoying sound on errors
set noerrorbells
set novisualbell
set t_vb=
set tm=500

" Leave some space from cursor to upper/lower border in lista
set scrolloff=4

"""
" => Visual mode
"""
" Visual mode pressing * or # searches for the current selection
" Super useful! From an idea by Michael Naumann
vnoremap <silent> * :call VisualSelection('f')<CR>
vnoremap <silent> # :call VisualSelection('b')<CR>

"""
" => Moving around, buffers
"""

" Disable arrow keys
map <up> <nop>
map <down> <nop>
map <left> <nop>
map <right> <nop>

" Treat long lines as break lines ( useful when moving around in them )
map j gj
map k gk

" Disable highlight when <leader><cr> is pressed
map <silent> <leader><cr> :noh<cr>

" Smart way to move between windows
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-h> <C-w>h
map <C-l> <C-w>l

" Close the current buffer
map <leader>bd :Bclose<cr>

" Close all buffers
map <leader>ba :1,1000 bd!<cr>

" Buffer becomes hidden when it's abandoned
set hid

" Ignore case when searching
set ignorecase

" When searching try to be smart about cases
set smartcase

" Makes search act like searching in modern browsers
set incsearch

" Useful mappings for managing tabs
nnoremap  <silent>   <tab>  :if &modifiable && !&readonly && &modified <CR> :write<CR> :endif<CR>:bnext<CR>
nnoremap  <silent> <s-tab>  :if &modifiable && !&readonly && &modified <CR> :write<CR> :endif<CR>:bprevious<CR>

" Opens a new tab with the current buffer's path
" Super useful when editing files in the same directory
map <leader>te :tabedit <c-r>=expand("%:p:h")<cr>/

" Switch CWD to the directory of the open buffer
map <leader>cd :cd %:p:h<cr>:pwd<cr>

" Specify the behavior when switching between buffers
try
    set switchbuf=useopen,usetab,newtab
    set stal=2
catch
endtry

" Return to last edit position when opening files ( You want this! )
autocmd BufReadPost *
     \ if line("'\"") > 0 && line("'\"") <= line("$") |
     \   exe "normal! g`\"" |
     \ endif

" Remember info about open buffers on close
set viminfo^=%

"""
" => Status line
"""

" Always show the status line
set laststatus=2

" Use 256 colors ( Use this setting only if your terminal supports 256 colors)
set t_Co=256

"""
" => Editing mappings
"""
" Toggle gundo.vim
nnoremap <leader>u : GundoToggle<CR>

" Remap VIM 0 to first non-blank character
map 0 ^

" Delete trailing white space on save, useful for Python and CoffeeScript
func! DeleteTrailingWD()

    exe "normal mz"
    %s/\s\+$//ge
    exe "normal `z"
endfunc
autocmd BufWrite *.py :call DeleteTrailingWD()
autocmd BufWrite *.coffee :call DeleteTrailingWD()

"""
" => Vimgrep searching and displaying
"""

" Vimgrep after selecting text when pressing gv
vnoremap <silent> gv :call VisualSelection('gv')<CR>

"""
" => Spell checking
"""

set spell

"""
" => Misc
"""
" Memory management
set hidden

" Change vimdiff colorscheme
if &diff
	colorscheme molokai
  "curl -fLo ~/.vim/colors/molokai.vim --create-dirs https://raw.githubusercontent.com/tomasr/molokai/master/colors/molokai.vim
endif

" Enable mouse
set mouse=a

" Don't redraw while executing macros ( performance config )
set lazyredraw

"""
" => Helper functions
"""

" Designed for VIm 8+
let skip_defaults_vim=1

"""
" => EOF
"""
endif
