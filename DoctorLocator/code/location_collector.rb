require_relative 'db_adapter'
require 'geocoder'

class LocationCollector
  def insert_data
    db = DbAdapter.new('orange-proton', 'doctors', 'localhost', '27017')
    docs = db.get_docs



    docs.each do |doc|

      address = doc['address']
      adr_parts = address.split(',')
      a = address#adr_parts[adr_parts.size-1].stripl#adr_parts[adr_parts.size-2].strip + ', ' + adr_parts[adr_parts.size-1].strip + ', Switzerland'

      puts a
      locations = Geocoder.search(a)
      loc = locations[0]
      if loc
        puts "Location #{loc.latitude}, #{loc.longitude} found for #{a}"
      else
        puts "No location found for #{a}"
      end
      id = doc['_id']
      db.insert_location(id, loc) unless loc.nil?
    end

  end
end