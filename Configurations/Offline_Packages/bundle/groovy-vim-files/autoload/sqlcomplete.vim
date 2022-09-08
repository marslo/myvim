" Vim completion script
" Language:    SQL
" Maintainer:  David Fishburn <fishburn@ianywhere.com>
" Version:     2.0
" Last Change: Mon Apr 03 2006 10:21:36 PM

" Set completion with CTRL-X CTRL-O to autoloaded function.
" This check is in place in case this script is
" sourced directly instead of using the autoload feature. 
if exists('&omnifunc')
    " Do not set the option if already set since this
    " results in an E117 warning.
    if &omnifunc == ""
        setlocal omnifunc=sqlcomplete#Complete
    endif
endif

if exists('g:loaded_sql_completion')
    finish 
endif
let g:loaded_sql_completion = 1

" Maintains filename of dictionary
let s:sql_file_table        = ""
let s:sql_file_procedure    = ""
let s:sql_file_view         = ""

" Define various arrays to be used for caching
let s:tbl_name              = []
let s:tbl_alias             = []
let s:tbl_cols              = []
let s:syn_list              = []
let s:syn_value             = []
 
" Used in conjunction with the syntaxcomplete plugin
let s:save_inc              = ""
let s:save_exc              = ""
if exists('g:omni_syntax_group_include_sql')
    let s:save_inc = g:omni_syntax_group_include_sql
endif
if exists('g:omni_syntax_group_exclude_sql')
    let s:save_exc = g:omni_syntax_group_exclude_sql
endif
 
" Used with the column list
let s:save_prev_table       = ""

" Default the option to verify table alias
if !exists('g:omni_sql_use_tbl_alias')
    let g:omni_sql_use_tbl_alias = 'a'
endif
" Default syntax items to precache
if !exists('g:omni_sql_precache_syntax_groups')
    let g:omni_sql_precache_syntax_groups = [
                \ 'syntax',
                \ 'sqlKeyword',
                \ 'sqlFunction',
                \ 'sqlOption',
                \ 'sqlType',
                \ 'sqlStatement'
                \ ]
endif

