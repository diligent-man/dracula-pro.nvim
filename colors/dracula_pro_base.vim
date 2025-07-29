" Configuration: {{{
if v:version > 580
  highlight clear
  if exists('syntax_on')
    syntax reset
  endif
endif

let g:colors_name = 'dracula_pro'

if !(has('termguicolors') && &termguicolors) && !has('gui_running') && &t_Co != 256
  finish
endif


" Palette: {{{
let s:red          = g:dracula_pro#palette.red
let s:cyan         = g:dracula_pro#palette.cyan
let s:pink         = g:dracula_pro#palette.pink
let s:grey         = g:dracula_pro#palette.grey
let s:green        = g:dracula_pro#palette.green
let s:black        = g:dracula_pro#palette.black
let s:orange       = g:dracula_pro#palette.orange
let s:purple       = g:dracula_pro#palette.purple
let s:purple       = g:dracula_pro#palette.purple
let s:yellow       = g:dracula_pro#palette.yellow
let s:slate_grey   = g:dracula_pro#palette.grey

let s:fg           = g:dracula_pro#palette.fg

let s:bg           = g:dracula_pro#palette.bg
let s:bgdark       = g:dracula_pro#palette.bgdark
let s:bglight      = g:dracula_pro#palette.bglight
let s:bgdarker     = g:dracula_pro#palette.bgdarker
let s:bglighter    = g:dracula_pro#palette.bglighter
let s:bgfold       = g:dracula_pro#palette.bgfold

let s:subtle       = g:dracula_pro#palette.subtle
let s:comment      = g:dracula_pro#palette.comment
let s:selection    = g:dracula_pro#palette.selection

let s:linenr       = g:dracula_pro#palette.slate_grey
let s:cursorlinenr = g:dracula_pro#palette.grey

let s:function     = g:dracula_pro#palette.function


let s:none      = ['NONE', 'NONE']

if has('nvim')
  for s:i in range(16)
    let g:terminal_color_{s:i} = g:dracula_pro#palette['color_' . s:i]
  endfor
endif

