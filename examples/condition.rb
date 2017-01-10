require 'pp'
require 'yaml'
require 'infermedica'
require 'byebug'

access = YAML.load(File.read('./config.yaml'))
api = Infermedica::Api.new(access)

def dump_condition(cond)
  puts "Id:         #{cond.id}"
  puts "Name:       #{cond.name}"
  puts "Categories: #{cond.categories}"
  puts "Prevalence: #{cond.prevalence}"
  puts "Acuteness:  #{cond.acuteness}"
  puts "Severity:   #{cond.severity}"
  puts "Extras:     #{cond.extras}"
  puts "Sex filter: #{cond.sex_filter}"
end

# Look for a specific condition

cond = api.get_condition('c_537')
dump_condition(cond)

# Look for a non existent condition

begin
  cond = api.get_condition('fail_test')
rescue Infermedica::HttpError => e
  puts
  puts e
  puts
end

# Get hash of all conditions.
# Note that this is not an Hash of Condition objects, but a hash of
# hashes, with the condition id as key

conditions = api.get_conditions
keys = conditions.keys
puts "The API currently has #{keys.size} conditions"

# Create an Infermedica::Condition object from one of the hash entry

my_cond = Infermedica::Condition.new(conditions['c_537'])
dump_condition(my_cond)
