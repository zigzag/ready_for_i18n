require 'helper'

class TestLocaleDictionary < Test::Unit::TestCase
  should "save the result hash to yaml file" do
    target_path = File.join(File.dirname(__FILE__),'output')
    dict = ReadyForI18N::LocaleDictionary.new
    dict['login_key'] = 'Login:'
    dict['label'] = 'OK'
    dict['text'] = 'Please Confirm:'
    dict['with_quote'] = 'It is my "Label"'
    dict.write_to target_path
    
    result = YAML.load_file File.join(target_path,'en.yml')
    assert_equal('Login:', result['en']['login_key'])
    assert_equal("It is my \"Label\"", result['en']['with_quote'])
  end
  
end
