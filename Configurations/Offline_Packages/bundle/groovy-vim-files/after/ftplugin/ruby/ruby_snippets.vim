set et
set sw=2
set ts=2

" Ruby
call IMAP('##', '#{<++>}', 'ruby')
call IMAP('def--', "def <++>\n<++>\nend", 'ruby')
call IMAP('do--', "do |<++>|\n<++>\nend", 'ruby')
call IMAP('{--', "{ |<++>| <++> }", 'ruby')
call IMAP('track--', "track \"<++>\"", 'ruby')
call IMAP('deb--', "debugger", 'ruby')
call IMAP('""', "\"<++>\"", 'ruby')
call IMAP("''", "'<++>'", 'ruby')
call IMAP('()', "\(<++>\)", 'ruby')
call IMAP('[]', "\[<++>\]", 'ruby')
call IMAP('{}', "\{<++>\}", 'ruby')

" RDoc
call IMAP('nodoc--', '#:nodoc:', 'ruby')

" Erb
call IMAP('h1--', '<h1><++></h1>', 'eruby')
call IMAP('h2--', '<h2><++></h2>', 'eruby')
call IMAP('h3--', '<h3><++></h3>', 'eruby')
call IMAP('div--', '<div><++></div>', 'eruby')
call IMAP('%%', '<% <++> %>', 'eruby')
call IMAP('%$', '<%= <++> %>', 'eruby')

" Rails > Logger
call IMAP('log--', "logger.info \"[DEBUG-FLAG] <++>\"", 'ruby')
call IMAP('rdl', "RAILS_DEFAULT_LOGGER.fatal \"[DEBUG-FLAG] <++> #{<++>}\"", 'ruby')
call IMAP('puts--', "puts \"[DEBUG-FLAG] <++> #{<++>}\"", 'ruby')

" Rails > Migrations
call IMAP('ct--', "create_table :<++>, :force => true do |t|\n  <++>\r\bend", 'ruby')
call IMAP('tc--', 't.column :<++>, <++>', 'ruby')
call IMAP('ac--', 'add_column :<++>, <++>, <++>', 'ruby')
call IMAP('rc--', 'remove_column <++>, <++>', 'ruby')
call IMAP('dt--', 'drop_table :<++>', 'ruby')
call IMAP('ai--', 'add_index :<++>, <++>', 'ruby')
call IMAP('ri--', 'remove_index :<++>, <++>', 'ruby')

" Rails > Validations
call IMAP('vu--', "validates_uniqueness_of :<++>", 'ruby')

" Rails > Navigation
call IMAP('redi--', "redirect_to(<++>)", 'ruby')

" Quick samples
call IMAP('array--', "[1, 2, 3, 4, 5]", 'ruby')
call IMAP('hash--', '{ "a" => 1, "b" => 2, "c" => 3 }', 'ruby')

" Tests
call IMAP('Test--', "class Test<++> < Test::Unit::TestCase\n<++>\nend", 'ruby')
call IMAP('context--', "context \"<++>\" do\n<++>\nend", 'ruby')
call IMAP('should--', "should \"<++>\" do\n<++>\nend", 'ruby')
call IMAP('story--', "story \"<++>\" do\n<++>\nend", 'ruby')
call IMAP('scenario--', "scenario \"<++>\" do\n<++>\nend", 'ruby')
call IMAP('setup--', "setup do\n<++>\nend", 'ruby')
call IMAP('teardown--', "teardown do\n<++>\nend", 'ruby')

" Stories with Webrat
call IMAP('sop--', "save_and_open_page", 'ruby')

" Global imaps.
call IMAP(',,', "`<++>`", '')
