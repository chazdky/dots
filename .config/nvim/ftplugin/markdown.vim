setlocal textwidth=0 wrapmargin=0 wrap spell
let g:markdown_fenced_languages = ['css', 'bash', 'python3', 'terminal', 'javascript', 'js=javascript', 'json=javascript', 'stylus', 'html']
autocmd BufNewFile,BufRead,BufWrite *.md syntax match Comment /\%^---\_.\{-}---$/
nnoremap <leader>me :<C-U>EvalBlock<cr>
