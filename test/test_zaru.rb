# encoding: utf-8

require 'test/unit'
require 'zaru'

class ZaruTest < Test::Unit::TestCase

  def setup
    Zaru.const_set :FALLBACK_FILENAME, 'file'
  end

  def test_normalization
    ['a', ' a', 'a ', ' a ', "a    \n"].each do |name|
      assert_equal 'a', Zaru.sanitize!(name)
    end

    ['x x', 'x  x', 'x   x', "x\tx", "x\r\nx"].each do |name|
      assert_equal 'x x', Zaru.sanitize!(name)
    end
  end

  def test_truncation
    name = "A"*400
    assert_equal 255, Zaru.sanitize!(name).length

    assert_equal 245, Zaru.sanitize!(name, :padding => 10).length
  end

  def test_sanitization
    assert_equal "abcdef", Zaru.sanitize!('abcdef')

    %w(< > | / \\ * ? : ~).each do |char|
      assert_equal '_', Zaru.sanitize!(char)
      assert_equal 'a_', Zaru.sanitize!("a#{char}")
      assert_equal '_a', Zaru.sanitize!("#{char}a")
      assert_equal 'a_a', Zaru.sanitize!("a#{char}a")
    end

    assert_equal "笊, ざる.pdf", Zaru.sanitize!("笊, ざる.pdf")

    assert_equal "what_ēver__wëird_user_înput_",
      Zaru.sanitize!('  what\\ēver//wëird:user:înput:')
  end

  def test_windows_reserved_named
    assert_equal "file", Zaru.sanitize!('CON')
    assert_equal "file", Zaru.sanitize!('lpt1 ')
    assert_equal "file", Zaru.sanitize!('com4')
    assert_equal "file", Zaru.sanitize!(' aux')
    assert_equal "LpT_2", Zaru.sanitize!(" LpT\x122")
    assert_equal "COM10", Zaru.sanitize!('COM10')
  end

  def test_blanks
    assert_equal 'file', Zaru.sanitize!("\n")
    assert_equal "file", Zaru.sanitize!('  ')
  end

  def test_dots
    assert_equal "file.pdf", Zaru.sanitize!(".pdf")
    assert_equal "_.pdf", Zaru.sanitize!("<.pdf")
    assert_equal "file..pdf", Zaru.sanitize!("..pdf")
  end

  def test_fallback_filename
    assert_equal "file", Zaru.sanitize!('')
    assert_equal "file.pdf", Zaru.sanitize!('.pdf')

    Zaru.const_set :FALLBACK_FILENAME, 'blub'
    assert_equal "blub", Zaru.sanitize!('')
    assert_equal "blub", Zaru.sanitize!('lpt1')
  end

end