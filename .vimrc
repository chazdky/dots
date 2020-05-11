" Basic Python-friendly Vim configuration. Colorscheme is changed from
" 'default' to make screenshots look better in print.
" basics {{{
syntax on                  " Enable syntax highlighting.
filetype plugin indent on  " Enable file type based indentation.

set autoindent             " Respect indentation when starting a new line.
set expandtab              " Expand tabs to spaces. Essential in Python.
set tabstop=4              " Number of spaces tab is counted for.
set shiftwidth=4           " Number of spaces to use for autoindent.
set noshowmode             " don't show which mode disabled for PowerLine

set backspace=2            " Fix backspace behavior on most terminals.
" }}}

call plug#begin('~/.vim/plugged')

" set term and dl colorschemes {{{
    set t_Co=256 " Explicitly tell vim that the terminal supports 256 colors
    " switch cursor to line when in insert mode, and block when not
    set guicursor=n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50
    \,a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor
    \,sm:block-blinkwait175-blinkoff150-blinkon175

    if &term =~ '256color'
        " disable background color erase
        set t_ut=
    endif

    " enable 24 bit color support if supported
    if (has("termguicolors"))
        if (!(has("nvim")))
            let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
            let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
        endif
        set termguicolors
    endif

    " highlight conflicts
    match ErrorMsg '^\(<\|=\|>\)\{7\}\([^=].\+\)\?$'

    " Terminal Vim with 256 colors colorscheme
    Plug 'fisadev/fisa-vim-colorscheme', { 'as': 'fisa' }
    Plug 'connorholyday/vim-snazzy', { 'as': 'snazzy' }
    Plug 'dracula/vim', { 'as': 'dracula' }
    Plug 'joshdick/onedark.vim'
    Plug 'Rigellute/shades-of-purple.vim'
    Plug 'drewtempelmeyer/palenight.vim'
" }}}

