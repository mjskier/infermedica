require 'pp'
require 'yaml'
require 'infermedica'

access = YAML.load(File.read('./config.yaml'))
api = Infermedica::Api.new(access)

puts 'Look for evidences containing phrase headache:'
puts api.search('headache')
puts 'Look for evidences containing phrase breast, only for female symptoms:'
puts api.search('breast', sex: 'female')
puts 'Same, but only 5 results'
puts api.search('breast', sex: 'female', max_results: 5)
puts 'With filters now. Only search in symptom and risk_factor'
puts api.search('trauma', filters: ['symptom', 'risk_factor'])

