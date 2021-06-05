# frozen_string_literal: true

require_relative 'lib/hexlet_code/version'

Gem::Specification.new do |spec|
  spec.name          = 'hexlet_code'
  spec.version       = HexletCode::VERSION
  spec.authors       = ['Konstantin Bochinin']
  spec.email         = ['konstantin6487@rambler.ru']

  spec.summary       = 'FormGenerator'
  spec.description   = 'FormGenerator is a DSL to make it far easier to create simple HTML forms'
  spec.homepage      = 'https://github.com/Konstantin6487/rails-project-lvl1'
  spec.license       = 'MIT'
  spec.required_ruby_version = Gem::Requirement.new('>= 3.0')

  spec.metadata['homepage_uri'] = spec.homepage
  spec.metadata['source_code_uri'] = 'https://github.com/Konstantin6487/rails-project-lvl1'
  spec.metadata['changelog_uri'] = 'https://github.com/Konstantin6487/rails-project-lvl1/blob/main/CHANGELOG.md'

  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files`.split('\x0').reject { |f| f.match(%r{\A(?:test|spec|features)/}) }
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']
end
