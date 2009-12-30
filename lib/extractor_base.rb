require 'stringio'

module ReadyForI18N
  module ExtractorBase
    
    def self.use_dot(on_off)
      @use_dot = on_off
    end
    def self.use_dot?
      @use_dot
    end
    def self.key_mapper=(mapper)
      @key_mapper = mapper
    end
    def self.key_mapper
      @key_mapper
    end
    
    def extract(input)
      buffer = StringIO.new
      input.each do |line|
        unless skip_line?(line)
          values_in_line(line).each do |e|
            if can_replace?(e)
              yield(to_key(e),to_value(e)) if block_given?
              replace_line(line,e)
            end
          end
        end
        buffer << line
      end
      buffer.string
    end
    def to_key(s)
      val = to_value(s)
      result = (ExtractorBase.key_mapper) ? ExtractorBase.key_mapper.key_for(val) : val.scan(/\w+/).join('_').downcase
      key_prefix ? "#{key_prefix}_#{result}" : result
    end
    def can_replace?(e)
      e.strip.size > 1
    end
    def t_method(val,wrap=false)
      m = ExtractorBase.use_dot? ? "t('.#{to_key(val)}')" : "t(:#{to_key(val)})"
      wrap ? "<%=#{m}%>" : m
    end
  end
end