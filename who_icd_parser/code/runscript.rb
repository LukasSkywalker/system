require_relative 'who_fileparser'
require_relative 'dimdi_web_parser'

parser = WhoFileparser.new('../Who_sourcecode.txt', '../icdranges_who.csv')
parser.parse
puts "parsed source file"
parser = DimdiWebParser.new('../icdranges_icdGM.csv')
parser.parse
puts "parsed website"