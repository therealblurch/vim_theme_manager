function! theme_manager#NextColorschemeVariant(delta) dict
  let l:current_variant = g:colors_name
  let l:num_variants = len(self.variants)
  let l:next_variant = self.variants[((a:delta+index(self.variants, l:current_variant)) % l:num_variants + l:num_variants) % l:num_variants]
  exec 'colors ' . l:next_variant
endfunction

function! theme_manager#NextColorschemeVariantMap(delta) dict
  let l:variant_list = copy(self.variants)
  call map(l:variant_list, function(self.Map))
  let l:current_variant = g:colors_name
  let l:num_variants = len(l:variant_list)
  let l:next_variant = l:variant_list[((a:delta+index(l:variant_list, l:current_variant)) % l:num_variants + l:num_variants) % l:num_variants]
  exec 'colors ' . l:next_variant
endfunction

function! theme_manager#NextStyleVariant(delta) dict
  let l:num_variants = len(self.variants)
  exec 'let ' . self.style_variable_name . ' = self.variants[((a:delta+index(self.variants, ' . self.style_variable_name . ')) % l:num_variants + l:num_variants) % l:num_variants]'
  exec 'colors ' . self.name
endfunction

function! theme_manager#NextStyleBackgroundVariant(delta) dict
  let l:num_variants = len(self.variants)
  exec 'let ' . self.style_variable_name . '_' . &background . ' = self.variants[((a:delta+index(self.variants, ' . self.style_variable_name . '_' . &background . ')) % l:num_variants + l:num_variants) % l:num_variants]'
  exec 'colors ' . self.name
endfunction

function! theme_manager#DefaultStyleVariant() dict
  exec 'let ' . self.style_variable_name . ' = "' . self.default_style . '"'
endfunction

function! theme_manager#DefaultStyleBackgroundVariant() dict
  exec 'let ' . self.style_variable_name . '_' . &background . ' = "' . self.default_style . '"'
endfunction

function! theme_manager#NextBackgroundVariant(delta) dict
  let &background = (&background == 'dark') ? 'light' : 'dark'
endfunction

function! theme_manager#ToggleBackground() dict
  let &background = (&background == 'dark') ? 'light' : 'dark'
endfunction

