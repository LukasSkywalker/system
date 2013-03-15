require 'test/unit'
require_relative '../../MDCtoFSParser/adapter'
require_relative '../../MDCtoFSParser/parser'
require 'minitest/reporters'
MiniTest::Reporters.use!

class ParserTest < Test::Unit::TestCase
   def test_count
     adapter = Adapter.new("mdc","mdcCodeToFSCode","pse4.iam.unibe.ch", 27017)
     parser = Parser.new ("data.csv")
     assert_equal(68, parser.parse_documents.size, "Wrong amount of data")
   end
end