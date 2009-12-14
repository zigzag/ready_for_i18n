require 'helper'

class TestReadyForI18n < Test::Unit::TestCase
  should "extract the label that need i18n from the erb view file" do
    f = File.join(File.dirname(__FILE__),'fixtures','index.html.erb')
    result = I18nExtractor.new(f).extract
    names = result.map{|e|e[1]}
    expected = %w{Users Login Name Groups Operations Login: Name: Password:} << 'Confirm password:'
    assert_same_elements(expected,names)
  end
end
