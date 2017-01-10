Gem::Specification.new do |s|
  s.name = 'infermedica'
  s.version = '0.0.1'
  s.date = '2017-01-09'
  s.summary = 'Provide a Ruby interface to the Infermedica REST API'
  s.description = 'A Ruby interface to the Infermedica REST API'
  s.authors = ['Bruno Melli']
  s.email = 'mjskier@tegali.com'
  s.files = `git ls-files`.split($\)
  s.require_paths = ['lib']
  s.license = 'MIT'
  s.homepage = 'https://github.com/mjskier/infermedica'
  s.add_runtime_dependency 'json', '~>1.8', '>= 1.8.3'
end

