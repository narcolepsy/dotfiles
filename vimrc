set nocompatible              " be iMproved, required
filetype off                  " required

" """"""""""""""""""""""""""""""""""""""""""""""""""""
"    PLUGIN MANAGEMENT
" """"""""""""""""""""""""""""""""""""""""""""""""""""
" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
"Tell vim to use the local fzf, not the system one so the plugin is not newer
"than binary
set rtp+=~/.vim/bundle/fzf/bin/fzf
call vundle#begin()
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal

" Install user-supplied Bundles {{{
let s:extrarc = expand('$HOME' . '/.vimrc_local_plugins')
if filereadable(s:extrarc)
   exec ':so ' . s:extrarc
endif

"Plugin 'w0rp/ale'                               " Syntax Checker "TODO
"investigating if ale is causing issues in syntax files

Plugin 'VundleVim/Vundle.vim'                   " Vim Plugin Manager (required!)
Plugin 'godlygeek/tabular'                      " Alignment
Plugin 'vhda/verilog_systemverilog.vim'         " Verilog and Systemverilog syntax
Plugin 'vim-airline/vim-airline'                " Improved Status/Tabline
Plugin 'vim-airline/vim-airline-themes'         " Adds theme support to vim-airline
Plugin 'ryanoasis/vim-devicons.git'             " Add icon support to nerdtree
Plugin 'junegunn/fzf'                           " Full Path Fuzzy Finder - fzf.vim needs this to live!
Plugin 'junegunn/fzf.vim'                       " Full Path Fuzzy Finder
Plugin 'will133/vim-dirdiff'                    " Directory Diffing
Plugin 'scrooloose/nerdtree'                    " Explore the Filesystem
Plugin 'scrooloose/nerdcommenter'               " Easy comments
Plugin 'junegunn/vim-easy-align'                " Auto Alignment of Code
Plugin 'simnalamburt/vim-mundo'                          " Visualise Vim Undo Tree
Plugin 'jlanzarotta/bufexplorer'                " Buffer explorer
Plugin 'tpope/vim-surround'                     " Surround with Parentheses
Plugin 'tpope/vim-repeat'                       " Allows dot command to work with vim-surround
Plugin 'tpope/vim-abolish'                      " TODO add comment

Plugin 'tpope/vim-fugitive'                     " Git plugin

Plugin 'SirVer/UltiSnips'                      " Snippets engine "TODO FIX
Plugin 'honza/vim-snippets'                    " Snippets library "TODO FIX

Plugin 'simeji/winresizer'                      " Vim window resizer
Plugin 'Yggdroot/indentLine'                    " Visually Display Indentation
Plugin 'altercation/vim-colors-solarized'       " Solarized Colourscheme
Plugin 'flazz/vim-colorschemes'                 " Vim Colourschemes
Plugin 'vim-scripts/wombat'                     " Desert-like colourscheme

Plugin 'majutsushi/tagbar'                      " tag panel navigation - requires universal ctags
Plugin 'ludovicchabant/vim-gutentags'           " automatically generated tag file

Plugin 'markonm/traces.vim'                     " live regexp debugging
Plugin 'machakann/vim-highlightedyank'          " highlight yanked text (useful if doing complex copies)


call vundle#end()            " required
filetype plugin indent on    " required
"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" GENERIC MANDATORY USEFUL FUNCTIONS
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set wildmenu         " Wildcard menu
set textwidth=0      "no auto word wrapping, just causes pain
set tabstop=3        " numbers of spaces of tab character
set shiftwidth=3     " numbers of spaces to (auto)indent
set expandtab        " don't use tabs, use spaces
set autoindent       " always set autoindenting on
syntax enable        " enable syntax highlighting
set nocompatible     " don't make compatible with vi - use all new functions for vim
set ruler            " show line numbers at bottom
set backspace=eol,start,indent
set noswapfile 		" do not create a swap file (massive pain if session crashes)
set number           " Enable line numbers


" vim-airline fix: make laststatus=2 to get airline on all the time
set laststatus=2

map <F11> :let &background = ( &background == "light"? "dark" : "light" )<CR>
"set cindent " NO cindent
"set smartindent "NO smart indent


"Searching functions
set showmatch     "highlight matching brackets
set showcmd       "show commands as typed
set hlsearch      "enable coloured highlighting of search terms
set isfname-=,    " add , as a separator between /path/to/file,linenumber for verilog simulator syntax (cadence specific....)

