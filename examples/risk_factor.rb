require 'pp'
require 'yaml'
require 'infermedica'
require 'byebug'

access = YAML.load(File.read('./config.yaml'))
api = Infermedica::Api.new(access)

def dump_risk_factor(rf)
  puts "Id:           #{rf.id}"
  puts "Name:         #{rf.name}"
  puts "Category:     #{rf.category}"
  puts "Extras:       #{rf.extras}"
  puts "Sex filter:   #{rf.sex_filter}"
  puts "Image url:    #{rf.image_url}"
  puts "Image source: #{rf.image_source}"
end

# Look for a specific risk factor

rf = api.get_risk_factor('p_37')
dump_risk_factor(rf)

# Look for a non existent risk factor

begin
  sym = api.get_risk_factor('fail_test')
rescue Infermedica::HttpError => e
  puts
  puts e
  puts
end

# Get a Hash of all risk factors
# Note that this is not a Hash of LabTest objects, but a hash of
# hashes, with the lab test id as key

rfs = api.get_risk_factors
keys = rfs.keys
puts "The API currently has #{keys.size} risk factors"

# Create an Infermedica::RiskFactor object from one of the hash entry

my_rf = Infermedica::RiskFactor.new(rfs['p_37'])
dump_risk_factor(my_rf)
