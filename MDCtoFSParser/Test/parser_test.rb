require 'test/unit'
require_relative '../../MDCtoFSParser/adapter'
require_relative '../../MDCtoFSParser/parser'
class ParserTest < Test::Unit::TestCase
   def check_count
     adapter = Adapter.new
     parser = Parser.new
     assert_equal(68, parser.parse_documents.size, "Your program sucks")
   end
end