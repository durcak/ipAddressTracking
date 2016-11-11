#!/usr/bin/env ruby

require 'csv'
require "ipaddress"
#require 'open-uri'
#require 'json'
	


@tor_list_file = "torsIpExits.csv"

@output_file = "output_tor.csv"
@output_file = ARGV[1] if ARGV[1]

@file_to_check = "data/data_simple.csv"
@file_to_check = ARGV[0] if ARGV[0]


def check_tor_list(tor_exits)
	puts "Data processing..."
	CSV.open(@output_file, "wb",:write_headers=> true,:headers => ["id","ip","tor"] ) do |output|
		CSV.foreach(@file_to_check, headers:true) do |row|
		   if IPAddress.valid? row[1]
		   		#@tor_exits = fetch_tor_exits #|| {}
		   		pom = tor_exits.include? row[1] 
		   		output << [row[0], row[1], pom]
		   else
		   		output << [row[0]]
		   	end
		end
	end
	puts "Results are saved in #{@output_file}"
end

def save_to_csv(filename, array)
	CSV.open(filename, 'wb') do |csv|
  		array.each do |ip|
  		 	csv << [ip] 
  		end
    end
end

def exist_file?(filename)
	File.file?(filename)
end

#  check age of torlist with ip adresses
def need_update?(filename)
	old =  File.mtime(filename)
	age = DateTime.now - (DateTime.parse old.to_s)
	return age >= 1
end

def fetch_tor_exits
  begin
  	  puts "Updating datafile with tor exits ..."
      check_url = 'https://www.dan.me.uk/torlist/'

      tor_exits = open(check_url).read.split("\n").select{|i| !(i =~ /^\#/)}
      save_to_csv(@tor_list_file, tor_exits)
      puts "List updated!"

      return tor_exits
  rescue OpenURI::HTTPError => e
    log_error "Error fetching list of tor exits (#{e})."
    puts "Data file could not be updated!"
    return nil
  end

  return tor_exits
end

def check(ip)
	@tor_exits.include? ip
end

def log_error(message)
    $stderr.puts "ERROR: #{message}"
end

def read_tors_exits
	if exist_file? @tor_list_file
		col_data = []
		CSV.foreach(@tor_list_file, headers:false) {|row| col_data << row[0]} 
		return col_data 
	else
		Kernel.abort("File #{@tor_list_file} could not be find or updated!")
	end
end

Kernel.abort("ERROR: File #{@file_to_check} could not be opened!") if !exist_file? @file_to_check

if !(exist_file? @tor_list_file) || (need_update? @tor_list_file)
	tor_exits = fetch_tor_exits
	if(tor_exits != nil)
		check_tor_list(tor_exits)
	else
		check_tor_list(read_tors_exits)
	end
else
	check_tor_list(read_tors_exits)
end

