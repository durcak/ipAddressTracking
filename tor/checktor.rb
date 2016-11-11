require 'rubygems'
require 'tor'
require 'csv'
require "ipaddress"

Tor::DNSEL.include?("208.75.57.100")               #=> true

CSV.open("output_simple.csv", "wb",:write_headers=> true,:headers => ["id","ip","tor"] ) do |output|
	CSV.foreach("data/data_simple.csv", headers:true) do |row|
	   if IPAddress.valid? row[1] 	   			   		
	   		output << [row[0], row[1], Tor::DNSEL.include?(row[1])]
	   else
	   		output << [row[0]]
	   	end
	end
end