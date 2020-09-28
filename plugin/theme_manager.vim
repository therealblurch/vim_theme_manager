if !exists('g:colorscheme_groups')
  let g:colorscheme_groups = {
"                             \  'vimspectr_light_themes' : [
"                             \                               'vimspectr0-light'  , 'vimspectr30-light' , 'vimspectr60-light' ,
"                             \                               'vimspectr90-light' , 'vimspectr120-light', 'vimspectr150-light',
"                             \                               'vimspectr180-light', 'vimspectr210-light', 'vimspectr240-light',
"                             \                               'vimspectr270-light', 'vimspectr300-light', 'vimspectr330-light',
"                             \                               'vimspectrgrey-light'
"                             \                              ],
"                             \  'atelier_light_themes'   : [
"                             \                               'atelier_cavelight',
"                             \                               'atelier_dunelight',
"                             \                               'atelier_estuarylight',
"                             \                               'atelier_forestlight',
"                             \                               'atelier_heathlight',
"                             \                               'atelier_lakesidelight',
"                             \                               'atelier_plateaulight',
"                             \                               'atelier_savannalight',
"                             \                               'atelier_seasidelight',
"                             \                               'atelier_sulphurpoollight',
"                             \                             ],
"                             \  'vimspectr_dark_themes'  : [
"                             \                               'vimspectr0-dark'  , 'vimspectr30-dark' , 'vimspectr60-dark' ,
"                             \                               'vimspectr90-dark' , 'vimspectr120-dark', 'vimspectr150-dark',
"                             \                               'vimspectr180-dark', 'vimspectr210-dark', 'vimspectr240-dark',
"                             \                               'vimspectr270-dark', 'vimspectr300-dark', 'vimspectr330-dark',
"                             \                               'vimspectrgrey-dark'
"                             \                             ],
"                             \  'atelier_dark_themes'    : [
"                             \                               'atelier_cavedark',
"                             \                               'atelier_dunedark',
"                             \                               'atelier_estuarydark',
"                             \                               'atelier_forestdark',
"                             \                               'atelier_heathdark',
"                             \                               'atelier_lakesidedark',
"                             \                               'atelier_plateaudark',
"                             \                               'atelier_savannadark',
"                             \                               'atelier_seasidedark',
"                             \                               'atelier_sulphurpooldark',
"                             \                             ],
"                             \  'seabird_themes'         : [
"                             \                               'greygull',
"                             \                               'petrel',
"                             \                               'seagull',
"                             \                               'stormpetrel'
"                             \                             ],
                             \ }
endif

"g:colorscheme_map is a list of dictionaries that specify options for colorschemes.  All keys but name and StatusColorscheme are optional.  The dictionary keys are as follows:
" name                : the name of the colorscheme
" comparison          : If this is set to 'fuzzy' don't require an exact name match
" variants            : a list of possible variants
" dark_tag/light_tag  : strings to be used in theme_manager#ToggleColorscheme
" style_variable_name : name of style variable to be used in theme_manager#NextStyleVariant and theme_manager#ToggleColorschemeStyle
" default_style       : default style variant
" pre_commands        : list of commands to run before setting the colorscheme, intended to set configuration variables for the scheme.
" tr_from/tr_to       : strings to be used in theme_manager#ColorschemeTR and theme_manager#ColorschemeTR
" pat/sub             : strings to be used in theme_manager#ColorschemeSub and theme_manager#ColorschemeSub
" suffix              : string to be used in theme_manager#ColorschemeSuffix and theme_manager#ColorschemeSuffix
" pat                 : string to be used in theme_manager#ColorschemeSubBackground and theme_manager#ColorschemeSubBackground
" NextVariant         : funcref to choose next colorscheme variant
" DefaultVariant      : funcref to generate statement to set default colorscheme style
" StatusColorscheme   : funcref to create colorscheme name to be placed in the status bar
" LightlineTheme      : funcref to choose the lightline colorscheme
" AirlineTheme        : funcref to choose the airline theme
" ToggleScheme        : funcref to toggle between light and dark versions of the colorscheme
" Map                 : funcref for map function to be used in theme_manager#NextColorschemeVariantMap
" All keys but name and StatusColorscheme are optional.

