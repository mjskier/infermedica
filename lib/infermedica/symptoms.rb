module Infermedica

  # = Symptom
  # Represents an Infermedica symptom

  class Symptom
    include Infermedica::Model

    attr_accessor :id, :name, :category, :children, :extras,
                  :image_source, :image_url, :parent_id,
                  :parent_relation, :question, :sex_filter
  end
end