" General Mappings {{{
	" set a map leader for more key combos
	let mapleader = ','

	" remap esc
	inoremap jk <esc>

	" shortcut to save
	nmap <leader>, :w<cr>
	" save as sudo
	nmap <leader>W :w !sudo tee "%"

	" " set paste toggle
	" set pastetoggle=<leader>v

	" Let shift enter and ctrl enter function like an IDE esc and inserting abv/bel
	imap <C-cr> <esc>O
	imap <S-cr> <esc>o

	" edit ~/.vimrc
	map <leader>ev :e! ~/.vimrc<cr>
	" edit gitconfig
	map <leader>eg :e! ~/.gitconfig<cr>

	" source the current file
	nmap <leader>s :source %<cr>

	" map control+a to select all from anywhere
	map <leader>a <esc>gg<S-v>G

	" clear highlighted search
	noremap <leader><space> :set hlsearch! hlsearch?<cr>

	" activate spell-checking alternatives
	nmap ;s :set invspell spelllang=en<cr>


	" remove extra whitespace
	nmap <leader><space> :%s/\s\+$<cr>
	nmap <leader><space><space> :%s/\n\{2,}/\r\r/g<cr>

	inoremap <expr> <C-j> pumvisible() ? "\<C-N>" : "\<C-j>"
	inoremap <expr> <C-k> pumvisible() ? "\<C-P>" : "\<C-k>"

	nmap <leader>li :set list!<cr>

	" keep visual selection when indenting/outdenting
	vmap < <gv
	vmap > >gv

	vnoremap . :normal .<cr>

	" movement {{{
		" cleaner window split behavior
		map <leader>ws :split<cr>
		map <leader>wv :vsplit<cr>

		" Better Window Movement
		map <silent> <C-h> <Plug>WinMoveLeft
		map <silent> <C-j> <Plug>WinMoveDown
		map <silent> <C-k> <Plug>WinMoveUp
		map <silent> <C-l> <Plug>WinMoveRight

		" Buffer Movement
		nmap <leader>. :bnext<cr>
		" close all other open buffers
		nmap <silent>bw :Bwipeout<cr>
		" turn all open buffers to tabs
		map <silent>bt :bufdo tab split<cr>
		" map a window close but not the application
		map <leader>bc :Bdelete<cr>


		" tab navigation mappings
		map tt :tabnew
		map <silent>tc :tabclose
		map <silent>to :tabonly
		map <A-l> :tabn<CR>
		imap <A-l> <ESC>:tabn<CR>
		map <A-h> :tabp<CR>
		imap <A-h> <ESC>:tabp<CR>
	"}}}



	nmap <leader>z <Plug>Zoom

	map <silent>wq :wincmd q<cr>

	" move line mappings
	" ∆ is <A-j> on macOS
	" ˚ is <A-k> on macOS
	nnoremap <A-j> :m .+1<cr>==
	nnoremap <A-k> :m .-2<cr>==
	inoremap <A-j> <Esc>:m .+1<cr>==gi
	inoremap <A-k> <Esc>:m .-2<cr>==gi
	vnoremap <A-j> :m '>+1<cr>gv=gv
	vnoremap <A-k> :m '<-2<cr>gv=gv

	vnoremap $( <esc>`>a)<esc>`<i(<esc>
	vnoremap $[ <esc>`>a]<esc>`<i[<esc>
	vnoremap ${ <esc>`>a}<esc>`<i{<esc>
	vnoremap $" <esc>`>a"<esc>`<i"<esc>
	vnoremap $' <esc>`>a'<esc>`<i'<esc>
	vnoremap $\ <esc>`>o*/<esc>`<O/*<esc>
	vnoremap $< <esc>`>a><esc>`<i<<esc>

	" toggle cursor line
	nnoremap <leader>i :set cursorline!<cr>

	" scroll the viewport faster
	nnoremap <C-e> 3<C-e>
	nnoremap <C-y> 3<C-y>

	" moving up and down work as you would expect
	nnoremap <silent> j gj
	nnoremap <silent> k gk
	nnoremap <silent> ^ g^
	nnoremap <silent> $ g$

	" helpers for dealing with other people's code
	nmap \t :set ts=4 sts=4 sw=4 noet<cr>
	nmap \s :set ts=4 sts=4 sw=4 et<cr>

	" Custom text objects

	" inner-line
	xnoremap <silent> il :<c-u>normal! g_v^<cr>
	onoremap <silent> il :<c-u>normal! g_v^<cr>

	" around line
	vnoremap <silent> al :<c-u>normal! $v0<cr>
	onoremap <silent> al :<c-u>normal! $v0<cr>

" }}}

" General Functionality {{{
    " better terminal integration
    " substitute, search, and abbreviate multiple variants of a word
    Plug 'tpope/vim-abolish'

    " Track my coding time and languages
    Plug 'wakatime/vim-wakatime'
    noremap <leader>wt :WakaTimeToday<cr>

    " easy commenting motions
    Plug 'tpope/vim-commentary'

    " mappings which are simply short normal mode aliases for commonly used ex commands
    Plug 'tpope/vim-unimpaired'

    " easy alignment of columns and tex
    Plug 'junegunn/vim-easy-align'

    " endings for html, xml, etc. - ehances surround
    Plug 'tpope/vim-ragtag'

    " mappings to easily delete, change and add such surroundings in pairs, such as quotes, parens, etc.
    Plug 'tpope/vim-surround'

    " tmux integration for vim
    Plug 'benmills/vimux'

    " enables repeating other supported plugins with the . command
    Plug 'tpope/vim-repeat'

    " quickrun
    Plug 'thinca/vim-quickrun'

    " .editorconfig support
    Plug 'editorconfig/editorconfig-vim'

    " single/multi line code handler: gS - split one line into multiple, gJ - combine multiple lines into one
    Plug 'AndrewRadev/splitjoin.vim'

    " add end, endif, etc. automatically
    Plug 'tpope/vim-endwise'

    " Writing in vim {{{{
        Plug 'junegunn/goyo.vim'
        Plug 'junegunn/limelight.vim'

        let g:limelight_conceal_ctermfg = 62
        let g:limelight_conceal_guifg = '#5f5fd7'
        let g:limelight_default_coeffecient = 0.7
        let g:limelight_paragraph_span = 1
        let g:limelight_priority = -1

        nmap <leader>gy :Goyo<CR>
        nmap <leader>ll :Limelight!!<CR>
    " }}}
    " Filetypes{{{
        """ Markdown {{{
        Plug 'godlygeek/tabular' | Plug 'plasticboy/vim-markdown'
        " build Composer function
        function! BuildComposer(info)
            if a:info.status != 'unchanged' || a:info.force
                if has('nvim')
                    !cargo build --release --locked
                else
                    !cargo build --release --locked --no-default-features --features json-rpc
                 endif
            endif
        endfunction
        
        Plug 'euclio/vim-markdown-composer', { 'do': function('BuildComposer') }
        let g:markdown_composer_autostart = 0
        nmap <leader>lr :ComposerStart<cr>

        "Tpope with that markdown ish
        Plug 'tpope/vim-markdown', { 'for': 'markdown' }
        let g:markdown_fenced_languages = [ 'tsx=typescript.tsx', 'bash=sh', 'viml=vim','python=py', 'csharp=cs', 'c++=cpp', 'flutter=dart', 'rust=rs' ]

        "vim-livedown for live markdown previews
        Plug 'shime/vim-livedown'
        let g:livedown_autorun = 0
        let g:livedown_open = 1
        let g:livedown_port = 1337
        let g:livedown_browser = "vivaldi-stable"
        noremap <leader>md :LivedownToggle<cr>

    " }}}
    " Latex {{{

        " well try to give vimtex a shot
        Plug 'lervag/vimtex'
        let g:tex_flavor = 'latex'
        let g:vimtex_view_method = 'zathura'
        let g:vimtex_latexmk_progname= '/usr/bin/nvr'
        let g:vimtex_latexmk_options="-pdf -pdflatex='pdflatex -file-line-error -shell-escape -synctex=1'"
        let g:vimtex_quickfix_mode = 0
        let g:vimtex_quickfix_open_on_warning = 0
        let g:vimtex_view_automatic=1
        let g:vimtex_view_forward_search_on_start = 0
        " built in Leader ll :VimtexCompileToggle
        " \ll to open in zathura :VimtexCompileToggle
        "useful vimtex commands
        ":VimtexTocOpen|:VimtexTocToggle
        ":VimtexInfo
        ":VimtexCountWords|:VimtexCountLetters
        ":VimtexLabelsOpen|:VimtexLabelsToggle
        ":VimtexCompileOutput
        ":VimtexErrors
        Plug 'KeitaNakamura/tex-conceal.vim'
        set conceallevel=1
        let g:tex_conceal='abdmg'

        setlocal spell
        set spelllang=en_us
        inoremap <C-s> <c-g>u<esc>[s1z=`]a<c-g>u
        nmap vu vgu
        nmap vU vgU


    " }}}

    " Flutter {{{

        " The dart language plugin
        Plug 'dart-lang/dart-vim-plugin'

        " vim-flutter for all the goodies
        Plug 'thosakwe/vim-flutter'

        "Enable flutter menu
        " call FlutterMenu()

        "keys for flutter dev
        nnoremap <leader>fa :FlutterRun<cr>
        nnoremap <leader>fq :FlutterQuit<cr>
        nnoremap <leader>fr :FlutterHotReload<cr>
        nnoremap <leader>fR :FlutterHotRestart<cr>
        nnoremap <leader>fD :FlutterVisualDebug<cr>

    " }}}

    " JSON {{{
        Plug 'elzr/vim-json', { 'for': 'json' }
        let g:vim_json_syntax_conceal = 0
    " }}}
    " Python {{{
    " run python commandline from inside nvim
        nmap <leader>py :write !python3<cr>

    " }}}
" }}}

call plug#end()

" Colorscheme and final setup {{{
    " This call must happen after the plug#end() call to ensure
    " that the colorschemes have been loaded
    colorscheme shades_of_purple
    syntax on
    filetype plugin indent on
    " make the highlighting of tabs and other non-text less annoying
    highlight SpecialKey ctermfg=19 guifg=#333333
    highlight NonText ctermfg=19 guifg=#333333

    " make comments and HTML attributes italic
    highlight Comment cterm=italic term=italic gui=italic
    highlight htmlArg cterm=italic term=italic gui=italic
    highlight xmlAttrib cterm=italic term=italic gui=italic
    " highlight Type cterm=italic term=italic gui=italic
    highlight Normal ctermbg=none
" }}}

" vim:set foldmethod=marker foldlevel=0
