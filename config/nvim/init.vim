" Fisa-vim-config, a config for both Vim and NeoVim
" http://vim.fisadev.com
" version: 12.2.1

" To use fancy symbols wherever possible, change this setting from 0 to 1
" and use a font from https://github.com/ryanoasis/nerd-fonts in your terminal 
" (if you aren't using one of those fonts, you will see funny characters here. 
" Trust me, they look nice when using one of those fonts).
let fancy_symbols_enabled = 0

" To use the background color of your terminal app, change this setting from 0
" to 1
let transparent_background = 0

set encoding=utf-8
let using_neovim = has('nvim')
let using_vim = !using_neovim

" Figure out the system Python for Neovim.
" if exists("$VIRTUAL_ENV")
"     let g:python3_host_prog=substitute(system("which -a python3 | head -n2 | tail -n1"), "\n", '', 'g')
" else
"     let g:python3_host_prog=substitute(system("which python3"), "\n", '', 'g')
" endif


" ============================================================================
" Vim-plug initialization
" Avoid modifying this section, unless you are very sure of what you are doing

let vim_plug_just_installed = 0
if using_neovim
    let vim_plug_path = expand('~/.config/nvim/autoload/plug.vim')
else
    let vim_plug_path = expand('~/.vim/autoload/plug.vim')
endif
if !filereadable(vim_plug_path)
    echo "Installing Vim-plug..."
    echo ""
    if using_neovim
        silent !mkdir -p ~/.config/nvim/autoload
        silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    else
        silent !mkdir -p ~/.vim/autoload
        silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    endif
    let vim_plug_just_installed = 1
endif

" manually load vim-plug the first time
if vim_plug_just_installed
    :execute 'source '.fnameescape(vim_plug_path)
endif

" Obscure hacks done, you can now modify the rest of the config down below
" as you wish :)
" IMPORTANT: some things in the config are vim or neovim specific. It's easy
" to spot, they are inside `if using_vim` or `if using_neovim` blocks.

" ============================================================================
" Active plugins
" You can disable or add new ones here:

" this needs to be here, so vim-plug knows we are declaring the plugins we
" want to use
if using_neovim
    call plug#begin("~/.config/nvim/plugged")
else
    call plug#begin("~/.vim/plugged")
endif

" Now the actual plugins:

" Override configs by directory
Plug 'arielrossanigo/dir-configs-override.vim'
" Code commenter
Plug 'tpope/vim-commentary'
" Search results counter
Plug 'vim-scripts/IndexedSearch'
" A couple of nice colorschemes
Plug 'fisadev/fisa-vim-colorscheme'
" Airline
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
" Code and files fuzzy finder
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
" Pending tasks list
Plug 'fisadev/FixedTaskList.vim'
" Async autocompletion
if using_neovim && vim_plug_just_installed
    Plug 'Shougo/deoplete.nvim', {'do': ':autocmd VimEnter * UpdateRemotePlugins'}
else
    Plug 'Shougo/deoplete.nvim'
endif
" Completion from other opened files
Plug 'Shougo/context_filetype.vim'
" Automatically close parenthesis, etc
"Plug 'Townk/vim-autoclose'
" Surround
Plug 'tpope/vim-surround'
" Indent text object
Plug 'michaeljsmith/vim-indent-object'
" Indentation based movements
Plug 'jeetsukumaran/vim-indentwise'
" Better language packs
Plug 'sheerun/vim-polyglot'
" Ack code search (requires ack installed in the system)
Plug 'mileszs/ack.vim'
" Paint css colors with the real color
Plug 'lilydjwg/colorizer'
" Git integration
Plug 'tpope/vim-fugitive'
" Git/mercurial/others diff icons on the side of the file lines
Plug 'mhinz/vim-signify'
" Yank history navigation
Plug 'vim-scripts/YankRing.vim'
" Relative numbering of lines (0 is the current line)
" (disabled by default because is very intrusive and can't be easily toggled
" on/off. When the plugin is present, will always activate the relative
" numbering every time you go to normal mode. Author refuses to add a setting
" to avoid that)
Plug 'myusuf3/numbers.vim'
" enable Gbrowse
Plug 'tpope/vim-rhubarb'
" md preview
Plug 'shime/vim-livedown'
" md preview
" Plug 'instant-markdown/vim-instant-markdown', {'for': 'markdown', 'do': 'yarn install'}
" md preview
"Plug 'MeanderingProgrammer/render-markdown.nvim'
Plug 'nvim-tree/nvim-web-devicons'
Plug 'echasnovski/mini.icons'
Plug 'echasnovski/mini.nvim'

