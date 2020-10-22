" mgr#init
"   Create an empty colorscheme_map
function mgr#init() abort
  let g:colorscheme_map = {}
endfunction

" mgr#add
"   Add information about a colorscheme
"     Arguments:
"       name - the name of the colorscheme.  This is the name used to set the
"         colorscheme with the :colors command.  Can be part of a colorscheme
"         name to match multiple colorschemes.
"       An additional dictionary can be added as an argument.  The dictionary
"       can have any of the following keys:
"         variants: A list of variants of the colorscheme.
"         pre: A list of commands to run before setting the colorscheme.  This
"           is intended to set configuration variables for the colorscheme.
"         next_variant: A funcref to a dictionary function that will switch to a the next
"           colorscheme variant in the variants list.
"         default_variant: A funcref to a dictionary function that will set the defaul
"           colorscheme style.
"         status: A funcref to a dictionary function that will return the
"           colorscheme name and variant for use in the status line.  Defaults to
"           mgr#cscheme.
"         lightline: A funcref to a dictionary function that will return the name
"           of the lightline theme for the colorscheme.
"         airline: A funcref to a dictionary function that will return the name of
"           the airline theme for the colorscheme.
"         toggle: A funcref to a dictionary function that will toggle between dark
"           and light versions of a colorscheme.
"         map: A funcref to a dictionary function that is referenced in the
"           |mgr#nxt_cscheme_var_mp()| function.
"         style_variable: The name of the variable used to set the colorschem
"           style.  This is used by the |mgr#nxt_styl_var()| and
"           |mgr#tggl_cscheme_styl()| functions.
"         default_style: The users preferred style for the colorscheme.  Used by
"           |mgr#def_styl_var()| and
"           |mgr#def_styl_bg_var()| functions.
function! mgr#add (name, ...) abort
  let l:opts = {}
  if a:0 == 1
    let l:opts = a:1
  endif
  let g:colorscheme_map[a:name] = extend (l:opts, {'status': function('mgr#cscheme')}, 'keep')
endfunction

" mgr#init_groups
"   Create empty colorscheme_groups dictionary
function mgr#init_groups() abort
  let g:colorscheme_groups = {}
endfunction

" mgr#init_group
"   Create an empty colorscheme_group dictionary
function mgr#init_group() abort
  let s:colorscheme_group = {}
endfunction

" mgr#add_cscheme
"   Add a colorscheme to the the colorscheme_group dictionary
"     Arguments:
"       name - The name of the colorscheme
function mgr#add_cscheme(name) abort
  let s:colorscheme_group[a:name] = 1
endfunction

" mgr#add_group
"   Copy a colorscheme group into the colorscheme groups dictionary
"     Arguments:
"       name - The name of the colorscheme group
function mgr#add_group(name)
  let g:colorscheme_groups[a:name] = deepcopy(s:colorscheme_group)
endfunction

" mgr#next_cscheme_var
"   Switch to new colorscheme in variant list
"     Arguments:
"       delta - A number indicating how far to increment or decrement through
"         the variant list.  A positive number increments, a negative number
"         decrements.
function! mgr#nxt_cscheme_var(delta) dict
  let l:current_variant = g:colors_name
  let l:num_variants = len(self.variants)
  let l:next_variant = self.variants[((a:delta+index(self.variants, l:current_variant)) % l:num_variants + l:num_variants) % l:num_variants]
  exec 'colors ' . l:next_variant
endfunction

" mgr#next_cscheme_var_mp
"   Switch to new colorscheme in variant list.  The variant list is passed
"     through a map function to construct the actual colorscheme names.
"     Arguments:
"       delta - A number indicating how far to increment or decrement through
"         the variant list.  A positive number increments, a negative number
"         decrements.
function! mgr#nxt_cscheme_var_mp(delta) dict
  let l:variant_list = copy(self.variants)
  call map(l:variant_list, function(self.map))
  let l:current_variant = g:colors_name
  let l:num_variants = len(l:variant_list)
  let l:next_variant = l:variant_list[((a:delta+index(l:variant_list, l:current_variant)) % l:num_variants + l:num_variants) % l:num_variants]
  exec 'colors ' . l:next_variant
