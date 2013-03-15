
require_relative 'adapter'
require_relative 'parser'

host = 'pse4.iam.unibe.ch'
port = 27017
collection = 'mdcCodeToFSCode'
db = 'mdc'


puts "connecting..."
adapter = Adapter.new(db,collection,host, port)
puts "connected to collection '#{collection}' in database '#{db}' on host '#{host}' port '#{port}'"
adapter.drop_documents()
puts "dropped all documents in collection"
parser = Parser.new ('data.csv')
puts "parsed input data, saving to db..."
documents = parser.parse_documents
documents.each {|doc|
    adapter.save_document(doc)}
puts "Success! #{documents.size} documents inserted"
