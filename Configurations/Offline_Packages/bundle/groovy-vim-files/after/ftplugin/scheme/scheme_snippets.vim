set et
set sw=2
set ts=2

" Scheme
call IMAP('##', '%(<++>)s', 'scheme')
call IMAP('""', "\"<++>\"", 'scheme')
call IMAP("''", "'<++>'", 'scheme')
call IMAP('()', "\(<++>\)<++>", 'scheme')
