set number
set mouse=a
set numberwidth=1
set clipboard=unnamed
syntax enable
set showcmd
set ruler
set encoding=utf-8
set showmatch
set sw=4
set relativenumber
set laststatus=2
set noshowmode

call plug#begin('~/.vim/plugged')

"========TEMAS==========
Plug 'morhetz/gruvbox'
Plug 'embark-theme/vim', { 'as': 'embark', 'branch': 'main' }
"Transparencia
Plug 'tribela/vim-transparent'

"Plug 'dracula/vim'
"=========IDE===========
Plug 'easymotion/vim-easymotion'

Plug 'scrooloose/nerdtree'
"navigator funciona con Ctrl + L   o Ctrl + H en modo normal
Plug 'christoomey/vim-tmux-navigator'

"coc
Plug 'neoclide/coc.nvim', {'branch': 'release'}

"emmet
Plug 'mattn/emmet-vim'

"git extensions
Plug 'tpope/vim-fugitive'
"bracket helper
Plug 'tpope/vim-surround'
"Wiki
Plug 'vimwiki/vimwiki'

"comment like a pro
Plug 'scrooloose/nerdcommenter'

"=========AIRLINE===========
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'


"tagbar, clasify clases, functions, etc."
Plug 'majutsushi/tagbar'

"better visual block (like vscode)
Plug 'mg979/vim-visual-multi', {'branch': 'master'}

"color hexadecimal
Plug 'gko/vim-coloresque'
Plug 'https://github.com/etdev/vim-hexcolor.git'

" Latex
Plug 'lervag/vimtex'
Plug 'matze/vim-tex-fold'

" Icons
Plug 'ryanoasis/vim-devicons'

" Marca los errores
Plug 'dense-analysis/ale'

Plug 'nvim-treesitter/nvim-treesitter'

" C#
Plug 'OmniSharp/omnisharp-vim'

" For debugging
Plug 'puremourning/vimspector'

" Iconos con color
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'

" Nerdtree git
Plug 'Xuyuanp/nerdtree-git-plugin'

" Lineas de indentacion
Plug 'lukas-reineke/indent-blankline.nvim'

" Menu principal
Plug 'mhinz/vim-startify'

" Terminal
Plug 'voldikss/vim-floaterm'

" Buscador
Plug 'junegunn/fzf'

call plug#end()

"colorscheme gruvbox
colorscheme embark

"theme airline
let g:airline_theme = 'zenburn'
"let g:gruvbox_contrast_dark = "hard"


let mapleader=" "


"activar Python highlight
let python_highlight_all=1
let g:coc_disable_startup_warning = 1




"autocmd Filetype python let b:coc_suggest_disable = 1
"autocmd Filetype javascript let b:coc_suggest_disable = 1
"autocmd Filetype scss set1 iskeyword+=@-@ 




"[[[[[[[[   ATAJOS PROPIOS   ]]]]]]]]

" Cambio de  pestañas
" Ir a la siguiente pestaña
nmap <Leader>t gt
nmap <Leader><S-t> gT


" Atajo easy motion
nmap <Leader>b <Plug>(easymotion-s2)

" agregar lineas en blanco con enter
map <Enter> o<ESC>
map <S-Enter> O<ESC>

nmap <Leader>w :w<CR>
nmap <Leader>q :q<CR>
nmap <Leader>wq :wq<CR>
nmap <Leader>wQ :wqa<CR>

