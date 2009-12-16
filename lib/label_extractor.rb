module ReadyForI18N
  class LabelExtractor
    LABEL_IN_HELPER_PATTERN =  %w{label_tag link_to field_set_tag submit_tag button_to}.map{|h| /#{h}[\s\w_]*('|")([\w ]*)(\1)/ }

    include ReadyForI18N::BaseExtractor
    
    protected 
    def values_in_line(line)
      LABEL_IN_HELPER_PATTERN.map{|h| line.match(h).captures.join if line =~ h}.compact
    end
    def skip_line?(s)
      false
    end
    def to_value(s)
      s.strip[1..-2]
    end
    def replace_line(line,e)
      line.gsub!(e,"t(:#{to_key(e)})")
    end
    def key_prefix
      'label'
    end
  end
end