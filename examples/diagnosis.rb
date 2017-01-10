require 'pp'
require 'yaml'
require 'infermedica'

access = YAML.load(File.read('./config.yaml'))
api = Infermedica::Api.new(access)

# Create a diagnosis object with some initial patient info

diag = Infermedica::Diagnosis.new(sex: 'male', age: '35')

diag.add_symptom('s_21', 'present')
diag.add_symptom('s_98', 'present')
diag.add_symptom('s_107', 'present')

diag.add_pursued_conditions(['c_33', 'c_49'])  # Optional

# Call the diagnosis endpoint

resp = api.diagnosis(diag)

# update diag with answers to questions in resp

diag.add_symptom('s_99', 'present')
diag.add_symptom('s_8',  'absent')
diag.add_symptom('s_25', 'present')

# Call diagnosis with updated symptoms

resp = api.diagnosis(diag)

diag.add_symptom('s_1193', 'present')
diag.add_symptom('s_604',  'present')
diag.add_symptom('s_23', 'absent')

resp = api.diagnosis(diag)

diag.add_symptom('s_122', 'absent')
resp = api.diagnosis(diag)

# Print the resulting data structure

pp resp
