require 'pp'
require 'yaml'
require 'infermedica'
require 'byebug'

access = YAML.load(File.read('./config.yaml'))
api = Infermedica::Api.new(access)

def dump_symptom(s)
  puts "Id:              #{s.id}"
  puts "Name:            #{s.name}"
  puts "Category:        #{s.category}"
  puts "Children:        #{s.children}"
  puts "Extras:          #{s.extras}"
  puts "Image Source:    #{s.image_source}"
  puts "Image url:       #{s.image_url}"
  puts "Parent Id:       #{s.parent_id}"
  puts "Parent Relation: #{s.parent_relation}"
  puts "Sex filter:      #{s.sex_filter}"
  puts "Question:        #{s.question}"
end

# Look for a specific symptom

sym = api.get_symptom('s_56')
dump_symptom(sym)

# Look for a non existent symptom

begin
  sym = api.get_symptom('fail_test')
rescue Infermedica::HttpError => e
  puts
  puts e
  puts
end

# Get a Hash of all symptoms
# Note that this is not a Hash of symptom objects, but a hash of
# hashes, with the symptom id as key

symptoms = api.get_symptoms
keys = symptoms.keys
puts "The API currently has #{keys.size} symptoms"

# Create an Infermedica::Symptom object from one of the hash entry

my_sym = Infermedica::Symptom.new(symptoms['s_551'])
dump_symptom(my_sym)
