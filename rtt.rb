require 'csv'
require "ipaddress"

=begin
CSV.open("output_rtt.csv", "wb",:write_headers=> true,:headers => ["id","ip","rtt"] ) do |output|
	CSV.foreach("data_simple.csv", headers:true) do |row|
	   if IPAddress.valid? row[1] 
	   		response_time = `ping -c 1 #{row[1]} | tail -1| awk '{print $4}' | cut -d '/' -f 2`
	   		if response_time != nil
	   			output << [row[0],row[1],response_time]
	   		else
	   			output << [row[0],row[1],'no_response']
	   		end
	   else
	   		output << [row[0]]
	   	end
	end
end
=end

print "Hello, World!\n"

response_time = `ping -c 1 147.251.171.86 | tail -1| awk '{print $4}' | cut -d '/' -f 2`

puts response_time
