class CheckSum

  def passes?(number)
    digits =  as_int_array(number).reverse
    product = digits.each_with_index.reduce(0) do |sum, (elem, index)| 
      sum + elem*(index+1) 
    end
    product % 11 == 0
  end

  def as_int_array(number)
    number.chars.map { |digit| digit.to_i }
  end

end