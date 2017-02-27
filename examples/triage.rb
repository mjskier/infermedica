require 'pp'
require 'yaml'
require 'infermedica'

access = YAML.load(File.read('./config.yaml'))
api = Infermedica::Api.new(access)

# Create a diagnosis object with some initial patient info

diag = Infermedica::Diagnosis.new(sex: 'male', age: '35')

diag.add_symptom('s_1193', 'present')
diag.add_symptom('s_488', 'present')
diag.add_symptom('s_418', 'present')

# Call the triage endpoint

resp = api.triage(diag)

# Print the resulting data structure

pp resp
