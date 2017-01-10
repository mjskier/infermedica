require 'minitest/autorun'
require 'infermedica'

class TestCondition < Minitest::Test

  def setup
    a_symptom = {
      'id'=>'s_551',
      'name'=>'Toothache',
      'category'=>'Signs and symptoms',
      'extras'=>{},
      'children'=> [
                    {'id'=>'s_339', 'parent_relation'=>'diminishing_factor'},
                    {'id'=>'s_55', 'parent_relation'=>'exacerbating_factor'},
                    {'id'=>'s_231', 'parent_relation'=>'exacerbating_factor'},
                    {'id'=>'s_56', 'parent_relation'=>'exacerbating_factor'},
                    {'id'=>'s_240', 'parent_relation'=>'severity'},
                    {'id'=>'s_233', 'parent_relation'=>'severity'},
                    {'id'=>'s_279', 'parent_relation'=>'character'},
                    {'id'=>'s_267', 'parent_relation'=>'location'}],
      'sex_filter'=>'both',
      'image_url'=>nil,
      'image_source'=>nil,
      'parent_id'=>nil,
      'parent_relation'=>nil
    }

    @symptom = Infermedica::Symptom.new(a_symptom)
  end


  def test_symptom_creation
    assert_equal @symptom.id, 's_551'
    assert_equal @symptom.name, 'Toothache'
    assert_equal @symptom.category, 'Signs and symptoms'
    assert_equal @symptom.extras.class, Hash
    assert_equal @symptom.sex_filter, 'both'
    assert_equal @symptom.image_url, nil
    assert_equal @symptom.parent_id, nil
    assert_equal @symptom.parent_relation, nil
    assert_equal @symptom.children.class, Array
    assert_equal @symptom.children[1]['id'], 's_55'
    assert_equal @symptom.children[4]['parent_relation'], 'severity'
  end

end
