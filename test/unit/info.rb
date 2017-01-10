require 'minitest/autorun'
require 'infermedica'

class TestCondition < Minitest::Test

  def setup
    the_info = {
      updated_at: '2016-11-21T13:26:04Z',
      conditions_count: '504',
      symptoms_count: '1110',
      risk_factors_count: '42',
      lab_tests_count: '457'
    }

    @info = Infermedica::Info.new(the_info)
  end


  def test_info_creation
    assert_equal @info.updated_at, '2016-11-21T13:26:04Z'
    assert_equal @info.conditions_count, '504'
    assert_equal @info.symptoms_count, '1110'
    assert_equal @info.risk_factors_count, '42'
    assert_equal @info.lab_tests_count, '457'
  end

end
