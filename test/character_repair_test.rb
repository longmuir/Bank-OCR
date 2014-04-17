require_relative '../lib/character_repair'
require_relative '../lib/ocr_character'
require 'test/unit'

class CharacterRepairTest < Test::Unit::TestCase

  def setup
    @char_repair = CharacterRepair.new(OCRCharacter.new)
  end

  def test_should_fix_1234E678E_with_two_possibilities
    error_line = "1234?678?"
    input      = "    _  _     _  _  _  _  _ \n"+ 
            "  | _| _||_| _ |_   ||_||_|\n"+
            "  ||_  _|  | _||_|  ||_| _ \n"
    errors = { 4 => " _  _  _|", 8 => " _ |_| _ "}
    possible_errors = @char_repair.get_possible_fixes(error_line, errors)
    assert_equal(["123456789","123436789"],possible_errors)
  end

end