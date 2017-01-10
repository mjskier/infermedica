require 'minitest/autorun'
require 'infermedica'

class TestCondition < Minitest::Test

  def setup
    a_risk_factor = {
      'id': 'p_37', 
      'name': 'Mushroom consumption', 
      'category': 'Risk factors', 
      'extras': {}, 
      'sex_filter': 'both', 
      'image_url': nil,
      'image_source': nil 
    }

    @risk_factor = Infermedica::RiskFactor.new(a_risk_factor)
  end


  def test_risk_factor_creation
    assert_equal @risk_factor.id, 'p_37'
    assert_equal @risk_factor.name, 'Mushroom consumption'
    assert_equal @risk_factor.category, 'Risk factors'
    assert_equal @risk_factor.extras.class, Hash
    assert_equal @risk_factor.sex_filter, 'both'
    assert_equal @risk_factor.image_url, nil
    assert_equal @risk_factor.image_source, nil
  end

end
