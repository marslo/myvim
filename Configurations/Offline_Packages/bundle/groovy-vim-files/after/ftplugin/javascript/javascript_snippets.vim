set et
set sw=2
set ts=2

call IMAP('""', "\"<++>\"", 'javascript')
call IMAP("''", "'<++>'", 'javascript')
call IMAP('()', "\(<++>\)", 'javascript')
call IMAP('[]', "\[<++>\]", 'javascript')
call IMAP('{}', "\{<++>\}", 'javascript')
call IMAP('$$', "\$\(<++>\)", 'javascript')
call IMAP("log-", "console.log('<++>')", 'javascript')
