class OCRCheckSum

  def initialize(number)
    @number = number
  end

  def passes?
    digits =  number_as_int_array.reverse
    index = 0
    product = digits.reduce(0) do | a, e | 
      index += 1
      a + e*index 
    end    
    product % 11 == 0
  end

  def number_as_int_array
    @number.chars.map { |digit| digit.to_i }
  end

end