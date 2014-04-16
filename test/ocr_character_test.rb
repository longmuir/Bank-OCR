require_relative '../lib/ocr_character'
require 'test/unit'

class OCRCharacterTest < Test::Unit::TestCase

  def setup 
    @converter = OCRCharacter.new
  end

  def test_convert_0
    input =" _ "+
           "| |"+
           "|_|"
    assert_equal("0", @converter.convert_to_char(input))
  end

  def test_convert_1
    input = "   "+
            "  |"+
            "  |"
    assert_equal("1", @converter.convert_to_char(input))
  end

  def test_convert_2
    input = " _ "+
            " _|"+
            "|_ "
    assert_equal("2", @converter.convert_to_char(input))
  end

  def test_convert_3
    input = " _ "+
            " _|"+
            " _|"
    assert_equal("3", @converter.convert_to_char(input))
  end

  def test_convert_4
    input = "   "+
            "|_|"+
            "  |"
    assert_equal("4", @converter.convert_to_char(input))
  end

  def test_convert_5
    input = " _ "+
            "|_ "+
            " _|"
    assert_equal("5", @converter.convert_to_char(input))
  end

  def test_convert_6
    input = " _ "+
            "|_ "+
            "|_|"
    assert_equal("6", @converter.convert_to_char(input))
  end

  def test_convert_7
    input = " _ "+
            "  |"+
            "  |"
    assert_equal("7", @converter.convert_to_char(input))
  end

  def test_convert_8
    input = " _ "+
            "|_|"+
            "|_|"
    assert_equal("8", @converter.convert_to_char(input))
  end

  def test_convert_9
    input = " _ "+
            "|_|"+
            " _|"
    assert_equal("9", @converter.convert_to_char(input))
  end

  def test_convert_illegible_returns_nil
    input = "   "+
            "|_|"+
            " _|"
    assert_equal(nil, @converter.convert_to_char(input))
  end

  def test_find_alternatives_should_return_9
    input = "   "+
            "|_|"+
            " _|"
    alternatives = @converter.find_alternatives(input)
    assert alternatives.include?("4")
    assert alternatives.include?("9")
    assert alternatives.size == 2
  end

  def test_find_alternatives_should_return_1
    input = "   "+
            "  |"+
            "   "
    assert_equal(["1"], @converter.find_alternatives(input))
  end

  def test_find_alternatives_should_return_1_again
    input = "   "+
            "  |"+
            " _|"
    assert_equal(["1"], @converter.find_alternatives(input))
  end

end