" This function is used for the 'omnifunc' option.
function! sqlcomplete#Complete(findstart, base)

    " Default to table name completion
    let compl_type = 'table'
    " Allow maps to specify what type of object completion they want
    if exists('b:sql_compl_type')
        let compl_type = b:sql_compl_type
    endif

    " First pass through this function determines how much of the line should
    " be replaced by whatever is chosen from the completion list
    if a:findstart
        " Locate the start of the item, including "."
        let line = getline('.')
        let start = col('.') - 1
        let lastword = -1
        while start > 0
            if line[start - 1] =~ '\w'
                let start -= 1
            elseif line[start - 1] =~ '\.' && compl_type =~ 'column'
                " If the completion type is column then assume we are looking
                " for column completion column_type can be either 
                " 'column' or 'column_csv'
                if lastword == -1 && compl_type == 'column'
                    " Do not replace the table name prefix or alias
                    " if completing only a single column name
                    let lastword = start
                endif
                let start -= 1
            else
                break
            endif
        endwhile

        " Return the column of the last word, which is going to be changed.
        " Remember the text that comes before it in s:prepended.
        if lastword == -1
            let s:prepended = ''
            return start
        endif
        let s:prepended = strpart(line, start, lastword - start)
        return lastword
    endif

    " Second pass through this function will determine what data to put inside
    " of the completion list
    " s:prepended is set by the first pass
    let base = s:prepended . a:base

    " Default the completion list to an empty list
    let compl_list = []

    " Default to table name completion
    let compl_type = 'table'
    " Allow maps to specify what type of object completion they want
    if exists('b:sql_compl_type')
        let compl_type = b:sql_compl_type
        unlet b:sql_compl_type
    endif

    if compl_type == 'tableReset'
        let compl_type = 'table'
        let base = ''
    endif

    if compl_type == 'table' ||
                \ compl_type == 'procedure' ||
                \ compl_type == 'view' 

        " This type of completion relies upon the dbext.vim plugin
        if s:SQLCCheck4dbext() == -1
            return []
        endif

        if s:sql_file_{compl_type} == ""
            let compl_type = substitute(compl_type, '\w\+', '\u&', '')
            let s:sql_file_{compl_type} = DB_getDictionaryName(compl_type)
        endif
        let s:sql_file_{compl_type} = DB_getDictionaryName(compl_type)
        if s:sql_file_{compl_type} != ""
            if filereadable(s:sql_file_{compl_type})
                let compl_list = readfile(s:sql_file_{compl_type})
            endif
        endif
    elseif compl_type == 'column'

        " This type of completion relies upon the dbext.vim plugin
        if s:SQLCCheck4dbext() == -1
            return []
        endif

        if base == ""
            " The last time we displayed a column list we stored
            " the table name.  If the user selects a column list 
            " without a table name of alias present, assume they want
            " the previous column list displayed.
            let base = s:save_prev_table
        endif

        if base != ""
            let compl_list        = s:SQLCGetColumns(base, '')
            let s:save_prev_table = base
            let base              = ''
        endif
    elseif compl_type == 'column_csv'

        " This type of completion relies upon the dbext.vim plugin
        if s:SQLCCheck4dbext() == -1
            return []
        endif

        if base == ""
            " The last time we displayed a column list we stored
            " the table name.  If the user selects a column list 
            " without a table name of alias present, assume they want
            " the previous column list displayed.
            let base = s:save_prev_table
        endif

        if base != ""
            let compl_list        = s:SQLCGetColumns(base, 'csv')
            let s:save_prev_table = base
            " Join the column array into 1 single element array
            " but make the columns column separated
            let compl_list        = [join(compl_list, ', ')]
            let base              = ''
        endif
    elseif compl_type == 'resetCache'
        " Reset all cached items
        let s:tbl_name  = []
        let s:tbl_alias = []
        let s:tbl_cols  = []
        let s:syn_list  = []
        let s:syn_value = []
    else
        let compl_list = s:SQLCGetSyntaxList(compl_type)
    endif

    if base != ''
        " Filter the list based on the first few characters the user
        " entered
        let expr = 'v:val =~ "^'.base.'"'
        let compl_list = filter(copy(compl_list), expr)
    endif

    if exists('b:sql_compl_savefunc') && b:sql_compl_savefunc != ""
        let &omnifunc = b:sql_compl_savefunc
    endif

    return compl_list
endfunc

function! s:SQLCWarningMsg(msg)
    echohl WarningMsg
    echomsg a:msg 
    echohl None
endfunction
      
function! s:SQLCErrorMsg(msg)
    echohl ErrorMsg
    echomsg a:msg 
    echohl None
endfunction
      
function! sqlcomplete#PreCacheSyntax(...)
    let syn_group_arr = []
    if a:0 > 0 
        let syn_group_arr = a:1
    else
        let syn_group_arr = g:omni_sql_precache_syntax_groups
    endif
    if !empty(syn_group_arr)
        for group_name in syn_group_arr
            call s:SQLCGetSyntaxList(group_name)
        endfor
    endif
endfunction

function! sqlcomplete#Map(type)
    " Tell the SQL plugin what you want to complete
    let b:sql_compl_type=a:type
    " Record previous omnifunc, if the SQL completion
    " is being used in conjunction with other filetype
    " completion plugins
    if &omnifunc != "" && &omnifunc != 'sqlcomplete#Complete'
        " Record the previous omnifunc, the plugin
        " will automatically set this back so that it
        " does not interfere with other ftplugins settings
        let b:sql_compl_savefunc=&omnifunc
    endif
    " Set the OMNI func for the SQL completion plugin
    let &omnifunc='sqlcomplete#Complete'
endfunction

function! s:SQLCGetSyntaxList(syn_group)
    let syn_group  = a:syn_group
    let compl_list = []

    " Check if we have already cached the syntax list
    let list_idx = index(s:syn_list, syn_group, 0, &ignorecase)
    if list_idx > -1
        " Return previously cached value
        let compl_list = s:syn_value[list_idx]
    else
        " Request the syntax list items from the 
        " syntax completion plugin
        if syn_group == 'syntax'
            " Handle this special case.  This allows the user
            " to indicate they want all the syntax items available,
            " so do not specify a specific include list.
            let g:omni_syntax_group_include_sql = ''
        else
            " The user has specified a specific syntax group
            let g:omni_syntax_group_include_sql = syn_group
        endif
        let g:omni_syntax_group_exclude_sql = ''
        let syn_value                       = OmniSyntaxList()
        let g:omni_syntax_group_include_sql = s:save_inc
        let g:omni_syntax_group_exclude_sql = s:save_exc
        " Cache these values for later use
        let s:syn_list  = add( s:syn_list,  syn_group )
        let s:syn_value = add( s:syn_value, syn_value )
        let compl_list  = syn_value
    endif

    return compl_list
