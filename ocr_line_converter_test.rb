require_relative 'ocr_line_converter'
require 'test/unit'

class OCRLineConverterTest < Test::Unit::TestCase

  def setup 
    @converter = OCRLineConverter.new(OCRCharConverter.new, 9)
  end

  def test_allZeros
    input = " _  _  _  _  _  _  _  _  _ \n"+
            "| || || || || || || || || |\n"+
            "|_||_||_||_||_||_||_||_||_|\n"
    assert_equal("000000000", @converter.convert_line(input))
  end

  def test_allOnes
    input = "                           \n"+
            "  |  |  |  |  |  |  |  |  |\n"+
            "  |  |  |  |  |  |  |  |  |\n" 
     assert_equal("111111111", @converter.convert_line(input))
  end

  def test_allTwos
    input =  " _  _  _  _  _  _  _  _  _ \n"+
             " _| _| _| _| _| _| _| _| _|\n"+
             "|_ |_ |_ |_ |_ |_ |_ |_ |_ \n"
     assert_equal("222222222", @converter.convert_line(input))
  end

  def test1to9
    input = "    _  _     _  _  _  _  _ \n"+
            "  | _| _||_||_ |_   ||_||_|\n"+
            "  ||_  _|  | _||_|  ||_| _|\n"
    assert_equal("123456789", @converter.convert_line(input))
  end

  def test_get_ocrchar_at_index
    sub_lines = ["    _  _     _  _  _  _  _ ",
                 "  | _| _||_||_ |_   ||_||_|",
                 "  ||_  _|  | _||_|  ||_| _|"]

    assert_equal(" _ "+
                 " _|"+
                 "|_ ", @converter.get_ocrchar_at_index(sub_lines,3))
  end

 def test_split_ocrline_into_ocrcharsy
    ocr_line  =  "    _  _     _  _  _  _  _ \n"+
                 "  | _| _||_||_ |_   ||_||_|\n"+
                 "  ||_  _|  | _||_|  ||_| _|\n"

    ocr_chars = @converter.split_ocrline_into_ocrchars(ocr_line)

    assert_equal(9, ocr_chars.size)

    assert_equal("   "+
                 "  |"+
                 "  |", ocr_chars[0])

    assert_equal(" _ "+
                 " _|"+
                 "|_ ", ocr_chars[1])

    assert_equal(" _ "+
                 "|_|"+
                 " _|", ocr_chars[8])
  end



end