" .vimrc / init.vim Will work for both vim and neovim
" this init was made by Chaz Davis (chazdky@github) 
" a testing ground for viml and to get the configuration that i am seeking
" in an init and create the playground for coding that i am seeking from my
" vim/nvim productivity and coding career

" ensure that vim-plug is installed and then load it {{{
call functions#PlugLoad()
call plug#begin('~/.config/nvim/plugged')

" General {{{
    " Abbreviations
    abbr funciton function
    abbr teh the
    abbr tempalte template
    abbr fitler filter
    abbr cosnt const
    abbr attribtue attribute
    abbr attribuet attribute

    set autoread " detect when a file is changed

    set history=1000 " change history to 1000
    set textwidth=79

    set backupdir=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
    set directory=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp

    if (has('nvim'))
        " show results of substition as they're happening
        " but don't open a split
        set inccommand=nosplit
    endif

    set backspace=indent,eol,start " make backspace behave in a sane manner
    set clipboard=unnamed

    if has('mouse')
        set mouse=a
    endif

    " Searching
    set ignorecase " case insensitive searching
    set smartcase " case-sensitive if expresson contains a capital letter
    set hlsearch " highlight search results
    set incsearch " set incremental search, like modern browsers
    set nolazyredraw " don't redraw while executing macros
    set modifiable " lets the buffer be modifiable

    set magic " Set magic on, for regex

    " error bells
    set noerrorbells
    set visualbell
    set t_vb=
    set tm=500
