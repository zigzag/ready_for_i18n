module ReadyForI18N
  class LocaleDictionary
    def initialize(locale = nil)
      @locale = locale || 'en'
      @hash = {}
    end
    def []=(key,value)
      @hash[key] = value
    end
    def write_to(out)
      out.puts "#{@locale}:"
      @hash.keys.sort{|a,b|a.to_s<=>b.to_s}.each { |k| out.puts "  #{k}: #{@hash[k].dump}" }
    end
  end
end