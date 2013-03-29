require 'mongo'
include Mongo

class Adapter
  attr_accessor :mongo_client, :db, :coll
  def initialize (db , collection ,host, port)
    mongo_client = MongoClient.new(host, port)
    puts 'Enter your PW for the account pse4_write: '
    mongo_client.db('admin').authenticate('pse4_write',gets.chomp)
    db = mongo_client.db(db)
    self.coll = db.collection(collection)
  end

  def get_entries ()
    self.coll.find().to_a
  end

end