" snipets
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
" Pluse search match
"Plug 'inside/vim-search-pulse'
" highlight on yank
Plug 'machakann/vim-highlightedyank'
" Markdown (:TableFormat)
Plug 'godlygeek/tabular'
Plug 'plasticboy/vim-markdown'
" Asynchronous Lint Engine
Plug 'dense-analysis/ale'
" grepper
Plug 'mhinz/vim-grepper'
" class outline viewer
Plug 'majutsushi/tagbar'
" per project config
Plug 'embear/vim-localvimrc'
" Automatic save session
Plug 'tpope/vim-obsession'
" golang
Plug 'fatih/vim-go', { 'do': ':GoInstallBinaries' }
Plug 'AndrewRadev/splitjoin.vim'
" change case, camel, kebab, etc
Plug 'tpope/vim-abolish'
" change hyphen case to camek case
Plug 'chiedo/vim-case-convert'
" Alternate between files
Plug 'tpope/vim-projectionist'
" Show the content of the register on " or @ or <CTRL-R> in insert mode
Plug 'junegunn/vim-peekaboo'

" Database
Plug 'tpope/vim-dadbod'
" Plug 'kristijanhusak/vim-dadbod-completion'
Plug 'kristijanhusak/vim-dadbod-ui'

" diff 2 dir: DirDiff <dir1> <dir2>
Plug 'will133/vim-dirdiff'

" Plug 'puremourning/vimspector'

" Plantuml
Plug 'aklt/plantuml-syntax'

" Neotest
Plug 'nvim-lua/plenary.nvim'
Plug 'antoinemadec/FixCursorHold.nvim'
Plug 'nvim-treesitter/nvim-treesitter'
Plug 'nvim-neotest/nvim-nio'
Plug 'nvim-neotest/neotest'
Plug 'nvim-neotest/neotest-go'

" run vim in the browser
" Plug 'glacambre/firenvim', { 'do': { _ -> firenvim#install(0) } }

" hurl file https://hurl.dev
Plug 'fourjay/vim-hurl'


" " github copilot
Plug 'github/copilot.vim'

" directory editor
Plug 'stevearc/oil.nvim'
" required for oil
Plug 'nvim-tree/nvim-web-devicons'

" yaml folds za zR
Plug 'pedrohdz/vim-yaml-folds'


Plug 'lewis6991/gitsigns.nvim'

Plug 'bruxisma/gitmoji.vim'

" Tell vim-plug we finished declaring plugins, so it can load them
call plug#end()

"lua require('render-markdown').setup({ log_level = 'debug' })
lua require('oil').setup()
lua require('gitsigns').setup()


" ============================================================================
" Install plugins the first time vim runs

if vim_plug_just_installed
	echo "Installing Bundles, please ignore key map error messages"
    :PlugInstall
endif


set foldlevelstart=20

" vim-commentary comment format for hurl files
autocmd FileType hurl setlocal commentstring=#\ %s

" ============================================================================
" majutsushi/tagbar
"#nmap <F3> :TagbarToggle<CR>
autocmd FileType go nmap <F8> :TagbarToggle<CR>
autocmd FileType python nmap <F8> :TagbarToggle<CR>


" ============================================================================
" vim-signify
autocmd User SignifyHunk call s:show_current_hunk()

function! s:show_current_hunk() abort
  let h = sy#util#get_hunk_stats()
  if !empty(h)
    echo printf('[Hunk %d/%d]', h.current_hunk, h.total_hunks)
  endif
endfunction

