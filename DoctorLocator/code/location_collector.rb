require_relative 'db_adapter'
require 'geocoder'

class LocationCollector
  def insert_data
    db = DbAdapter.new('doctors', 'doctors', 'pse4.iam.unibe.ch', '27017')
    docs = db.get_docs
    docs.each do |doc|
      address = doc['address']
      locations = Geocoder.search(address)
      loc = locations[0]
      id = doc['_id']
      db.insert_location(id, loc) unless loc.nil?
    end
  end
end