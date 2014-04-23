require_relative 'ocr_character'
require_relative 'ocr_line_parser'

#This class doesn't do much - remove!
class OCRLineReader

  attr_reader :number, :ocr_line

  def initialize(args = {})
    @lineParser = OCRLineParser.new(OCRCharacter.new)
  end

  def read_line(ocr_line)
    account_number = @lineParser.read_account_number(ocr_line)
    account_number.format_output
  end
    
end