require 'ip2location_ruby'
require 'csv'
require "ipaddress"


i2l = Ip2location.new.open("IP2LOCATION-LITE-DB11.BIN")

CSV.open("output.csv", "wb",:write_headers=> true,:headers => ["id","ip","countryCode","countryCode","regionName","cityName","latitude","longitude"] ) do |output|
	CSV.foreach("data/data.csv", headers:true) do |row|
	   if IPAddress.valid? row[1] 
	   		record = i2l.get_all(row[1])
	   		output << [row[0],row[1],record.country_short,record.country_long,record.region,record.city,record.latitude,record.longitude]
	   else
	   		output << [row[0]]
	   	end
	end
end



