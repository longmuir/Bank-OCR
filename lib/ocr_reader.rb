require_relative 'ocr_character'
require_relative 'ocr_line_parser'
require_relative 'character_repair'

class OCRReader

  attr_reader :number, :ocr_line

  def initialize(args = {})
    @char_parser = OCRCharacter.new
    @lineParser = OCRLineParser.new(@char_parser)
  end

  def read_line(ocr_line)
    account_number = @lineParser.read_account_number(ocr_line)
    if @lineParser.errors
      account_number = repair(account_number)
    end
    account_number.format_output
  end

  def repair(account_number)
    if account_number.contains_illegible?
      char_repair = CharacterRepair.new(@char_parser)
      possible_fixes = char_repair.get_possible_fixes(account_number.number, @lineParser.errors)
      account_number.add_alternates(possible_fixes)
    end
    account_number
  end
    
end