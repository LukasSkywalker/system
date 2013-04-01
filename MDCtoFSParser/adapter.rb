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

