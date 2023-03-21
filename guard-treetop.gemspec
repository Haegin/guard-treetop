# frozen_string_literal: true

Gem::Specification.new do |spec|
  spec.name = "guard-treetop"
  spec.version = "1.0.0"
  spec.authors = ["Harry Porter-Mills"]
  spec.email = ["guard-treetop@portermills.net"]

  spec.summary = "A treetop autoprocessor for Guard"
  spec.description = "A guard plugin to automatically compile treetop grammars to Ruby"
  spec.homepage = "https://github.com/haegin/guard-treetop"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 2.6.0"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/haegin/guard-treetop"
  spec.metadata["changelog_uri"] = "https://github.com/haegin/guard-treetop/blob/main/CHANGELOG.md"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(__dir__) do
    `git ls-files -z`.split("\x0").reject do |f|
      (File.expand_path(f) == __FILE__) || f.start_with?(*%w[bin/ test/ spec/ features/ .git .circleci appveyor])
    end
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "guard-compat", "~> 1.1"

  # For more information and examples about making a new gem, check out our
  # guide at: https://bundler.io/guides/creating_gem.html
end
