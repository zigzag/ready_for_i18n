require 'helper'

class TestBaseExtractor < Test::Unit::TestCase
  should "find a proper key for a given text/label" do
    c = Object.new
    def c.key_prefix; nil;end
    def c.to_value(s); s ;end
    c.extend ReadyForI18N::BaseExtractor
    assert_equal('confirm_password', c.to_key('Confirm password:'))
  end

  should "work fine with prefix" do
    c = Object.new
    def c.key_prefix; 'label' ;end
    def c.to_value(s); s ;end
    c.extend ReadyForI18N::BaseExtractor
    assert_equal('label_login', c.to_key('Login:'))
  end

end
