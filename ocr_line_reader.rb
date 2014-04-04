require_relative 'ocr_character'
require_relative 'ocr_line_parser'

class OCRLineReader

  def initialize()
    @char_parser = OCRCharacter.new
  end

  def read_line(ocr_line)
    lineParser = OCRLineParser.new(ocr_line, @char_parser)
    format_output(lineParser)
  end

  def format_output(lineParser)
    if lineParser.contains_illegible?
       lineParser.number+" ILL"
    elsif !lineParser.checksum_passes?
      lineParser.number+" ERR"     
    else
      lineParser.number
    end
  end

    
end