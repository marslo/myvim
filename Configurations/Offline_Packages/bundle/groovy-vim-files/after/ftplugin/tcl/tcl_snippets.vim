set et
set sw=2
set ts=2

call IMAP('""', "\"<++>\"", 'tcl')
call IMAP("''", "'<++>'", 'tcl')
call IMAP('()', "\(<++>\)", 'tcl')
call IMAP('[]', "\[<++>\]", 'tcl')
call IMAP('{}', "\{<++>\}", 'tcl')
