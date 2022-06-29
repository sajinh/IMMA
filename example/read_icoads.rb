require_relative "../lib/icoads"
require 'pp'
require 'yaml'
require 'fileutils'


year=1880
icd=ICOADS.new
#icd.input=fname  # pass a filename if you want to read one single file
icd.year=year   # pass a year if you want to read data for the whole year
icd.src_dir=File.join("./data/raw",year.to_s)
icd.c0 = c0
icd.c1 = c1

vars = ["sst"]  # add a list of variables that you want to read
                # see imma_tables.rb for available variables
data = icd.read(#stop_at:1000,
                    get: vars,
              with_time:{unit:'day',ref:[1600,1,1]}) { 

              |d| d > [lat:-10.0..-5] > [lon:100.0..130]
          }                     
                         # the > operators are pipe operators
                         # they help to filter data
		           # e.g. [lat:-10.0..-5] is an argument
		           # of the pipe operator that
		           # that filters out data between 10S and 5S.

FileUtils.mkdir_p("./data/processed/#{year}/YML")
fout = File.open("./data/processed/#{year}/YML/#{year}.yml","w")
fout.puts data.to_yaml
fout.close
