module Infermedica

  # = Diagnosis
  #
  # Interface to the /diagnosis and /explain endpoints
  # See examples/diagnosis.rb and examples/explain.rb for example use

  class Diagnosis

    def initialize(args)
      raise ArgumentError, 'Patient sex is required' unless args.key?(:sex)
      raise ArgumentError, 'Patient age is required' unless args.key?(:age)

      args[:time] = Time.now unless args.key?(:time)
      args[:case_id] = nil unless args.key?(:case_id)

      args.each do |k, v|
        instance_variable_set(:"@#{k}", v)
      end

      %w[ symptoms lab_tests risk_factors pursued ].each do |k|
        args.key?(k) || instance_variable_set(:"@#{k}", Array.new)
      end
      
      @extras = {}
      @extras_permanent = {}

    end

    # Add a symptom to the list of symptom kept in this object
    # k: symptom code (for example 's_10'
    # v: symptom appropriate value (for example 'present')

    def add_symptom(k, v)
      @symptoms << { 'id': k, 'choice_id': v }
    end

    # Add a pursued_conditions
    # TODO: find out what these are and how they are used

    def add_pursued_conditions(args)
      @pursued.push(*args)
    end

    # Add a target condition that will be used by the /explain endpoint
    # v: The target condition (for example 'c_371')

    def add_target(v)
      @target = v
    end

    # Convert self to a json representation

    def to_json(*a)
      h = { 
        'sex': @sex,
        'age': @age,
        'evidence': @symptoms,
        'extras': @extras,
      }
      h['target'] = @target unless @target.nil?
      h['pursued'] = @pursued unless @pursued.empty?
      h['lab_tests'] = @lab_tests unless @lab_tests.empty?
      h['risk_factors'] = @risk_factors unless @risk_factors.empty?
      h['extras_permanent'] = @extras_permanent unless @extras_permanent.empty?
      h.to_json(*a)
    end

  end # class Diagnosis
  
end # module
