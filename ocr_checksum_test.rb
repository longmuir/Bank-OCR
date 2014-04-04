require_relative 'ocr_checksum'

require 'test/unit'

class OCRCheckSumTest < Test::Unit::TestCase

  def test_checksum_allzeros
    checksum = OCRCheckSum.new("000000000")
    assert checksum.passes?
  end

  def test_checksum_fails_664371495
    checksum = OCRCheckSum.new("664371495")
    assert !checksum.passes?
  end

  def test_checksum_passes_457508000
    checksum = OCRCheckSum.new("457508000")
    assert checksum.passes?
  end


  def test_number_as_int_array
    checksum = OCRCheckSum.new("123456789")
    assert_equal([1,2,3,4,5,6,7,8,9], checksum.number_as_int_array)
  end

end