endfunction

" mgr#next_styl_var
"   Switch to new colorscheme style in variant list.
"     Arguments:
"       delta - A number indicating how far to increment or decrement through
"         the variant list.  A positive number increments, a negative number
"         decrements.
function! mgr#nxt_styl_var(delta) dict
  let l:num_variants = len(self.variants)
  exec 'let ' . self.style_variable . ' = self.variants[((a:delta+index(self.variants, ' . self.style_variable . ')) % l:num_variants + l:num_variants) % l:num_variants]'
  exec 'colors ' . g:colors_name
endfunction

" mgr#next_styl_bg_var
"   Switch to new colorscheme style in variant list.  The current background
"     is used to construct the style_variable.
"     Arguments:
"       delta - A number indicating how far to increment or decrement through
"         the variant list.  A positive number increments, a negative number
"         decrements.
function! mgr#nxt_styl_bg_var(delta) dict
  let l:num_variants = len(self.variants)
  exec 'let ' . self.style_variable . '_' . &background . ' = self.variants[((a:delta+index(self.variants, ' . self.style_variable . '_' . &background . ')) % l:num_variants + l:num_variants) % l:num_variants]'
  exec 'colors ' . g:colors_name
endfunction

" mgr#def_styl_var
"   Set style variable to style indicated in default_style dictionary entry.
function! mgr#def_styl_var() dict
  exec 'let ' . self.style_variable . ' = "' . self.default_style . '"'
endfunction

" mgr#def_styl_bg_var
"   Set style variable to style indicated in defatul_style dictionary entry.
"   The current background is used to construct the style variable.
function! mgr#def_styl_bg_var() dict
  exec 'let ' . self.style_variable . '_' . &background . ' = "' . self.default_style . '"'
endfunction

" mgr#tggl_bg
"   Switch between light and dark backgrounds.
function! mgr#tggl_bg(...) dict
  let &background = (&background == 'dark') ? 'light' : 'dark'
endfunction

