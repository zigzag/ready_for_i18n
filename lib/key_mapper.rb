module ReadyForI18N
  class KeyMapper
    def initialize(text1,text2)
      @hash = {}
      arr1 = text1.split("\n")
      arr2 = text2.split("\n")
      raise 'Mapper files should contain the same number of lines' if arr1.size != arr2.size
      arr1.each_with_index { |text,i| @hash[text] = arr2[i] }
    end
    def key_for(text)
      possible_key = @hash[text] ? @hash[text] : @hash.invert[text]
      possible_key.scan(/\w+/).join('_').downcase
    end
  end
end