"Navigating in splits
noremap <C-H> <C-W>h
noremap <C-J> <C-W>j
noremap <C-K> <C-W>k
noremap <C-L> <C-W>l

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Configure vim to have a global backup area for gundo
" and to disable .swp file usage, which causes nothing but issues
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
call system('mkdir -vp ~/.backup/undo/ > /dev/null 2>&1')
set backupdir=~/.backup,.       " list of directories for the backup file
set directory=~/.backup,~/tmp,. " list of directory names for the swap file
set nobackup            " do not write backup files
set backupskip+=~/tmp/*,/private/tmp/* " skip backups on OSX temp dir, for crontab -e to properly work
set noswapfile          " do not write .swp files
set undofile
set undodir=~/.backup/undo/,~/tmp,.


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Setup a leader - this is used for many vim functions
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let mapleader = ","


if has('win32') || has('win64')
   colors desert
   set guifont="Lucidia_Console:h8:cANSI"
else
   set gfn=Hack\ Nerd\ Font\ 9
   "powerline symbols working in vim
   let g:airline_powerline_fonts = 1

   set background=dark
   if has('gui_running')
      nmap <S-F12> :call FontSizeMinus()<CR>
      nmap <F12> :call FontSizePlus()<CR>
   else
      "Disable devicons as we can't guarantee shell font supports them
      let g:webdevicons_enable = 0
      set mouse=a
      if has("mouse_sgr")
         set ttymouse=sgr
      else
         set ttymouse=xterm2
      endif
      let g:solarized_termcolors=256
   endif
   colors solarized
endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Adding font size increase/decrease shortcuts F12/Shift+F12
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

if has("unix")
    function! FontSizePlus ()
      let l:gf_size_whole = matchstr(&guifont, '\( \)\@<=\d\+$')
      let l:gf_size_whole = l:gf_size_whole + 1
      let l:new_font_size = ' '.l:gf_size_whole
      let &guifont = substitute(&guifont, ' \d\+$', l:new_font_size, '')
    endfunction

    function! FontSizeMinus ()
      let l:gf_size_whole = matchstr(&guifont, '\( \)\@<=\d\+$')
      let l:gf_size_whole = l:gf_size_whole - 1
      let l:new_font_size = ' '.l:gf_size_whole
      let &guifont = substitute(&guifont, ' \d\+$', l:new_font_size, '')
    endfunction
else
    function! FontSizePlus ()
      let l:gf_size_whole = matchstr(&guifont, '\(:h\)\@<=\d\+$')
      let l:gf_size_whole = l:gf_size_whole + 1
      let l:new_font_size = ':h'.l:gf_size_whole
      let &guifont = substitute(&guifont, ':h\d\+$', l:new_font_size, '')
    endfunction

    function! FontSizeMinus ()
      let l:gf_size_whole = matchstr(&guifont, '\(:h\)\@<=\d\+$')
      let l:gf_size_whole = l:gf_size_whole - 1
      let l:new_font_size = ':h'.l:gf_size_whole
      let &guifont = substitute(&guifont, ':h\d\+$', l:new_font_size, '')
    endfunction
endif

"""""""""""""""""""""""""""""""""""""""""
"" Folding ""
"""""""""""""""""""""""""""""""""""""""""
inoremap <F9> <C-O>za
nnoremap <F9> za
onoremap <F9> <C-C>za
"If manual folding is on
vnoremap <F9> zf


nmap <leader>p4 :! p4 edit %<CR>
nnoremap <F4> :! p4 edit %<CR>

" Adding toggle for tagbar
nnoremap <F3> :TagbarToggle<CR>
let g:tagbar_ctags_bin = $HOME . '/local_tools/bin/ctags'
"let g:tagbar_ctags_bin = $HOME . '/local_tools/bin/ctags --fields=\*'

" Adding in indentlines toggle
nnoremap <F7> :NERDTreeToggle<CR>
"Change NERDTree settings
let NERDTreeMouseMode = 2
"TODO investigate why these glyphs need to be defined
"let g:NERDTreeDirArrowExpandable = '▸'
"let g:NERDTreeDirArrowCollapsible = '▾'
"let g:NERDTreeGlyphReadOnly = "RO"

" Adding in indentlines toggle
nnoremap <F6> :IndentLinesToggle<CR>
autocmd FileType nerdtree setlocal shiftwidth=2 tabstop=2
autocmd FileType nerdtree IndentLinesReset
""""""""""""""""""""""""""""""""""""""""""""""""""""
" Adding in mundo toggles
""""""""""""""""""""""""""""""""""""""""""""""""""""
nnoremap <F5> :MundoToggle<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""
" Adding in ALE toggles
""""""""""""""""""""""""""""""""""""""""""""""""""""
nnoremap <F10> :ALEToggle<CR>
"Turn off balloons as they seem quite buggy
let g:ale_set_balloons = 0
set noballooneval
"TODO disabling ALE for demo purposes - roll this out once it works for
"verilog
let g:ale_enabled = 0

"Define a list of project roots for taglist creation
let g:gutentags_enabled       = 1
let g:gutentags_ctags_executable = $HOME . '/local_tools/bin/ctags'
let g:gutentags_ctags_exclude = [ 'tech/*',
                                 \ 'tech_local/*',
                                 \ 'Physical/*',
                                 \ '*.js',
                                 \ '*.json' ]
"let g:gutentags_ctags_exclude_wildignore = 0 " TODO working around a bug in gutentags
let g:gutentags_project_root  = ['.p4config']
nnoremap <C-]> g<C-]> " enforce vim to prompt for tag match rather than always select first match


""""""""""""""""""""""""""""""""""""""""""""""""""""
"Ultisnips configuration
""""""""""""""""""""""""""""""""""""""""""""""""""""
" Trigger configuration. Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.
let g:UltiSnipsExpandTrigger="<A-n>"
let g:UltiSnipsJumpForwardTrigger="<A-n>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"
 
" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"
let g:UltiSnipsSnippetDirectories=["UltiSnips", "~/.vim/bundle/vim-snippets/UltiSnips"]

"TODO """""""""""""""""""""""""""""""""""""
let g:UltiSnipsUsePythonVersion=3 "TODO using python3 seems to cause vim to crash

"""""""""""""
" Autocomplete Functions
""""""""""""
"set complete=.,i
"set complete=.,] "don't need included files checked, but tags is nice :)
set complete=., "don't need included files checked

""""""""""""""""""""""""""""""""""""""""""""""""""""""
" FZF shortcut setup
nmap <leader>f :Files<CR>
nmap <leader>b :Buffers<CR>
nmap <leader>a :Ag<space>
""""""""""""""""""""""""""""""""""""""""""""""""""""
" Filetype functions
" """"""""""""""""""""""""""""""""""""""""""""""""""""
filetype plugin indent on
au BufNewFile,BufRead *.lib,*.svh,*.sv,*.v,*.vh,*.vams,*.f call SetVerilogOptions()
au BufNewFile,BufRead *.rv call SetRubyvogOptions()
"au BufNewFile,BufRead *.rv set ft=verilog_systemverilog
au BufNewFile,BufRead *.cpp.rf set ft=cpp
au BufNewFile,BufRead *.rb.rf set ft=ruby
au BufNewFile,BufRead *.regmap.rb set ft=rubyrdl

function! SetVerilogOptions()
   set ft=verilog_systemverilog
   "UltiSnipsAddFiletypes systemverilog.verilog "TODO re-rnable snippets
endfunction
function! SetRubyvogOptions()
   set ft=rubyvog
   "UltiSnipsAddFiletypes systemverilog.verilog "TODO re-rnable snippets
endfunction
nnoremap <leader>i :VerilogFollowInstance<CR>
nnoremap <leader>o :VerilogReturnInstance<CR>
nnoremap <leader>I :VerilogFollowPort<CR>
""""""""""""""""""""""""""""""""""""""""""""""""""""
" Personal Additions
""""""""""""""""""""""""""""""""""""""""""""""""""""
set ic            " set case insensitive search on
set smartcase     " set case insensitive search on
nmap <leader>l :set list!<CR> " show hidden characters such as newline/tab
nmap <leader>u :set gfn=Terminess\ Powerline\ 8<CR>
nmap <leader>U :set gfn=Terminess\ Powerline\ 15<CR>
nmap <leader>h :nohlsearch<CR>
nmap <leader>nt :NERDTree 
nmap <leader>n :NERDTreeToggle<CR>
nmap <leader>w SetWritableBit<CR>
nmap <leader>c "+y
nmap <leader>so :source ~/.vimrc<CR>
nmap <leader>t :call mkdir(fnamemodify(tempname(),':h'),'p',0700)<CR>

"Use TAB to complete when typing words, else inserts TABs as usual.
"Uses dictionary and source files to find matching words to complete.

"See help completion for source,
"Note: usual completion is on <C-n> but more trouble to press all the time.
"Never type the same word twice and maybe learn a new spellings!
"Use the Linux dictionary when spelling is in doubt.
"Window users can copy the file to their machine.
"Remapping ulti-snips expand trigger to be ALT+N instead of <TAB>
function! Tab_Or_Complete()
   if col('.')>1 && strpart( getline('.'), col('.')-2, 3 ) =~ '^\w'
      return "\<C-N>"
   else
      return "\<Tab>"
   endif
endfunction
inoremap <Tab> <C-R>=Tab_Or_Complete()<CR>
"Map shift-tab to tab left
inoremap <S-Tab> <C-d>

""""""""""""""""""""""""""""""""""""""""""""""""""""
" TODO trying to fix Ag integration in vim
" """"""""""""""""""""""""""""""""""""""""""""""""""
autocmd VimEnter * command! -bang -nargs=* Ag
  \ call fzf#vim#ag(<q-args>, '--skip-vcs-ignores --ignore "Physical" --ignore "tech_local"', <bang>0)


"""""""""""""""""""""""""""""""""""""
" Ruby Ctags
let g:tagbar_type_ruby = {
    \ 'kinds' : [
        \ 'm:modules',
        \ 'c:classes',
        \ 'd:describes',
        \ 'C:contexts',
        \ 'f:methods',
        \ 'F:singleton methods'
    \ ]
    \ }


"""""""""""""""""""""""""""""""""""""
" Powerline configuration
let g:airline_theme='solarized'
let g:airline#extensions#tabline#enabled     = 0
let g:airline#extensions#whitespace#enabled  = 0
let g:airline#parts#ffenc#skip_expected_string='utf-8[unix]'
let g:airline_skip_empty_sections = 1

""""""""""""""""""""""""""""""""""""""""""""
" file is large from 10mb - trying to turn off features for netlists
let g:LargeFile = 1024 * 1024 * 10
augroup LargeFile 
 autocmd BufReadPre * let f=getfsize(expand("<afile>")) | if f > g:LargeFile || f == -2 | call LargeFile() | endif
augroup END

function! LargeFile()
 "Tagbar goes nuts with gigantic files - especially verilog netlists. Rely on
 "ctags only
 let b:tagbar_ignore = 1
 "" no syntax highlighting etc
 "set eventignore+=FileType
 "" save memory when other file is viewed
 "setlocal bufhidden=unload
 "" is read-only (write with :w new_filename)
 "setlocal buftype=nowrite
 "" no undo possible
 "setlocal undolevels=-1
 "" display message
 autocmd VimEnter *  echo "The file is larger than " . (g:LargeFile / 1024 / 1024) . " MB, so tagbar is disabled (see .vimrc for details)."
endfunction

"Creating a function to chmod a file when doing a writebang
" - turn off detection of file permission change checking
" - chmod u+w <file>
" - write file
" - turn back on file permission change checking
function! SetWritableBit()
   let fname = expand("%:p")
   checktime
   execute "au FileChangedShell " . fname . " :echo"
   silent !chmod u+w %
   write
   checktime
   execute "au! FileChangedShell " . fname
endfunction
command! -bang W call SetWritableBit()

""""""""""""""""""""""""
" TODO can be removed with updated vim
if !exists('##TextYankPost')
   map y <Plug>(highlightedyank)
endif

"""""""""""""""""""""""""""
" vim-devicons mappings
"""""""""""""""""""""""""""
if exists("g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols")
else
   let g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols = {}
endif
let g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols['v'] = '' "f27d
let g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols['sv'] = '' "f27d
let g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols['rv'] = '﬒' "fb12
"let g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols['bom'] = '' "e615
let g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols['bom'] = '' "f1e2
let g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols['erb'] = '' "f43b
let g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols['tcl'] = '' "f462
let g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols['log'] = '' "f40e
let g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols['txt'] = '' "f40e
let g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols['rpt'] = '' "f40e
let g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols['sgdc'] = '﫸' "faf8
let g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols['swl'] = '﫸' "faf8
let g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols['awl'] = '﫸' "faf8
"Error symbols
let g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols['core'] = '' "f46e
let g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols['diag'] = '' "f46e

if exists("let g:WebDevIconsUnicodeDecorateFileNodesExactSymbols")
else
  let g:WebDevIconsUnicodeDecorateFileNodesExactSymbols = {} " needed
endif
"NOTE: all have to be lowercase
let g:WebDevIconsUnicodeDecorateFileNodesExactSymbols['readme'] = '' "f071
let g:WebDevIconsUnicodeDecorateFileNodesExactSymbols['rakefile'] = '擄' "f930
let g:WebDevIconsUnicodeDecorateFileNodesExactSymbols['makefile'] = '擄' "f930
let g:WebDevIconsUnicodeDecorateFileNodesExactSymbols['build_it'] = '屢' "f94b
"let g:WebDevIconsUnicodeDecorateFileNodesExactSymbols['tags'] = '﬜' "fb1c
let g:WebDevIconsUnicodeDecorateFileNodesExactSymbols['tags'] = '笠' "f9f8
"let g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols['rv'] = '' "f690


"Try to get devicons to not be clipped
autocmd FileType nerdtree setlocal nolist
let g:WebDevIconsNerdTreeAfterGlyphPadding = '  '

"Disable statusline filetype glyph
let g:webdevicons_enable_airline_statusline  = 0
let g:webdevicons_enable_airline_tabline     = 0

" after a re-source, fix syntax matching issues (concealing brackets):
if exists('g:loaded_webdevicons')
   call webdevicons#refresh()
endif
