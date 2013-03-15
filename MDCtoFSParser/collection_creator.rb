
require_relative 'adapter'
require_relative 'parser'

adapter = Adapter.new
parser = Parser.new
puts parser.parse_documents
