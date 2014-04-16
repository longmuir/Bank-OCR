require_relative 'account_number'

class OCRLineParser
 
  attr_reader :number, :errors

  def initialize(char_parser)
    @char_parser = char_parser
    @errors = {}
  end

  #refactor me
  def read_account_number(ocr_line)
    converted_line = convert_line(ocr_line) 
    account_number = AccountNumber.new( converted_line )
    
    if account_number.contains_illegible?
      possible_fixes = resolve_all_errors(converted_line)
      account_number.add_alternates(possible_fixes)
    end
    account_number
  end

  def resolve_all_errors(line_with_errors)
    @fixed_lines = []
    resolve_errors(line_with_errors, @errors)
  end

  #Now for a little recursion... needs refactoring!
  def resolve_errors(line_with_errors, errors)
    errors.each_key do |error_key|
      fixed_chars = @char_parser.find_alternatives(errors[error_key])

      fixed_chars.each do |fixed_char|
        line_to_fix = line_with_errors.dup
        line_to_fix[error_key] = fixed_char
        if line_to_fix.include?("?")
          errors.delete(error_key)
          resolve_errors(line_to_fix, errors)
        else
          @fixed_lines.push(line_to_fix)
        end
      end

    end
    @fixed_lines
  end
  
  #refactor me
  def convert_line(ocr_line)
    @errors = {}
    ocr_chars = split_ocrline_into_ocrchars(ocr_line)
    ocr_chars.each_with_index.reduce("") do |line_sum, (ocr_char, index)|
      ocr_conversion = convert_char(ocr_char)
      if !ocr_conversion 
        @errors[index] = ocr_char
        ocr_conversion = AccountNumber::INVALID_CHAR
      end
      line_sum + ocr_conversion
    end
  end

  def convert_char(ocr_char)
    result = @char_parser.convert_to_char(ocr_char) 
  end

  def split_ocrline_into_ocrchars(ocr_line)
    ocr_chars = Array.new
    (0..index_of_last_ocrchar).step(ocr_char_size) do |index|
      ocr_chars.push ( get_ocrchar_at_index(lines_from(ocr_line), index) )
    end
    ocr_chars
  end

  def lines_from(ocr_line)
    ocr_line.split("\n")
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
     AccountNumber::DIGIT_COUNT*ocr_char_size-ocr_char_size
  end

  def contains_illegible?(number)
    number.include?(AccountNumber::INVALID_CHAR)
  end

  def ocr_char_size
    3
  end

end