module ReadyForI18N
  class HtmlAttrExtractor < HtmlTextExtractor
    LABEL_TAG_ATTR_PATTERN = [[/<img(.*)(\/>|<\/img>)/i,/alt=["'](.*?)["']/i],
                              [/<img(.*)(\/>|<\/img>)/i,/title=["'](.*?)["']/i],
                              [/<input(.*)\s*type\s*=\s*["']submit["']/i,/value\s*=\s*["'](.*?)["']/i],
                              [/<input\s*type\s*=\s*["']submit["'](.*)/i,/value\s*=\s*["'](.*?)["']/i],
                              [/<input(.*)\s*type\s*=\s*["']button["']/i,/value\s*=\s*["'](.*?)["']/i],
                              [/<input\s*type\s*=\s*["']button["'](.*)/i,/value\s*=\s*["'](.*?)["']/i]]
    SKIP_PATTERN = /<%(.*)%>/
    protected 
    def values_in_line(line)
      values = []
      LABEL_TAG_ATTR_PATTERN.each do |p|
        attrs = line.match(p[0])[1] if line =~ p[0]
        if attrs =~ p[1] 
          value = attrs.match(p[1])[1]
          values << value unless value =~ SKIP_PATTERN
        end
      end
      values
    end
    def key_prefix
      'label'
    end
  end
end
