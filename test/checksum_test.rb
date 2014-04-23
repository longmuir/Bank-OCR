require_relative '../lib/checksum'
require "test/unit"

class OCRCheckSumTest < Test::Unit::TestCase

  def setup
    @checksum = CheckSum.new
  end

  def test_checksum_passes_allzeros
    assert @checksum.passes?("000000000")
  end

  def test_checksum_fails_664371495
    assert !@checksum.passes?("664371495")
  end

  def test_checksum_passes_457508000
    assert @checksum.passes?("457508000")
  end

  def test_as_int_array_return_array
    assert_equal([1,2,3,4,5,6,7,8,9], @checksum.as_int_array("123456789"))
  end

end
