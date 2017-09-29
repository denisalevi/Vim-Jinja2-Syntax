" Figure out which type of hilighting to use for html.
fun! s:SelectHTML()
  let n = 1
  while n < 50 && n <= line("$")
    " check for jinja
    if getline(n) =~ '{{.*}}\|{%[-+]\?\s*\(end.*\|extends\|block\|macro\|set\|if\|for\|include\|trans\)\>'
      set ft=jinja.html
      return
    endif
    let n = n + 1
  endwhile
endfun
fun! s:SelectCpp()
  let n = 1
  while n < 50 && n <= line("$")
    " check for jinja
    if getline(n) =~ '{{.*}}\|{%[-+]\?\s*\(end.*\|extends\|block\|macro\|set\|if\|for\|include\|trans\)\>'
      set ft=cpp.jinja
      return
    endif
    let n = n + 1
  endwhile
endfun
fun! s:SelectCuda()
  let n = 1
  while n < 50 && n <= line("$")
    " check for jinja
    if getline(n) =~ '{{.*}}\|{%[-+]\?\s*\(end.*\|extends\|block\|macro\|set\|if\|for\|include\|trans\)\>'
      set ft=cuda.jinja
      return
    endif
    let n = n + 1
  endwhile
endfun
autocmd BufNewFile,BufRead *.html,*.htm,*.nunjucks,*.nunjs,*.njk  call s:SelectHTML()
autocmd BufNewFile,BufRead *.cpp  call s:SelectCpp()
autocmd BufNewFile,BufRead *.cu,*.cuh  call s:SelectCuda()
autocmd BufNewFile,BufRead *.jinja2,*.j2,*.jinja set ft=jinja
