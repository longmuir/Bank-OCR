require_relative 'ocr_line_reader'
require 'test/unit'

class OCRLineReaderTest < Test::Unit::TestCase

  def setup 
    @reader = OCRLineReader.new
  end

  def test_output_123456789
    input = "    _  _     _  _  _  _  _ \n"+ 
            "  | _| _||_||_ |_   ||_||_|\n"+
            "  ||_  _|  | _||_|  ||_| _|\n"
    assert_equal("123456789", @reader.read_line(input))
  end

  def test_output_000000051
    input =  " _  _  _  _  _  _  _  _    \n"+
             "| || || || || || || ||_   |\n"+
             "|_||_||_||_||_||_||_| _|  |\n"
    assert_equal("000000051", @reader.read_line(input))
  end

  def test_output_49006771L
    input = "    _  _  _  _  _  _     _ \n"+
            "|_||_|| || ||_   |  |  | _ \n"+
            "  | _||_||_||_|  |  |  | _|"
        assert_equal("49006771? ILL", @reader.read_line(input))
  end

  def test_output_1234Errors
    input = "    _  _     _  _  _  _  _ \n"+ 
            "  | _| _||_| _ |_   ||_||_|\n"+
            "  ||_  _|  | _||_|  ||_| _ \n"
    assert_equal("1234?678? ILL", @reader.read_line(input))
  end

end