" }}}
" Appearance {{{
    set number " show line numbers
    set wrap " turn on line wrapping
    set wrapmargin=8 " wrap lines when coming within n characters from side
    set linebreak " set soft wrapping
    set showbreak=… " show ellipsis at breaking
    set autoindent " automatically set indent of new line
    set ttyfast " faster redrawing
    set diffopt+=vertical,iwhite,internal,algorithm:patience,hiddenoff
    set laststatus=2 " show the status line all the time
    set so=999 " set 10 lines to the cursors - when moving vertical
    set wildmenu " enhanced command line completion
    set hidden " current buffer can be put into background
    set showcmd " show incomplete commands
    set noshowmode " don't show which mode disabled for PowerLine
    set wildmode=list:longest " complete files like a shell
    set shell=$SHELL
    set cmdheight=1 " command bar height
    set title " set terminal title
    set showmatch " show matching braces
    set mat=2 " how many tenths of a second to blink
    set updatetime=300
    set signcolumn=yes
    set shortmess+=c

    " Tab control
    set smarttab " tab respects 'tabstop', 'shiftwidth', and 'softtabstop'
    set tabstop=4 " the visible width of tabs
    set softtabstop=4 " edit as if the tabs are 4 characters wide
    set shiftwidth=4 " number of spaces to use for indent and unindent
    set shiftround " round indent to a multiple of 'shiftwidth'

    " code folding settings
    set foldmethod=syntax " fold based on indent
    set foldlevelstart=99
    set foldnestmax=10 " deepest fold is 10 levels
    set nofoldenable " don't fold by default
    set foldlevel=1

    " toggle invisible characters
    set list
    set listchars=tab:→\ ,eol:¬,trail:⋅,extends:❯,precedes:❮
    set showbreak=↪

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

    " LightLine {{{
        Plug 'itchyny/lightline.vim'
	Plug 'ap/vim-buftabline'
        let g:lightline = {
            \   'colorscheme': 'shades_of_purple',
            \   'active': {
            \       'left': [ [ 'mode', 'paste' ],
            \               [ 'gitbranch' ],
            \               [ 'readonly', 'filetype', 'filename' ]],
            \       'right': [ [ 'percent' ], [ 'lineinfo' ],
            \               [ 'fileformat', 'fileencoding' ],
            \               [ 'gitblame', 'currentfunction',  'cocstatus', 'linter_errors', 'linter_warnings' ]]
            \   },
            \   'component_expand': {
            \   },
            \   'component_type': {
            \       'readonly': 'error',
            \       'linter_warnings': 'warning', 
            \       'linter_errors': 'error' 
            \   }, 
            \   'component_function': { 
            \       'fileencoding': 'helpers#lightline#fileEncoding',
            \       'filename': 'helpers#lightline#fileName',
            \       'fileformat': 'helpers#lightline#fileFormat',
            \       'filetype': 'helpers#lightline#fileType',
            \       'gitbranch': 'helpers#lightline#gitBranch',
            \       'cocstatus': 'coc#status',
            \       'currentfunction': 'helpers#lightline#currentFunction',
            \       'gitblame': 'helpers#lightline#gitBlame',
            \       'pomostatus': 'helpers#lightline#pomoStatus'
            \   },
            \   'tabline': {
            \       'left': [ [ 'tabs' ] ],
            \       'right': [ [ 'close' ] ]
            \   },
            \   'tab': {
            \       'active': [ 'filename', 'modified' ],
            \       'inactive': [ 'filename', 'modified' ],
            \   },
            \   'separator': { 'left': '', 'right': '' },
            \   'subseparator': { 'left': '', 'right': '' }
        \ }
    " }}}
    " better linux integration {{{
        Plug 'tpope/vim-eunuch'
        " :Delete :Unlink :Move :Rename :Chmod :Mkdir :Cfind :Clocate
        " :Lfind :Llocate :Wall :SudoWrite :SudoEdit
    " }}}
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

    " set paste toggle
    set pastetoggle=<leader>v

    " Let shift enter and ctrl enter function like an IDE esc and inserting abv/bel
    imap <C-cr> <esc>O
    imap <S-cr> <esc>o

    " edit ~/.config/nvim/init.vim
    map <leader>ev :e! ~/.config/nvim/init.vim<cr>
    " edit gitconfig
    map <leader>eg :e! ~/.gitconfig<cr>

    " source the current file
    nmap <leader>so :source %<cr>

    " map control+a to select all from anywhere
    nmap <leader>a <esc>gg<S-v>G

    " clear highlighted search
    noremap <space> :set hlsearch! hlsearch?<cr>

    " activate spell-checking alternatives
    nmap ;s :set invspell spelllang=en<cr>

    " markdown to html
    nmap <leader>md :%!markdown --html4tags <cr>

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

    nnoremap <silent> <leader>u :call functions#HtmlUnEscape()<cr>

    command! Rm call functions#Delete()
    command! RM call functions#Delete() <Bar> q!

    " Custom text objects

    " inner-line
    xnoremap <silent> il :<c-u>normal! g_v^<cr>
    onoremap <silent> il :<c-u>normal! g_v^<cr>

    " around line
    vnoremap <silent> al :<c-u>normal! $v0<cr>
    onoremap <silent> al :<c-u>normal! $v0<cr>

    " Interesting word mappings
    nmap <leader>0 <Plug>ClearInterestingWord
    nmap <leader>1 <Plug>HiInterestingWord1
    nmap <leader>2 <Plug>HiInterestingWord2
    nmap <leader>3 <Plug>HiInterestingWord3
    nmap <leader>4 <Plug>HiInterestingWord4
    nmap <leader>5 <Plug>HiInterestingWord5
    nmap <leader>6 <Plug>HiInterestingWord6
" }}}