nmap gj <plug>(signify-next-hunk)
nmap gk <plug>(signify-prev-hunk)

" ============================================================================
" Vim settings and mappings
" You can edit them as you wish

if using_vim
    " A bunch of things that are set by default in neovim, but not in vim

    " no vi-compatible
    set nocompatible

    " allow plugins by file type (required for plugins!)
    filetype plugin on
    filetype indent on

    " always show status bar
    set ls=2

    " incremental search
    set incsearch
    " highlighted search results
    set hlsearch

    " syntax highlight on
    syntax on

    " better backup, swap and undos storage for vim (nvim has nice ones by
    " default)
    set directory=~/.vim/dirs/tmp     " directory to place swap files in
    set backup                        " make backup files
    set backupdir=~/.vim/dirs/backups " where to put backup files
    set undofile                      " persistent undos - undo after you re-open the file
    set undodir=~/.vim/dirs/undos
    set viminfo+=n~/.vim/dirs/viminfo
    " create needed directories if they don't exist
    if !isdirectory(&backupdir)
        call mkdir(&backupdir, "p")
    endif
    if !isdirectory(&directory)
        call mkdir(&directory, "p")
    endif
    if !isdirectory(&undodir)
        call mkdir(&undodir, "p")
    endif
end

" tabs and spaces handling
set expandtab
set tabstop=4
set softtabstop=4
set shiftwidth=4

" show line numbers
set nu

" ignorecase and smartcase for search
set ignorecase
set smartcase

" remove ugly vertical lines on window division
set fillchars+=vert:\

" use 256 colors when possible
if has('gui_running') || using_neovim || (&term =~? 'mlterm\|xterm\|xterm-256\|screen-256')
    if !has('gui_running')
        let &t_Co = 256
    endif
    " colorscheme vim-monokai-tasty
    " colorscheme fisa
    " colorscheme duskfox
    " colorscheme habamax
    " colorscheme nightfox
    colorscheme nordfox
    " colorscheme terafox
    " colorscheme vim
else
    colorscheme delek
endif

if transparent_background
    highlight Normal guibg=none
    highlight Normal ctermbg=none
    highlight NonText ctermbg=none
endif


" needed so deoplete can auto select the first suggestion
set completeopt+=noinsert
" comment this line to enable autocompletion preview window
" (displays documentation related to the selected completion option)
" disabled by default because preview makes the window flicker
set completeopt-=preview

" autocompletion of files and commands behaves like shell
" (complete only the common part, list the options that match)
set wildmode=list:longest

" save as sudo
ca w!! w !sudo tee "%"

" tab navigation mappings
map tt :tabnew
map <M-Right> :tabn<CR>
imap <M-Right> <ESC>:tabn<CR>
map <M-Left> :tabp<CR>
imap <M-Left> <ESC>:tabp<CR>

" when scrolling, keep cursor 3 lines away from screen border
set scrolloff=10

" clear search results
nnoremap <silent> // :noh<CR>

" clear empty spaces at the end of lines on save of python files
autocmd BufWritePre *.py :%s/\s\+$//e

" fix problems with uncommon shells (fish, xonsh) and plugins running commands
" (neomake, ...)
set shell=/bin/bash

" Ability to add python breakpoints
" (I use ipdb, but you can change it to whatever tool you use for debugging)
au FileType python map <silent> <leader>b Oimport ipdb; ipdb.set_trace()<esc>

set autowrite
let mapleader = ","

" disable mouse navigation
set mouse =""

" Jump to the last position when reopening a file
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

" persistent undo
set undofile " Maintain undo history between sessions
set undodir=~/.vim/undodir

" to learn other move deactivate arrows
noremap <Up> <Nop>
noremap <Down> <Nop>
noremap <Left> <Nop>
noremap <Right> <Nop>
" search option "
:set incsearch
:set hlsearch

"by default Vim saves your last 8 commands.
set history=100
set number
set rnu
" :e %% to get current dir of the file
cnoremap <expr> %% getcmdtype() == ':' ? expand('%:h').'/' : '%%'

" Highlight 80th column
set colorcolumn=100

