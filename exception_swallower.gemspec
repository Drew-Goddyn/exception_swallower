Gem::Specification.new do |s|
  s.name        = 'exception-swallower'
  s.version     = '0.0.1'
  s.summary     = "Concern for defining exceptions to be swallowed"
  s.description = "This gem provides a concern that can be included into ruby classes. Once included, you can define exceptions which every class/instance method should swallow and not raise"
  s.author     = "Drew Goddyn"
  s.email       = 'drgoddyn@gmail.com'
  s.files       = ["lib/exception_swallower.rb"]
  s.license       = 'MIT'

  s.require_paths = ["lib"]

  s.add_development_dependency "rspec"
  s.add_development_dependency "pry-byebug"
end
