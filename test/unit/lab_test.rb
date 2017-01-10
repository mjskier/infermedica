require 'minitest/autorun'
require 'infermedica'

class TestCondition < Minitest::Test

  def setup
    a_lab_test = {
      'id': 'lt_81',
      'name': 'Blood urea nitrogen (BUN)',
      'category': 'Biochemistry',
      'results' =>  [ 
                     {'id' => 'lt_81_1', 'type' => 'low'}, 
                     {'id' => 'lt_81_2', 'type' => 'normal'},
                     {'id' => 'lt_81_3', 'type' => 'high'}]}

    @lab_test = Infermedica::LabTest.new(a_lab_test)
  end


  def test_lab_test_creation
    assert_equal @lab_test.id, 'lt_81'
    assert_equal @lab_test.name, 'Blood urea nitrogen (BUN)'
    assert_equal @lab_test.category, 'Biochemistry'
    assert_equal @lab_test.results.class, Array
    assert_equal @lab_test.results[0].class, Hash
    assert_equal @lab_test.results[0]['id'], 'lt_81_1'
    assert_equal @lab_test.results[1]['type'], 'normal'
  end

end
