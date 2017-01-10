module Infermedica

  # = LabTest
  #
  # Representation of a Lab Test

  class LabTest
    include Infermedica::Model
    attr_reader :id, :name, :category, :results
  end

end
