require_relative 'ocr_line_parser'
require_relative 'ocr_character'

require 'test/unit'

class OCRLineParserTest < Test::Unit::TestCase

  def std_ocr_line
    "    _  _     _  _  _  _  _ \n"+
    "  | _| _||_||_ |_   ||_||_|\n"+
    "  ||_  _|  | _||_|  ||_| _|\n"
  end

  def char_parser
    OCRCharacter.new
  end

  def std_line_parser
    OCRLineParser.new(std_ocr_line, char_parser)
  end

  def test_contains_illegible_OK
    assert !std_line_parser.contains_illegible?
  end

  def test_contains_illegible_fail
    parser = OCRLineParser.new(std_ocr_line.insert(2,"|"), char_parser)
    assert parser.contains_illegible?
  end

  def test_allZeros
    input = " _  _  _  _  _  _  _  _  _ \n"+
            "| || || || || || || || || |\n"+
            "|_||_||_||_||_||_||_||_||_|\n"
    parser = OCRLineParser.new(input, char_parser)
    assert_equal("000000000", parser.convert_line())
  end

  def test_allOnes
    input = "                           \n"+
            "  |  |  |  |  |  |  |  |  |\n"+
            "  |  |  |  |  |  |  |  |  |\n" 
    parser = OCRLineParser.new(input, char_parser)
    assert_equal("111111111", parser.convert_line())
  end

  def test_allTwos
    input =  " _  _  _  _  _  _  _  _  _ \n"+
             " _| _| _| _| _| _| _| _| _|\n"+
             "|_ |_ |_ |_ |_ |_ |_ |_ |_ \n"
     parser = OCRLineParser.new(input, char_parser)
     assert_equal("222222222", parser.convert_line())
  end

  def test1to9
    assert_equal("123456789", std_line_parser.convert_line())
  end

 def test_split_ocrline_into_ocrchars
    ocr_chars = std_line_parser.split_ocrline_into_ocrchars()

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
                 "|_ ", std_line_parser.get_ocrchar_at_index(sub_lines,3))
  end



end
