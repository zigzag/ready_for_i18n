require 'helper'

class TestLocaleDictionary < Test::Unit::TestCase
  should "save the result hash to yaml file" do
    locale_file = File.join(File.dirname(__FILE__),'output','en.yml')
    
    dict = ReadyForI18N::LocaleDictionary.new
    dict['login_key'] = 'Login:'
    dict['label'] = 'OK'
    dict['text'] = 'Please Confirm:'
    dict['with_quote'] = 'It is my "Label"'
    File.open(locale_file,'w+') {|f| dict.write_to f}
    
    result = YAML.load_file locale_file
    assert_equal('Login:', result['en']['login_key'])
    assert_equal("It is my \"Label\"", result['en']['with_quote'])
  end
  
  should "output to STDOUT when write to is nil" do
    dict = ReadyForI18N::LocaleDictionary.new
    dict['label'] = 'OK'
    dict.write_to STDOUT
  end
  
end
