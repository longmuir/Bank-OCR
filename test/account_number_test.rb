require_relative '../lib/account_number'
require "test/unit"

class AccountNumberTest < Test::Unit::TestCase

  def test_123456789_ok
    account_number = AccountNumber.new("123456789")
    assert_equal("123456789", account_number.number)
    assert_equal([], account_number.alternative_numbers)
    assert !account_number.contains_illegible?
    assert account_number.checksum_passes?
    assert !account_number.ambiguous?
  end

  def test_111111111_corrected_by_1
    account_number = AccountNumber.new("111111111")
    assert_equal("711111111", account_number.number)
    assert_equal([], account_number.alternative_numbers)
    assert !account_number.contains_illegible?
    assert account_number.checksum_passes?
    assert !account_number.ambiguous?
  end

  def test_666666666_ambiguous
    account_number = AccountNumber.new("666666666")
    assert_equal("666666666", account_number.number)
    assert account_number.ambiguous?
    assert_equal(["686666666","666566666"], account_number.alternative_numbers)
  end

  def test_add_two_alternates_should_only_take_one
    account_number = AccountNumber.new("1234?678?")
    account_number
    account_number.add_alternates(["123456789","123436789"])
    assert_equal("123456789", account_number.number)
    assert_equal([], account_number.alternative_numbers)
  end

end