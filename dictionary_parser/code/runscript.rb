require_relative 'adapter'
require_relative 'parser'

host = 'pse4.iam.unibe.ch'
port = 27017
db = 'dictionaries'


puts "parsing"
parser = Parser.new('../chop_keywords.csv')
docs = parser.parse_ranges
puts "connecting..."
write_adapter = Adapter.new(db,'chop_dictionary',host, port, true)
puts "removing..."
write_adapter.drop_collection
puts "inserting..."
docs.each do |doc|
  write_adapter.insert(doc)
end


