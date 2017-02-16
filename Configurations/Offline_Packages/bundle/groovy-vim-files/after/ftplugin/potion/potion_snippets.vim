set et
set sw=2
set ts=2

" Potion
call IMAP('""', "\"<++>\"", 'potion')
call IMAP("''", "'<++>'", 'potion')
call IMAP('||', "\|<++>\|", 'potion')
call IMAP('()', "\(<++>\)", 'potion')
call IMAP('[]', "\[<++>\]", 'potion')
call IMAP('{}', "\{<++>\}", 'potion')
call IMAP('%%', "%\(<++>\)s", 'potion')
