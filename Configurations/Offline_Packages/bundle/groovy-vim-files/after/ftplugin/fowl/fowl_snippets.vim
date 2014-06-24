set et
set sw=2
set ts=2

" Raven
call IMAP('##', '%(<++>)s', 'fowl')
call IMAP('""', "\"<++>\"", 'fowl')
call IMAP("''", "'<++>'", 'fowl')
call IMAP('()', "\(<++>\)", 'fowl')
call IMAP('[]', "\[<++>\]", 'fowl')
call IMAP('{}', "\{<++>\}", 'fowl')
