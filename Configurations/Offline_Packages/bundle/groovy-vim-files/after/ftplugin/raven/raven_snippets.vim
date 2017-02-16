set et
set sw=2
set ts=2

" Raven
call IMAP('##', '%(<++>)s', 'raven')
call IMAP('""', "\"<++>\"", 'raven')
call IMAP("''", "'<++>'", 'raven')
call IMAP('()', "\( <++> \)", 'raven')
call IMAP('[]', "\[ <++> \]", 'raven')
call IMAP('{}', "\{ <++> \}", 'raven')
