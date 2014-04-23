require_relative '../lib/character_repair'
require_relative '../lib/ocr_character'
require "test/unit"

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

  
  def test_find_alternatives_should_return_9
    input = "   "+
            "|_|"+
            " _|"
    alternatives = @char_repair.find_alternatives(input)
    assert alternatives.include?("4")
    assert alternatives.include?("9")
    assert alternatives.size == 2
  end

  def test_find_alternatives_should_return_1
    input = "   "+
            "  |"+
            "   "
    assert_equal(["1"], @char_repair.find_alternatives(input))
  end

  def test_find_alternatives_should_return_1_again
    input = "   "+
            "  |"+
            " _|"
    assert_equal(["1"], @char_repair.find_alternatives(input))
  end

end