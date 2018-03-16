" no vi-compatible
set nocompatible
syntax on

" Setting up Vundle - the vim plugin bundler
let iCanHazVundle=1
let vundle_readme=expand('~/.local/share/nvim/site/autoload/plug.vim')
if !filereadable(vundle_readme)
    echo "Installing Vim-pug..."
    echo ""
    silent !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    let iCanHazVundle=0
endif

" required for vundle
filetype off

"
" Mostrar caracteres
"
set listchars=eol:$,tab:>-,trail:~,extends:>,precedes:<,nbsp:☠,tab:▸␣
" set listchars=eol:$,tab:>-,trail:~,extends:>,precedes:<,nbsp:☠,tab:▸␣,space:.
set list

" Specify a directory for plugins
" - For Neovim: ~/.local/share/nvim/plugged
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.vim/plugged')
" ===========================================================
" ***************** INSTALL *********************************
" ===========================================================
" Plugins from GitHub repos:
"
Plug 'prabirshrestha/async.vim'
Plug 'prabirshrestha/vim-lsp'
Plug 'prabirshrestha/asyncomplete.vim'
Plug 'prabirshrestha/asyncomplete-lsp.vim'
"
Plug 'scrooloose/syntastic'
" Better file browser
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
" Code commenter
Plug 'scrooloose/nerdcommenter'
" Class/module browser
Plug 'majutsushi/tagbar'
" Code and files fuzzy finder
Plug 'kien/ctrlp.vim'
" Extension to ctrlp, for fuzzy command finder
Plug 'fisadev/vim-ctrlp-cmdpalette'
" The following are examples of different formats supported.
" plugin on GitHub repo
Plug 'tpope/vim-fugitive'

" Command T
Plug 'wincent/command-t'
"
" Airline
"
Plug 'bling/vim-airline'
" Terminal Vim with 256 colors colorscheme
Plug 'fisadev/fisa-vim-colorscheme'
" Consoles as buffers
Plug 'rosenfeld/conque-term'
" Pending tasks list
Plug 'fisadev/FixedTaskList.vim'
" Surround
Plug 'tpope/vim-surround'
" Autoclose
Plug 'Townk/vim-autoclose'
" Indent text object
Plug 'michaeljsmith/vim-indent-object'
" Snippets manager (SnipMate), dependencies, and snippets repo
Plug 'MarcWeber/vim-addon-mw-utils'
Plug 'tomtom/tlib_vim'
" Git diff icons on the side of the file lines
Plug 'airblade/vim-gitgutter'
" Relative numbering of lines (0 is the current line)
" (disabled by default because is very intrusive and can't be easily toggled
" on/off. When the plugin is present, will always activate the relative
" numbering every time you go to normal mode. Author refuses to add a setting
" to avoid that)
Plug 'myusuf3/numbers.vim'

" Plugins from vim-scripts repos
"
Plug 'michalbachowski/vim-wombat256mod'
"
" RUST Lang
"
Plug 'rust-lang/rust.vim',{ 'for': ['rust'] }
"
" Typescript
"
" Plugin 'leafgarland/typescript-vim'

" Vim syntax file & snippets for Docker's Dockerfile
Plug 'ekalinin/Dockerfile.vim', {'for': ['Dockerfile']}
"
" TOML Syntax
"
Plug 'cespare/vim-toml', { 'for': ['toml'] }
"
" GO Configuracion
"
Plug 'fatih/vim-go',{ 'for': ['go'] }
Plug 'nsf/gocode', { 'rtp': 'nvim/', 'for': ['go']}

"
" Auto Pairs
"
Plug 'jiangmiao/auto-pairs'
"
" FZF
"
Plug 'junegunn/fzf.vim'

" Initialize plugin system
call plug#end()

" Installing plugins the first time
if iCanHazVundle == 0
    echo "Installing Plugins, please ignore key map error messages"
    echo ""
    :PluginInstall
endif

