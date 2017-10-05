" Figure out if a file uses Jinja templates
fun! s:SelectHTML()
  let n = 1
  while n < 50 && n <= line("$")
    " check for jinja
    if getline(n) =~ '{{.*}}\|{%[-+]\?\s*\(end.*\|extends\|block\|macro\|set\|if\|for\|include\|trans\)\>'
      " The jinja syntax file takes care of loading html syntax
      set ft=jinja.html
      return
    endif
    let n = n + 1
  endwhile
endfun

fun! s:AddJinjaFileType(ftype)
  let n = 1
  while n < 50 && n <= line("$")
    " check for jinja
    if getline(n) =~ '{{.*}}\|{%[-+]\?\s*\(end.*\|extends\|block\|macro\|set\|if\|for\|include\|trans\)\>'
      " Jinja syntax file will later be loaded for the correct code snippets
      exec "set ft=" . a:ftype . ".jinja"
      return
    endif
    let n = n + 1
  endwhile
endfun

autocmd BufNewFile,BufRead *.html,*.htm,*.nunjucks,*.nunjs,*.njk  call s:SelectHTML()
autocmd BufNewFile,BufRead *.cpp  call s:AddJinjaFileType("cpp")
autocmd BufNewFile,BufRead *.cu,*.cuh  call s:AddJinjaFileType("cuda")
autocmd BufNewFile,BufRead *.jinja2,*.j2,*.jinja set ft=jinja
