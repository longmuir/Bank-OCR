class CheckSumRepair

  attr_reader :possible_fixes

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
    @possible_fixes = Array.new
    number.chars.each_with_index do |digit, index|
      add_fixed_number_if_passes(number, digit, index)
    end
    @possible_fixes
  end

  def add_fixed_number_if_passes(number, digit, index)
    OCR_ONE_OFF_CANDIDATES[digit].each do |candidate_digit|
      add_if_passes(compute_trial_number(number, candidate_digit, index))
    end
  end

  def compute_trial_number(number, candidate, index)
    trial_number = number.dup
    trial_number[index] = candidate
    trial_number
  end

  def add_if_passes(trial_number)
   @possible_fixes.push(trial_number) if @checksum.passes?(trial_number)
  end

end
