function mgr#init() abort
  let g:colorscheme_map = {}
endfunction

function! mgr#add (name, ...) abort
  let l:opts = {}
  if a:0 == 1
    let l:opts = a:1
  endif
  let g:colorscheme_map[a:name] = extend (l:opts, {'status': function('mgr#cscheme')}, 'keep')
endfunction

function mgr#init_groups() abort
  let g:colorscheme_groups = {}
endfunction

function mgr#init_group() abort
  let s:colorscheme_group = {}
endfunction

function mgr#add_cscheme(name) abort
  let s:colorscheme_group[a:name] = 1
endfunction

function mgr#add_group(name)
  let g:colorscheme_groups[a:name] = deepcopy(s:colorscheme_group)
endfunction

function! mgr#nxt_cscheme_var(delta) dict
  let l:current_variant = g:colors_name
  let l:num_variants = len(self.variants)
  let l:next_variant = self.variants[((a:delta+index(self.variants, l:current_variant)) % l:num_variants + l:num_variants) % l:num_variants]
  exec 'colors ' . l:next_variant
endfunction

function! mgr#nxt_cscheme_var_mp(delta) dict
  let l:variant_list = copy(self.variants)
  call map(l:variant_list, function(self.map))
  let l:current_variant = g:colors_name
  let l:num_variants = len(l:variant_list)
  let l:next_variant = l:variant_list[((a:delta+index(l:variant_list, l:current_variant)) % l:num_variants + l:num_variants) % l:num_variants]
  exec 'colors ' . l:next_variant
endfunction

function! mgr#nxt_styl_var(delta) dict
  let l:num_variants = len(self.variants)
  exec 'let ' . self.style_variable . ' = self.variants[((a:delta+index(self.variants, ' . self.style_variable . ')) % l:num_variants + l:num_variants) % l:num_variants]'
  exec 'colors ' . g:colors_name
endfunction

function! mgr#nxt_styl_bg_var(delta) dict
  let l:num_variants = len(self.variants)
  exec 'let ' . self.style_variable . '_' . &background . ' = self.variants[((a:delta+index(self.variants, ' . self.style_variable . '_' . &background . ')) % l:num_variants + l:num_variants) % l:num_variants]'
  exec 'colors ' . g:colors_name
endfunction

function! mgr#def_styl_var() dict
  exec 'let ' . self.style_variable . ' = "' . self.default_style . '"'
endfunction

function! mgr#def_styl_bg_var() dict
  exec 'let ' . self.style_variable . '_' . &background . ' = "' . self.default_style . '"'
endfunction

function! mgr#tggl_bg(...) dict
  let &background = (&background == 'dark') ? 'light' : 'dark'
endfunction

