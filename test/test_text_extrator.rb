require 'helper'

class TestTextExtractor < Test::Unit::TestCase
  should "extract the text that need i18n from the erb view file" do
    f = File.join(File.dirname(__FILE__),'fixtures','index.html.erb')
    expected = %w{Users Login Name Groups Operations Login: Name: Password: Export} << 'Confirm password:'
    result = []
    ReadyForI18N::TextExtractor.new(f).extract{|k,v| result << v}
    assert_same_elements(expected,result)
  end
  
  should "replace the text in helper with t method" do
    source = File.join(File.dirname(__FILE__),'fixtures','index.html.erb')
    target = File.join(File.dirname(__FILE__),'output','text.html.erb')
    ReadyForI18N::TextExtractor.new(source,target).extract
    %w{Users Login Name Groups Operations Login: Name: Password: Export}.each do |e|
      assert(File.read(target).include?("<%=t(:text_#{e.downcase.gsub(':','')})%>"), "should found t method with symbol")
    end
  end
  
end
