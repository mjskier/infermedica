module Infermedica

  # = Condition
  #
  # Represents an infermedica condition
  
  class Condition
    include Infermedica::Model
    attr_reader :id, :name, :categories, :prevalence, :acuteness,
    :severity, :extras, :sex_filter
  end

end
