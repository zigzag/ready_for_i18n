class I18nExtractor
  SKIP_INLINE_TAG = [/<%(.*?)%>/,/<(.*?)>/,/<%(.*)$/,/^(.*)%>/,/&nbsp;/]
  SKIP_TAGS = [[/<script/i,/<\/script>/i],[/<%/,/%>/],[/<style/i,/\/style>/i]]
  TEXT_IN_HELPER =  %w{label_tag link_to field_set_tag}.map{|h| /#{h}\s*('|")([\w ]*)(\1)/ }
  SEPERATOR = '_@@@_'

  def initialize(filename)
    @filename = filename
    @stack = []
    @result = []
  end
 
  def extract
    File.open(@filename).each_with_index do |line,i|
      text_in_helper = TEXT_IN_HELPER.map{|h| line.match(h).captures[1] if line =~ h}.compact
      text_in_helper.each { |e| @result << [i+1,e.strip] if e.strip.size > 1  }
      next if in_script_block?(line)
      text = SKIP_INLINE_TAG.inject(line){|memo,tag| memo.gsub(tag,SEPERATOR)}.strip
      arr = text.split SEPERATOR
      arr.each { |e| @result << [i+1,e.strip] if e.strip.size > 1  }
    end
    @result
  end
 
private
  def in_script_block?(s)
    return true if s.nil? || s.strip.size == 0 
    jump_in_tag = SKIP_TAGS.find{ |start_tag,end_tag| s =~ start_tag}
    @stack.push jump_in_tag[1] if jump_in_tag
    if @stack.last
      end_tag_match = s.match(@stack.last) 
      if end_tag_match
        @stack.pop 
        return in_script_block?(end_tag_match.post_match)
      end
    end
    return !@stack.empty?
  end
 
end
