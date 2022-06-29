require_relative "imma_tables"
require_relative "asc_dat"

class IMMA < AscDat
 def get(key,str,verbose=false)
    val, opts = find_by_key(key,str)
    return return_value(nil,key,verbose) unless val
    if opts
      val = val*opts[:scale] if opts[:scale]
      unit = opts[:unit]
      range = opts[:range]
      return return_value([nil],key,verbose) unless (range.include?(val)) && range
      return return_value([val,unit],key,verbose) if unit
    end
    return return_value([val],key,verbose)
  end
private
  def return_value(val,key,verbose=false)
      if verbose
        if val[0]
          puts "#{key} :: #{val.join ' '}"  
        else
          puts "#{key} values out of range"
        end
      end
      val
  end
end
