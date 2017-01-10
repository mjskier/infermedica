require 'minitest/autorun'
require 'infermedica'

class TestCondition < Minitest::Test

  def setup
    @diag = Infermedica::Diagnosis.new(sex: 'male', age: '35')
  end

  def test_diagnosis_creation
    assert_equal @diag.sex, 'male'
    assert_equal @diag.age, '35'
  end

  def test_symptom_addition
    assert_equal @diag.symptoms.class, Array
    assert_equal @diag.symptoms.empty?, true
    @diag.add_symptom('s_10', 'present')
    assert_equal @diag.symptoms[0][:id], 's_10'
    assert_equal @diag.symptoms[0][:choice_id], 'present'
  end

  def test_pursued_addition
    assert_equal @diag.pursued.class, Array
    assert_equal @diag.pursued.empty?, true
    @diag.add_pursued_conditions(['c_33', 'c_49'])
    assert_equal @diag.pursued.size, 2
    assert_equal @diag.pursued[0], 'c_33'
  end

  def test_target_addition
    assert_equal @diag.target, nil
    @diag.add_target('c_371')
    assert_equal @diag.target, 'c_371'
  end

  def test_the_to_json_method
    json = @diag.to_json
    assert_equal json.class, String
    match = json =~ /\"age\":\"(\d+)\"/
    assert_equal $1, '35'
  end

end
