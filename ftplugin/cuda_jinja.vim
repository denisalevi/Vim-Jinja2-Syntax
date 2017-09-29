" load matchit config from jinja.vim
runtime ftplugin/jinja.vim

" Different syntax highlighting within regions of a file
" http://vim.wikia.com/wiki/Different_syntax_highlighting_within_regions_of_a_file
" Important changes:
" * Add keepend, otherwise nested C++/Jinja doesn't work!
" * Add containedin=ALL, so also highlighted in C comments and strings.
" * Remove the textSnipHl section (since want to include the delimiters
"   for Jinja).
"
" ...and using syntax from:
" http://www.vim.org/scripts/script.php?script_id=1856
function! TextEnableCodeSnip(filetype,start,end) abort
  let ft=toupper(a:filetype)
  let group='textGroup'.ft
  if exists('b:current_syntax')
    let s:current_syntax=b:current_syntax
    " Remove current syntax definition, as some syntax files (e.g. cpp.vim)
    " do nothing if b:current_syntax is defined.
    unlet b:current_syntax
  endif
  execute 'syntax include @'.group.' syntax/'.a:filetype.'.vim'
  try
    execute 'syntax include @'.group.' after/syntax/'.a:filetype.'.vim'
  catch
  endtry
  if exists('s:current_syntax')
    let b:current_syntax=s:current_syntax
  else
    unlet b:current_syntax
  endif
  execute 'syntax region textSnip'.ft.'
  \ start="'.a:start.'" end="'.a:end.'"
  \ keepend
  \ containedin=ALL
  \ contains=@'.group
endfunction

" mixed filetypes where jinja is the last part (e.g. cpp.jinja)
" have the first part loaded as syntax (cpp) and need extra
" jinja syntax loading in correct file parts
au FileType *.jinja call TextEnableCodeSnip('jinja', '{{', '}}')
au FileType *.jinja call TextEnableCodeSnip('jinja', '{%', '%}')
au FileType *.jinja call TextEnableCodeSnip('jinja', '{#', '#}')

" vim:ft=vim:fdm=marker
