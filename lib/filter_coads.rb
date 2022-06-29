require_relative 'icoads'
require 'yaml'
require 'fileutils'

class FilterCOADS
  def year=(args)
    @year=[args].flatten
  end
  def year
    @year||=check_files
  end
  def src_dir=(src_dir)
    @src_dir=src_dir
  end
  def check_files
    Dir.chdir(@src_dir) do
      @year=Dir.glob("[0-9][0-9][0-9][0-9].yml").sort.map do |f|
        File.basename(f,".yml")
      end
    end
  end

  def concat(opt={})
    opt = {}.merge (opt)
    data = []
    year.each do |yr|
      if block_given?
        concat_file(yr,data,&Proc.new)
      else
        concat_file(yr,data)
      end 
    end
    data
  end
private
  def concat_file(yr,data)
    fnam = File.join(@src_dir,yr)+".yml"
    puts "Processing #{fnam}"
    YAML::load(File.open(fnam)).each do |hsh|
      hsh = hsh.to_icdata
      hsh =  yield(hsh) if block_given?
      data << hsh unless hsh.empty?
    end
  end
end

class Hash
  def to_icdata
    return ICDATA[self.to_a]
  end
end
