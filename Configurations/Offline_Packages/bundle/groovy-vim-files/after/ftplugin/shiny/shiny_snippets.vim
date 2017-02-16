set et
set sw=2
set ts=2

" Shiny
call IMAP('""', "\"<++>\"", 'shiny')
call IMAP("''", "'<++>'", 'shiny')
call IMAP('||', "\|<++>\|", 'shiny')
call IMAP('()', "\(<++>\)", 'shiny')
call IMAP('[]', "\[<++>\]", 'shiny')
call IMAP('{}', "\{<++>\}", 'shiny')
call IMAP('%%', "%\(<++>\)s", 'shiny')