" ============================================================================
" Plugins settings and mappings
" Edit them as you wish.

" git, fugitive ----------------------------------
set diffopt+=vertical

" Gitmoji
let g:gitmoji_insert_emoji = v:true

" Ale --------------------------------------------
" let g:ale_fixers = {'python': ['black', 'isort']}
"let g:ale_linters = {'python':['mypy', 'flake8'], 'go': ['govet', 'gobuild', 'gotype', 'gopls'], 'javascript': ['eslint'], 'typescript': ['tsserver', 'tslint'], 'markdown': ['markdownlint', 'vale'], 'java': ['javac']}
let g:ale_linters = {'markdown': ['markdownlint', 'vale'], 'go': ['govet', 'gobuild', 'gotype', 'gopls'],'python':['mypy', 'flake8']}
let g:ale_echo_msg_format = '[%linter%](%code%) %s [%severity%]'
let g:ale_fix_on_save = 1
" " only run linter on save
" let g:ale_lint_on_text_changed = 'never'
let g:ale_open_list = 1
" " used nvim current dir so it use .config files
" let g:ale_python_pylint_change_directory = 0

" vim-markdown ----------------------------------
let g:vim_markdown_folding_disabled = 1


" grepper ---------------------------------------
let g:grepper = {}
let g:grepper.tools = ['grep', 'git', 'rg --hidden', 'ag --hidden']

" golang vim-go ---------------------------------
"noremap <C-y> :cnext<CR>
"noremap <C-m> :cprevious<CR>
"nnoremap <leader>a :cclose<CR>
autocmd FileType go nmap <leader>r <Plug>(go-run)
autocmd FileType go nmap <leader>t <Plug>(go-test)
autocmd FileType go nmap <Leader>c <Plug>(go-coverage-toggle)

" let g:go_highlight_types = 1
" let g:go_highlight_fields = 1
" let g:go_highlight_functions = 1
" let g:go_highlight_function_calls = 1
" let g:go_highlight_operators = 1
" let g:go_highlight_extra_types = 1
" let g:go_highlight_build_constraints = 1

"let g:go_metalinter_autosave = 1
" run :GoBuild or :GoTestCompile based on the go file
function! s:build_go_files()
  let l:file = expand('%')
  if l:file =~# '^\f\+_test\.go$'
    call go#test#Test(0, 1)
  elseif l:file =~# '^\f\+\.go$'
    call go#cmd#Build(0)
  endif
endfunction
autocmd FileType go nmap <leader>b :<C-u>call <SID>build_go_files()<CR>
" let g:go_fmt_command = "goimports -local "
let g:go_fmt_options = {
    \ 'gofmt': '-s',
    \ 'goimports': '-local github.com/metriodev/datasources',
    \ }
let g:go_fmt_command = "goimports"
let g:go_imports_mode = 'goimports'
let g:go_imports_autosave = 1

let g:go_rename_command = 'gopls'
let g:go_def_mode='gopls'
let g:go_info_mode='gopls'

" Tell deoplete to use omni for autocompletion
call deoplete#custom#option('omni_patterns', { 'go': '[^. *\t]\.\w*' })

" Tagbar ----------------------------------------

" toggle tagbar display
map <F8> :TagbarToggle<CR>
" autofocus on tagbar open
let g:tagbar_autofocus = 1

" Tasklist ------------------------------

" show pending tasks list
map <F2> :TaskList<CR>

" Fzf ------------------------------

" file finder mapping
nmap ,e :Files<CR>
" tags (symbols) in current file finder mapping
nmap ,g :BTag<CR>
" the same, but with the word under the cursor pre filled
nmap ,wg :execute ":BTag " . expand('<cword>')<CR>
" tags (symbols) in all files finder mapping
nmap ,G :Tags<CR>
" the same, but with the word under the cursor pre filled
nmap ,wG :execute ":Tags " . expand('<cword>')<CR>
" general code finder in current file mapping
nmap ,f :BLines<CR>
" the same, but with the word under the cursor pre filled
nmap ,wf :execute ":BLines " . expand('<cword>')<CR>
" general code finder in all files mapping
nmap ,F :Lines<CR>
" the same, but with the word under the cursor pre filled
nmap ,wF :execute ":Lines " . expand('<cword>')<CR>
" commands finder mapping
nmap ,c :Commands<CR>

