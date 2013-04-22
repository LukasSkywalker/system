require_relative 'adapter'

host = 'pse4.iam.unibe.ch'
port = 27017
db = 'doctors'
coll = 'doctors'

keywords = {'thora' => 'thoraxchirurgen', 'neuroch' => 'neurochirurgen'}


read_adapter = Adapter.new(db,coll,host, port, false)
write_adapter = Adapter.new(db,coll,host, port, true)

keywords.each_key do |key|
  read_adapter.get_matches(key).each do |doc|
    doc['docfield'] = keywords[key]
    doc.delete('_id')
    write_adapter.insert(doc)
  end
end


