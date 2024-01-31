{ config, pkgs, lib, ... }:
with lib; {
  programs.vim = {
    enable = true;
    defaultEditor = true;
    extraConfig = ''
      " Basic
      set nocompatible
      filetype plugin indent on
      syntax enable

      """ Options
      " UI
      set background=dark
      set cursorline
      set display=uhex
      set fillchars=vert:│,fold:─,foldopen:·,foldclose:·,foldsep:┼,diff:─
      set hlsearch
      set laststatus=2
      set list
      set listchars=tab:┆\ ,trail:·,extends:>,precedes:<,nbsp:+
      set mouse=ar
      set number
      set relativenumber
      set ruler
      set scrolloff=1
      set shortmess=aoOstT
      set showcmd
      set showmatch
      set showtabline=2
      set sidescrolloff=1
      set termguicolors
      set title
      set updatetime=100
      set wildmenu
      set wildoptions=fuzzy,pum,tagfile

      " Gui
      behave xterm
      set guicursor=n-v-c-sm:block,i-ci:ver5,ve-o-r-cr:hor20
      set guifont=Monofur\ Nerd\ Font\ Mono\ 12
      set guiheadroom=0
      set guioptions=!Pimgk

      " Files
      set autoread
      set path+=**
      set undofile

      set backupdir=$HOME/.cache/vim/backup
      set directory=$HOME/.cache/vim/swap
      set undodir=$HOME/.cache/vim/undo
      set viewdir=$HOME/.cache/vim/view
      set viminfofile=$HOME/.cache/vim/info

      " Functions
      set clipboard=unnamed,autoselectplus,html
      set diffopt+=filler,closeoff,vertical,internal,algorithm:minimal
      set keywordprg=:Man
      set nrformats+=alpha
      set sessionoptions+=globals,resize,slash,winpos

      " Editing
      set autoindent
      set completeopt=menuone,noinsert,noselect,preview
      set cscopeverbose
      set formatoptions=ro/qnbjp
      set nojoinspaces
      set smarttab

      " UX
      set belloff=backspace,cursor,complete,insertmode,wildmode
      set hidden
      set history=10000
      set incsearch
      set maxcombine=6
      set switchbuf=uselast

      " Omnicomp
      inoremap <expr> <C-d> pumvisible() ? "\<PageDown>\<C-p>\<C-n>" : "\<C-d>"
      inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<CR>"
      inoremap <expr> <C-u> pumvisible() ? "\<PageUp>\<C-p>\<C-n>" : "\<C-u>"
      inoremap <expr> <Down> pumvisible() ? "\<C-n>" : "\<Down>"
      inoremap <expr> <Esc> pumvisible() ? "\<C-e>" : "\<Esc>"
      inoremap <expr> <PageDown> pumvisible() ? "\<PageDown>\<C-p>\<C-n>" : "\<PageDown>"
      inoremap <expr> <PageUp> pumvisible() ? "\<PageUp>\<C-p>\<C-n>" : "\<PageUp>"
      inoremap <expr> <Up> pumvisible() ? "\<C-p>" : "\<Up>"

      set omnifunc=syntaxcomplete#Complete

      " Keys
      let mapleader = ' ' " <Space>
      let maplocalleader = '' " <Alt-Space>

      " Some built-in plugins
      packadd matchit
      runtime ftplugin/man.vim

      " Netrw
      let g:netrw_banner = 0
      let g:netrw_browse_split = 4
      let g:netrw_liststyle = 3
      let g:netrw_menu = 0
      let g:netrw_winsize = 15
      "nnoremap <Leader>td :Lexplore!<CR>

      " Dein
      let vimdir = fnamemodify($MYVIMRC, ":h")
      let &runtimepath = &runtimepath . "," . vimdir . "/repos/github.com/Shougo/dein.vim"
      call dein#begin(vimdir)
      call dein#add('Shougo/dein.vim')

      " Lightline
      call dein#add('itchyny/lightline.vim')
      call dein#add('mengelbrecht/lightline-bufferline')

      let g:lightline = {
      	\ 'colorscheme': 'solarized',
      	\ 'active': {
      	\ 	'left': [[ 'mode', 'paste' ],
      	\ 		[ 'readonly', 'signify' ]],
      	\ 	'right': [[ 'charvaluehex', 'lineinfo', 'percent' ],
      	\ 		[ 'fileformat', 'fileencoding', 'filetype' ]]},
      	\ 'tabline': {
      	\ 	'left': [[ 'filename' ], [ 'buffers' ]],
      	\ 	'right': [[ 'close' ]]},
      	\ 'component_expand': { 'buffers': 'lightline#bufferline#buffers' },
      	\ 'component_type': { 'buffers': 'tabsel' },
      	\ 'component_function': {
      	\ 	'signify': 'LightlineSignify',
      	\ 	'fileformat': 'LightlineFileformat',
      	\ 	'fileencoding': 'LightlineFileencoding' }}

      function! LightlineFileformat()
      	return &ff !=# "unix" ? &ff : ""
      endfunction

      function! LightlineFileencoding()
      	let fileenc = &fenc !=# "" ? &fenc : &enc
      	return fileenc !=# "utf-8" ? fileenc : ""
      endfunction

      function! LightlineSignify()
      	let stats = sy#repo#get_stats_decorated()
      	if stats ==# ${"''"}
      		if &modified == 1
      			return "+"
      		elseif &modifiable == 0
      			return "-"
      		else
      			return ""
      		endif
      	else
      		let branch = FugitiveHead()
      		if branch != ""
      			let branch = " " . branch
      		endif
      		return stats . branch . ""
      	endif
      endfunction

      let g:lightline#bufferline#enable_nerdfont = 1
      let g:lightline#bufferline#unicode_symbols = 1
      let g:lightline#bufferline#show_number = 1

      nnoremap <Leader>1 <Plug>lightline#bufferline#go(1)
      nnoremap <Leader>2 <Plug>lightline#bufferline#go(2)
      nnoremap <Leader>3 <Plug>lightline#bufferline#go(3)
      nnoremap <Leader>4 <Plug>lightline#bufferline#go(4)
      nnoremap <Leader>5 <Plug>lightline#bufferline#go(5)
      nnoremap <Leader>6 <Plug>lightline#bufferline#go(6)
      nnoremap <Leader>7 <Plug>lightline#bufferline#go(7)
      nnoremap <Leader>8 <Plug>lightline#bufferline#go(8)
      nnoremap <Leader>9 <Plug>lightline#bufferline#go(9)
      nnoremap <Leader>0 <Plug>lightline#bufferline#go(10)

      nnoremap <Leader>d1 <Plug>lightline#bufferline#delete(1)
      nnoremap <Leader>d2 <Plug>lightline#bufferline#delete(2)
      nnoremap <Leader>d3 <Plug>lightline#bufferline#delete(3)
      nnoremap <Leader>d4 <Plug>lightline#bufferline#delete(4)
      nnoremap <Leader>d5 <Plug>lightline#bufferline#delete(5)
      nnoremap <Leader>d6 <Plug>lightline#bufferline#delete(6)
      nnoremap <Leader>d7 <Plug>lightline#bufferline#delete(7)
      nnoremap <Leader>d8 <Plug>lightline#bufferline#delete(8)
      nnoremap <Leader>d9 <Plug>lightline#bufferline#delete(9)
      nnoremap <Leader>d0 <Plug>lightline#bufferline#delete(10)

      " Fern
      call dein#add('lambdalisue/fern.vim')
      call dein#add('lambdalisue/fern-renderer-nerdfont.vim')
      call dein#add('lambdalisue/fern-git-status.vim')
      call dein#add('lambdalisue/fern-hijack.vim')

      let g:fern#renderer = "nerdfont"
      nnoremap <Leader>td :Fern . -drawer -toggle<CR>
      nnoremap <Leader>te :Fern .<CR>

      " Tagbar
      call dein#add('preservim/tagbar')
      nnoremap <Leader>tt :TagbarToggle<CR>

      " Goyo
      call dein#add('junegunn/goyo.vim')
      call dein#add('junegunn/limelight.vim')

      autocmd! User GoyoEnter Limelight
      autocmd! User GoyoLeave Limelight!
      let g:limelight_conceal_ctermfg = 240
      nnoremap <Leader>mg :Goyo<CR>

      " Vim-move
      call dein#add('matze/vim-move')

      " Vim-solarized8
      call dein#add('lifepillar/vim-solarized8')
      colorscheme solarized8
      highlight SpecialKey ctermbg=NONE guibg=NONE

      " Vim-polyglot
      call dein#add('sheerun/vim-polyglot')
      let g:polyglot_disabled = ['sensible']

      " indentLine
      call dein#add('Yggdroot/indentLine')
      let g:indentLine_char = '┊'
      let g:indentLine_showFirstIndentLevel = 1

      " Random stuff
      call dein#add('dyng/ctrlsf.vim')
      call dein#add('kshenoy/vim-signature')
      call dein#add('lambdalisue/nerdfont.vim')
      call dein#add('mg979/vim-visual-multi')
      call dein#add('mhinz/vim-signify')
      call dein#add('preservim/nerdcommenter')
      call dein#add('tpope/vim-fugitive')
      call dein#add('tpope/vim-surround')
      call dein#add('srstevenson/vim-picker')
      call dein#add('direnv/direnv.vim')

      call dein#end()
    '';
  };
}
