set nocompatible              " be iMproved, required
filetype off                  " required

" """"""""""""""""""""""""""""""""""""""""""""""""""""
"    PLUGIN MANAGEMENT
" """"""""""""""""""""""""""""""""""""""""""""""""""""
" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
Plugin 'VundleVim/Vundle.vim'                   " Vim Plugin Manager (required!)
Plugin 'godlygeek/tabular'                      " Alignment
Plugin 'plasticboy/vim-markdown'                " Markdown Syntax Highlighting (must come after tabular!)
Plugin 'vhda/verilog_systemverilog.vim'         " Verilog and Systemverilog syntax
Plugin 'vim-airline/vim-airline'                " Improved Status/Tabline
Plugin 'vim-airline/vim-airline-themes'         " Adds theme support to vim-airline
"Plugin 'junegunn/fzf'                           " Full Path Fuzzy Finder - fzf.vim needs this to live!
"Plugin 'junegunn/fzf.vim'                       " Full Path Fuzzy Finder
Plugin 'ctrlpvim/ctrlp.vim'                     " Fuzzy file finder (written in vimscript)
"Plugin 'w0rp/ale'                               " Syntax Checker "TODO
"investigating if ale is causing issues in syntax files
Plugin 'will133/vim-dirdiff'                    " Directory Diffing
Plugin 'scrooloose/nerdtree'                    " Explore the Filesystem
Plugin 'scrooloose/nerdcommenter'               " Easy comments
Plugin 'junegunn/vim-easy-align'                " Auto Alignment of Code
Plugin 'sjl/gundo.vim'                          " Visualise Vim Undo Tree
Plugin 'jlanzarotta/bufexplorer'                " Buffer explorer
Plugin 'tpope/vim-surround'                     " Surround with Parentheses
"Plugin 'ervandew/supertab'                     " Tab Autocompletion
"WTF? multiple cursors?
"Plugin 'terryma/vim-multiple-cursors'          " Multiple Cursors ??
Plugin 'ntpeters/vim-better-whitespace'         " Highlights Whitespace
Plugin 'vim-scripts/genutils'                   " TODO remove? Required by perforce

Plugin 'tpope/vim-fugitive'                     " Git plugin

"Plugin 'SirVer/UltiSnips'                      " Snippets engine
"Plugin 'honza/vim-snippets'                    " Snippet files
" or use snipmate? - confirm with Robbie
Plugin 'simeji/winresizer'                      " Vim window resizer
Plugin 'Yggdroot/indentLine'                    " Visually Display Indentation
Plugin 'altercation/vim-colors-solarized'       " Solarized Colourscheme
Plugin 'flazz/vim-colorschemes'                 " Vim Colourschemes
Plugin 'vim-scripts/wombat'                     " Desert-like colourscheme

Plugin 'majutsushi/tagbar'                      " tag panel navigation - requires universal ctags
Plugin 'ludovicchabant/vim-gutentags'           " automatically generated tag file

call vundle#end()            " required
filetype plugin indent on    " required
"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" GENERIC MANDATORY USEFUL FUNCTIONS
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
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
   colors wombat
   "set guifont="Lucidia_Console:h8:cANSI"
   set guifont=peep:h8:cANSI
else
   "set gfn=Liberation\ Mono\ 6.5
   "set gfn=Bitstream\ Vera\ Sans\ Mono\ 7
   set gfn=Terminess\ Powerline\ 14
   "Try to get powerline symbols working in vim
   let g:airline_powerline_fonts = 1


   "set gfn=Anonymous\ Pro\ for\ Powerline\ 8
   "set gfn=monofur\ for\ Powerline\ 10
   "set gfn=Neep\ 7
   "colors wombat
   if has('gui_running')
      set background=dark
      colors solarized
   else
      set background=dark
      let g:solarized_termcolors=256
      colors solarized
   endif
   "highlight Search ctermfg=0 ctermbg=220 guifg=black guibg=gold
endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Configure ctrlp
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:ctrlp_root_markers = ['.p4config']
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
"let g:ctrlp_custom_ignore = '\v[\/](tech|tech_local)$'
let g:ctrlp_custom_ignore = {
  \ 'dir'        : '\v[\/](tech|tech_local)$',
  \ 'link'       : 'some_bad_symbolic_links',
\ }
"  \ 'tech':  '\vtech\/$',
"  \ 'tech_local': '\vtech_local\/$',
"  \ 'link': 'some_bad_symbolic_links',
"""""""""""""""""""""""""""""""""""""""""
"" Folding ""
"""""""""""""""""""""""""""""""""""""""""
inoremap <F9> <C-O>za
nnoremap <F9> za
onoremap <F9> <C-C>za
"If manual folding is on
vnoremap <F9> zf
nmap <leader>fol :set shiftwidth=2<CR>:set fdm=indent<CR>:set foldcolumn=4<CR>
nmap <leader>nof :set shiftwidth=3<CR>:set nofoldenable<CR>:set foldcolumn=0<CR>
nmap <leader>p4 :! p4 edit %<CR>
nnoremap <F4> :! p4 edit %<CR>

" Adding toggle for tabbar
nnoremap <F3> :TagbarToggle<CR>
"let g:tagbar_ctags_bin = $HOME . '/build/universal-ctags/bin/ctags'

" Adding in indentlines toggle
nnoremap <F7> :NERDTreeToggle<CR>
"Change NERDTree settings
let NERDTreeMouseMode = 2

" Adding in indentlines toggle
nnoremap <F6> :IndentLinesToggle<CR>
""""""""""""""""""""""""""""""""""""""""""""""""""""
" Adding in gundo toggles
""""""""""""""""""""""""""""""""""""""""""""""""""""
nnoremap <F5> :GundoToggle<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""
"Now set up taglist plugin
""""""""""""""""""""""""""""""""""""""""""""""""""""
nmap <leader>tl :TlistToggle<CR>
let Tlist_Use_Right_Window=1

"Define a list of project roots for taglist creation
let g:gutentags_enabled       = 1
"TODO get universal ctags installed!
"let g:gutentags_ctags_executable = $HOME . '/build/universal-ctags/bin/ctags'
let g:gutentags_ctags_exclude = [ 'tech/*',
                                 \ 'tech_local/*',
                                 \ '*.js',
                                 \ '*.json' ]
let g:gutentags_project_root  = ['.p4config']


""""""""""""""""""""""""""""""""""""""""""""""""""""
"Perforce plugins
""""""""""""""""""""""""""""""""""""""""""""""""""""
"this means a multi-line return code (i.e. if two people are editing the same file will not result in a failure to p4 edit)
let g:p4MaxLinesInDialog = 5

"""""""""""""
" Autocomplete Functions
""""""""""""
"set complete=.,i
"set complete=.,] "don't need included files checked, but tags is nice :)
set complete=., "don't need included files checked

""""""""""""""""""""""""""""""""""""""""""""""""""""
" Filetype functions
" """"""""""""""""""""""""""""""""""""""""""""""""""""
filetype plugin indent on
au BufNewFile,BufRead *.lib,*.svh,*.sv,*.v,*.vh,*.vams set ft=verilog_systemverilog
au BufNewFile,BufRead *.rv set ft=rubyvog
"au BufNewFile,BufRead *.rv set ft=verilog_systemverilog
au BufNewFile,BufRead *.cpp.rf set ft=c
au BufNewFile,BufRead *.rb.rf set ft=ruby
au BufNewFile,BufRead *.regmap.rb set ft=rubyrdl

"Ensure that ruby verilog is correctly coloured within rv files - this has to
"be done last such that any specific overrides such as the ones above will win
  "\ 'syn_argument': "include @ERB syntax/ruby.vim keepend contains=@ERB",
  "  TODO
"  \ 'rubyvog1'     : [{
"     \ 'match_start' : "<%",
"     \ 'match_end'   : "%>",
"     \ 'syn_argument': "keepend contains=rubyCode",
"  \  },
"  \ {
"     \ 'match'       : "\<sh_psel\>",
"     \ 'syn_argument': "contains=Todo",
"  \  },
"  \ {
"     \ 'match'       : "\<clk_req_hold\>",
"     \ 'syn_argument': "contains=Todo",
"  \  }],
"  \ }
"let g:verilog_disable_indent = "property"
"let g:verilog_verbose = 1
"let g:verilog_syntax_fold_lst = "class"
"let g:verilog_quick_syntax = 1


""""""""""""""""""""""""""""""""""""""""""""""""""""
" Randomly useful functions
""""""""""""""""""""""""""""""""""""""""""""""""""""
"mark current pos (a)
"reverse search for module
"copy word (what does the i do?)
"return to mark a
"restore previous search
"echo to screen
nmap <leader>mod ma?module<CR>Wyiw/<Up><Up><CR>'a:echo "module -->" @0<CR>

nmap <leader>inst mb?)[\n\s]*\s*\w\+[\n\s]*\s*(<CR>wyw/<Up><Up><CR>'b:echo "instance --->" @0<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""
" Personal Additions
""""""""""""""""""""""""""""""""""""""""""""""""""""
set ic            " set case insensitive search on
set smartcase            " set case insensitive search on
nmap <leader>l :set list!<CR>
nmap <leader>u :set gfn=Terminess\ Powerline\ 8<CR>
nmap <leader>U :set gfn=Terminess\ Powerline\ 15<CR>
nmap <leader>h :nohlsearch<CR>
nmap <leader>n :NERDTree
nmap <leader>nt :NERDTree<CR>
nmap <leader>v :s/\<\w*\>/&  (&)<CR>/aaa<CR>
nmap <leader>m &
nmap <leader>s :w!<CR>
nmap <leader>c "+y
nmap <leader>so :source ~/.vimrc<CR>
nmap <leader>t :call mkdir(fnamemodify(tempname(),':h'),'p',0700)<CR>
cmap ;\ \(\)<Left><Left>

