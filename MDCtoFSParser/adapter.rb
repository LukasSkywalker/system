class Adapter

  require 'mongo'
  include Mongo

  attr_accessor :mongo_client, :db, :coll
  def initialize
    mongo_client = MongoClient.new("pse4.iam.unibe.ch", 27017)
    db = mongo_client.db("mdc")
    coll = db.collection("mdcCodeToFSCode")
  end

  def insert_document( doc )
    coll.insert(doc)
  end


end

