#!/usr/bin/env ruby

require 'csv'

csvfilename = ARGV[0]
outfilename = ARGV[1]

data = File.read(csvfilename)
csv = CSV.parse(data, :headers => true)

puts csv.headers.length

File.open(outfilename,"a+") do |out|
   out.write("{| class='wikitable'\n")
   wikitablehead = ""
   firsthead = true
   csv.headers.each do |col_head|
      head_delimiter = firsthead == true ? "!" : "!!"
      firsthead = false
      wikitablehead += "#{head_delimiter}#{col_head}"
   end
   out.write("#{wikitablehead}\n")
   csv.each do |row|
      wikirow = "|"
      firstcell = true
      row.each do |k,v|
         cell_delimiter = firstcell == true ? "" : "||"
         firstcell = false
         val = (["",nil].include? v) ? " " : v
         wikirow += "#{cell_delimiter}#{val}"
      end
      out.write("|- \n#{wikirow}\n")
   end
   out.write("|}")
end
