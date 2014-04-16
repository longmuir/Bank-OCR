class Repair
  OCR_ONE_OFF_CANDIDATES = {"0" => ["8"],
                            "1" => ["7"],
                            "2" => [],
                            "3" => ["9"],
                            "4" => [],
                            "5" => ["6","9"],
                            "6" => ["5","8"],
                            "7" => ["1"],
                            "8" => ["0","6","9"],
                            "9" => ["3","5","8"]
                          }

  def initialize(checksum_function)
    @checksum = checksum_function
  end
 
  def get_possible_fixes(number)
    possible_fixes = Array.new
    number.chars.each_with_index do |digit, index|
      alternative_digits = OCR_ONE_OFF_CANDIDATES[digit]

      alternative_digits.each do |candidate_digit|
        trial_number = number.dup
        trial_number[index] = candidate_digit

        if @checksum.passes?(trial_number)
          possible_fixes.push(trial_number) 
        end
      end
    end
    possible_fixes
  end
end
