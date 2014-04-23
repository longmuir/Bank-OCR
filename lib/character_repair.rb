
#Refactoring in Progress... recursive methods could be broken up more.
class CharacterRepair

  OCR_ALL_ON = " _ |_||_|".chars

  def initialize(char_parser)
    @char_parser = char_parser
    @possible_fixes = []
  end

  def get_possible_fixes(line_with_errors, errors)
    errors.each_key do |error_index|
      fixed_chars = find_alternatives(errors[error_index])
      insert_fixed_chars_and_check(line_with_errors, fixed_chars, errors, error_index)
    end
    @possible_fixes
  end

  def insert_fixed_chars_and_check(line_with_errors, fixed_chars, errors, error_index)
    fixed_chars.each do |fixed_char|
      line_to_fix = insert_fixed_character(line_with_errors, fixed_char, error_index)
      if not all_characters_ok_add_fix(line_to_fix)
        try_next_character(line_to_fix, errors, error_index)
      end
    end
  end

  def insert_fixed_character(line, fixed_char, index)
    new_line = line.dup
    new_line[index] = fixed_char
    new_line
  end

  def all_characters_ok_add_fix(line_to_fix)
    if not line_to_fix.include?("?")
      @possible_fixes.push(line_to_fix)
    end
  end

  def try_next_character(line_to_fix, errors, error_index)
    errors.delete(error_index)
    get_possible_fixes(line_to_fix, errors)
  end

  def find_alternatives(error_ocr_char)
    alternatives = [] 
    parts_of_bad_char = error_ocr_char.chars
    OCR_ALL_ON.each_with_index do |char, index|
      char_parts_to_try = assemble_char_to_try(parts_of_bad_char, char, index)
      trial_conversion = @char_parser.convert_to_char( char_parts_to_try.join )
      trial_conversion ? alternatives.push(trial_conversion) : nil
    end
    alternatives
  end

  def assemble_char_to_try(parts_of_bad_char, char, index)
    char_parts_to_try = parts_of_bad_char.dup
    if parts_of_bad_char[index] == char
      char_parts_to_try[index] = " "
    else
      char_parts_to_try[index] = char
    end
    char_parts_to_try
  end
  
end