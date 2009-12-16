module ReadyForI18N
  module BaseExtractor
    VALUE_PATTERN = /\w+/
    def initialize(erb_source, erb_target = nil)
      @erb_source = erb_source
      @erb_target = erb_target
    end

    def extract
      buffer = ''
      File.open(@erb_source).each do |line|
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
      File.open(@erb_target,'w+') {|f| f << buffer} if @erb_target
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