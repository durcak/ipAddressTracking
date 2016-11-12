#!/usr/bin/ruby

require 'csv'
require "ipaddress"
require 'maxminddb'
require 'ip2location_ruby'

emptysum = 0
ident = 0
diff = 0
#nullMaxmind = 0

CSV.foreach("output-kombinacia.csv", headers:true) do |row|
	if row[1] == nil
		emptysum += 1
	else
			if row[5].to_i.round(2) == row[10].to_i.round(2) # && row[6].to_i.round(2) == row[11].to_i.round(2)
				ident += 1
			else
				diff += 1
			end
	end
end
puts "Empty: #{emptysum}"
puts "Ident: #{ident}"
puts "Diff: #{diff}"
puts "SUMall: #{ident + emptysum+diff}"
puts "SUMnoEmpty: #{diff + ident}"
#puts nullMaxmind

wrong = 100.0*diff/(diff+ident)
good = 100.0*ident/(diff+ident)

puts "Good: #{good}"
puts "Wrong: #{wrong}"
puts good + wrong

# emptz 6065
# sim 613637
# diff 2707
# wrong 0.43920278286151887
# good  99.56079721713849


#[Finished in 1318.0s] [Finished in 923.9s]