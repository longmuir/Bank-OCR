require_relative '../lib/repair'
require_relative '../lib/checksum'
require 'test/unit'

class RepairTest < Test::Unit::TestCase

  def setup
    @repair = Repair.new(CheckSum.new)
  end

  def test_11111111
    input = "111111111"
    assert_equal(["711111111"],@repair.get_possible_fixes(input))
  end
  
  def test_200000000
    input = "200000000"
    assert_equal(["200800000"],@repair.get_possible_fixes(input))
  end

  def test_333333333
    input = "333333333"
    assert_equal(["333393333"],@repair.get_possible_fixes(input))
  end


end