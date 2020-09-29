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

if !exists('g:theme_manager_slash')
  let g:theme_manager_slash = '/'
endif

if !exists('g:theme_manager_underscore')
  let g:theme_manager_underscore = '_'
endif

if !exists('g:theme_manager_randomize')
  let g:theme_manager_randomize = 0
endif

augroup ColorschemeSetup
  autocmd!
  if has('patch-8.0.1777')
    autocmd ColorschemePre Atelier*Dark set background=dark
    autocmd ColorschemePre Atelier*Light set background=light
    autocmd ColorschemePre vimspectr*dark set background=dark
    autocmd ColorschemePre vimspectr*light set background=light
    autocmd ColorSchemePre * let g:current_color_dictionary = theme_manager#GetColorDictionary(expand('<amatch>'))
                         \ | if has_key (g:current_color_dictionary, 'DefaultVariant')
                         \ |   if !exists('g:colors_name') || g:colors_name != expand('<amatch>')
                         \ |     call g:current_color_dictionary.DefaultVariant()
                         \ |   endif
                         \ | endif
                         \ | if has_key (g:current_color_dictionary, 'pre_commands')
                         \ |   for command in g:current_color_dictionary.pre_commands
                         \ |     exec command
                         \ |   endfor
                         \ | endif
  endif
augroup END

augroup StatusBarTheme
  autocmd!
  autocmd Colorscheme * call writefile([&background, expand('<amatch>')], expand(g:colorscheme_file))
                    \ | if theme_manager#WhichStatus(expand('<amatch>')) == "airline"
                    \ |   packadd vim-airline
                    \ |   packadd vim-airline-themes
                    \ |   let g:airline_section_x = airline#section#create_right(['%-25{g:current_color_dictionary.StatusColorscheme()}', 'bookmark', 'tagbar', 'vista', 'gutentags', 'grepper', 'filetype'])
                    \ |   call theme_manager#AirlineTheme()
                    \ | endif
                    \ | if theme_manager#WhichStatus(expand('<amatch>')) == "lightline"
                    \ |   packadd lightline.vim | packadd lightline-buffer
                    \ |   packadd lightline_foobar.vim
                    \ |   call theme_manager#LightlineUpdate()
                    \ | endif
                    \ | if theme_manager#WhichStatus(expand('<amatch>')) == "none" && exists('g:loaded_lightline')
                    \ |   call theme_manager#LightlineUpdate()
                    \ | endif
                    \ | if theme_manager#WhichStatus(expand('<amatch>')) == "none" && exists('g:loaded_airline')
                    \ |   call theme_manager#AirlineTheme()
                    \ | endif
augroup END

autocmd! VimEnter * call theme_manager#SetLastColorscheme()

nmap <silent> <leader>- :<c-u>call theme_manager#SchemeVariant(-v:count1)<cr>
nmap <silent> <leader>+ :<c-u>call theme_manager#SchemeVariant(+v:count1)<cr>
nmap <silent> <leader>b :<c-u>call theme_manager#ToggleScheme()<cr>
