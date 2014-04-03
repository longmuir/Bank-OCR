require_relative 'ocr_char_converter'
require 'test/unit'

class OCRCharConverterTest < Test::Unit::TestCase

  def setup 
    @converter = OCRCharConverter.new
  end

  def test_convert_0
    input =" _ "+
           "| |"+
           "|_|"
    assert_equal(0, @converter.ocrchar_to_char(input))
  end

  def test_convert_1
    input = "   "+
            "  |"+
            "  |"
    assert_equal(1, @converter.ocrchar_to_char(input))
  end

  def test_convert_2
    input = " _ "+
            " _|"+
            "|_ "
    assert_equal(2, @converter.ocrchar_to_char(input))
  end

  def test_convert_3
    input = " _ "+
            " _|"+
            " _|"
    assert_equal(3, @converter.ocrchar_to_char(input))
  end

  def test_convert_4
    input = "   "+
            "|_|"+
            "  |"
    assert_equal(4, @converter.ocrchar_to_char(input))
  end

  def test_convert_5
    input = " _ "+
            "|_ "+
            " _|"
    assert_equal(5, @converter.ocrchar_to_char(input))
  end

  def test_convert_6
    input = " _ "+
            "|_ "+
            "|_|"
    assert_equal(6, @converter.ocrchar_to_char(input))
  end

  def test_convert_7
    input = " _ "+
            "  |"+
            "  |"
    assert_equal(7, @converter.ocrchar_to_char(input))
  end

  def test_convert_8
    input = " _ "+
            "|_|"+
            "|_|"
    assert_equal(8, @converter.ocrchar_to_char(input))
  end

  def test_convert_9
    input = " _ "+
            "|_|"+
            " _|"
    assert_equal(9, @converter.ocrchar_to_char(input))
  end

end
