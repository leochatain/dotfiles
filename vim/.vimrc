" ============================================================================
" Basic Settings
" ============================================================================
filetype plugin indent on
syntax on

" ============================================================================
" Indentation
" ============================================================================
set autoindent              " Copy indent from current line when starting new line
set smartindent             " Smart autoindenting for C-like programs
set softtabstop=2           " Number of spaces per tab when editing
set tabstop=2               " Number of spaces that a tab counts for
set shiftwidth=2            " Number of spaces for each indentation step
set expandtab               " Use spaces instead of tabs

" ============================================================================
" UI and Display
" ============================================================================
set ruler                   " Show cursor position in status line
set showcmd                 " Show incomplete commands in status line
set nu                      " Show line numbers
set wildmenu                " Enhanced command-line completion
set background=light        " Optimize colors for light background
set showmatch               " Highlight matching brackets/parentheses
set lazyredraw              " Don't redraw during macros (improves performance)

" ============================================================================
" Search
" ============================================================================
set incsearch               " Show matches as you type
set hlsearch                " Highlight all search matches
set ignorecase              " Case-insensitive search
set smartcase               " Case-sensitive if search contains uppercase

" ============================================================================
" System Integration
" ============================================================================
" Platform-specific clipboard integration
if has('mac')
  set clipboard=unnamed       " macOS clipboard
elseif has('unix')
  set clipboard=unnamedplus   " Linux clipboard (X11/Wayland)
endif

set backspace=indent,eol,start  " Allow backspace over everything in insert mode