"Agregara los parentesis de cierre en automatico
inoremap { {}<Esc>i
inoremap ( ()<Esc>i
inoremap [ []<Esc>i
inoremap < <><Esc>i
inoremap ' ''<Esc>i
inoremap " ""<Esc>i

"Para desplazarce en el modo insert con HJKL tecla 'alt' + HJKoL
"A == alt
inoremap <A-h> <C-o>h
inoremap <A-j> <C-o>j
inoremap <A-k> <C-o>k
inoremap <A-l> <C-o>l

"Atajos coc

"nmap <silent> gd <Plug>(coc-definition)
"nmap <silent> gy <Plug>(coc-type-definition)
"nmap <silent> gi <Plug>(coc-implementation)
"nmap <silent> gr <Plug>(coc-references)


" [[[[[[[[[[  CONFIGURACION COC  ]]]]]]]]]]

" Some servers have issues with backup files, see #649.
set nobackup
set nowritebackup

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
set signcolumn=yes

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1):
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

" Make <CR> to accept selected completion item or notify coc.nvim to format
" <C-g>u breaks current undo, please make your own choice.
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call ShowDocumentation()<CR>

function! ShowDocumentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call feedkeys('K', 'in')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current buffer.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Run the Code Lens action on the current line.
nmap <leader>cL  <Plug>(coc-codelens-action)

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Remap <C-f> and <C-b> for scroll float windows/popups.
if has('nvim-0.4.0') || has('patch-8.2.0750')
  nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-b>"
  inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
  inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
  vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
endif

" Use CTRL-S for selections ranges.
" Requires 'textDocument/selectionRange' support of language server.
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocActionAsync('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocActionAsync('runCommand', 'editor.action.organizeImport')

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Mappings for CoCList
" Show all diagnostics.
nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions.
nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
" Show commands.
nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list.
nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>




"[[[[[[[[[[[[  Syntastic config  ]]]]]]]]]]]]
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0



"[[[[[[[[[[[[  Tagbar config   ]]]]]]]]]]]]
nmap <F8> :TagbarToggle<CR>


"
"[[[[[[[[[[[[  LATEX   ]]]]]]]]]]]]

" This is necessary for VimTeX to load properly. The "indent" is optional.
" Note that most plugin managers will do this automatically.
filetype plugin indent on

" This enables Vim's and neovim's syntax-related features. Without this, some
" VimTeX features will not work (see ":help vimtex-requirements" for more
" info).
syntax enable

" Viewer options: One may configure the viewer either by specifying a built-in
" viewer method:
let g:vimtex_view_method = 'zathura'

" Or with a generic interface:
let g:vimtex_view_general_viewer = 'okular'
let g:vimtex_view_general_options = '--unique file:@pdf\#src:@line@tex'

" VimTeX uses latexmk as the default compiler backend. If you use it, which is
" strongly recommended, you probably don't need to configure anything. If you
" want another compiler backend, you can change it as follows. The list of
" supported backends and further explanation is provided in the documentation,
" see ":help vimtex-compiler".
let g:vimtex_compiler_method = 'latexmk'

" Most VimTeX mappings rely on localleader and this can be changed with the
" following line. The default is usually fine and is the symbol "\".
let maplocalleader = ","

" use net6 for OmniSharpm (C#) language server
let g:OmniSharp_server_use_net6 = 1



"[[[[[[[[   COC SNIPPETS  ]]]]]]]]
" permite saltar al siguiente cursor
inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#_select_confirm() :
      \ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
      \ CheckBackSpace() ? "\<TAB>" :
      \ coc#refresh()

function! CheckBackSpace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

let g:coc_snippet_next = '<tab>'



"[[[[[[[[  VIMSPECTOR (DEBUG)  ]]]]]]]]
nmap <F2> :CocCommand java.debug.vimspector.start<CR>

nnoremap <leader>da :call vimspector#Launch()<CR>

"(regresa la variable)
nnoremap <leader>du :call vimspector#DeleteWatch()<CR>
"left (arrasta la variable para ver cambios)
nnoremap <leader>dh :call vimspector#AddWatch( expand( '<cexpr>' ) )<CR>
"right
nnoremap <leader>dl :call vimspector#StepOver()<CR>
"up
nnoremap <leader>dk :call vimspector#StepOut()<CR>
"down
nnoremap <leader>dj :call vimspector#StepInto()<CR>

"nnoremap <leader>di :call AddToWatch()<CR>
nnoremap <leader>db :call vimspector#ToggleBreakpoint()<CR>
nnoremap <leader>di :call vimspector#ListBreakpoints()<CR>
nnoremap <leader>dn :call vimspector#Continue()<CR>
nnoremap <leader>dx :call vimspector#Reset()<CR>
nnoremap <leader>dX :call vimspector#ClearBreakpoints()<CR>
nnoremap <leader>dr :call vimspector#Restart()<CR>
nnoremap <leader>dp :call vimspector#Pause()<CR>

"conditional breakpoint
nnoremap <leader>dc :call vimspector#ToggleBreakpoint( { trigger expr, hit count expr } )<CR>
"function breakpoint
nnoremap <leader>df :call vimspector#AddFunctionBreakpoint( '<cexpr>' )<CR>


"[[[[[[[[  TRANSPARENCIA  ]]]]]]]]

"" default
"let g:transparent_groups = ['Normal', 'Comment', 'Constant', 'Special', 'Identifier',
                            "\ 'Statement', 'PreProc', 'Type', 'Underlined', 'Todo', 'String',
                            "\ 'Function', 'Conditional', 'Repeat', 'Operator', 'Structure',
                            "\  'NonText', 'SignColumn', 'CursorLineNr', 'EndOfBuffer']
"
"" Pmenu
"let g:transparent_groups += ['Pmenu']
"
"" coc.nvim
"let g:transparent_groups += ['NormalFloat', 'CocFloating']
"
"augroup transparent
    "autocmd VimEnter,ColorScheme * call MyTransparent()
"augroup END
"
"function! MyTransparent()
    "" Customize the highlight groups for transparency in here.
"
    "" CursorLine
    ""hi CursorLine ctermfg=NONE ctermbg=239 guibg=NONE guibg=#4e4e4e
"
    "" coc.nvim
    ""hi CocMenuSel ctermbg=239 guibg=#4e4e4e
"endfunction
"

"[[[[[[[[  AIRLINE  ]]]]]]]]

" unicode symbols
let g:airline_left_sep = ''
"let g:airline_left_sep = '▓▒░'
let g:airline_right_sep = ''

" Activa airline para tabs
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#left_sep = ''
let g:airline#extensions#tabline#left_alt_sep = ''

" Comment out the `colorscheme`.
let g:lightline = {
      "\ 'colorscheme': 'deus',
      \ }



"[[[[[[[[  COMENTARIOS  ]]]]]]]]

" Allow commenting and inverting empty lines (useful when commenting a region)
let g:NERDCommentEmptyLines = 1




"[[[[[[[[  EMMET  ]]]]]]]]
"Lo activa solo en html y css
let g:user_emmet_install_global = 0
autocmd FileType html,css EmmetInstall

"Redefine aplicar el snippet
"let g:user_emmet_leader_key='<C-M>'


"[[[[[[[[  NERD TREE  ]]]]]]]]
nmap <Leader>nt :NERDTreeFind<CR>

"setea tamano de ventana de nerdtree
let g:NERDTreeWinSize=22
let NERDTreeQuitOnOpen=1

if &filetype ==# 'java' || &filetype ==# 'cpp' || &filetype ==# 'c'|| &filetype ==# 'cs' || &filetype ==# 'python' || &filetype ==# 'html' || &filetype ==# 'css'    
    " Start NERDTree and put the cursor back in the other window.
    autocmd VimEnter * NERDTree | wincmd p
endif
"
" Close the tab if NERDTree is the only window remaining in it.
autocmd BufEnter * if winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif

" Mirror the NERDTree before showing it. This makes it the same on all tabs.
"nnoremap <F2> :NERDTreeMirror<CR>:NERDTreeFocus<CR>

"[[[[[[[[  NERD TREE GIT  ]]]]]]]]
let g:NERDTreeGitStatusIndicatorMapCustom = {
                \ 'Modified'  :'M',
                \ 'Staged'    :'✚',
                \ 'Untracked' :'',
                \ 'Renamed'   :'R',
                \ 'Unmerged'  :'═',
                \ 'Deleted'   :'✖',
                \ 'Dirty'     :'✗',
                \ 'Ignored'   :'☒',
                \ 'Clean'     :'✔︎',
                \ 'Unknown'   :'?',
                \ }


"[[[[[[[[  FLOAT TERM  ]]]]]]]]

" Aparcer y desaparecer terminal
let g:floaterm_keymap_toggle = '<leader>k'
