"================================================================================
" Exit if script has abready been sourced.
"================================================================================
if exists('g:loaded_mgr')
  finish
endif
let g:loaded_mgr = 1

"================================================================================
" Set default values for global configuration variables.
"================================================================================

" g:prefer_airline
"   1 - load airline if both airline and lightline themes exist
"   0 - load lightline if both airline and lightline themes exist
if !exists ('g:prefer_airline')
  let g:prefer_airline = 1
endif

" g:default_airline_theme
"   Name of default airline theme if an airline theme doesn't exist
if !exists('g:default_airline_theme')
  let g:default_airline_theme = 'distinguished'
endif

" g:default_lightline_colorscheme
"   Name of default lightline colorscheme if lightline colorscheme doesn't
"   exist
if !exists('g:default_lightline_colorscheme')
  let g:default_lightline_colorscheme = 'powerline'
endif

" g:colorschem_file
"   Name of file used to store last colorscheme used
if !exists('g:colorscheme_file')
  let g:colorscheme_file = '~/.vim/.colorscheme'
endif

" g:mgr_slash
"   Character that separates colorscheme name and style in status bar
if !exists('g:mgr_slash')
  let g:mgr_slash = '/'
endif

" g:mgr_randomize
"   Load a random theme on startup
if !exists('g:mgr_randomize')
  let g:mgr_randomize = 0
endif

" g:mgr_randomize_group
"   If the last colorscheme was a member of a group, load a random colorscheme
"   from the same group
if !exists('g:mgr_randomize_group')
  let g:mgr_randomize_group = 0
endif

"================================================================================
" Define default mappings.
"================================================================================

if !hasmapto('<Plug>PreviousVariant')
  map <unique> <leader>- <Plug>PreviousVariant
endif

if !hasmapto('<Plug>NextVariant')
  map <unique> <leader>+ <Plug>NextVariant
endif

if !hasmapto('<Plug>ToggleBackground')
  map <unique> <leader>b <Plug>ToggleBackground
endif

if !hasmapto('<Plug>RandomScheme')
  map <unique> <leader>r <Plug>RandomScheme
endif

if !hasmapto('<Plug>RandomGroupScheme')
  map <unique> <leader>p <Plug>RandomGroupScheme
endif

noremap <unique> <script> <Plug>PreviousVariant <SID>PreviousVariant
noremap <unique> <script> <Plug>NextVariant <SID>NextVariant
noremap <unique> <script> <Plug>ToggleBackground <SID>ToggleBackground
noremap <unique> <script> <Plug>RandomScheme <SID>RandomScheme
noremap <unique> <script> <Plug>RandomGroupScheme <SID>RandomGroupScheme

noremap <silent> <SID>PreviousVariant :call <SID>PreviousVariant(-v:count1)<cr>
noremap <silent> <SID>NextVariant :call <SID>NextVariant(-v:count1)<cr>
noremap <silent> <SID>ToggleBackground :call <SID>ToggleBackground()<cr>
noremap <silent> <SID>RandomScheme :call <SID>RandomScheme()<cr>
noremap <silent> <SID>RandomGroupScheme :call<SID>RandomGroupScheme(g:colors_name)<cr>

"================================================================================
" Translate mapped functions to autoloaded functions.
"================================================================================

function s:PreviousVariant(count)
  call mgr#scheme_var(a:count)
endfunction

function s:NextVariant(count)
  call mgr#scheme_var(a:count)
endfunction

function s:ToggleBackground()
  call mgr#tggl()
endfunction

function s:RandomScheme()
  call mgr#set_rand_cscheme()
endfunction

function s:RandomGroupScheme(last_cscheme)
  call mgr#set_rand_grp_cscheme()
endfunction

"================================================================================
" Define actions to take before a colorscheme is set.
"   1.  Extract the dictionary for the new colorscheme from the colorscheme
"   map
"   2.  Set default colorscheme variant if needed
"   3.  Set defaut background if specified
"   4.  Execute pre commands if they exist
"================================================================================

function s:colorscheme_pre (new_colorscheme)
  let g:current_color_dictionary = mgr#get_color_dict(a:new_colorscheme)
  if !exists('g:colors_name') || g:colors_name != a:new_colorscheme
    if has_key (g:current_color_dictionary, 'default_variant')
      call g:current_color_dictionary.default_variant()
    endif
    if has_key (g:current_color_dictionary, 'default_bg')
       exec 'set background=' . g:current_color_dictionary.default_bg
     endif
  endif
  if has_key (g:current_color_dictionary, 'pre')
    for command in g:current_color_dictionary.pre
      exec command
    endfor
  endif
endfunction

augroup ColorschemeSetup
  autocmd!
  if has('patch-8.0.1777')
    autocmd ColorSchemePre * call s:colorscheme_pre (expand('<amatch>'))
  else
    autocmd User ColorSchemePre * call s:colorscheme_pre (expand('<amatch>'))
  endif
augroup END

"================================================================================
" Define actions to take after a colorscheme is set.
"   1.  Write colorscheme file with new colorscheme information.
"   2.  If no status bar plugin has been loaded load a statusbar plugin.
"   3.  If a status bar plugin has been loaded update the theme for the
"   statusbar.
"================================================================================

function s:colorscheme_post (new_colorscheme)
  call writefile([&background, a:new_colorscheme], expand(g:colorscheme_file))
  let g:which_status = mgr#which_status(a:new_colorscheme)
  if g:which_status == "airline"
    packadd vim-airline
    packadd vim-airline-themes
    let g:airline_section_x = airline#section#create_right(['%-25{g:current_color_dictionary.status()}', 'bookmark', 'tagbar', 'vista', 'gutentags', 'grepper', 'filetype'])
    call mgr#airline_theme()
  endif
  if g:which_status == "lightline"
    packadd lightline.vim | packadd lightline-buffer
    packadd lightline_foobar.vim
    call mgr#lightline_updt()
  endif
  if g:which_status == "none" && exists('g:loaded_lightline')
    call mgr#lightline_updt()
  endif
  if g:which_status == "none" && exists('g:loaded_airline')
    call mgr#airline_theme()
  endif
endfunction

augroup StatusBarTheme
  autocmd!
  autocmd Colorscheme * call s:colorscheme_post(expand('<amatch>'))
augroup END

"================================================================================
" Call InitializeMgr autocmd to create colorscheme groups and initialize
" colorscheme map.
"================================================================================

autocmd! VimEnter * doautocmd User InitializeMgr

"================================================================================
" When the MgrInitialized autocmd is called, set the colorscheme.
"================================================================================

autocmd! User MgrInitialized call mgr#set_cscheme()
