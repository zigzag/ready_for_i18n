require 'helper'

class TestExtractorBase < Test::Unit::TestCase
  should "find a proper key for a given text/label" do
    c = Object.new
    def c.key_prefix; nil;end
    def c.to_value(s); s ;end
    c.extend ReadyForI18N::ExtractorBase
    assert_equal('confirm_password', c.to_key('Confirm password:'))
  end

  should "work fine with prefix" do
    c = Object.new
    def c.key_prefix; 'label' ;end
    def c.to_value(s); s ;end
    c.extend ReadyForI18N::ExtractorBase
    assert_equal('label_login', c.to_key('Login:'))
  end
  
  should "t_method should use symbol when no use dot" do
    ReadyForI18N::ExtractorBase.use_dot(false)
    c = Object.new
    def c.key_prefix; 'label' ;end
    def c.to_value(s); s ;end
    c.extend ReadyForI18N::ExtractorBase
    assert_equal("t(:label_login)", c.t_method('Login:'))
    assert_equal("<%=t(:label_login)%>", c.t_method('Login:',true))
  end

  should "t_method should start with a dot when use dot" do
    ReadyForI18N::ExtractorBase.use_dot(true)
    c = Object.new
    def c.key_prefix; 'label' ;end
    def c.to_value(s); s ;end
    c.extend ReadyForI18N::ExtractorBase
    assert_equal("t('.label_login')", c.t_method('Login:'))
    assert_equal("<%=t('.label_login')%>", c.t_method('Login:',true))
  end
  
  should "using keymapper when set" do
    mapper = Object.new
    def mapper.key_for(text); 'keeey' ;end
    ReadyForI18N::ExtractorBase.key_mapper = mapper
    c = Object.new
    def c.key_prefix; 'label' ;end
    def c.to_value(s); s ;end
    c.extend ReadyForI18N::ExtractorBase
    assert_equal('label_keeey', c.to_key('Login:'))
    assert_equal("t(:label_keeey)", c.t_method('Login:'))
    ReadyForI18N::ExtractorBase.key_mapper = nil
  end

end
