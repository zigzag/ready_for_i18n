require 'set'
module ReadyForI18N
  class NoKeyDictionary
    def initialize(locale = nil)
      @set = Set.new
    end
    def push(key,value,path = nil)
      @set << value if value && !value.strip.empty?
    end
    def write_to(out)
      @set.each { |e| out.puts e }
    end
  end
end