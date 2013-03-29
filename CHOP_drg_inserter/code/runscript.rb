require_relative 'adapter'
require_relative 'parser'

host = 'pse4.iam.unibe.ch'
port = 27017
db = 'chop_2013_ch'


puts "connecting..."
parser = Parser.new('../chop_related_drg.csv')
de_read_adapter = Adapter.new(db,'de',host, port)
#{de_read_adapter = Adapter.new(db,'test_coll',host, port)}
puts de_read_adapter.get_entries
puts parser.get_lines