endfunction

function! s:SQLCCheck4dbext()
    if !exists('g:loaded_dbext')
        let msg = "The dbext plugin must be loaded for dynamic SQL completion"
        call s:SQLCErrorMsg(msg)
        " Leave time for the user to read the error message
        :sleep 2
        return -1
    elseif g:loaded_dbext < 210
        let msg = "The dbext plugin must be at least version 2.10 " .
                    \ " for dynamic SQL completion"
        call s:SQLCErrorMsg(msg)
        " Leave time for the user to read the error message
        :sleep 2
        return -1
    endif
    return 1
endfunction

function! s:SQLCAddAlias(table_name, table_alias, cols)
    let table_name  = a:table_name
    let table_alias = a:table_alias
    let cols        = a:cols

    if g:omni_sql_use_tbl_alias != 'n' 
        if table_alias == ''
            if 'da' =~? g:omni_sql_use_tbl_alias
                if table_name =~ '_'
                    " Treat _ as separators since people often use these
                    " for word separators
                    let save_keyword = &iskeyword
                    setlocal iskeyword-=_

                    " Get the first letter of each word
                    " [[:alpha:]] is used instead of \w 
                    " to catch extended accented characters
                    "
                    let table_alias = substitute( 
                                \ table_name, 
                                \ '\<[[:alpha:]]\+\>_\?', 
                                \ '\=strpart(submatch(0), 0, 1)', 
                                \ 'g'
                                \ )
                    " Restore original value
                    let &iskeyword = save_keyword
                elseif table_name =~ '\u\U'
                    let initials = substitute(
                                \ table_name, '\(\u\)\U*', '\1', 'g')
                else
                    let table_alias = strpart(table_name, 0, 1)
                endif
            endif
        endif
        if table_alias != ''
            " Following a word character, make sure there is a . and no spaces
            let table_alias = substitute(table_alias, '\w\zs\.\?\s*$', '.', '')
            if 'a' =~? g:omni_sql_use_tbl_alias && a:table_alias == ''
                let table_alias = inputdialog("Enter table alias:", table_alias)
            endif
        endif
        if table_alias != ''
            let cols = substitute(cols, '\<\w', table_alias.'&', 'g')
        endif
    endif

    return cols
endfunction

