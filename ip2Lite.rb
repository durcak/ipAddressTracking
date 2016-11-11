require 'csv'
require "ipaddress"


CSV.open("output_rtt.csv", "wb",:write_headers=> true,:headers => ["id","ip","countryName","countryIsoCode","cityName","latitude","longitude"] ) do |output|
	CSV.foreach("data_simple.csv", headers:true) do |row|
	   if IPAddress.valid? row[1] 
	   		response_time = `ping -c 1 #{response_time} | tail -1| awk '{print $4}' | cut -d '/' -f 2`
	   		if ret > 0
	   			output << [row[0],row[1],response_time]
	   		else
	   			output << [row[0],row[1],'no_response']
	   		end
	   else
	   		output << [row[0]]
	   	end
	end
end

print "Hello, World!\n"

response_time = `ping -c 1 147.251.171.86 | tail -1| awk '{print $4}' | cut -d '/' -f 2`

puts response_time
