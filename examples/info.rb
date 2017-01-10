require 'pp'
require 'yaml'
require 'infermedica'

access = YAML.load(File.read('./config.yaml'))
api = Infermedica::Api.new(access)

# Get info about the API

info = api.get_info

puts "API updated at:    #{info.updated_at}"
puts "Condition count:   #{info.conditions_count}"
puts "Lab test count:    #{info.lab_tests_count}"
puts "Risk factor count: #{info.risk_factors_count}"
puts "Symptom count:     #{info.symptoms_count}"

