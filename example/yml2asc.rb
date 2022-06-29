require_relative '../lib/filter_coads.rb'

year = 1880
FileUtils.mkdir_p("./data/processed/#{year}/ASC")
fcd = FilterCOADS.new
fcd.src_dir="./data/processed/#{year}/YML"
puts fcd.check_files
arr = fcd.concat { |d| d >  [sst:10..40] }
months=1..12
months.each do |mon|
  data = []
  fnam = "./data/processed/#{year}/ASC/out.#{"%02d" % mon}"
  puts "Writing #{fnam}"
  fout = File.open(fnam,"w")
  arr.each do |v|
    data << [v["sst"][0],v[:lat][0],v[:lon][0],v[:time]].join(",") if v[:mo][0] == mon
  end
  fout.puts data
  fout.close
end
