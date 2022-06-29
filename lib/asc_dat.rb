require 'bigdecimal'

class AscDat
  def initialize(hash_arr)
    @hash_arr=hash_arr
    lengths=hash_arr.values.map {|v|  v[0]}
    offsets=lengths-lengths
    offsets[0]=0
    offset=0
    lengths.each_index do |i|
       next if i==0
       offset+=lengths[i-1]
       offsets[i]=offset
    end
    i = 0
    @hash_arr.keys.each do |k|
      @hash_arr[k].insert(1, offsets[i])
      i+=1
    end
    #p offsets.last
  end

  def keys
    @hash_arr.keys
  end
  def find_by_key(key,str)
    abort(exit_msg(key)) unless @hash_arr[key.to_sym]
    arr=@hash_arr[key.to_sym].clone
    len=arr.shift
    offset=arr.shift
    type=arr.shift
    val = str[offset,len].strip
    val = to_numeric(val) if type == :numeric
    [val,arr.shift]
  end


  def get(key,str,verbose=false)
    val = find_by_key(key,str)[0]
    p "#{key} = #{val}" if verbose
    val
  end
private
  def to_numeric(str)
    str="0" if str.empty?
    num = BigDecimal(str)
    if num.frac == 0
      num.to_i
    else
      num.to_f
    end
  end
  def exit_msg(key)
    "The parameter #{key} is not specified in your input table\n\tProgram will exit now\n\tPlease correct entries in your input table"
  end
end