function! mgr#tggl_cscheme() dict
  let l:new_colorscheme = (g:colors_name =~# 'dark') ? substitute(g:colors_name, 'dark', 'light', '') : substitute(g:colors_name, 'light', 'dark', '')
  exec 'colors ' . l:new_colorscheme
endfunction

function! mgr#tggl_cscheme_styl() dict
  exec 'let l:current_style = ' . self.style_variable
  let l:current_style = (l:current_style == 'dark') ? 'light' : 'dark'
  exec 'let ' . self.style_variable . " = '" . l:current_style . "'"
  exec 'colors ' . g:colors_name
endfunction

function! mgr#cscheme() dict
  return g:colors_name
endfunction

function! mgr#cscheme_styl() dict
  exec 'let l:current_style = ' . self.style_variable
  return g:colors_name . g:mgr_slash . l:current_style
endfunction

function! mgr#cscheme_bg_styl() dict
  exec 'let l:current_style = ' . self.style_variable . '_' . &background
  return g:colors_name . g:mgr_slash . l:current_style
endfunction

function! mgr#cscheme_bg_sl() dict
  return g:colors_name . g:mgr_slash . &background
endfunction

function! mgr#cscheme_dsh_to_uscr() dict
  return tr(g:colors_name, '-', '_')
endfunction

function! mgr#csheme_rm_dsh() dict
  return substitute(g:colors_name, '-', '', 'g')
endfunction

function! mgr#cscheme_lwr() dict
  return tolower(g:colors_name)
endfunction

function! mgr#cschemeSuffix() dict
  return g:colors_name . self.suffix
endfunction

function! mgr#cscheme_bg_uscr() dict
  return g:colors_name . '_' . &background
endfunction

function! mgr#get_color_dict(color_name)
  let l:color_dictionary = {}
  try
    let l:color_dictionary = g:colorscheme_map[a:color_name]
  catch /^Vim\%((\a\+)\)\=:E716:/ " catch error E716
    for color in keys(g:colorscheme_map)
      if a:color_name =~ color
        let l:color_dictionary = g:colorscheme_map[color]
        break
      endif
    endfor
  endtry
  return l:color_dictionary
endfunction

function! mgr#get_color_dict_key(color_name)
  let l:color_key = ''
  let l:color_dictionary = {}
  try
     let l:color_dictionary = g:colorscheme_map[a:color_name]
     let l:color_key = a:color_name
  catch /^Vim\%((\a\+)\)\=:E716:/ " catch error E716
    for color in keys(g:colorscheme_map)
      if a:color_name =~ color
        let l:color_key = color
        break
      endif
    endfor
  endtry
  return l:color_key
endfunction

function! mgr#scheme_var(delta) abort
  if has_key(g:current_color_dictionary, 'next_variant')
    call g:current_color_dictionary.next_variant(a:delta)
  endif
endfunction

function! mgr#tggl() abort
  if has_key(g:current_color_dictionary, 'toggle')
    call g:current_color_dictionary.toggle()
  endif
endfunction

function! mgr#airline_theme()
  if has_key (g:current_color_dictionary, 'airline')
    let l:airline_theme = g:current_color_dictionary.airline()
  else
    let l:airline_theme = g:default_airline_theme
  endif
  exec "AirlineTheme " . l:airline_theme
endfunction

function! mgr#lightline_updt()
  if !exists('g:loaded_lightline')
    return
  endif
  try
    if has_key(g:current_color_dictionary, 'lightline')
      let g:lightline.colorscheme = g:current_color_dictionary.lightline()
    else
      let g:lightline.colorscheme = g:default_lightline_colorscheme
    endif
    exe 'runtime autoload/lightline/colorscheme/' . g:lightline.colorscheme . '.vim'
    call lightline#init()
    call lightline#colorscheme()
    call lightline#updte()
  endtry
endfunction

function! s:cscheme_list()
  let matches = {}
  let l:theme_list = split(globpath(&runtimepath, 'colors/*.vim'), '\n')
  for l:file in l:theme_list
    let l:scheme = fnamemodify(l:file, ':t:r')
    let l:color_dictionary = mgr#get_color_dict(l:scheme)
    if l:color_dictionary != {}
      let matches[l:scheme] = 1
    endif
  endfor
  return sort(keys(matches), 1)
endfunction

function! s:random_no(number)
  let l:time = split(reltimestr(reltime()), '\.')
  let l:ms = l:time[-1] + 0
  return l:ms % a:number
endfunction

function! s:set_cscheme(new_colorscheme)
  if has('patch-8.0.1777')
    silent exec 'doautocmd ColorschemePre ' . a:new_colorscheme
  endif
  exec 'colors ' . a:new_colorscheme
  let g:colors_name = a:new_colorscheme
  silent exec 'doautocmd Colorscheme ' . a:new_colorscheme
endfunction

function! mgr#set_rand_grp_cscheme (...)
  if a:0 > 1
    let l:new_colorscheme = g:colors_name
  else
    let l:new_colorscheme = a:1
  endif
  for colorscheme_group in values(g:colorscheme_groups)
    if has_key(colorscheme_group, a:1)
      let s:colorschemes = sort(keys(colorscheme_group))
      let l:new_colorscheme = s:colorschemes[s:random_no(len(s:colorschemes))]
      break
    endif
  endfor
  call s:set_cscheme (l:new_colorscheme)
endfunction

function! mgr#set_rand_cscheme()
  let l:themes = s:cscheme_list()
  let l:new_colorscheme = l:themes[s:random_no(len(l:themes))]
  call s:set_cscheme (l:new_colorscheme)
endfunction

function! mgr#set_last_cscheme()
  let l:last_colorscheme = readfile(expand(g:colorscheme_file))
  let [l:background, l:colorscheme] = l:last_colorscheme
  exec 'set background='.l:background
  if g:mgr_randomize
    call mgr#set_rand_csheme()
  elseif g:mgr_randomize_group
    call mgr#set_rand_grp_cscheme(l:colorscheme)
  else
    call s:set_cscheme(l:colorscheme)
  endif
endfunction

function! mgr#which_status(colorscheme)
  if has_key(g:current_color_dictionary, 'airline')
    let l:airlinetheme = g:current_color_dictionary.airline()
  else
    let l:airlinetheme = ''
  endif
  if has_key(g:current_color_dictionary, 'lightline')
    let l:lightlinetheme = g:current_color_dictionary.lightline()
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

