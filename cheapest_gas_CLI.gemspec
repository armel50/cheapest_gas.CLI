lib = File.expand_path("lib", __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)


Gem::Specification.new do |spec|
  spec.name          = "cheapest_gas_CLI"
  spec.version       = "0.0.4"
  spec.authors       = ["Cloe Kouadjo"]
  spec.email         = ["armelfli50@gmail.com"]

  spec.summary       = %q{A gem to generate the location of the cheapest gas station near the user.}
  spec.homepage      = "https://github.com/armel50/cheapest_gas.CLI"
  spec.license       = "MIT"


  spec.files = ["bin/find-gas"]
  
  spec.bindir        = "bin"
  spec.executables   = "find-gas"
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 2.0"
  spec.add_development_dependency "rake", "~> 10.0" 
  spec.add_development_dependency "nokogiri" 
  spec.add_development_dependency "colorize"
  
end
