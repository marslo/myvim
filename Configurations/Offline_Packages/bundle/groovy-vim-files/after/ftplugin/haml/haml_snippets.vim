" set noet
set sw=2
set ts=2

" Ruby
call IMAP('##', '#{<++>}', 'haml')
call IMAP('do-', "do |<++>|\n  <++>\r", 'haml')
call IMAP('{-', "{ |<++>| <++> }", 'haml')
call IMAP('""', "\"<++>\"", 'haml')
call IMAP("''", "'<++>'", 'haml')
call IMAP('||', "\|<++>\|", 'haml')
call IMAP('()', "\(<++>\)", 'haml')
call IMAP('[]', "\[<++>\]", 'haml')
call IMAP('{}', "\{<++>\}", 'haml')

" HTML
call IMAP('h1-', '%h1=', 'haml')
call IMAP('h2-', '%h2=', 'haml')
call IMAP('h3-', '%h3=', 'haml')
call IMAP('div-', 'div_for :<++>', 'haml')