" =======================================================================
" =================== END INSTALL =======================================
" =======================================================================
" Rebind <Leader> key
" I like to have it here becuase it is easier to reach than the default and
" it is next to ``m`` and ``n`` which I use for navigating between tabs.
let mapleader = ","

" allow plugins by file type
filetype plugin on
filetype indent on

" tabs and spaces handling
set expandtab
set tabstop=4
set softtabstop=4
set shiftwidth=4

" tablength exceptions
autocmd FileType html setlocal shiftwidth=2 tabstop=2 softtabstop=2
autocmd FileType htmldjango setlocal shiftwidth=2 tabstop=2 softtabstop=2
autocmd FileType javascript setlocal shiftwidth=2 tabstop=2 softtabstop=2
autocmd FileType rust setlocal shiftwidth=4 tabstop=4 softtabstop=4
autocmd FileType go setlocal shiftwidth=4 tabstop=4 softtabstop=4

" always show status bar
set ls=2

" incremental search
set incsearch

" highlighted search results
set hlsearch

" line numbers
set nu

" toggle Tagbar display
map <F4> :TagbarToggle<CR>
" autofocus on Tagbar open
let g:tagbar_autofocus = 1

" NERDTree (better file browser) toggle
map <F3> :NERDTreeToggle<CR>

" tab navigation
map tn :tabn<CR>
map tp :tabp<CR>
map tm :tabm
map tt :tabnew
map ts :tab split<CR>
map <C-S-Right> :tabn<CR>
imap <C-S-Right> <ESC>:tabn<CR>
map <C-S-Left> :tabp<CR>
imap <C-S-Left> <ESC>:tabp<CR>

" navigate windows with meta+arrows
map <M-Right> <c-w>l
map <M-Left> <c-w>h
map <M-Up> <c-w>k
map <M-Down> <c-w>j
imap <M-Right> <ESC><c-w>l
imap <M-Left> <ESC><c-w>h
imap <M-Up> <ESC><c-w>k
imap <M-Down> <ESC><c-w>j

" automatically close autocompletion window
autocmd CursorMovedI * if pumvisible() == 0|pclose|endif
autocmd InsertLeave * if pumvisible() == 0|pclose|endif

" old autocomplete keyboard shortcut
imap <C-J> <C-X><C-O>

" show pending tasks list
map <F2> :TaskList<CR>

" save as sudo
ca w!! w !sudo tee "%"

" colors and settings of autocompletion
highlight Pmenu ctermbg=4 guibg=LightGray
" highlight PmenuSel ctermbg=8 guibg=DarkBlue guifg=Red
" highlight PmenuSbar ctermbg=7 guibg=DarkGray
" highlight PmenuThumb guibg=Black
" use global scope search

" debugger keyboard shortcuts
map <F5> :Dbg over<CR>
map <F6> :Dbg into<CR>
map <F7> :Dbg out<CR>
map <F8> :Dbg here<CR>
map <F9> :Dbg break<CR>
map <F10> :Dbg watch<CR>
map <F11> :Dbg down<CR>
map <F12> :Dbg up<CR>

" CtrlP (new fuzzy finder)
let g:ctrlp_map = ',e'
nmap <Leader>g :CtrlPBufTag<CR>
nmap <Leader>G :CtrlPBufTagAll<CR>
nmap <Leader>f :CtrlPLine<CR>
nmap <Leader>m :CtrlPMRUFiles<CR>
nmap <Leader>c :CtrlPCmdPalette<CR>
" to be able to call CtrlP with default search text
function! CtrlPWithSearchText(search_text, ctrlp_command_end)
    execute ':CtrlP' . a:ctrlp_command_end
    call feedkeys(a:search_text)
