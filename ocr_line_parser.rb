require_relative 'ocr_checksum'

class OCRLineParser
 
  attr_reader :number

  def initialize(ocr_line, char_parser)
    @char_parser = char_parser
    @ocr_line = ocr_line
    @number = convert_line
  end

  def convert_line()
    ocr_chars = split_ocrline_into_ocrchars
    ocr_chars.reduce("") { |a, e| a + @char_parser.convert_to_char(e) }
  end

  def split_ocrline_into_ocrchars()
    #TODO: Perhaps there's a more ruby-esque way to do this - looking to learn!
    ocr_chars = Array.new
    (0..index_of_last_ocrchar).step(ocr_char_size) do |index|
      ocr_chars.push ( get_ocrchar_at_index(lines_from_ocrline, index) )
    end
    ocr_chars
  end

  def lines_from_ocrline
    @ocr_line.split("\n")
  end

  def get_ocrchar_at_index(sub_lines, index)
      verify_has_3_sublines(sub_lines)
      sub_lines[0].slice(index..index+ocr_char_size-1) +
      sub_lines[1].slice(index..index+ocr_char_size-1) +
      sub_lines[2].slice(index..index+ocr_char_size-1) 
  end

  def verify_has_3_sublines(lines)
    if lines.size != 3
      raise "Input OCR line did not contain 3 lines: #{lines}"
    end
  end

  def index_of_last_ocrchar
     digits_in_accountnumber*ocr_char_size-ocr_char_size
  end

  def checksum_passes?
    OCRCheckSum.new(@number).passes?
  end

  def contains_illegible?
    @number.include?("?")
  end

  def digits_in_accountnumber
    9
  end

  def ocr_char_size
    3
  end

end