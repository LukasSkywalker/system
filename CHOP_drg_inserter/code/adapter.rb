require 'mongo'
include Mongo

class Adapter
  attr_accessor :mongo_client, :db, :coll, :write
  def initialize (db , collection ,host, port, write)
    mongo_client = MongoClient.new(host, port)
    self.write = write
    if write
      puts 'Enter your PW for the account pse4_write: '
      mongo_client.db('admin').authenticate('pse4_write',gets.chomp)
    else
      mongo_client.db('admin').authenticate('pse4_read','plokij')
    end
    db = mongo_client.db(db)
    self.coll = db.collection(collection)
  end

  def get_entries
    results = []
    puts self.coll.find().count
    self.coll.find().each do |doc|
      doc.delete('_id')
      doc['drgs'] = []
      results << doc
    end
    results
  end

  def drop_collection
    self.coll.remove()
  end

  def get_percentage
    ((self.coll.find().count()/14789.0)*100.0).to_s+'%'
  end

  def insert(doc)
    return :no_permission unless self.write
    self.coll.insert(doc)
  end

end

