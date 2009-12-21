require 'helper'

class TestHtmlAttrExtractor < Test::Unit::TestCase
  should "extract the Some Attribute that need i18n from the HTML file" do
    f = File.join(File.dirname(__FILE__),'fixtures','html_attr.html.erb')
    expected = %w{Print Measure Save copy} << 'Compare on chart'
    result = []
    ReadyForI18N::HtmlAttrExtractor.new.extract(File.read(f)){|k,v| result << v}
    assert_same_elements(expected,result)
  end
  
  should "replace the attribut in html with t method" do
    source = File.join(File.dirname(__FILE__),'fixtures','html_attr.html.erb')
    output = ReadyForI18N::HtmlAttrExtractor.new.extract(File.read(source))
    %w{Print Measure Save copy}.each do |e|
      assert(output.include?("<%=t(:label_#{e.downcase.gsub(':','')})%>"), "should found t method with symbol")
    end
  end
  
end
