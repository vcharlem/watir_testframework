# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'watir_testframework/version'

Gem::Specification.new do |spec|
  spec.name          = "watir_testframework"
  spec.version       = WatirTestframework::VERSION
  spec.authors       = ["Vladmr"]
  spec.email         = ["vcharlem@gmail.com"]

  spec.summary       = %q{Web Application TestFramework}
  spec.description   = %q{Test framework based on Watir, Ruby, Git and Rspec}
  spec.homepage      = "https://github.com/vcharlem/watir_testframework.git"
  spec.license       = "MIT"

  spec.files         = ["lib/common.rb",
                        "lib/setup.rb",
                        "lib/watir_testframework.rb",
                        "lib/tar.rb",
                        "bin/compress_template",
                        "bin/template/",
                        "lib/watir_testframework/version.rb"]
  spec.bindir        = "bin"
  spec.executables   = ["runregress"]
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.11"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "watir-webdriver", "~> 0.9.1"  
end