" Telescope ----------------------------
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>


" Deoplete -----------------------------

" Use deoplete.
let g:deoplete#enable_at_startup = 1
call deoplete#custom#option({
\   'ignore_case': v:true,
\   'smart_case': v:true,
\})
" complete with words from any opened file
let g:context_filetype#same_filetypes = {}
let g:context_filetype#same_filetypes._ = '_'

" Jedi-vim ------------------------------

" Disable autocompletion (using deoplete instead)
let g:jedi#completions_enabled = 0

" Ack.vim ------------------------------
" mappings
nmap ,r :Ack
nmap ,wr :execute ":Ack " . expand('<cword>')<CR>

" Window Chooser ------------------------------

" mapping
nmap  -  <Plug>(choosewin)
" show big letters
let g:choosewin_overlay_enable = 1

" Signify ------------------------------

" this first setting decides in which order try to guess your current vcs
" UPDATE it to reflect your preferences, it will speed up opening files
let g:signify_vcs_list = ['git']
" mappings to jump to changed blocks
nmap <leader>sn <plug>(signify-next-hunk)
nmap <leader>sp <plug>(signify-prev-hunk)
" nicer colors
highlight DiffAdd           cterm=bold ctermbg=none ctermfg=119
highlight DiffDelete        cterm=bold ctermbg=none ctermfg=167
highlight DiffChange        cterm=bold ctermbg=none ctermfg=227
highlight SignifySignAdd    cterm=bold ctermbg=237  ctermfg=119
highlight SignifySignDelete cterm=bold ctermbg=237  ctermfg=167
highlight SignifySignChange cterm=bold ctermbg=237  ctermfg=227

" Autoclose ------------------------------

" Fix to let ESC work as espected with Autoclose plugin
" (without this, when showing an autocompletion window, ESC won't leave insert
"  mode)
let g:AutoClosePumvisible = {"ENTER": "\<C-Y>", "ESC": "\<ESC>"}

" Yankring -------------------------------

if using_neovim
    let g:yankring_history_dir = '~/.config/nvim/'
    " Fix for yankring and neovim problem when system has non-text things
    " copied in clipboard
    let g:yankring_clipboard_monitor = 0
else
    let g:yankring_history_dir = '~/.vim/dirs/'
endif

" Airline ------------------------------

let g:airline_powerline_fonts = 0
let g:airline_theme = 'bubblegum'
let g:airline#extensions#whitespace#enabled = 0

" close all buffers except current one
command! BufCurOnly execute '%bdelete|edit#|bdelete#'


" Fancy Symbols!!

if fancy_symbols_enabled
    let g:webdevicons_enable = 1

    " custom airline symbols
    if !exists('g:airline_symbols')
       let g:airline_symbols = {}
    endif
    let g:airline_left_sep = ''
    let g:airline_left_alt_sep = ''
    let g:airline_right_sep = ''
    let g:airline_right_alt_sep = ''
    let g:airline_symbols.branch = '⭠'
    let g:airline_symbols.readonly = '⭤'
    let g:airline_symbols.linenr = '⭡'
else
    let g:webdevicons_enable = 0
endif

" Custom configurations ----------------

" Include user's custom nvim configurations
if using_neovim
    let custom_configs_path = "~/.config/nvim/custom.vim"
else
    let custom_configs_path = "~/.vim/custom.vim"
endif
if filereadable(expand(custom_configs_path))
  execute "source " . custom_configs_path
endif

" Set yaml.gotmpl as yaml file
au BufRead,BufNewFile *.yaml.gotmpl setfiletype yaml


" python --------------------------------------------
" let g:python3_host_prog = '/Users/phigra/.pyenv/versions/3.9.16/bin/python'
let g:python3_host_prog = '/Users/phigra/.pyenv/versions/3.11.3/bin/python'