endfunction
" CtrlP with default text
nmap <Leader>wg :call CtrlPWithSearchText(expand('<cword>'), 'BufTag')<CR>
nmap <Leader>wG :call CtrlPWithSearchText(expand('<cword>'), 'BufTagAll')<CR>
nmap <Leader>wf :call CtrlPWithSearchText(expand('<cword>'), 'Line')<CR>
nmap <Leader>we :call CtrlPWithSearchText(expand('<cword>'), '')<CR>
nmap <Leader>pe :call CtrlPWithSearchText(expand('<cfile>'), '')<CR>
nmap <Leader>wm :call CtrlPWithSearchText(expand('<cword>'), 'MRUFiles')<CR>
nmap <Leader>wc :call CtrlPWithSearchText(expand('<cword>'), 'CmdPalette')<CR>
" Don't change working directory
let g:ctrlp_working_path_mode = 0
" Ignore files on fuzzy finder
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/](\.git|\.hg|\.svn)$',
  \ 'file': '\.pyc$\|\.pyo$',
  \ }

" Ignore files on NERDTree
let NERDTreeIgnore = ['\.pyc$', '\.pyo$']

" simple recursive grep
command! -nargs=1 RecurGrep lvimgrep /<args>/gj ./**/*.* | lopen | set nowrap
command! -nargs=1 RecurGrepFast silent exec 'lgrep! <q-args> ./**/*.*' | lopen
nmap <Leader>R :RecurGrep
nmap <Leader>r :RecurGrepFast
nmap <Leader>wR :RecurGrep <cword><CR>
nmap <Leader>wr :RecurGrepFast <cword><CR>

" tabman shortcuts
let g:tabman_toggle = 'tl'
let g:tabman_focus  = 'tf'

" use 256 colors when possible
if &term =~? 'mlterm\|xterm\|xterm-256\|screen-256'
    let &t_Co = 256
    " color
    colorscheme fisa
else
    " color
    colorscheme delek
endif

" colors for gvim
if has('gui_running')
    colorscheme wombat
endif

" when scrolling, keep cursor 3 lines away from screen border
set scrolloff=3

" autocompletion of files and commands behaves like shell
" (complete only the common part, list the options that match)
set wildmode=list:longest

" Fix to let ESC work as espected with Autoclose plugin
let g:AutoClosePumvisible = {"ENTER": "\<C-Y>", "ESC": "\<ESC>"}

" easier moving of code blocks
" Try to go into visual mode (v), thenselect several lines of code here and
" then press ``>`` several times.
vnoremap < <gv " better indentation
vnoremap > >gv " better indentation


" Show whitespace
" MUST be inserted BEFORE the colorscheme command
autocmd ColorScheme * highlight ExtraWhitespace ctermbg=red guibg=red
au InsertLeave * match ExtraWhitespace /\s\+$/


" Color scheme
" mkdir -p ~/.vim/colors && cd ~/.vim/colors
" wget -O wombat256mod.vim http://www.vim.org/scripts/download_script.php?src_id=13400
set t_Co=256
color wombat256mod

" Disable stupid backup and swap files - they trigger too many events
" for file system watchers
set nobackup
set nowritebackup
set noswapfile

"
" Python LSP
" pip install python-language-server
"
if executable('pyls')
    au User lsp_setup call lsp#register_server({
        \ 'name': 'pyls',
        \ 'cmd': {server_info->['pyls']},
        \ 'whitelist': ['python'],
        \ })
endif

autocmd FileType python setlocal omnifunc=lsp#complete
"
" Rust Configurations
"
let g:rustfmt_autosave = 1


"
" Rust autocompleter
"
if executable('rls')
    au User lsp_setup call lsp#register_server({
        \ 'name': 'rls',
        \ 'cmd': {server_info->['rustup', 'run', 'stable', 'rls']},
        \ 'whitelist': ['rust'],
        \ })
endif


"let g:lsp_async_completion = 1
autocmd FileType rust setlocal omnifunc=lsp#complete

"
" GoLang Configuration
"
au FileType go nmap <leader>r <Plug>(go-run)
au FileType go nmap <leader>b <Plug>(go-build)
au FileType go nmap <leader>t <Plug>(go-test)
au FileType go nmap <leader>c <Plug>(go-coverage)
"
" Vim Go
"
let g:go_fmt_command = "goimports"
