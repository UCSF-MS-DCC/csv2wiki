
require 'csv'

csvfilename = ARGV[0]
outfilename = ARGV[1]

datafile = File.read(csvfilename)
csv = CSV.parse(File.read(csvfilename.to_s), :headers => true)

File.open(outfilename,"a+") do |out|
   out.write("{| class='wikitable'\n")
   wikitablehead = ""
   firsthead = true
   csv.headers.each do |col_head|
      head_delimiter = firsthead == true ? "!" : "!!"
      firsthead = false
      headval = (["",nil].include? col_head.to_s) ? " " : col_head.to_s
      wikitablehead += "#{head_delimiter}#{headval}"
   end
   out.write("#{wikitablehead}\n")
   csv.each do |row|
      wikirow = "|"
      firstcell = true
#puts row
      row.each do |k,v|
         cell_delimiter = firstcell == true ? "" : "||"
         firstcell = false
         val = (["",nil].include? v.to_s) ? " " : v.to_s
         wikirow += "#{cell_delimiter}#{val}"
      end
      out.write("|- \n#{wikirow}\n")
   end
   out.write("|}")
end
