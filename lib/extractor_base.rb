require 'stringio'

module ReadyForI18N
  module ExtractorBase
    VALUE_PATTERN = /\w+/
    def self.use_dot(on_off)
      @use_dot = on_off
    end
    def self.use_dot?
      @use_dot
    end
    attr_accessor :use_dot
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
      result = to_value(s).scan(/\w+/).join('_').downcase
      key_prefix ? "#{key_prefix}_#{result}" : result
    end
    def can_replace?(e)
      e.scan(VALUE_PATTERN).length > 0
    end
    def t_method(val,wrap=false)
      m = ExtractorBase.use_dot? ? "t('.#{to_key(val)}')" : "t(:#{to_key(val)})"
      wrap ? "<%=#{m}%>" : m
    end
  end
end