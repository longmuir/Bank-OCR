require_relative '../lib/ocr_line_parser'
require_relative '../lib/ocr_character'
require "test/unit"

class OCRLineParserTest < Test::Unit::TestCase

  def std_ocr_line
    "    _  _     _  _  _  _  _ \n"+
    "  | _| _||_||_ |_   ||_||_|\n"+
    "  ||_  _|  | _||_|  ||_| _|\n"
  end

  def char_parser
    OCRCharacter.new
  end

  def setup
    @parser = OCRLineParser.new(OCRCharacter.new)
  end

  def test_allZeros
    input = " _  _  _  _  _  _  _  _  _ \n"+
            "| || || || || || || || || |\n"+
            "|_||_||_||_||_||_||_||_||_|\n"
    assert_equal("000000000", @parser.convert_line(input))
  end

  def test_allOnes
    input = "                           \n"+
            "  |  |  |  |  |  |  |  |  |\n"+
            "  |  |  |  |  |  |  |  |  |\n" 
    assert_equal("111111111", @parser.convert_line(input))
  end

  def test_allTwos
    input =  " _  _  _  _  _  _  _  _  _ \n"+
             " _| _| _| _| _| _| _| _| _|\n"+
             "|_ |_ |_ |_ |_ |_ |_ |_ |_ \n"
     assert_equal("222222222", @parser.convert_line(input))
  end

  def test1to9
    assert_equal("123456789", @parser.convert_line(std_ocr_line))
  end

 def test_split_ocrline_into_ocrchars
    ocr_chars = @parser.split_ocrline_into_ocrchars(std_ocr_line)

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

  def test_get_ocrchar_at_index
    sub_lines = ["    _  _     _  _  _  _  _ ",
                 "  | _| _||_||_ |_   ||_||_|",
                 "  ||_  _|  | _||_|  ||_| _|"]
    assert_equal(" _ "+
                 " _|"+
                 "|_ ", @parser.get_ocrchar_at_index(sub_lines,3))
  end

end
