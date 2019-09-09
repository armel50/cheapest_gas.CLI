lib = File.expand_path("lib", __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
#require "cheapest_gas_CLI/command_line_interface"

Gem::Specification.new do |spec|
  spec.name          = "cheapest_gas_CLI"
  spec.version       = "0.0.1"
  spec.authors       = ["Cloe Kouadjo"]
  spec.email         = ["armelfli50@gmail.com"]

  spec.summary       = %q{A gem to generate the location of the cheapest gas station near the user.}
  spec.homepage      = "https://github.com/armel50/cheapest_gas.CLI"
  spec.license       = "MIT"

#   spec.metadata["allowed_push_host"] = "TODO: Set to 'http://mygemserver.com'"

#   spec.metadata["homepage_uri"] = spec.homepage
#   spec.metadata["source_code_uri"] = "TODO: Put your gem's public repo URL here."
#   spec.metadata["changelog_uri"] = "TODO: Put your gem's CHANGELOG.md URL here."

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "bin"
  spec.executables   = "find-gas"
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 2.0"
  spec.add_development_dependency "rake", "~> 10.0"
end
