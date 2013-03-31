require 'mongo'

class DbAdapter
  attr_accessor :mongo_client, :db, :coll

  def initialize (host, port)
    @con = Mongo::MongoClient.new(host, port, :pool_size => 20, :pool_timeout => 10)
    db = @con.db('admin')
    puts 'Enter password for db:'
    pw = gets.chomp
    db.authenticate('pse4_write', pw)
  end

  def get_icd_fs_rel
    @con['relationFSZuICD']['relationFSZuICD'].find('by_seq_match' => { '$exists' => 0 })
  end

  def get_icds
    @con['icd_2012_ch']['de'].find({},{:fields => {'_id'=> 0, 'code' => 1, 'text' => 1, 'synonyms' => 1}}).to_a
  end

  def get_fmhs
    @con['fachgebieteUndSpezialisierungen']['fachgebieteUndSpezialisierungen'].find({},{:fields => {'_id'=> 0, 'code' => 1, 'de' => 1}}).to_a
  end

  def insert_updated_rel(id, score)
    rel = @con['relationFSZuICD']['relationFSZuICD'].find_one({_id: id})
    rel['by_seq_match'] = score
    puts rel
    @con['relationFSZuICD']['relationFSZuICD'].update({'_id' => id}, rel )
  end
end