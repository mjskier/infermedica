require 'minitest/autorun'
require 'infermedica'

class TestCondition < Minitest::Test

  def setup
    a_condition = {
      "id"=>"c_537",
      "name"=>"Abdominal obesity",
      "prevalence"=>"common", 
      "acuteness"=>"chronic",
      "severity"=>"moderate",
      "sex_filter"=>"both",
      "categories"=>["Internal Medicine"],
      "extras"=> {
        "hint"=>"Please consult your family doctor.", 
        "icd10_code"=>"E65"
      },
    }

    @condition = Infermedica::Condition.new(a_condition)
  end


  def test_condition_creation
    assert_equal @condition.id, 'c_537'
    assert_equal @condition.name, 'Abdominal obesity'
    assert_equal @condition.prevalence, 'common'
    assert_equal @condition.acuteness, 'chronic'
    assert_equal @condition.severity, 'moderate'
    assert_equal @condition.sex_filter, 'both'
    assert_equal @condition.categories.class, Array
    assert_equal @condition.categories[0], 'Internal Medicine'
    assert_equal @condition.extras.class, Hash
    assert_includes @condition.extras, 'hint'
    assert_equal @condition.extras['icd10_code'], 'E65'
  end

end
