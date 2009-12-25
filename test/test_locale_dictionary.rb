require 'helper'
require 'stringio'

class TestLocaleDictionary < Test::Unit::TestCase
  should "save the result hash to yaml file" do
    locale_file = File.join(File.dirname(__FILE__),'output','en.yml')
    
    dict = ReadyForI18N::LocaleDictionary.new
    dict.push 'login_key','Login:'
    dict.push 'label','OK'
    dict.push 'text','Please Confirm:'
    dict.push 'with_quote','It is my "Label"'
    File.open(locale_file,'w+') {|f| dict.write_to f}
    
    result = YAML.load_file locale_file
    assert_equal('Login:', result['en']['login_key'])
    assert_equal("It is my \"Label\"", result['en']['with_quote'])
  end
  
  should "output to STDOUT when write to is nil" do
    dict = ReadyForI18N::LocaleDictionary.new
    dict.push 'label','OK'
    out = StringIO.new
    dict.write_to out
    assert_equal("en:\n  label: \"OK\"\n", out.string)
  end
  
  should "should intent output when path is given" do 
    dict = ReadyForI18N::LocaleDictionary.new
    dict.push 'label','OK',['my_view']
    out = StringIO.new
    dict.write_to out
    assert_equal("en:\n  my_view:\n    label: \"OK\"\n", out.string)
  end
  
end