" mgr#tggl_cscheme
"   Switch between light and dark versions of the same colorscheme.
function! mgr#tggl_cscheme() dict
  let l:new_colorscheme = (g:colors_name =~# 'dark') ? substitute(g:colors_name, 'dark', 'light', '') : substitute(g:colors_name, 'light', 'dark', '')
  exec 'colors ' . l:new_colorscheme
endfunction

" mgr#tggl_cscheme_styl
"   Switch between light and dark styles of the current colorscheme.
function! mgr#tggl_cscheme_styl() dict
  exec 'let l:current_style = ' . self.style_variable
  let l:current_style = (l:current_style == 'dark') ? 'light' : 'dark'
  exec 'let ' . self.style_variable . " = '" . l:current_style . "'"
  exec 'colors ' . g:colors_name
endfunction

" mgr@cscheme
"   Returns the current colorscheme.
function! mgr#cscheme() dict
  return g:colors_name
endfunction

" mgr#cscheme_styl
"   Returns the current colorscheme / current style
function! mgr#cscheme_styl() dict
  exec 'let l:current_style = ' . self.style_variable
  return g:colors_name . g:mgr_slash . l:current_style
endfunction

" mgr#cscheme_bg_style
"   Returns the current colorscheme / current style.  The current background
"   is used to construct the style variable name.
function! mgr#cscheme_bg_styl() dict
  exec 'let l:current_style = ' . self.style_variable . '_' . &background
  return g:colors_name . g:mgr_slash . l:current_style
endfunction

" mgr#cscheme_bg_sl
"   Returns the current colorscheme / current background
function! mgr#cscheme_bg_sl() dict
  return g:colors_name . g:mgr_slash . &background
endfunction

" mgr#cscheme_dsh_to_uscr
"   Returns the current colorscheme with all '-' changed to '_'
function! mgr#cscheme_dsh_to_uscr() dict
  return tr(g:colors_name, '-', '_')
endfunction

" mgr#csheme_rm_dsh
"   Returns the current colorscheme with '-' characters removed.
function! mgr#csheme_rm_dsh() dict
  return substitute(g:colors_name, '-', '', 'g')
endfunction

" mgr#cscheme_lwr
"   Returns the current colorscheme in lower case
function! mgr#cscheme_lwr() dict
  return tolower(g:colors_name)
endfunction

" mgr#cscheme_sffx
"  Returns colorscheme with a suffix appended
function! mgr#cschemeSuffix() dict
  return g:colors_name . self.suffix
endfunction

" mgr#cscheme_bg_uscr
"   Returns current colorscheme _ background
function! mgr#cscheme_bg_uscr() dict
  return g:colors_name . '_' . &background
endfunction

" mgr#get_color_dict
"   Returns a dictionary of information for a colorscheme
"     Paramters:
"       color_name - The name of the desired color.  If there is no
"       colorscheme that exactly matched the color, a colorscheme matching
"       part of color_name will be returned.
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

" mgr#get_color_dict_key
"   Returns the color dictionary key for a colorscheme.  Can be used to
"   extract the base name of a colorscheme
"     Arguments:
"       color_name - The name of the desired color.  If there is no
"       colorscheme that exactly matched the color, a colorscheme matching
"       part of color_name will be returned.
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

" mgr#scheme_var
"   Generic function call to switch to next colorscheme variant.  Calls the
"   function indicated in the current colorscheme dictionary.
function! mgr#scheme_var(delta) abort
  if has_key(g:current_color_dictionary, 'next_variant')
    call g:current_color_dictionary.next_variant(a:delta)
  endif
endfunction

" mgr#tggl
"   Generic function call to switch between light and dark versions of the
"   current colorscheme.  Call the function indicated in the current
"   colorscheme dictionary.
function! mgr#tggl() abort
  if has_key(g:current_color_dictionary, 'toggle')
    call g:current_color_dictionary.toggle()
  endif
endfunction

" mgr#airline_theme
"   Set airline theme to match colorscheme.
function! mgr#airline_theme()
  if has_key (g:current_color_dictionary, 'airline')
    let l:airline_theme = g:current_color_dictionary.airline()
  else
    let l:airline_theme = g:default_airline_theme
  endif
  exec "AirlineTheme " . l:airline_theme
endfunction

" mgr#lightline_updt
"   Set lightline theme to match colorscheme.
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
    call lightline#update()
  endtry
endfunction

" s:cscheme_list
"   Create a list of colorschemes that are defined in the colorscheme map
"   dictionary
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

" s:random_no
"   Generate a random number based on the current time.
"     Arguments:
"       number - the maximum randoem number to generate
function! s:random_no(number)
  let l:time = split(reltimestr(reltime()), '\.')
  let l:ms = l:time[-1] + 0
  return l:ms % a:number
endfunction

" s:set_cscheme
"   Change the colorscheme
"   Arguments:
"     new_colorscheme - the name of the colorscheme to set.
function! s:set_cscheme(new_colorscheme)
  if has('patch-8.0.1777')
    silent exec 'doautocmd ColorschemePre ' . a:new_colorscheme
  endif
  exec 'colors ' . a:new_colorscheme
  let g:colors_name = a:new_colorscheme
  silent exec 'doautocmd Colorscheme ' . a:new_colorscheme
endfunction

" mgr#set_rand_grp_cscheme
"   Choose a new colorscheme from the group of colorschemes that contains the
"   current colorscheme.
"   Arguments:
"     An optional argument contaiing the name of a colorscheme may be used
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

" mgr#set_rand_cscheme
"   Choose a new colorscheme from the colorschemes defined in the colorscheme
"   map.
function! mgr#set_rand_cscheme()
  let l:themes = s:cscheme_list()
  let l:new_colorscheme = l:themes[s:random_no(len(l:themes))]
  call s:set_cscheme (l:new_colorscheme)
endfunction

" mgr#set_cscheme
"   Set the colorscheme.  The colorscheme will either be the last colorscheme
"   used, or a randome colorscheme baased on the values of g:mgr_randomize and
"   g:mgr_randomize_group
function! mgr#set_cscheme()
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

" mgr#which_status
"   Choose the statusbar plugin to use based on the colorscheme that has been
"   set.
"     Arguments:
"       colorscheme - The name of the colorscheme
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

