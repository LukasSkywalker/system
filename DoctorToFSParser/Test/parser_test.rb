require 'test/unit'
require_relative '../../DoctorToFSParser/adapter'
require_relative '../../DoctorToFSParser/parser'
require 'minitest/reporters'
MiniTest::Reporters.use!

class ParserTest < Test::Unit::TestCase
   def test_count
     parser = Parser.new ("data.csv")

     assert_equal(152, parser.parse_documents.size, "Wrong amount of data")
   end
end