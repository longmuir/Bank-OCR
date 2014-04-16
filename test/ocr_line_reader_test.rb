require_relative '../lib/ocr_line_reader'
require 'test/unit'

class OCRLineReaderTest < Test::Unit::TestCase

  def setup 
    @reader = OCRLineReader.new
  end

  def test_reads_123456789
    input = "    _  _     _  _  _  _  _ \n"+ 
            "  | _| _||_||_ |_   ||_||_|\n"+
            "  ||_  _|  | _||_|  ||_| _|\n"
    assert_equal("123456789", @reader.read_line(input))
  end

  def test_reads_000000051
    input =  " _  _  _  _  _  _  _  _    \n"+
             "| || || || || || || ||_   |\n"+
             "|_||_||_||_||_||_||_| _|  |\n"
    assert_equal("000000051", @reader.read_line(input))
  end

  def test_reads_49006771L
    input = "    _  _  _  _  _  _     _ \n"+
            "|_||_|| || ||_   |  |  | _ \n"+
            "  | _||_||_||_|  |  |  | _|"
        assert_equal("49006771? ILL", @reader.read_line(input))
  end

  def test_reads_1234Errors_and_corrects
    input = "    _  _     _  _  _  _  _ \n"+ 
            "  | _| _||_| _ |_   ||_||_|\n"+
            "  ||_  _|  | _||_|  ||_| _ \n"
    assert_equal("123456789", @reader.read_line(input))
  end

  def test_correct_111111111
    input = "                           \n"+ 
            "  |  |  |  |  |  |  |  |  |\n"+
            "  |  |  |  |  |  |  |  |  |"
    assert_equal("711111111", @reader.read_line(input))
  end

  def test_correct_777777777
    input = " _  _  _  _  _  _  _  _  _ \n"+
            "  |  |  |  |  |  |  |  |  |\n"+
            "  |  |  |  |  |  |  |  |  |"
    assert_equal("777777177", @reader.read_line(input))
  end
  
  def test_correct_200000000
    input = " _  _  _  _  _  _  _  _  _ \n"+
            " _|| || || || || || || || |\n"+
            "|_ |_||_||_||_||_||_||_||_|"
    assert_equal("200800000", @reader.read_line(input))
  end

  def test_correct_33333333
    input = " _  _  _  _  _  _  _  _  _ \n"+
            " _| _| _| _| _| _| _| _| _|\n"+
            " _| _| _| _| _| _| _| _| _|"
    assert_equal("333393333", @reader.read_line(input))
  end

  def test_888888888_returns_AMB_3_possibilities
    input = " _  _  _  _  _  _  _  _  _ \n"+
            "|_||_||_||_||_||_||_||_||_|\n"+
            "|_||_||_||_||_||_||_||_||_|"
    #Possibilities "888888888 AMB ['888886888', '888888880', '888888988']"
    result = @reader.read_line(input)
    assert result.start_with?("888888888 AMB")
    #Order isn't guaranteed
    assert result.include?('888886888')
    assert result.include?('888888880')
    assert result.include?('888888988')
  end

  def test_555555555_should_be_AMB
    input = " _  _  _  _  _  _  _  _  _ \n"+
            "|_ |_ |_ |_ |_ |_ |_ |_ |_ \n"+
            " _| _| _| _| _| _| _| _| _|"
    
    result = @reader.read_line(input)
    assert result.start_with?("555555555 AMB")
    assert result.include?('555655555')
    assert result.include?('559555555')
  end

  def test_666666666_should_be_AMB
    input = " _  _  _  _  _  _  _  _  _ \n"+
            "|_ |_ |_ |_ |_ |_ |_ |_ |_ \n"+
            "|_||_||_||_||_||_||_||_||_|"
    result = @reader.read_line(input)
    assert result.start_with?("666666666 AMB")
    assert result.include?('666566666')
    assert result.include?('686666666')
  end

  def test_99999999_should_be_AMB
    input = " _  _  _  _  _  _  _  _  _ \n"+
            "|_||_||_||_||_||_||_||_||_|\n"+
            " _| _| _| _| _| _| _| _| _|"
    result = @reader.read_line(input)
    assert result.start_with?("999999999 AMB")
    assert result.include?('899999999')
    assert result.include?('993999999')
    assert result.include?('999959999')
  end

  def test_490067715_should_be_AMB
    input = "    _  _  _  _  _  _     _ \n"+
            "|_||_|| || ||_   |  |  ||_ \n"+
            "  | _||_||_||_|  |  |  | _|"
    result = @reader.read_line(input)
    assert result.start_with?("490067715 AMB")
    assert result.include?('490067115')
    assert result.include?('490067719')
    assert result.include?('490867715')
  end

  def test_E23456789_should_be_corrected
    input = "    _  _     _  _  _  _  _ \n"+
            " _| _| _||_||_ |_   ||_||_|\n"+
            "  ||_  _|  | _||_|  ||_| _|"
    assert_equal("123456789", @reader.read_line(input))
  end 

  def test_0E0000051_should_be_corrected
    input = " _     _  _  _  _  _  _    \n"+
            "| || || || || || || ||_   |\n"+
            "|_||_||_||_||_||_||_| _|  |"
    assert_equal("000000051", @reader.read_line(input))
  end

  def test_49086771E_should_be_corrected
    input = "    _  _  _  _  _  _     _ \n"+
            "|_||_|| ||_||_   |  |  | _ \n"+
            "  | _||_||_||_|  |  |  | _|"
    assert_equal("490867715", @reader.read_line(input))
  end

end