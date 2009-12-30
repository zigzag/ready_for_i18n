require 'helper'
require 'stringio'

class TestNoKeyDictionary < Test::Unit::TestCase
  
  should "output to STDOUT when write to is nil" do
    dict = ReadyForI18N::NoKeyDictionary.new
    dict.push 'label','OK'
    out = StringIO.new
    dict.write_to out
    assert_equal("OK\n", out.string)
  end

  should "two same string will only generate one line" do
    dict = ReadyForI18N::NoKeyDictionary.new
    dict.push 'Key 1','Same Value:'
    dict.push 'Key 2','Same Value:'
    dict.push 'key 3','Different Value:'
    out = StringIO.new
    dict.write_to out
    assert_equal("Same Value:\nDifferent Value:\n", out.string)
  end

  should "skip the empty string" do
    dict = ReadyForI18N::NoKeyDictionary.new
    dict.push 'Key 1','Some Value'
    dict.push 'Key 2','  '
    out = StringIO.new
    dict.write_to out
    assert_equal("Some Value\n", out.string)
  end
  
end