if has('terminal')
  let g:terminal_ansi_colors = []
  for s:i in range(16)
    call add(g:terminal_ansi_colors, g:dracula_pro#palette['color_' . s:i])
  endfor
endif
" }}}


" User Configuration: {{{
if !exists('g:dracula_bold')
  let g:dracula_bold = 1
endif

if !exists('g:dracula_italic')
  let g:dracula_italic = 1
endif

if !exists('g:dracula_underline')
  let g:dracula_underline = 1
endif

if !exists('g:dracula_undercurl') && g:dracula_underline != 0
  let g:dracula_undercurl = 1
endif

if !exists('g:dracula_inverse')
  let g:dracula_inverse = 1
endif

if !exists('g:dracula_colorterm')
  let g:dracula_colorterm = 1
endif
"}}}


" Script Helpers: {{{
let s:attrs = {
      \ 'bold': g:dracula_bold == 1 ? 'bold' : 0,
      \ 'italic': g:dracula_italic == 1 ? 'italic' : 0,
      \ 'underline': g:dracula_underline == 1 ? 'underline' : 0,
      \ 'undercurl': g:dracula_undercurl == 1 ? 'undercurl' : 0,
      \ 'inverse': g:dracula_inverse == 1 ? 'inverse' : 0,
      \}

function! s:h(scope, fg, ...) " bg, attr_list, special
  let l:fg = copy(a:fg)
  let l:bg = get(a:, 1, ['NONE', 'NONE'])

  let l:attr_list = filter(get(a:, 2, ['NONE']), 'type(v:val) == 1')
  let l:attrs = len(l:attr_list) > 0 ? join(l:attr_list, ',') : 'NONE'

  " Falls back to coloring foreground group on terminals because
  " nearly all do not support undercurl
  let l:special = get(a:, 3, ['NONE', 'NONE'])
  if l:special[0] !=# 'NONE' && l:fg[0] ==# 'NONE' && !has('gui_running')
    let l:fg[0] = l:special[0]
    let l:fg[1] = l:special[1]
  endif

  let l:hl_string = [
        \ 'highlight!', a:scope,
        \ 'guifg=' . l:fg[0], 'ctermfg=' . l:fg[1],
        \ 'guibg=' . l:bg[0], 'ctermbg=' . l:bg[1],
        \ 'gui=' . l:attrs, 'cterm=' . l:attrs,
        \ 'guisp=' . l:special[0],
        \]

  execute join(l:hl_string, ' ')
endfunction
"}}}


" Dracula Highlight Groups: {{{
call s:h('DraculaCyan', s:cyan)
call s:h('DraculaCyanItalic', s:cyan, s:none, [s:attrs.italic])

call s:h('DraculaGreen', s:green)
call s:h('DraculaGreenBold', s:green, s:none, [s:attrs.bold])
call s:h('DraculaGreenItalic', s:green, s:none, [s:attrs.italic])
call s:h('DraculaGreenItalicUnderline', s:green, s:none, [s:attrs.italic, s:attrs.underline])

call s:h('DraculaOrange', s:orange)
call s:h('DraculaOrangeBold', s:orange, s:none, [s:attrs.bold])
call s:h('DraculaOrangeItalic', s:orange, s:none, [s:attrs.italic])
call s:h('DraculaOrangeBoldItalic', s:orange, s:none, [s:attrs.bold, s:attrs.italic])
call s:h('DraculaOrangeInverse', s:bg, s:orange)

call s:h('DraculaPink', s:pink)
call s:h('DraculaPinkItalic', s:pink, s:none, [s:attrs.italic])

call s:h('DraculaPurple', s:purple)
call s:h('DraculaPurpleBold', s:purple, s:none, [s:attrs.bold])
call s:h('DraculaPurpleItalic', s:purple, s:none, [s:attrs.italic])

call s:h('DraculaRed', s:red)
call s:h('DraculaRedInverse', s:fg, s:red)

call s:h('DraculaYellow', s:yellow)
call s:h('DraculaYellowItalic', s:yellow, s:none, [s:attrs.italic])

call s:h('DraculaPurple', s:purple)
call s:h('DraculaSlateGrey', s:slate_grey)
""""""""""""

call s:h('DraculaBgLight', s:none, s:bglight)
call s:h('DraculaBgLighter', s:none, s:bglighter)
call s:h('DraculaBgDark', s:none, s:bgdark)
call s:h('DraculaBgDarker', s:none, s:bgdarker)

call s:h('DraculaFg', s:fg)
call s:h('DraculaFgBold', s:fg, s:none, [s:attrs.bold])
call s:h('DraculaFgUnderline', s:fg, s:none, [s:attrs.underline])
""""""""""""

call s:h('DraculaComment', s:comment)
call s:h('DraculaCommentBold', s:comment, s:none, [s:attrs.bold])

call s:h('DraculaSubtle', s:subtle)
call s:h('DraculaSelection', s:none, s:selection)

call s:h('LineNr', s:linenr)
call s:h('CursorLineNr', s:cursorlinenr)
call s:h('IncSearch', s:none, s:none, [s:attrs.inverse, s:attrs.italic])

call s:h('DraculaTodo', s:cyan, s:none, [s:attrs.bold])
call s:h('DraculaSearch', s:green, s:yellow, [s:attrs.inverse])

call s:h('DraculaFunction', s:function)

call s:h('DraculaBoundary', s:comment, s:bgdark)
call s:h('DraculaFolding', s:comment, s:bgfold)
call s:h('DraculaLink', s:cyan, s:none, [s:attrs.underline])

call s:h('DraculaError', s:red, s:none, [s:attrs.italic], s:red)
call s:h('DraculaErrorLine', s:none, s:none, [s:attrs.undercurl], s:red)
call s:h('DraculaWarnLine', s:none, s:none, [s:attrs.undercurl], s:orange)
call s:h('DraculaInfoLine', s:none, s:none, [s:attrs.undercurl], s:cyan)

call s:h('DraculaDiffChange', s:orange, s:none)
call s:h('DraculaDiffText', s:bg, s:orange)
call s:h('DraculaDiffDelete', s:red, s:bgdark)
" }}}
" }}}


" User Interface: {{{
" Ref: https://neovim.io/doc/user/syntax.html#_13.-highlight-command
set background=dark

" Required as some plugins will overwrite
call s:h('Normal', s:fg, g:dracula_colorterm || has('gui_running') ? s:bg : s:none )
call s:h('StatusLine', s:none, s:bglighter, [s:attrs.bold])
call s:h('StatusLineNC', s:none, s:bglight)
call s:h('StatusLineTerm', s:none, s:bglighter, [s:attrs.bold])
call s:h('StatusLineTermNC', s:none, s:bglight)
call s:h('WildMenu', s:bg, s:purple, [s:attrs.bold])
call s:h('CursorLine', s:none, s:subtle)

hi! link LineNr       LineNr
hi! link CursorLineNr CursorLineNr

hi! link Search       DraculaSearch

hi! link ColorColumn  DraculaBgDark
hi! link CursorColumn CursorBg

hi! link IncSearch    IncSearch

hi! link MoreMsg      DraculaFgBold
hi! link ErrorMsg     DraculaError
hi! link WarningMsg   DraculaYellow
hi! link WarningMsg   DraculaOrangeItalic

hi! link WinSeparator DraculaPink

hi! link FoldColumn   DraculaSubtle
hi! link Folded       DraculaFolding

hi! link DiffAdd      DraculaGreen
hi! link DiffAdded    DiffAdd
hi! link DiffChange   DraculaDiffChange
hi! link DiffDelete   DraculaDiffDelete
hi! link DiffRemoved  DiffDelete
hi! link DiffText     DraculaDiffText
hi! link Directory    DraculaPurpleBold

hi! link NonText      DraculaSubtle
hi! link Pmenu        DraculaBgDark
hi! link PmenuSbar    DraculaBgDark
hi! link PmenuSel     DraculaSelection
hi! link PmenuThumb   DraculaSelection
hi! link Question     DraculaFgBold

call s:h('SignColumn', s:comment)

hi! link TabLine      DraculaBoundary
hi! link TabLineFill  DraculaBgDarker
hi! link TabLineSel   Normal
hi! link Title        DraculaGreenBold
hi! link Visual       DraculaSelection
hi! link VisualNOS    Visual

hi! link VertSplit    DraculaBoundary
" }}}


" Syntax: {{{
" Required as some plugins will overwrite
call s:h('MatchParen', s:green, s:none, [s:attrs.underline])
call s:h('Conceal', s:cyan, s:none)

" Neovim uses SpecialKey for escape characters only. Vim uses it for that, plus whitespace.
if has('nvim')
  hi! link SpecialKey DraculaRed
  hi! link LspDiagnosticsUnderline DraculaFgUnderline
  hi! link LspDiagnosticsInformation DraculaCyan
  hi! link LspDiagnosticsHint DraculaCyan
  hi! link LspDiagnosticsError DraculaError
  hi! link LspDiagnosticsWarning DraculaOrange
  hi! link LspDiagnosticsUnderlineError DraculaErrorLine
  hi! link LspDiagnosticsUnderlineHint DraculaInfoLine
  hi! link LspDiagnosticsUnderlineInformation DraculaInfoLine
  hi! link LspDiagnosticsUnderlineWarning DraculaWarnLine
else
  hi! link SpecialKey DraculaSubtle
endif

hi! link Comment DraculaComment
hi! link Underlined DraculaFgUnderline
hi! link Todo DraculaTodo

hi! link Error DraculaError
hi! link SpellBad DraculaErrorLine
hi! link SpellLocal DraculaWarnLine
hi! link SpellCap DraculaInfoLine
hi! link SpellRare DraculaInfoLine

" Some dtypes not match with Python, etc.
hi! link Constant DraculaPurple
hi! link String DraculaYellow
hi! link Character DraculaPink
hi! link Number DraculaPurple
hi! link Boolean DraculaPurple
hi! link Float DraculaPurple

" Common to most languages
hi! link Identifier DraculaFg               " any variable name
hi! link Function DraculaFunction           " also method
hi! link Statement DraculaPink              " any statement (e.g. class in Python)
hi! link Conditional DraculaPink            " if, then, else, endif, switch, etc.
hi! link Repeat DraculaPink                 " for, do, while, etc.
hi! link Label DraculaPink                  " case, default, etc.
hi! link Operator DraculaPink               " sizeof, +, *, etc.
hi! link Keyword DraculaPink                " any other keyword
hi! link Exception DraculaPink              " try, catch, throw

" Mostly for C/ C++
hi! link PreProc DraculaPink
hi! link Include DraculaPink
hi! link Define DraculaPink
hi! link Macro DraculaPink
hi! link PreCondit DraculaPink
hi! link StorageClass DraculaPink
hi! link Structure DraculaPink
hi! link Typedef DraculaPink

hi! link Type DraculaPinkItalic

hi! link Delimiter DraculaFg

hi! link Special DraculaPink
hi! link SpecialComment DraculaCyanItalic
hi! link Tag DraculaCyan

hi! link helpHyperTextJump DraculaLink
hi! link helpCommand DraculaPurple
hi! link helpExample DraculaGreen
hi! link helpBacktick Special
"}}}

" vim: fdm=marker ts=2 sts=2 sw=2 fdl=0 et:
