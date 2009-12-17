module ReadyForI18N
  class LocaleDictionary
    def initialize(locale = nil)
      @locale = locale || 'en'
      @hash = {}
    end
    def []=(key,value)
      @hash[key] = value
    end

    def write_to(path)
      file = File.join(path,"#{@locale}.yml")
      File.open(file,'w+') do |f|
        f.puts "#{@locale}:"
        @hash.keys.sort{|a,b|a.to_s<=>b.to_s}.each { |k| f.puts "  #{k}: #{@hash[k].dump}" }
      end
      file
    end
    
  end
end