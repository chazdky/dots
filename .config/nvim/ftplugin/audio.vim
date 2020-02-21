function! s:Cmd() abort
    if executable("xdg-open")
        return "xdg-open"
    endif
endfunction

call system(<SID>Cmd() . " " . expand("%:p")) | buffer# | bdelete# | redraw! | syntax on
