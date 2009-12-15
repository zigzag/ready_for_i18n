require 'helper'

class TestLabelExtractor < Test::Unit::TestCase
  should "extract the label that need i18n from the erb view file" do
    f = File.join(File.dirname(__FILE__),'fixtures','index.html.erb')
    result = []
    ReadyForI18N::LabelExtractor.new(f).extract{|k,v| result << v}
    expected = %w{edit delete select export cancel}
    assert_same_elements(expected,result)
  end
  
  should "replace the label in helper with t method" do
    source = File.join(File.dirname(__FILE__),'fixtures','index.html.erb')
    target = File.join(File.dirname(__FILE__),'output','label.html.erb')
    ReadyForI18N::LabelExtractor.new(source,target).extract
    %w{edit delete select export cancel}.each do |e|
      assert(File.read(target).include?("t(:label_#{e})"), "should found t method with symbol")
    end
  end
  
end
