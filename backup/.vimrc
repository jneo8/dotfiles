"==============================================================================
" jneo8 vimrc - https://github.com/jneo8/vim_settings
"==============================================================================

"------------------------------------------------------------------------------
" Directory Setup: Backup, Swap, Undo
"------------------------------------------------------------------------------
silent !mkdir -p ~/.vim/dirs/tmp > /dev/null 2>&1
silent !mkdir -p ~/.vim/dirs/backups > /dev/null 2>&1
silent !mkdir -p ~/.vim/dirs/undos > /dev/null 2>&1


set directory=~/.vim/dirs/tmp
set backup
set backupdir=~/.vim/dirs/backups
set undofile
set undodir=~/.vim/dirs/undos
set viminfo+=n~/.vim/dirs/viminfo


"------------------------------------------------------------------------------
" Plugin Manager - vim-plug
"------------------------------------------------------------------------------
call plug#begin('~/.vim/plugged')

" Core Plugins
Plug 'dense-analysis/ale'
Plug 'scrooloose/nerdtree'
Plug 'ryanoasis/vim-devicons'
Plug 'airblade/vim-gitgutter'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
" Plug 'maralla/completor.vim'
Plug 'prabirshrestha/vim-lsp'
Plug 'prabirshrestha/asyncomplete.vim'
Plug 'prabirshrestha/asyncomplete-lsp.vim'
Plug 'mattn/vim-lsp-settings' " optional: auto setup gopls

Plug 'mg979/vim-visual-multi', {'branch': 'master'}
Plug 'farmergreg/vim-lastplace'
Plug 'mattn/emmet-vim'
Plug 'editorconfig/editorconfig-vim'
Plug 'easymotion/vim-easymotion'
Plug 'chrisbra/Colorizer'

" Filetype Plugins
Plug 'godlygeek/tabular'
Plug 'plasticboy/vim-markdown'
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() } }
Plug 'cespare/vim-toml'
Plug 'alvan/vim-closetag'

" Language Plugins
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
Plug 'derekwyatt/vim-scala'
Plug 'hdima/python-syntax'
Plug 'psf/black'
Plug 'weihanglo/polar.vim'

" Theme
Plug 'NLKNguyen/papercolor-theme'
Plug 'jneo8/papercolor-jneo8'

call plug#end()

"------------------------------------------------------------------------------
" Basic Settings
"------------------------------------------------------------------------------
syntax on
set nocompatible
set number
set mouse+=a
set backspace=indent,eol,start
set t_Co=256

set encoding=utf-8
set fileencoding=utf-8
let &t_TI = ""
let &t_TE = ""

" Tabs & Indentation
set autoindent
set nosmartindent
set smarttab
set expandtab
set shiftwidth=4
set softtabstop=4

" Search
set hlsearch
set incsearch

" Theme
set background=dark
let g:afterglow_blackout = 1
let g:afterglow_inherit_background = 1
colorscheme PaperColor

"------------------------------------------------------------------------------
" Plugin Configurations
"------------------------------------------------------------------------------

" ALE
let g:ale_sign_column_always = 1
let g:ale_open_list = 0
let g:ale_keep_list_window_open = 0
let g:ale_list_window_size = 5
let g:ale_echo_msg_error_str = 'E'
let g:ale_echo_msg_warning_str = 'W'
let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'
let g:ale_set_loclist = 0
let g:ale_set_quickfix = 1
let g:ale_python_flake8_executable = 'python'
let g:ale_python_flake8_options = '-m flake8 --docstring-convention google'
nmap <silent> <C-k> <Plug>(ale_previous_wrap)
nmap <silent> <C-j> <Plug>(ale_next_wrap)

" NERDTree
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
command! NE NERDTree
command! NEF NERDTreeFocus
command! NF NERDTreeFind

" Airline
let g:airline_theme = 'night_owl'
let g:airline_powerline_fonts = 1
let g:airline#extensions#whitespace#enabled = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#formatter = 'default'
let g:airline#extensions#tabline#show_tabs = 1
let g:airline#extensions#tabline#tab_nr_type = 1
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '|'

" Python
let python_highlight_all = 1

" vim-markdown
let g:vim_markdown_folding_disabled = 1

" Black
let g:black_skip_string_normalization = 1
let g:black_linelength = 79
" Uncomment below to auto-format on save
" augroup black_on_save
"   autocmd!
"   autocmd BufWritePre *.py Black
" augroup END

" vim-go
let g:go_def_mode = 'gopls'
let g:go_info_mode = 'gopls'
let g:go_fmt_command = "goimports"
let g:go_fmt_autosave = 1
let g:go_gopls_timeout = 120
let g:ale_linters = {
\   'go': [],
\}

" asynccomplete.vim
let g:lsp_diagnostics_enabled = 0         " disable diagnostics support
let g:lsp_document_highlight_enabled = 0
let g:asyncomplete_popup_delay = 500
let g:lsp_settings = {
 \  'gopls': {
 \    'disable': 1,
 \  },
 \  'golangci-lint-langserver': {
 \    'disable': 1,
 \  },
 \}

" fzf - Visual selection helpers
function! s:getVisualSelection()
    let [line_start, column_start] = getpos("'<")[1:2]
    let [line_end, column_end] = getpos("'>")[1:2]
    let lines = getline(line_start, line_end)
    if len(lines) == 0 | return "" | endif
    let lines[-1] = lines[-1][:column_end - (&selection == "inclusive" ? 1 : 2)]
    let lines[0] = lines[0][column_start - 1:]
    return join(lines, "\n")
endfunction
vnoremap <silent><leader>f <Esc>:Ag <C-R>=<SID>getVisualSelection()<CR><CR>
vnoremap <silent><leader>r <Esc>:Rg <C-R>=<SID>getVisualSelection()<CR><CR>