" AutoGroups {{{
    " file type specific settings
    augroup configgroup
        autocmd!

        " automatically resize panes on resize
        autocmd VimResized * exe 'normal! \<c-w>='
        autocmd BufWritePost .vimrc,.vimrc.local,init.vim source %
        autocmd BufWritePost .vimrc.local source %
        " save all files on focus lost, ignoring warnings about untitled buffers
        autocmd FocusLost * silent! wa

        " make quickfix windows take all the lower section of the screen
        " when there are multiple windows open
        autocmd FileType qf wincmd J
        autocmd FileType qf nmap <buffer> q :q<cr>
    augroup END
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

    " quickrun
    Plug 'thinca/vim-quickrun'

    " enables repeating other supported plugins with the . command
    Plug 'tpope/vim-repeat'

    " .editorconfig support
    Plug 'editorconfig/editorconfig-vim'

    " single/multi line code handler: gS - split one line into multiple, gJ - combine multiple lines into one
    Plug 'AndrewRadev/splitjoin.vim'

    " add end, endif, etc. automatically
    Plug 'tpope/vim-endwise'

    " detect indent style (tabs vs. spaces)
    Plug 'tpope/vim-sleuth'

    " Startify: Fancy startup screen for vim {{{
	Plug 'mhinz/vim-startify'

	" Don't change to directory when selecting a file
	let g:startify_files_number = 5
	let g:startify_change_to_dir = 0
	let g:startify_custom_header = [ ]
	let g:startify_relative_path = 1
	let g:startify_use_env = 1

	" Custom startup list, only show MRU from current directory/project
	let g:startify_lists = [
	\  { 'type': 'dir',       'header': [ 'Files '. getcwd() ] },
	\  { 'type': function('helpers#startify#listcommits'), 'header': [ 'Recent Commits' ] },
	\  { 'type': 'sessions',  'header': [ 'Sessions' ]       },
	\  { 'type': 'bookmarks', 'header': [ 'Bookmarks' ]      },
	\  { 'type': 'commands',  'header': [ 'Commands' ]       },
	\ ]

	let g:startify_commands = [
	\   { 'up': [ 'Update Plugins', ':PlugUpdate' ] },
	\   { 'ug': [ 'Upgrade Plugin Manager', ':PlugUpgrade' ] },
	\ ]

	let g:startify_bookmarks = [
	    \ { 'c': '~/.config/nvim/init.vim' },
	    \ { 'g': '~/.gitconfig' },
	    \ { 'z': '~/.zshrc' },
	    \ { 'a': '~/.config/awesome/rc.lua' },
	    \ { 't': '~/.config/kitty/kitty.conf' },
    	\ ]

	autocmd User Startified setlocal cursorline
	nmap <leader>st :Startify<cr>
    " }}}

    " Close buffers but keep splits
    Plug 'moll/vim-bbye'
    nmap <leader>b :Bdelete<cr>

    " Writing in vim {{{{
	Plug 'junegunn/goyo.vim'
	Plug 'junegunn/limelight.vim'

	let g:limelight_conceal_ctermfg = 56
	let g:limelight_conceal_guifg = '#5f00d7'
	let g:limelight_default_coeffecient = 0.7
	let g:limelight_paragraph_span = 1
	let g:limelight_priority = -1

	nmap <leader>gy :Goyo<CR>
	nmap <leader>ll :Limelight!!<CR>

   " }}}
   " Context-aware pasting
   Plug 'sickill/vim-pasta'

    " NERDTree {{{
      Plug 'scrooloose/nerdtree', { 'on': ['NERDTreeToggle', 'NERDTreeFind'] } 
      Plug 'Xuyuanp/nerdtree-git-plugin'
      Plug 'ryanoasis/vim-devicons'
      Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
      let g:WebDevIconsUseSystemCallToDetetOS = 1
      let g:WebDevIconsUnicodeDecorateFolderNodes = 1
      let g:DevIconsEnableFolderOpenClose = 1
      let g:DevIconsEnableFolderExtensionPatternmatching = 1
      let NERDTreeDirArrowExpandable = "\u00a0" " make arrows invisible
      let NERDTreeDirArrowCollapsible = "\u00a0" " make arrows invisible
      let NERDTreeNodeDelimiter = "\u263a" " smiley face

      augroup nerdtree
          autocmd!
          autocmd FileType nerdtree setlocal nolist " turn off whitespace characters
          autocmd FileType nerdtree setlocal nocursorline " turn off line highlighting for performance
      augroup END

      " Toggle NERDTree
      function! ToggleNerdTree()
          if @% != "" && @% !~ "Startify" && (!exists("g:NERDTree") || (g:NERDTree.ExistsForTab() && !g:NERDTree.IsOpen()))
              :NERDTreeFind
          else
              :NERDTreeToggle
          endif
      endfunction
      " toggle nerd tree
      nmap <silent> <leader>n :call ToggleNerdTree()<cr>
      " find the current file in nerdtree without needing to reload the drawer
      nmap <silent> <leader>y :NERDTreeFind<cr>

	  let NERDTreeShowHidden=1
		let g:NERDTreeIndicatorMapCustom = {
		\ "Modified"  : "✹",
		\ "Staged"    : "✚",
		\ "Untracked" : "✭",
		\ "Renamed"   : "➜",
		\ "Unmerged"  : "═",
		\ "Deleted"   : "✖",
		\ "Dirty"     : "✗",
		\ "Clean"     : "✔︎",
		\ 'Ignored'   : '☒',
		\ "Unknown"   : "?"
		\ }
   
   
    " }}}
    " FZF {{{
        Plug '/usr/local/opt/fzf'
        Plug 'junegunn/fzf.vim'
        let g:fzf_layout = { 'down': '~25%' }

        if isdirectory(".git")
            " if in a git project, use :GFiles
            nmap <silent> <leader>t :GitFiles --cached --others --exclude-standard<cr>
        else
            " otherwise, use :FZF
            nmap <silent> <leader>t :FZF<cr>
        endif

        nmap <silent> <leader>s :GFiles?<cr>

        nmap <silent> <leader>r :Buffers<cr>
        nmap <silent> <leader>e :FZF<cr>
        nmap <leader><tab> <plug>(fzf-maps-n)
        xmap <leader><tab> <plug>(fzf-maps-x)
        omap <leader><tab> <plug>(fzf-maps-o)

        " Insert mode completion
        imap <c-x><c-k> <plug>(fzf-complete-word)
        imap <c-x><c-f> <plug>(fzf-complete-path)
        imap <c-x><c-j> <plug>(fzf-complete-file-ag)
        imap <c-x><c-l> <plug>(fzf-complete-line)

        nnoremap <silent> <Leader>C :call fzf#run({
        \   'source':
        \     map(split(globpath(&rtp, "colors/*.vim"), "\n"),
        \         "substitute(fnamemodify(v:val, ':t'), '\\..\\{-}$', '', '')"),
        \   'sink':    'colo',
        \   'options': '+m',
        \   'left':    30
        \ })<CR>

        command! FZFMru call fzf#run({
        \  'source':  v:oldfiles,
        \  'sink':    'e',
        \  'options': '-m -x +s',
        \  'down':    '40%'})

        command! -bang -nargs=* Find call fzf#vim#grep(
            \ 'rg --column --line-number --no-heading --follow --color=always '.<q-args>, 1,
            \ <bang>0 ? fzf#vim#with_preview('up:60%') : fzf#vim#with_preview('right:50%:hidden', '?'), <bang>0)
        command! -bang -nargs=? -complete=dir Files
            \ call fzf#vim#files(<q-args>, fzf#vim#with_preview('right:50%', '?'), <bang>0)
        command! -bang -nargs=? -complete=dir GitFiles
            \ call fzf#vim#gitfiles(<q-args>, fzf#vim#with_preview('right:50%', '?'), <bang>0)
    " }}}

    " vim-fugitive {{{
        Plug 'tpope/vim-fugitive'
        nmap <silent> <leader>gs :Gstatus<cr>
        nmap <leader>ge :Gedit<cr>
        nmap <silent><leader>gr :Gread<cr>
        nmap <silent><leader>gb :Gblame<cr>

        Plug 'tpope/vim-rhubarb' " hub extension for fugitive
        Plug 'sodapopcan/vim-twiggy'
    " }}}
    " Vim tmux
    Plug 'tmux-plugins/vim-tmux'

    " UltiSnips {{{
        Plug 'SirVer/ultisnips' " Snippets plugin
        let g:UltiSnipsExpandTrigger="<leader>m"
        let g:UltiSnipsJumpForwardTrigger="<C-j>"
        let g:UltiSnipsJumpBackwardTrigger="<C-k>"
        let g:UltiSnipsEditSplit="vertical"
        nmap <leader>ue :UltiSnipsEdit<cr>

    " }}}

    " coc {{{
        Plug 'neoclide/coc.nvim', {'do': 'yarn install --frozen-lockfile'}

        let g:coc_global_extensions = [
        \ 'coc-css',
        \ 'coc-json',
        \ 'coc-tsserver',
        \ 'coc-git',
        \ 'coc-eslint',
        \ 'coc-tslint-plugin',
        \ 'coc-pairs',
        \ 'coc-sh',
        \ 'coc-vimlsp',
        \ 'coc-emmet',
        \ 'coc-prettier',
        \ 'coc-ultisnips',
        \ 'coc-explorer',
        \ 'coc-python',
        \ 'coc-lists',
        \ 'coc-rls',
        \ 'coc-vimtex',
        \ 'coc-java',
        \ 'coc-smartf',
        \ 'coc-yank'
        \ ]

        autocmd CursorHold * silent call CocActionAsync('highlight')

        " coc-prettier
        command! -nargs=0 Prettier :CocCommand prettier.formatFile
        nmap <leader>f :CocCommand prettier.formatFile<cr>

        " coc-git
        nmap [g <Plug>(coc-git-prevchunk)
        nmap ]g <Plug>(coc-git-nextchunk)
        nmap gs <Plug>(coc-git-chunkinfo)
        nmap gu :CocCommand git.chunkUndo<cr>

        nmap <silent> <leader>k :CocCommand explorer<cr>

        "remap keys for gotos
        nmap <silent> gd <Plug>(coc-definition)
        nmap <silent> gy <Plug>(coc-type-definition)
        nmap <silent> gi <Plug>(coc-implementation)
        nmap <silent> gr <Plug>(coc-references)
        nmap <silent> gh <Plug>(coc-doHover)

        " diagnostics navigation
        nmap <silent> [c <Plug>(coc-diagnostic-prev)
        nmap <silent> ]c <Plug>(coc-diagnostic-next)

        " rename
        nmap <silent> <leader>rn <Plug>(coc-rename)

        " Remap for format selected region
        xmap <leader>f  <Plug>(coc-format-selected)
        nmap <leader>f  <Plug>(coc-format-selected)

        " organize imports
        command! -nargs=0 OR :call CocAction('runCommand', 'editor.action.organizeImport')

        " Use K to show documentation in preview window
        nnoremap <silent> K :call <SID>show_documentation()<CR>

        function! s:show_documentation()
            if (index(['vim','help'], &filetype) >= 0)
                execute 'h '.expand('<cword>')
            else
                call CocAction('doHover')
            endif
        endfunction

        "tab completion
        inoremap <silent><expr> <TAB>
            \ pumvisible() ? "\<C-n>" :
            \ <SID>check_back_space() ? "\<TAB>" :
            \ coc#refresh()
        inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

        function! s:check_back_space() abort
        let col = col('.') - 1
        return !col || getline('.')[col - 1]  =~# '\s'
        endfunction

        " Using CocList
        " Show all diagnostics
        nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
        " Manage extensions
        nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
        " Show commands
        nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
        " Find symbol of current document
        nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
        " Search workspace symbols
        nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
        " Do default action for next item.
        nnoremap <silent> <space>j  :<C-u>CocNext<CR>
        " Do default action for previous item.
        nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
        " Resume latest coc list
        nnoremap <silent> <space>p  :<C-u>CocListResume<CR>

        " coc-smartf setup
        " press <esc> to cancel.
        nmap f <Plug>(coc-smartf-forward)
        nmap F <Plug>(coc-smartf-backward)
        nmap ; <Plug>(coc-smartf-repeat)
        nmap , <Plug>(coc-smartf-repeat-opposite)

        augroup Smartf
          autocmd User SmartfEnter :hi Conceal ctermfg=220 guifg=#6638F0
          autocmd User SmartfLeave :hi Conceal ctermfg=239 guifg=#504945
        augroup end

        " coc-yank setup
        " -A means auto preview, and --normal means open list on normal mode.
        nnoremap <silent> <space>y  :<C-u>CocList -A --normal yank<cr>

    " }}}
