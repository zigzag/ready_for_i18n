require 'stringio'

module ReadyForI18N
  module BaseExtractor
    VALUE_PATTERN = /\w+/
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
  end
end