function! s:SQLCGetColumns(table_name, list_type)
    let table_name   = matchstr(a:table_name, '^\w\+')
    let table_cols   = []
    let table_alias  = ''
    let move_to_top  = 1

    if g:loaded_dbext >= 210
        let saveSettingAlias = DB_listOption('use_tbl_alias')
        exec 'DBSetOption use_tbl_alias=n'
    endif

    " Check if we have already cached the column list for this table
    " by its name
    let list_idx = index(s:tbl_name, table_name, 0, &ignorecase)
    if list_idx > -1
        let table_cols = split(s:tbl_cols[list_idx])
    else
        " Check if we have already cached the column list for this table 
        " by its alias, assuming the table_name provided was actually
        " the alias for the table instead
        "     select *
        "       from area a
        "      where a.
        let list_idx = index(s:tbl_alias, table_name, 0, &ignorecase)
        if list_idx > -1
            let table_alias = table_name
            let table_name  = s:tbl_name[list_idx]
            let table_cols  = split(s:tbl_cols[list_idx])
        endif
    endif

    " If we have not found a cached copy of the table
    " And the table ends in a "." or we are looking for a column list
    " if list_idx == -1 && (a:table_name =~ '\.' || b:sql_compl_type =~ 'column')
    " if list_idx == -1 && (a:table_name =~ '\.' || a:list_type =~ 'csv')
    if list_idx == -1 
         let saveY      = @y
         let saveSearch = @/
         let saveWScan  = &wrapscan
         let curline    = line(".")
         let curcol     = col(".")

         " Do not let searchs wrap
         setlocal nowrapscan
         " If . was entered, look at the word just before the .
         " We are looking for something like this:
         "    select * 
         "      from customer c
         "     where c.
         " So when . is pressed, we need to find 'c'
         "

         " Search backwards to the beginning of the statement
         " and do NOT wrap
         " exec 'silent! normal! v?\<\(select\|update\|delete\|;\)\>'."\n".'"yy'
         exec 'silent! normal! ?\<\(select\|update\|delete\|;\)\>'."\n"

         " Start characterwise visual mode
         " Advance right one character
         " Search foward until one of the following:
         "     1.  Another select/update/delete statement
         "     2.  A ; at the end of a line (the delimiter)
         "     3.  The end of the file (incase no delimiter)
         " Yank the visually selected text into the "y register.
         exec 'silent! normal! vl/\(\<select\>\|\<update\>\|\<delete\>\|;\s*$\|\%$\)'."\n".'"yy'

         let query = @y
         let query = substitute(query, "\n", ' ', 'g')
         let found = 0

         " if query =~? '^\(select\|update\|delete\)'
         if query =~? '^\(select\)'
             let found = 1
             "  \(\(\<\w\+\>\)\.\)\?   - 
             " 'from.\{-}'  - Starting at the from clause
             " '\zs\(\(\<\w\+\>\)\.\)\?' - Get the owner name (optional)
             " '\<\w\+\>\ze' - Get the table name 
             " '\s\+\<'.table_name.'\>' - Followed by the alias
             " '\s*\.\@!.*'  - Cannot be followed by a .
             " '\(\<where\>\|$\)' - Must be followed by a WHERE clause
             " '.*'  - Exclude the rest of the line in the match
             let table_name_new = matchstr(@y, 
                         \ 'from.\{-}'.
                         \ '\zs\(\(\<\w\+\>\)\.\)\?'.
                         \ '\<\w\+\>\ze'.
                         \ '\s\+\%(as\s\+\)\?\<'.table_name.'\>'.
                         \ '\s*\.\@!.*'.
                         \ '\(\<where\>\|$\)'.
                         \ '.*'
                         \ )
             if table_name_new != ''
                 let table_alias = table_name
                 let table_name  = table_name_new

                 let list_idx = index(s:tbl_name, table_name, 0, &ignorecase)
                 if list_idx > -1
                     let table_cols  = split(s:tbl_cols[list_idx])
                     let s:tbl_name[list_idx]  = table_name
                     let s:tbl_alias[list_idx] = table_alias
                 else
                     let list_idx = index(s:tbl_alias, table_name, 0, &ignorecase)
                     if list_idx > -1
                         let table_cols = split(s:tbl_cols[list_idx])
                         let s:tbl_name[list_idx]  = table_name
                         let s:tbl_alias[list_idx] = table_alias
                     endif
                 endif

             endif
         else
             " Simply assume it is a table name provided with a . on the end
             let found = 1
         endif

         let @y        = saveY
         let @/        = saveSearch
         let &wrapscan = saveWScan

         " Return to previous location
         call cursor(curline, curcol)
         
         if found == 0
             if g:loaded_dbext > 201
                 exec 'DBSetOption use_tbl_alias='.saveSettingAlias
             endif

             " Not a SQL statement, do not display a list
             return []
         endif
    endif 

    if empty(table_cols)
        " Specify silent mode, no messages to the user (tbl, 1)
        " Specify do not comma separate (tbl, 1, 1)
        let table_cols_str = DB_getListColumn(table_name, 1, 1)

        if table_cols_str != ""
            let s:tbl_name  = add( s:tbl_name,  table_name )
            let s:tbl_alias = add( s:tbl_alias, table_alias )
            let s:tbl_cols  = add( s:tbl_cols,  table_cols_str )
            let table_cols  = split(table_cols_str)
        endif

    endif

    if g:loaded_dbext > 201
        exec 'DBSetOption use_tbl_alias='.saveSettingAlias
    endif

    if a:list_type == 'csv' && !empty(table_cols)
        let cols = join(table_cols, ', ')
        let cols = s:SQLCAddAlias(table_name, table_alias, cols)
        let table_cols = [cols]
    endif

    return table_cols
endfunction

