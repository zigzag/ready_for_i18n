module ReadyForI18N
  class LocaleDictionary
    def initialize(locale = nil)
      @locale = locale || 'en'
      @hash = {}
    end
    def push(key,value,path = nil)
      h = @hash
      path.each{|p| h[p] ||= {}; h = h[p] } if path
      h[key] = value
    end
    def write_to(out)
      out.puts "#{@locale}:"
      write_out_hash(out,@hash,1)
    end
    
    private 
    def write_out_hash(out,hash,intent)
      hash.keys.sort{|a,b|a.to_s<=>b.to_s}.each do |k|
        key_with_indent = "#{'  '*intent}#{k}:"
        val = hash[k]
        if (val.is_a? Hash)
          out.puts(key_with_indent)
          write_out_hash(out, val, intent + 1) 
        else
          out.puts("#{key_with_indent} #{val.dump}" )
        end
      end
    end
  end
end