require_relative 'adapter'
require_relative 'parser'

host = 'pse4.iam.unibe.ch'
port = 27017
db = 'chop_2013_ch'


puts "connecting..."
parser = Parser.new('../chop_related_drg.csv')
de_read_adapter = Adapter.new(db,'de',host, port, false)
de_write_adapter = Adapter.new(db,'test_coll',host, port, true)
chop_entries = de_read_adapter.get_entries
chop_drg_assocs = parser.read_assocs
results = []
chop_drg_assocs.each do |assoc|
  puts assoc['chop']

    found_entries = chop_entries.select{|entry|
      entry['code'].eql? assoc['chop']
    }
    unless found_entries[0].nil?
      found_entries[0]['drgs']<<assoc['drg']
    end
end
puts 'inserting...'
chop_entries.each do |entry|
  de_write_adapter.insert(entry)
end

