require 'net/http'
require 'json'
require 'uri'

require_relative 'infermedica/model'
require_relative 'infermedica/conditions'
require_relative 'infermedica/diagnosis'
require_relative 'infermedica/info'
require_relative 'infermedica/lab_tests'
require_relative 'infermedica/risk_factors'
require_relative 'infermedica/symptoms'
require_relative 'infermedica/connection'

# = Infermedica: A ruby interface to the infermedica REST API
#
# == Quick Start
#
# You will need a valid *api_id* and *api_key*.
# Get one from https://developer.infermedica.com/docs/api
#
# To start using the API, require the infermedica gem and create an
# Infermedica::Api object, passing the api_id and api_key to the constructor
#
# The constructor takes a hash as argument, so you have different options
# to pass the id and key:
#
#    require 'infermedica'
#    api = Infermedica::Api.new(api_id: 'xxxxx', api_key: 'xxxxxxxxxxx')
#
# or put the key and id in a .yaml file, read it and pass the resulting hash
#
# In config.yaml
#    :api:id:  xxxxx
#    :api_key: xxxxxxxxxxx
#
# In your script
#
#    require 'infermedica'
#    require 'yaml'
#    access = YAML.load(File.read('./config.yaml'))
#    api = Infermedica::Api.new(access)

module Infermedica

  # Api defines all operations available from the REST API

  class Api

    def get_conditions     # return a Hash of known conditions
      get_collection('/conditions')
    end

    def get_condition(id) # return a Condition object
      response = @connection.get("/conditions/#{id}")
      return Condition.new(response)
    end

    def get_lab_tests # erturn a Hash of lab_tests
      get_collection('/lab_tests')
    end

    def get_lab_test(id) # return a LabTest object
      response = @connection.get("/lab_tests/#{id}")
      return LabTest.new(response)
    end

    def get_risk_factors # return a Hash of risk_factors
      get_collection('/risk_factors')
    end

    def get_risk_factor(id) # return a RiskFactor object
      response = @connection.get("/risk_factors/#{id}")
      return RiskFactor.new(response)
    end

    def get_symptoms # return a list of symptoms
      get_collection('/symptoms')
    end

    def get_symptom(id) # return a Symptom object
      response = @connection.get("/symptoms/#{id}")
      return Symptom.new(response)
    end

    # Get the Api info (version, date, 
    # number of conditions, lab_tests, risk_factors, symptoms

    def get_info 
      response = @connection.get("/info")
      return Info.new(response)
    end

    # Submit a diagnosis object to get a diagnosis, or a list of additional
    # conditions required to refine the diagnosis
    # See examples/diagnosis.rb for an example
    def diagnosis(diag)
      response = @connection.post('/diagnosis', diag.to_json)
    end

    # Submit a diagnosis object to get an explanation
    # See examples/explain.rb for an example
    def explain(req, args = {})
      response = @connection.post('/explain', req.to_json, args)
    end

    # Submit a search request, possibly filtered by where to look
    # See examples/search.rb for an example

    def search(phrase, args = {})
      url = '/search?phrase=' + phrase
      args['max_results'] = 8 unless args.key?('max_results')
      args.each do |k, v| 
        puts "'#{k}': #{v.class} #{v}"
        if v.is_a?(Array) && k.to_s == 'filters'
          v.each { |e| url << "&type=#{e}" }
        else 
          url << "&#{k}=#{v}"
        end
      end
      puts "url: #{url}"
      response = @connection.get(url)
    end

    # Create a new Infermedica::Api object.
    # Takes a hash as argument.
    # The *api_id* and *api_key* entries are required.

    def initialize(args)
      raise ArgumentError, 
      'Infermedica::Api::initialize argument needs to be a Hash)' unless
        args.is_a?(Hash)
      raise ArgumentError, 'api_id is required' unless args.key?(:api_id)
      raise ArgumentError, 'api_key is required' unless args.key?(:api_key)

      connection_args = { api_id: args[:api_id], api_key: args[:api_key] }
      connection_args[:endpoint] = args[:endpoint] if args.key?(:endpoint)
      @connection = Connection.new(connection_args)

      # Probably need more argument validation here...
      args.each do |k, v|
        instance_variable_set(:"@#{k}", v)
      end
    end

    private

    # Common frontend to the public methods that require collections

    def get_collection(path) # :nodoc:
      response = @connection.get(path)
      # response is an array
      collection = {}
      response.each do |item|
        collection[item['id']] = item
      end
      collection
    end

  end # class Api
end # module
