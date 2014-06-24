set et
set sw=2
set ts=2

call IMAP('""', "\"<++>\"", 'lua')
call IMAP("''", "'<++>'", 'lua')
call IMAP('()', "\(<++>\)", 'lua')
call IMAP('[]', "\[<++>\]", 'lua')
call IMAP('{}', "\{<++>\}", 'lua')
