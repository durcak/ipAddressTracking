#!/usr/bin/ruby

require 'csv'
require "ipaddress"
require 'maxminddb'
require 'ip2location_ruby'


mm = MaxMindDB.new('./database/GeoLite2-Country.mmdb')
i2l = Ip2location.new.open("../database/IP2LOCATION-LITE-DB11.BIN")

CSV.open("output_compare_code.csv", "wb",:write_headers=> true,:headers => ["id","ip","countryCode1","countryCode2","countryIsoCode_maxmind","countryIsoCode_ip2lite"] ) do |output|
	CSV.foreach("data/data.csv", headers:true) do |row|
	   if IPAddress.valid? row[1] 
	   		ret = mm.lookup(row[1])
	   		record = i2l.get_all(row[1])
	   		output << [row[0],row[1],row[2],row[3],ret.country.iso_code,record.country_short]
	   else
	   		output << [row[0]]
	   	end
	end
end

#[Finished in 1318.0s] [Finished in 923.9s]