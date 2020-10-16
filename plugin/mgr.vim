if exists('g:loaded_mgr')
  finish
endif
let g:loaded_mgr = 1

if !exists('g:colorscheme_groups')
  let g:colorscheme_groups = {
                             \ }
endif

if !exists('g:colorscheme_map')
  let g:colorscheme_map = [
                          \ ]
endif

if !exists ('g:prefer_airline')
  let g:prefer_airline = 1
endif

if !exists('g:default_airline_theme')
  let g:default_airline_theme = 'distinguished'
endif

if !exists('g:default_lightline_colorscheme')
  let g:default_lightline_colorscheme = 'powerline'
endif

if !exists('g:colorscheme_file')
  let g:colorscheme_file = '~/.vim/.colorscheme'
endif

if !exists('g:mgr_slash')
  let g:mgr_slash = '/'
endif

if !exists('g:mgr_underscore')
  let g:mgr_underscore = '_'
endif

if !exists('g:mgr_randomize')
  let g:mgr_randomize = 0
endif

if !exists('g:mgr_randomize_group')
  let g:mgr_randomize_group = 0
endif

if !hasmapto('<Plug>PrevVar')
  map <unique> <leader>- <Plug>PrevVar
endif

if !hasmapto('<Plug>NextVar')
  map <unique> <leader>+ <Plug>NextVar
endif

if !hasmapto('<Plug>Toggle')
  map <unique> <leader>b <Plug>Toggle
endif

if !hasmapto('<Plug>RandomScheme')
  map <unique> <leader>r <Plug>RandomScheme
endif

if !hasmapto('<Plug>RandomGroupScheme')
  map <unique> <leader>p <Plug>RandomGroupScheme
endif

noremap <unique> <script> <Plug>PrevVar <SID>Previous
noremap <unique> <script> <Plug>NextVar <SID>Next
noremap <unique> <script> <Plug>Toggle <SID>Toggle
noremap <unique> <script> <Plug>RandomScheme <SID>Random
noremap <unique> <script> <Plug>RandomGroupScheme <SID>RandomGroup

noremap <silent> <SID>Previous :call <SID>Previous(-v:count1)<cr>
noremap <silent> <SID>Next :call <SID>Next(-v:count1)<cr>
noremap <silent> <SID>Toggle :call <SID>Toggle()<cr>
noremap <silent> <SID>Random :call <SID>Random()<cr>
noremap <silent> <SID>RandomGroup :call<SID>RandomGroup(g:colors_name)<cr>

function s:Previous(count)
  call mgr#scheme_var(a:count)
endfunction

function s:Next(count)
  call mgr#scheme_var(a:count)
endfunction

function s:Toggle()
  call mgr#tggl()
endfunction

function s:Random()
  call mgr#set_rand_cscheme()
endfunction

function s:RandomGroup(last_cscheme)
  call mgr#set_rand_grp_cscheme(a:last_cscheme)
endfunction

augroup ColorschemeSetup
  autocmd!
  if has('patch-8.0.1777')
    autocmd ColorschemePre Atelier*Dark set background=dark
    autocmd ColorschemePre Atelier*Light set background=light
    autocmd ColorschemePre vimspectr*dark set background=dark
    autocmd ColorschemePre vimspectr*light set background=light
    autocmd ColorSchemePre * let g:current_color_dictionary = mgr#get_color_dict(expand('<amatch>'))
                         \ | if has_key (g:current_color_dictionary, 'default_variant')
                         \ |   if !exists('g:colors_name') || g:colors_name != expand('<amatch>')
                         \ |     call g:current_color_dictionary.default_variant()
                         \ |   endif
                         \ | endif
                         \ | if has_key (g:current_color_dictionary, 'pre')
                         \ |   for command in g:current_color_dictionary.pre
                         \ |     exec command
                         \ |   endfor
                         \ | endif
  endif
augroup END

augroup StatusBarTheme
  autocmd!
  autocmd Colorscheme * call writefile([&background, expand('<amatch>')], expand(g:colorscheme_file))
                    \ | if mgr#which_status(expand('<amatch>')) == "airline"
                    \ |   packadd vim-airline
                    \ |   packadd vim-airline-themes
                    \ |   let g:airline_section_x = airline#section#create_right(['%-25{g:current_color_dictionary.status()}', 'bookmark', 'tagbar', 'vista', 'gutentags', 'grepper', 'filetype'])
                    \ |   call mgr#airline_theme()
                    \ | endif
                    \ | if mgr#which_status(expand('<amatch>')) == "lightline"
                    \ |   packadd lightline.vim | packadd lightline-buffer
                    \ |   packadd lightline_foobar.vim
                    \ |   call mgr#lightline_updt()
                    \ | endif
                    \ | if mgr#which_status(expand('<amatch>')) == "none" && exists('g:loaded_lightline')
                    \ |   call mgr#lightline_updt()
                    \ | endif
                    \ | if mgr#which_status(expand('<amatch>')) == "none" && exists('g:loaded_airline')
                    \ |   call mgr#airline_theme()
                    \ | endif
augroup END

autocmd! VimEnter * call mgr#set_last_cscheme()