function! theme_manager#ToggleColorscheme() dict
  let l:new_colorscheme = (g:colors_name =~# self.dark_tag) ? substitute(g:colors_name, self.dark_tag, self.light_tag, '') : substitute(g:colors_name, self.light_tag, self.dark_tag, '')
  exec 'colors ' . l:new_colorscheme
endfunction

function! theme_manager#ToggleColorschemeStyle() dict
  exec 'let l:current_style = ' . self.style_variable_name
  let l:current_style = (l:current_style == 'dark') ? 'light' : 'dark'
  exec 'let ' . self.style_variable_name . " = '" . l:current_style . "'"
  exec 'colors ' . self.name
endfunction

function! theme_manager#StatusColorscheme() dict
  return g:colors_name
endfunction

function! theme_manager#StatusColorschemeStyle() dict
  exec 'let l:current_style = ' . self.style_variable_name
  return g:colors_name . '/' . l:current_style
endfunction

function! theme_manager#StatusColorschemeBackgroundStyle() dict
  exec 'let l:current_style = ' . self.style_variable_name . '_' . &background
  return g:colors_name . '/' . l:current_style
endfunction

function! theme_manager#StatusColorschemeBackground() dict
  return g:colors_name . '/' . &background
endfunction

function! theme_manager#AirlineThemeColorscheme() dict
  return g:colors_name
endfunction

function! theme_manager#AirlineThemeColorschemeTR() dict
  return tr(g:colors_name, self.tr_from, self.tr_to)
endfunction

function! theme_manager#AirlineThemeColorschemeSub() dict
  return substitute(g:colors_name, self.pat, self.sub, 'g')
endfunction

function! theme_manager#AirlineThemeColorschemeSubBackground() dict
  return substitute(g:colors_name, self.pat, &background, 'g')
endfunction

function! theme_manager#AirlineThemeColorschemeLower() dict
  return tolower(g:colors_name)
endfunction

function! theme_manager#AirlineThemeColorschemeSuffix() dict
  return g:colors_name . self.suffix
endfunction

function! theme_manager#AirlineThemeColorschemeBackground() dict
  return g:colors_name . '_' . &background
endfunction

function! theme_manager#LightlineThemeColorscheme() dict
  return g:colors_name
endfunction

function! theme_manager#LightlineThemeColorschemeTR() dict
  return tr(g:colors_name, self.tr_from, self.tr_to)
endfunction

function! theme_manager#LightlineThemeColorschemeSub() dict
  return substitute(g:colors_name, self.pat, self.sub, 'g')
endfunction

function! theme_manager#LightlineThemeColorschemeSubBackground() dict
  return substitute(g:colors_name, self.pat, &background, 'g')
endfunction

function! theme_manager#LightlineThemeColorschemeLower() dict
  return tolower(g:colors_name)
endfunction

function! theme_manager#LightlineThemeColorschemeSuffix() dict
  return g:colors_name . self.suffix
endfunction

function! theme_manager#LightlineThemeColorschemeBackground() dict
  return g:colors_name . '_' . &background
endfunction

function! theme_manager#GetColorDictionary(color_name)
  let l:color = {}
  for color in g:colorscheme_map
    if a:color_name == color.name || (has_key(color, 'comparison') && color.comparison == 'fuzzy' && a:color_name =~ color.name)
      let l:color = color
      break
    endif
  endfor
  return l:color
endfunction

function! theme_manager#SchemeVariant(delta) abort
  if has_key(g:current_color_dictionary, 'NextVariant')
    call g:current_color_dictionary.NextVariant(a:delta)
  endif
endfunction

function! theme_manager#ToggleScheme() abort
  if has_key(g:current_color_dictionary, 'ToggleScheme')
    call g:current_color_dictionary.ToggleScheme()
  endif
endfunction

function! theme_manager#AirlineTheme()
  if has_key (g:current_color_dictionary, 'AirlineTheme')
    let g:airline_theme = g:current_color_dictionary.AirlineTheme()
  else
    let g:airline_theme = g:default_airline_theme
  endif
  exec "AirlineTheme " . g:airline_theme
endfunction

function! theme_manager#LightlineUpdate()
  if !exists('g:loaded_lightline')
    return
  endif
  try
    if has_key(g:current_color_dictionary, 'LightlineTheme')
      let l:new_lightline_colorscheme = g:current_color_dictionary.LightlineTheme()
    else
      let l:new_lightline_colorscheme = g:default_lightline_colorscheme
    endif
    exe 'runtime autoload/lightline/colorscheme/' . l:new_lightline_colorscheme . '.vim'
    call theme_manager#SetLightlineColorscheme(l:new_lightline_colorscheme)
  endtry
endfunction

function! theme_manager#SetLightlineColorscheme(name) abort
  let g:lightline.colorscheme = a:name
  call lightline#init()
  call lightline#colorscheme()
  call lightline#update()
endfunction

function! s:ChooseNextColorscheme (last_colorscheme)
  let l:new_colorscheme = a:last_colorscheme
  for colorscheme_group in values(g:colorscheme_groups)
    for colorscheme_group_member in colorscheme_group
      if a:last_colorscheme == colorscheme_group_member
        let l:new_colorscheme = colorscheme_group[localtime() % len(colorscheme_group)]
        break
      endif
    endfor
  endfor
  return l:new_colorscheme
endfunction

function! theme_manager#SetLastColorscheme()
  let l:last_colorscheme = readfile(expand(g:colorscheme_file))
  exec 'set background='.l:last_colorscheme[0]
  if has('patch-8.0.1777')
    silent exec 'doautocmd ColorschemePre ' . l:last_colorscheme[1]
  endif
  exec 'colors ' . l:last_colorscheme[1]
  let g:colors_name = l:last_colorscheme[1]
  silent exec 'doautocmd Colorscheme ' . l:last_colorscheme[1]
endfunction
