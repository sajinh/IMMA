require 'date'
class ICOADS
  attr_accessor :c0, :c1

  def input=(fnam)
    @fnam=fnam
  end

  def year=(year)
    @year=year
  end
  def src_dir=(src_dir)
    @src_dir=src_dir
  end

  def read(opts={})
    opts = {progress: true}.merge! opts
    data=[]
    keys = opts[:get].clone
    keys = [keys] if keys.is_a? String
    keys =  !keys.empty? ? keys : c0.keys  # all keys if keys is not in opts
    keys << [:yr, :mo, :dy, :hr, :lat, :lon]
    keys.flatten!
    if @year
      src_dir=@src_dir||"./"
      files=collect_files(src_dir)
      files.each do |f|
        @fnam=f 
        read_file(data,keys,opts,&Proc.new)
        puts
      end
    else
      read_file(data,keys,opts,&Proc.new)
    end 
    data
  end
  def collect_files(src_dir)
    Dir.glob(File.join(src_dir,"IMMA*#@year*")).sort
  end
  def read_file(data,keys,opts)
    lno=0
    lsiz=0
    puts "Processing #@fnam"
    File.open(@fnam,"r").each do |line|
    lsiz+=line.size
      progress_meter(lsiz) if opts[:progress] && lno%50==0
      val = parse_line(keys,line)
      # proceed to next line if timestamp is incomplete upto hour
      next unless passed_timestamp_check?(val) 
      val = yield(val) if block_given?
      data << add_time(val,opts) unless val.empty?
      lno+=1
      if opts[:stop_at]
        break if lno==opts[:stop_at]
      end
    end
    data
  end
private
  def passed_timestamp_check?(val)
    ymdh = val[:yr][0], val[:mo][0], val[:dy][0], val[:hr][0]
    ymdh.all? {|c| c}
  end
  def add_time(val,opts)
    val = val.to_hash
    return val unless opts[:with_time]
    make_time(val,opts)
  end
  def make_time(val,opts)
    topts=opts[:with_time]
    base_time=Time.utc(*topts[:ref]).to_i
    y,m,d,h = val[:yr][0], val[:mo][0], val[:dy][0], hm_arr(val[:hr][0])
    curr_time=Time.utc(y,m,d,*h)
    val[:time] = (curr_time-base_time).to_i/tscale(topts[:unit])
    val
  end
  def hm_arr(hr)
    h = hr.to_i
    m = ((hr-h)*60).to_i
    [h,m]
  end

  def tscale(unit)
    case unit
      when 'day'
        24.0*60*60
    end
  end
  def parse_line(keys,line)
      hash=ICDATA.new
      keys.each do |k|
        hash[k] = c0.get(k,line) 
      end
      hash
  end
  def progress_meter(lsiz)
    fsiz = File.size(@fnam)
    val = 100.0 * lsiz/fsiz
    print "\tProcessed #{val} "
    print "% \r"
  end
end

class ICDATA < Hash
  def >(args)
    key = args[0].keys.first
    rng = args[0].values.first
    check_range(key,rng)
  end
  def to_hash
    return Hash[self.to_a]
  end
private
  def check_range(key,range)
     val =  self[key]
     val = self[key.to_s] unless val
     return ICDATA.new unless val
     val = val[0]
     if range.include? val
       return self
     else
       return ICDATA.new
     end
  end
end
