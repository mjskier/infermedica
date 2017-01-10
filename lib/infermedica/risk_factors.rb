module Infermedica

  # = RiskFactor
  # Represent an Infermedica risk factor object

  class RiskFactor
    include Infermedica::Model
    attr_accessor :id, :name, :category, :extras, :sex_filter,
                  :image_url, :image_source
  end

end
