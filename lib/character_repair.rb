class CharacterRepair

  OCR_ALL_ON = " _ |_||_|".chars

  def initialize(char_parser)
    @char_parser = char_parser
    @possible_fixes = []
  end

  def get_possible_fixes(line_with_errors, errors)
    errors.each_key do |error_key|
      fixed_chars = @char_parser.find_alternatives(errors[error_key])

      fixed_chars.each do |fixed_char|
        line_to_fix = insert_fixed_character(line_with_errors, fixed_char, error_key)
        if line_to_fix.include?("?")
          errors.delete(error_key)
          get_possible_fixes(line_to_fix, errors)
        else
          @possible_fixes.push(line_to_fix)
        end
      end
    end
    @possible_fixes
  end

  def insert_fixed_character(line, fixed_char, index)
    new_line = line.dup
    new_line[index] = fixed_char
    new_line
  end
  
end