"""""""""""""""""""""""""""""""""""""""""""""""""""
" Printing Setup
"""""""""""""""""""""""""""""""""""""""""""""""""""
set pdev=2NEAST7845
"set printoptions=paper:A4,duplex:off,collate:n
"We want way less whitespace....
set printoptions=paper:A4,duplex:off,collate:n,left:2pc,right:2pc,top:1pc,bottom:2pc
"lp -o number-up=2 -o sides=single-sided-long-edge -d 1murrayf4500
set pexpr=system('lp'\ .\ (&printdevice\ ==\ ''\ \?\ ''\ :\ '\ -o\ ColorModel=color'\ .\ '\ -o\ number-up=2'\ .\ '\ -o\ sides=single-sided-long-edge'\ .\ '\ -d'\ .\ &printdevice)\ .\ '\ '\ .\ v:fname_in)\ .\ delete(v:fname_in)\ +\ v:shell_error
set pfn=courier:h8

"Use TAB to complete when typing words, else inserts TABs as usual.
"Uses dictionary and source files to find matching words to complete.

"See help completion for source,
"Note: usual completion is on <C-n> but more trouble to press all the time.
"Never type the same word twice and maybe learn a new spellings!
"Use the Linux dictionary when spelling is in doubt.
"Window users can copy the file to their machine.
function! Tab_Or_Complete()
   if col('.')>1 && strpart( getline('.'), col('.')-2, 3 ) =~ '^\w'
      return "\<C-N>"
   else
      return "\<Tab>"
   endif
endfunction
:inoremap <Tab> <C-R>=Tab_Or_Complete()<CR>

