require 'pp'
require 'yaml'
require 'infermedica'
require 'byebug'

access = YAML.load(File.read('./config.yaml'))
api = Infermedica::Api.new(access)

def dump_lab_test(lt)
  puts "Id:       #{lt.id}"
  puts "Name:     #{lt.name}"
  puts "Category: #{lt.category}"
  puts "Result:   #{lt.results}"
end

# Look for a specific lab test

lt = api.get_lab_test('lt_81')
dump_lab_test(lt)

# Look for a non existent symptom

begin
  sym = api.get_lab_test('fail_test')
rescue Infermedica::HttpError => e
  puts
  puts e
  puts
end

# Get a Hash of all lab tests
# Note that this is not an Hash of LabTest objects, but a hash of
# hashes, with the lab test id as key

lts = api.get_lab_tests
keys = lts.keys
puts "The API currently has #{keys.size} lab tests"

# Create an Infermedica::LabTest object from one of the hash entry

my_lt = Infermedica::LabTest.new(lts['lt_81'])
dump_lab_test(my_lt)
