module Infermedica

  # = Info
  #
  # Class holding the response to an /info request
  #
  # This includes the date and version of the API, as well as counts for the
  # various collections available from the API

  class Info
    include Infermedica::Model
    attr_reader :updated_at, :conditions_count, :symptoms_count,
                :risk_factors_count, :lab_tests_count
  end

end
