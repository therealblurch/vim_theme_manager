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

function! theme_manager#Colorscheme() dict
  return g:colors_name
endfunction

function! theme_manager#ColorschemeStyle() dict
  exec 'let l:current_style = ' . self.style_variable_name
  return g:colors_name . g:theme_manager_slash . l:current_style
endfunction

function! theme_manager#ColorschemeBackgroundStyle() dict
  exec 'let l:current_style = ' . self.style_variable_name . '_' . &background
  return g:colors_name . g:theme_manager_slash . l:current_style
endfunction

function! theme_manager#ColorschemeBackgroundSlash() dict
  return g:colors_name . g:theme_manager_slash . &background
endfunction

function! theme_manager#ColorschemeTR() dict
  return tr(g:colors_name, self.tr_from, self.tr_to)
endfunction

function! theme_manager#ColorschemeSub() dict
  return substitute(g:colors_name, self.pat, self.sub, 'g')
endfunction

function! theme_manager#ColorschemeSubBackground() dict
  return substitute(g:colors_name, self.pat, &background, 'g')
endfunction

function! theme_manager#ColorschemeLower() dict
  return tolower(g:colors_name)
endfunction

function! theme_manager#ColorschemeSuffix() dict
  return g:colors_name . self.suffix
endfunction

function! theme_manager#ColorschemeBackgroundUnderscore() dict
  return g:colors_name . g:theme_manager_underscore . &background
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
    let l:airline_theme = g:current_color_dictionary.AirlineTheme()
  else
    let l:airline_theme = g:default_airline_theme
  endif
  if l:airline_theme != g:colors_name
    exec "AirlineTheme " . l:airline_theme
  endif
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

function! s:ColorschemeList()
  let matches = {}
  let l:theme_list = split(globpath(&runtimepath, 'colors/*.vim'), '\n')
  for l:file in l:theme_list
    let l:scheme = fnamemodify(l:file, ':t:r')
    let l:color_dictionary = theme_manager#GetColorDictionary(l:scheme)
    if l:scheme =~ l:color_dictionary.name
      let matches[l:scheme] = 1
    endif
  endfor
  return sort(keys(matches), 1)
endfunction

function! s:Random(number)
  let l:new_number = localtime() % a:number
  return l:new_number
endfunction

function! s:SetColorscheme(new_colorscheme)
  if has('patch-8.0.1777')
    silent exec 'doautocmd ColorschemePre ' . a:new_colorscheme
  endif
  exec 'colors ' . a:new_colorscheme
nipMateNextOrTrigger let g:colors_name = a:new_colorscheme
  silent exec 'doautocmd Colorscheme ' . a:new_colorscheme
endfunction

function! theme_manager#SetRandomGroupColorscheme (last_colorscheme)
  let l:new_colorscheme = a:last_colorscheme
  for colorscheme_group in values(g:colorscheme_groups)
    for colorscheme_group_member in colorscheme_group
      if a:last_colorscheme == colorscheme_group_member
        let l:new_colorscheme = colorscheme_group[s:Random(len(colorscheme_group))]
        break
      endif
    endfor
  endfor
  call s:SetColorscheme (l:new_colorscheme)
endfunction

function! theme_manager#SetRandomColorscheme()
  let l:themes = s:ColorschemeList()
  let l:new_colorscheme = l:themes[s:Random(len(l:themes))]
  call s:SetColorscheme (l:new_colorscheme)
endfunction

function! theme_manager#SetLastColorscheme()
  let l:last_colorscheme = readfile(expand(g:colorscheme_file))
  exec 'set background='.l:last_colorscheme[0]
  if g:theme_manager_randomize
    call theme_manager#SetRandomColorscheme()
  elseif g:theme_manager_randomize_group
    call theme_manager#SetRandomGroupColorscheme(l:last_colorscheme)
  else
    call s:SetColorscheme(l:last_colorscheme)
  endif
endfunction

function! theme_manager#WhichStatus(colorscheme)
  if has_key(g:current_color_dictionary, 'AirlineTheme')
    let l:airlinetheme = g:current_color_dictionary.AirlineTheme()
  else
    let l:airlinetheme = ''
  endif
  if has_key(g:current_color_dictionary, 'LightlineTheme')
    let l:lightlinetheme = g:current_color_dictionary.LightlineTheme()
  else
    let l:lightlinetheme = ''
  endif
  if (empty(l:airlinetheme) && empty(l:lightlinetheme))
    if (g:prefer_airline)
      let l:user_status = "airline"
    else
      let l:user_statue = "lightline"
    endif
  elseif exists('g:loaded_airline')
    let l:user_status = "airline"
  elseif exists('g:loaded_lightline')
    let l:user_status = "lightline"
  elseif g:prefer_airline && !empty(l:airlinetheme)
    let l:user_status = "airline"
  elseif !g:prefer_airline && !empty(l:lightlinetheme)
    let l:user_status = "lightline"
  elseif !empty(l:airlinetheme)
    let l:user_status = "airline"
  elseif !empty(l:lightlinetheme)
    let l:user_status = "lightline"
  endif
  return l:user_status
endfunction

