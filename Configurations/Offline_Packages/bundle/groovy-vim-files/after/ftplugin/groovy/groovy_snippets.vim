set et
set sw=4
set ts=4

call IMAP('##', '#{<++>}', 'groovy')
call IMAP('def--', "def <++>\n<++>\nend", 'groovy')
call IMAP('do--', "do |<++>|\n<++>\nend", 'groovy')
call IMAP('{--', "{ |<++>| <++> }", 'groovy')
call IMAP('track--', "track \"<++>\"", 'groovy')
call IMAP('deb--', "debugger", 'groovy')
call IMAP('""', "\"<++>\"", 'groovy')
call IMAP("''", "'<++>'", 'groovy')
call IMAP('()', "\(<++>\)", 'groovy')
call IMAP('[]', "\[<++>\]", 'groovy')
call IMAP('{}', "\{<++>\}", 'groovy')
call IMAP('webtest--', "webtest(\"<++>\"){\n<++>\n}", 'groovy')
call IMAP('test--', "void test<++>(){\n<++>\n}", 'groovy')
call IMAP('save--', "save(flush: true)", 'groovy')
call IMAP('delete--', "executeUpdate(\"delete <++>\")", 'groovy')

" RDoc
call IMAP('nodoc--', '#:nodoc:', 'groovy')

" Erb
call IMAP('h1--', '<h1><++></h1>', 'egroovy')
call IMAP('h2--', '<h2><++></h2>', 'egroovy')
call IMAP('h3--', '<h3><++></h3>', 'egroovy')
call IMAP('div--', '<div><++></div>', 'egroovy')
call IMAP('%%', '<% <++> %>', 'egroovy')
call IMAP('%$', '<%= <++> %>', 'egroovy')

" Rails > Logger
call IMAP('log--', "logger.info \"[DEBUG-FLAG] <++>\"", 'groovy')
call IMAP('rdl', "RAILS_DEFAULT_LOGGER.fatal \"[DEBUG-FLAG] <++> #{<++>}\"", 'groovy')
call IMAP('puts--', "puts \"[DEBUG-FLAG] <++> #{<++>}\"", 'groovy')

" Rails > Migrations
call IMAP('ct--', "create_table :<++>, :force => true do |t|\n  <++>\r\bend", 'groovy')
call IMAP('tc--', 't.column :<++>, <++>', 'groovy')
call IMAP('ac--', 'add_column :<++>, <++>, <++>', 'groovy')
call IMAP('rc--', 'remove_column <++>, <++>', 'groovy')
call IMAP('dt--', 'drop_table :<++>', 'groovy')
call IMAP('ai--', 'add_index :<++>, <++>', 'groovy')
call IMAP('ri--', 'remove_index :<++>, <++>', 'groovy')

" Rails > Validations
call IMAP('vu--', "validates_uniqueness_of :<++>", 'groovy')

" Rails > Navigation
call IMAP('redi--', "redirect_to(<++>)", 'groovy')

" Quick samples
call IMAP('array--', "[1, 2, 3, 4, 5]", 'groovy')
call IMAP('hash--', '{ "a" => 1, "b" => 2, "c" => 3 }', 'groovy')

" Tests
call IMAP('Test--', "class Test<++> < Test::Unit::TestCase\n<++>\nend", 'groovy')
call IMAP('context--', "context \"<++>\" do\n<++>\nend", 'groovy')
call IMAP('should--', "should \"<++>\" do\n<++>\nend", 'groovy')
call IMAP('story--', "story \"<++>\", {\n<++>\n}", 'groovy')
call IMAP('scenario--', "scenario \"<++>\", {\n<++>\n}", 'groovy')
call IMAP('before--', "before {\n<++>\n}", 'groovy')
call IMAP('after--', "after {\n<++>\n}", 'groovy')

" Stories with Webrat
call IMAP('sop--', "save_and_open_page", 'groovy')

" Global imaps.
call IMAP(',,', "`<++>`", '')
