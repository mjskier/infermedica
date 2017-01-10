require 'pp'
require 'yaml'
require 'infermedica'

access = YAML.load(File.read('./config.yaml'))
api = Infermedica::Api.new(access)

# Create a diagnosis object

req = Infermedica::Diagnosis.new(sex: 'female', age: '35')

# Add some symptoms

req.add_symptom('s_10', 'present')
req.add_symptom('s_608', 'present')
req.add_symptom('s_1394', 'absent')
req.add_symptom('s_216', 'present')
req.add_symptom('s_9', 'present')
req.add_symptom('s_188', 'present')

# Add a target condition

req.add_target('c_371')

# See if the symptoms fit the condition

resp = api.explain(req)

# Print the resulting data structure

pp resp

