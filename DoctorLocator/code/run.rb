require_relative 'location_collector'

Geocoder.configure(

    # geocoding service (see below for supported options):
    :lookup => :bing,

    # to use an API key:
    :api_key => 'As5IoO4njYNOj5SGEOgoWWOPDLTE9OvR7SDDNgdwjEykB8HjE5DjdsTJNe-dehlT',

    # geocoding service request timeout, in seconds (default 3):
    :timeout => 10,

    # set default units to kilometers:
    :units => :km,
)


locator = LocationCollector.new
locator.insert_data