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

augroup ColorschemeSetup
  autocmd!
  if has('patch-8.0.1777')
    autocmd ColorschemePre Atelier*Dark set background=dark
    autocmd ColorschemePre Atelier*Light set background=light
    autocmd ColorschemePre vimspectr*dark set background=dark
    autocmd ColorschemePre vimspectr*light set background=light
    autocmd ColorSchemePre * let g:current_color_dictionary = mgr#GetColorDictionary(expand('<amatch>'))
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
                    \ | if mgr#WhichStatus(expand('<amatch>')) == "airline"
                    \ |   packadd vim-airline
                    \ |   packadd vim-airline-themes
                    \ |   let g:airline_section_x = airline#section#create_right(['%-25{g:current_color_dictionary.status()}', 'bookmark', 'tagbar', 'vista', 'gutentags', 'grepper', 'filetype'])
                    \ |   call mgr#AirlineTheme()
                    \ | endif
                    \ | if mgr#WhichStatus(expand('<amatch>')) == "lightline"
                    \ |   packadd lightline.vim | packadd lightline-buffer
                    \ |   packadd lightline_foobar.vim
                    \ |   call mgr#LightlineUpdate()
                    \ | endif
                    \ | if mgr#WhichStatus(expand('<amatch>')) == "none" && exists('g:loaded_lightline')
                    \ |   call mgr#LightlineUpdate()
                    \ | endif
                    \ | if mgr#WhichStatus(expand('<amatch>')) == "none" && exists('g:loaded_airline')
                    \ |   call mgr#AirlineTheme()
                    \ | endif
augroup END

autocmd! VimEnter * call mgr#SetLastColorscheme()

nmap <silent> <leader>- :<c-u>call mgr#SchemeVariant(-v:count1)<cr>
nmap <silent> <leader>+ :<c-u>call mgr#SchemeVariant(+v:count1)<cr>
nmap <silent> <leader>b :<c-u>call mgr#Toggle()<cr>
nmap <silent> <leader>r :<c-u>call mgr#SetRandomColorscheme()<cr>
