require_relative 'checksum'
require_relative 'repair'

class AccountNumber
  DIGIT_COUNT = 9
  INVALID_CHAR = "?"

  attr_reader :number, :alternative_numbers

  def initialize(number)
    @checksum = CheckSum.new
    @number = number 
    @alternative_numbers = []
    validate_number
  end

  def add_alternates(numbers)
    @alternative_numbers += numbers.select { |num| @checksum.passes?(num) }
    check_for_certainty
  end

  def validate_number
    #refactor this ugly statement
    if !@number.include?(INVALID_CHAR) && !@checksum.passes?(@number)
      repair = Repair.new(@checksum)
      @alternative_numbers = repair.get_possible_fixes(@number)
      check_for_certainty
    end
  end

  def check_for_certainty
    if @alternative_numbers.size == 1
      @number = @alternative_numbers.pop
    end
  end

  def contains_illegible?
    @number.include?(INVALID_CHAR)
  end

  def checksum_passes?
    @checksum.passes?(@number)
  end

  def ambiguous?
    !@alternative_numbers.empty?
  end

  def format_output
    if contains_illegible?
      @number + " ILL"
    elsif ambiguous?
      @number + " AMB "+format_alternatives
    elsif !checksum_passes?
      @number + " ERR"     
    else
      @number 
    end
  end

  def format_alternatives
    "['"+@alternative_numbers.join("', '")+"']"
  end


end
