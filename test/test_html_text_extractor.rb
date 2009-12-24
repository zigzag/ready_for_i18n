require 'helper'

class TestHtmlTextExtractor < Test::Unit::TestCase
  should "extract the text that need i18n from the erb view file" do
    f = File.join(File.dirname(__FILE__),'fixtures','index.html.erb')
    expected = %w{Users Login Name Groups Operations Login: Name: Password: Export} << 'Confirm password:' << 'select all &raquo;'
    result = []
    ReadyForI18N::HtmlTextExtractor.new.extract(File.read(f)){|k,v| result << v}
    assert_same_elements(expected,result)
  end
  
  should "replace the text in helper with t method" do
    source = File.join(File.dirname(__FILE__),'fixtures','index.html.erb')
    output = ReadyForI18N::HtmlTextExtractor.new.extract(File.read(source))
    %w{Users Login Name Groups Operations Login: Name: Password: Export}.each do |e|
      assert(output.include?("<%=t(:text_#{e.downcase.gsub(':','')})%>"), "should found t method with symbol")
    end
  end
  
  should "replace the text only needed" do
    input = "<span id='Replace Me'>Replace Me</span>"
    output = ReadyForI18N::HtmlTextExtractor.new.extract input
    assert_equal("<span id='Replace Me'><%=t(:text_replace_me)%></span>", output)

    input = "<span id='Replace Me'>Replace Me"
    output = ReadyForI18N::HtmlTextExtractor.new.extract input
    assert_equal("<span id='Replace Me'><%=t(:text_replace_me)%>", output)
  end
end