if !exists('g:colorscheme_map')
  let g:colorscheme_map = [
"                          \ {
"                          \ {
"                          \   'name'              : 'atlas',
"                          \   'StatusColorscheme' : function('theme_manager#StatusColorscheme'),
"                          \   'LightlineTheme'    : function('theme_manager#Colorscheme'),
"                          \ },
"                          \ {
"                          \   'name'              : 'apprentice',
"                          \   'StatusColorscheme' : function('theme_manager#StatusColorscheme'),
"                          \   'LightlineTheme'    : function('theme_manager#Colorscheme'),
"                          \   'AirlineTheme'      : function('theme_manager#Colorscheme'),
"                          \ },
"                          \ {
"                          \   'name'                : 'ayu',
"                          \   'variants'            : ['light', 'dark', 'mirage'],
"                          \   'style_variable_name' : 'g:ayucolor',
"                          \   'default_style'       : 'light',
"                          \   'NextVariant'         : function('theme_manager#NextStyleVariant'),
"                          \   'DefaultVariant'      : function('theme_manager#DefaultStyleVariant'),
"                          \   'StatusColorscheme'   : function('theme_manager#StatusColorschemeStyle'),
"                          \   'LightlineTheme'      : function('theme_manager#Colorscheme'),
"                          \   'AirlineTheme'        : function('theme_manager#Colorscheme'),
"                          \   'ToggleScheme'        : function('theme_manager#ToggleColorschemeStyle'),
"                          \ },
"                          \ {
"                          \   'name'              : 'cosmic_latte',
"                          \   'NextVariant'       : function('theme_manager#NextBackgroundVariant'),
"                          \   'StatusColorscheme' : function('theme_manager#StatusColorschemeBackground'),
"                          \   'LightlineTheme'    : function('theme_manager#ColorschemeBackground'),
"                          \   'AirlineTheme'      : function('theme_manager#ColorschemeBackground'),
"                          \   'ToggleScheme'      : function('theme_manager#ToggleBackground'),
"                          \ },
"                          \ {
"                          \   'name'              : 'deep-space',
"                          \   'tr_from'           : '-',
"                          \   'tr_to'             : '_',
"                          \   'pat'               : '-',
"                          \   'sub'               : '',
"                          \   'StatusColorscheme' : function('theme_manager#StatusColorscheme'),
"                          \   'LightlineTheme'    : function('theme_manager#ColorschemeSub'),
"                          \   'AirlineTheme'      : function('theme_manager#ColorschemeTR'),
"                          \ },
"                          \ {
"                          \   'name'              : 'desertink',
"                          \   'StatusColorscheme' : function('theme_manager#StatusColorscheme'),
"                          \   'AirlineTheme'      : function('theme_manager#Colorscheme'),
"                          \ },
"                          \ {
"                          \   'name'              : 'deus',
"                          \   'StatusColorscheme' : function('theme_manager#StatusColorscheme'),
"                          \   'AirlineTheme'      : function('theme_manager#Colorscheme'),
"                          \ },
"                          \ {
"                          \   'name'              : 'distinguished',
"                          \   'StatusColorscheme' : function('theme_manager#StatusColorscheme'),
"                          \   'AirlineTheme'      : function('theme_manager#Colorscheme'),
"                          \ },
"                          \ {
"                          \   'name'              : 'dogrun',
"                          \   'StatusColorscheme' : function('theme_manager#StatusColorscheme'),
"                          \   'LightlineTheme'    : function('theme_manager#Colorscheme'),
"                          \ },
"                          \ {
"                          \   'name'              : 'dracula',
"                          \   'StatusColorscheme' : function('theme_manager#StatusColorscheme'),
"                          \   'LightlineTheme'    : function('theme_manager#Colorscheme'),
"                          \   'AirlineTheme'      : function('theme_manager#Colorscheme'),
"                          \ },
"                          \ {
"                          \   'name'                : 'edge',
"                          \   'variants'            : ['default', 'aura', 'neon'],
"                          \   'style_variable_name' : 'g:edge_style',
"                          \   'default_style'       : 'default',
"                          \   'NextVariant'         : function('theme_manager#NextStyleVariant'),
"                          \   'DefaultVariant'      : function('theme_manager#DefaultStyleVariant'),
"                          \   'StatusColorscheme'   : function('theme_manager#StatusColorschemeStyle'),
"                          \   'LightlineTheme'      : function('theme_manager#Colorscheme'),
"                          \   'AirlineTheme'        : function('theme_manager#Colorscheme'),
"                          \   'ToggleScheme'        : function('theme_manager#ToggleBackground'),
"                          \ },
"                          \ {
"                          \   'name'              : 'forest-night',
"                          \   'dark_tag'          : 'dark',
"                          \   'light_tag'         : 'light',
"                          \   'StatusColorscheme' : function('theme_manager#StatusColorscheme'),
"                          \   'LightlineTheme'    : function('theme_manager#Colorscheme'),
"                          \   'AirlineTheme'      : function('theme_manager#Colorscheme'),
"                          \   'ToggleScheme'      : function('theme_manager#ToggleColorscheme'),
"                          \ },
"                          \ {
"                          \   'name'                : 'gruvbox-material',
"                          \   'variants'            : ['soft', 'medium', 'hard'],
"                          \   'style_variable_name' : 'g:gruvbox_material_background',
"                          \   'default_style'       : 'hard',
"                          \   'pre_commands'        : ['let g:gruvbox_material_better_performance = 1'],
"                          \   'tr_from'             : '-',
"                          \   'tr_to'               : '_',
"                          \   'NextVariant'         : function('theme_manager#NextStyleVariant'),
"                          \   'DefaultVariant'      : function('theme_manager#DefaultStyleVariant'),
"                          \   'StatusColorscheme'   : function('theme_manager#StatusColorschemeStyle'),
"                          \   'LightlineTheme'      : function('theme_manager#Colorscheme'),
"                          \   'AirlineTheme'        : function('theme_manager#ColorschemeTR'),
"                          \   'ToggleScheme'        : function('theme_manager#ToggleBackground'),
"                          \ },
"                          \ {
"                          \   'name'              : 'iceberg',
"                          \   'StatusColorscheme' : function('theme_manager#StatusColorscheme'),
"                          \   'LightlineTheme'    : function('theme_manager#Colorscheme'),
"                          \   'AirlineTheme'      : function('theme_manager#Colorscheme'),
"                          \ },
"                          \ {
"                          \   'name'              : 'jellybeans',
"                          \   'StatusColorscheme' : function('theme_manager#StatusColorscheme'),
"                          \   'AirlineTheme'      : function('theme_manager#Colorscheme'),
"                          \ },
"                          \ {
"                          \   'name'              : 'landscape',
"                          \   'StatusColorscheme' : function('theme_manager#StatusColorscheme'),
"                          \   'AirlineTheme'      : function('theme_manager#Colorscheme'),
"                          \ },
"                          \ {
"                          \   'name'                : 'material',
"                          \   'variants'            : ['default', 'palenight', 'ocean', 'lighter', 'darker'],
"                          \   'style_variable_name' : 'g:material_theme_style',
"                          \   'default_style'       : 'palenight',
"                          \   'pre_commands'        : ['let g:material_terminal_italics = 1'],
"                          \   'suffix'              : '_vim',
"                          \   'NextVariant'         : function('theme_manager#NextStyleVariant'),
"                          \   'DefaultVariant'      : function('theme_manager#DefaultStyleVariant'),
"                          \   'StatusColorscheme'   : function('theme_manager#StatusColorschemeStyle'),
"                          \   'LightlineTheme'      : function('theme_manager#ColorschemeSuffix'),
"                          \   'AirlineTheme'        : function('theme_manager#Colorscheme'),
"                          \ },
"                          \ {
"                          \   'name'                : 'materialbox',
"                          \   'variants'            : ['soft', 'medium', 'hard'],
"                          \   'style_variable_name' : 'g:materialbox_contrast',
"                          \   'default_style'       : 'hard',
"                          \   'NextVariant'         : function('theme_manager#NextStyleBackgroundVariant'),
"                          \   'DefaultVariant'      : function('theme_manager#DefaultStyleBackgroundVariant'),
"                          \   'StatusColorscheme'   : function('theme_manager#StatusColorschemeBackgroundStyle'),
"                          \   'AirlineTheme'        : function('theme_manager#Colorscheme'),
"                          \   'ToggleScheme'        : function('theme_manager#ToggleBackground'),
"                          \ },
"                          \ {
"                          \   'name'                : 'night-owl',
"                          \   'pat'               : '-',
"                          \   'sub'               : '',
"                          \   'StatusColorscheme'   : function('theme_manager#StatusColorscheme'),
"                          \   'LightlineTheme'      : function('theme_manager#ColorschemeSub'),
"                          \ },
"                          \ {
"                          \   'name'              : 'nord',
"                          \   'StatusColorscheme' : function('theme_manager#StatusColorscheme'),
"                          \   'LightlineTheme'    : function('theme_manager#Colorscheme'),
"                          \   'AirlineTheme'      : function('theme_manager#Colorscheme'),
"                          \ },
"                          \ {
"                          \   'name'              : 'one',
"                          \   'NextVariant'       : function('theme_manager#NextBackgroundVariant'),
"                          \   'StatusColorscheme' : function('theme_manager#StatusColorschemeBackground'),
"                          \   'LightlineTheme'    : function('theme_manager#Colorscheme'),
"                          \   'AirlineTheme'      : function('theme_manager#Colorscheme'),
"                          \   'ToggleScheme'      : function('theme_manager#ToggleBackground'),
"                          \ },
"                          \ {
"                          \   'name'              : 'palenight',
"                          \   'StatusColorscheme' : function('theme_manager#StatusColorscheme'),
"                          \   'LightlineTheme'    : function('theme_manager#Colorscheme'),
"                          \   'AirlineTheme'      : function('theme_manager#Colorscheme'),
"                          \ },
"                          \ {
"                          \   'name'              : 'PaperColor',
"                          \   'NextVariant'       : function('theme_manager#NextBackgroundVariant'),
"                          \   'StatusColorscheme' : function('theme_manager#StatusColorschemeBackground'),
"                          \   'LightlineTheme'    : function('theme_manager#Colorscheme'),
"                          \   'AirlineTheme'      : function('theme_manager#ColorschemeLower'),
"                          \   'ToggleScheme'      : function('theme_manager#ToggleBackground'),
"                          \ },
"                          \ {
"                          \   'name'              : 'pencil',
"                          \   'NextVariant'       : function('theme_manager#NextBackgroundVariant'),
"                          \   'StatusColorscheme' : function('theme_manager#StatusColorschemeBackground'),
"                          \   'LightlineTheme'    : function('theme_manager#Colorscheme'),
"                          \   'AirlineTheme'      : function('theme_manager#Colorscheme'),
"                          \   'ToggleScheme'      : function('theme_manager#ToggleBackground'),
"                          \ },
"                          \ {
"                          \   'name'              : 'pop-punk',
"                          \   'tr_from'           : '-',
"                          \   'tr_to'             : '_',
"                          \   'StatusColorscheme' : function('theme_manager#StatusColorscheme'),
"                          \   'AirlineTheme'      : function('theme_manager#ColorschemeTR'),
"                          \ },
"                          \ {
"                          \   'name'              : 'seagull',
"                          \   'variants'          : ['seagull', 'greygull', 'petrel', 'stormpetrel'],
"                          \   'NextVariant'       : function('theme_manager#NextColorschemeVariant'),
"                          \   'StatusColorscheme' : function('theme_manager#StatusColorscheme'),
"                          \   'AirlineTheme'      : function('theme_manager#Colorscheme'),
"                          \ },
"                          \ {
"                          \   'name'                : 'sonokai',
"                          \   'variants'            : ['default', 'atlantis', 'andromeda', 'maia'],
"                          \   'style_variable_name' : 'g:sonokai_style',
"                          \   'default_style'       : 'default',
"                          \   'pre_commands'        : ['let g:sonokai_better_performance = 1'],
"                          \   'NextVariant'         : function('theme_manager#NextStyleVariant'),
"                          \   'DefaultVariant'      : function('theme_manager#DefaultStyleVariant'),
"                          \   'StatusColorscheme'   : function('theme_manager#StatusColorschemeStyle'),
"                          \   'LightlineTheme'      : function('theme_manager#Colorscheme'),
"                          \   'AirlineTheme'        : function('theme_manager#Colorscheme'),
"                          \ },
"                          \ {
"                          \   'name'              : 'snow',
"                          \   'NextVariant'       : function('theme_manager#NextBackgroundVariant'),
"                          \   'StatusColorscheme' : function('theme_manager#StatusColorschemeBackground'),
"                          \   'LightlineTheme'    : function('theme_manager#ColorschemeBackground'),
"                          \   'AirlineTheme'      : function('theme_manager#ColorschemeBackground'),
"                          \   'ToggleScheme'      : function('theme_manager#ToggleBackground'),
"                          \ },
"                          \ {
"                          \   'name'              : 'space_vim_theme',
"                          \   'pat'               : 'theme',
"                          \   'NextVariant'       : function('theme_manager#NextBackgroundVariant'),
"                          \   'StatusColorscheme' : function('theme_manager#StatusColorschemeBackground'),
"                          \   'ToggleScheme'      : function('theme_manager#ToggleBackground'),
"                          \   'LightlineTheme'    : function('theme_manager#ColorschemeSubBackground')
"                          \ },
"                          \ {
"                          \   'name'              : 'srcery',
"                          \   'StatusColorscheme' : function('theme_manager#StatusColorscheme'),
"                          \   'LightlineTheme'    : function('theme_manager#Colorscheme'),
"                          \   'AirlineTheme'      : function('theme_manager#Colorscheme'),
"                          \ },
"                          \ {
"                          \   'name'              : 'stellarized',
"                          \   'NextVariant'       : function('theme_manager#NextBackgroundVariant'),
"                          \   'StatusColorscheme' : function('theme_manager#StatusColorschemeBackground'),
"                          \   'LightlineTheme'    : function('theme_manager#ColorschemeBackground'),
"                          \   'AirlineTheme'      : function('theme_manager#ColorschemeBackground'),
"                          \   'ToggleScheme'      : function('theme_manager#ToggleBackground'),
"                          \ },
"                          \ {
"                          \   'name'              : 'tokyo-metro',
"                          \   'pat'               : '-',
"                          \   'sub'               : '',
"                          \   'StatusColorscheme' : function('theme_manager#StatusColorscheme'),
"                          \   'LightlineTheme'    : function('theme_manager#ColorschemeSub'),
"                          \   'AirlineTheme'      : function('theme_manager#ColorschemeSub'),
"                          \ },
"                          \ {
"                          \   'name'              : 'twilight',
"                          \   'StatusColorscheme' : function('theme_manager#StatusColorscheme'),
"                          \ },
"                          \ {
"                          \   'name'              : 'vadelma',
"                          \   'NextVariant'       : function('theme_manager#NextBackgroundVariant'),
"                          \   'StatusColorscheme' : function('theme_manager#StatusColorschemeBackground'),
"                          \   'LightlineTheme'    : function('theme_manager#Colorscheme'),
"                          \   'ToggleScheme'      : function('theme_manager#ToggleBackground'),
"                          \ },
"                          \ {
"                          \   'name'              : 'vividchalk',
"                          \   'StatusColorscheme' : function('theme_manager#StatusColorscheme'),
"                          \ },
"                          \ {
"                          \   'name'              : 'xcode',
"                          \   'comparison'        : 'fuzzy',
"                          \   'variants'          : ['xcodedark', 'xcodelight', 'xcodewwdc', 'xcodedarkhc', 'xcodelighthc'],
"                          \   'dark_tag'          : 'dark',
"                          \   'light_tag'         : 'light',
"                          \   'NextVariant'       : function('theme_manager#NextColorschemeVariant'),
"                          \   'StatusColorscheme' : function('theme_manager#StatusColorscheme'),
"                          \   'ToggleScheme'      : function('theme_manager#ToggleColorscheme'),
"                          \   'AirlineTheme'      : function('theme_manager#Colorscheme'),
"                          \ },
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
