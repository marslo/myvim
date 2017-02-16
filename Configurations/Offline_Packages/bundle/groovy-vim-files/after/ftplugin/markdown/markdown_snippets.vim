call IMAP('""', "\"<++>\"", 'markdown')
call IMAP("''", "'<++>'", 'markdown')
call IMAP('()', "\(<++>\)", 'markdown')
call IMAP('[]', "\[<++>\]", 'markdown')
call IMAP('{}', "\{<++>\}", 'markdown')
call IMAP('as-', "As a <++> I want to <++> so I can <++>.", 'markdown')

" Global imaps.
call IMAP(',,', "`<++>`", '')
