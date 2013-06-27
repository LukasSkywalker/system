require 'mongo'

class DbAdapter
  attr_accessor :mongo_client, :db, :coll
  def initialize (db , collection ,host, port)
    mongo_client = Mongo::Connection.new(host, port)
    self.db = mongo_client.db(db)
    self.coll = self.db.collection(collection)
  end

  def get_docs
    co = self.coll.find('long' => 0)
    puts co.count
    co.to_a
  end

  def insert_location(id, loc)
    doc = self.coll.find_one({_id: id})
    doc['long'] = loc.longitude
    doc['lat'] = loc.latitude
    puts doc
    puts "#{loc.longitude}, #{loc.latitude}"
    #self.coll.remove({_id: id})
    #self.coll.insert(doc)
    self.coll.update({'_id' => id}, doc )
  end

  #Adds a document to the collection this instance manages
  #@param doc: the document being added
  def save_document( doc )
    self.coll.insert(doc)
  end

  #Drops all documents in the collection
  def drop_documents
    self.coll.remove()
  end
end