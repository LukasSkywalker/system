require_relative 'adapter'
require_relative 'parser'

host = 'pse4.iam.unibe.ch'
port = 27017
db = 'ICDRangeFSH'


puts "parsing"
parser = Parser.new('../ranges.csv')
docs = parser.parse_ranges
puts "connecting..."
write_adapter = Adapter.new('ICDRangeFSH','mappings',host, port, true)
puts "removing..."
write_adapter.drop_collection
puts "inserting..."
docs.each do |doc|
  write_adapter.insert(doc)
end


