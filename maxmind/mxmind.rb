require 'csv'
require "ipaddress"
require 'maxminddb'


db = MaxMindDB.new('./database/GeoLite2-Country.mmdb')

CSV.open("output_Country.csv", "wb",:write_headers=> true,:headers => ["id","ip","countryName","countryIsoCode","cityName","latitude","longitude"] ) do |output|
	CSV.foreach("data/data.csv", headers:true) do |row|
	   if IPAddress.valid? row[1] 
	   		ret = db.lookup(row[1])
	   		if ret.found? # => true
	   			output << [row[0],row[1],ret.country.name,ret.country.iso_code,ret.city.name(:fr),ret.location.latitude,ret.location.longitude]
	   		else
	   			output << [row[0]]
	   		end
	   else
	   		output << [row[0]]
	   	end
	end
end
# [Finished in 436.0s]
# [Finished in 419.4s]