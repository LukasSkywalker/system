class Adapter

  require 'mongo'
  include Mongo

  attr_accessor :mongo_client, :db, :coll
  def initialize (db , collection ,host, port)
    mongo_client = MongoClient.new(host, port)
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