" }}}

" Language-Specific Configuration {{{
    " html / templates {{{
        " emmet support for vim - easily create markdup wth CSS-like syntax
        Plug 'mattn/emmet-vim'

        " match tags in html, similar to paren support
        Plug 'gregsexton/MatchTag', { 'for': 'html' }

        " html5 support
        Plug 'othree/html5.vim', { 'for': 'html' }


        " Paint css colors with the real color
        Plug 'lilydjwg/colorizer'

        " mustache support
        Plug 'mustache/vim-mustache-handlebars'



        " Live Preview for html/css bracey with npm/node in the directory
        Plug 'turbio/bracey.vim'
        let g:bracey_browser_command = 0
        let g:bracey_auto_start_browser = 1
        let g:bracey_refresh_on_save = 1
        let g:bracey_auto_start_server = 1
        noremap <leader>bb :Bracey<cr>
        noremap <leader>bs :BraceyStop<cr>
        noremap <leader>br :BraceyReload<cr>
    " }}}

    " JavaScript {{{
        Plug 'moll/vim-node', { 'for': 'javascript' }
        Plug 'ternjs/tern_for_vim', { 'for': ['javascript', 'javascript.jsx'], 'do': 'npm install' }
        Plug 'MaxMEllon/vim-jsx-pretty'
        let g:vim_jsx_pretty_highlight_close_tag = 1
    " }}}

    " TypeScript {{{
        Plug 'leafgarland/typescript-vim', { 'for': ['typescript', 'typescript.tsx'] }
    " }}}


    " Styles {{{
        Plug 'wavded/vim-stylus', { 'for': ['stylus', 'markdown'] }
        Plug 'hail2u/vim-css3-syntax', { 'for': 'css' }
    " }}}

    " markdown {{{
        " Plugins for a better markdown writing experience
        Plug 'godlygeek/tabular', { 'for': 'markdown' }
        Plug 'plasticboy/vim-markdown', { 'as': 'markdown', 'for': 'markdown' }
        let g:vim_markdown_toc_autofit = 1
        nmap <leader>Tc :Toc<cr>
        nmap <leader>Tv :Tocv<cr>

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
        nmap <leader>vc :VimtexClean<cr>
        nmap <leader>vt :VimtexTocToggle<cr>

        " Tex conceal - make it easier to read as your write live
        Plug 'KeitaNakamura/tex-conceal.vim'
        set conceallevel=1
        let g:tex_conceal='abdmg'

        setlocal spell
        set spelllang=en_us
        inoremap <C-s> <c-g>u<esc>[s1z=`]a<c-g>u
        nmap vu vgu
        nmap vU vgU


    " }}}
    
    " init.lua {{{

       command! Scratch lua require'tools'.makeScratch()

    "}}}

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

    Plug 'ekalinin/Dockerfile.vim'
" }}}
" Lua shit {{{
   " load lua functions for navigation
   " lua require("navigation")
   " let g:fzf_layout = { 'window': 'lua NavigationFloatingWin()' }

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
