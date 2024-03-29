lib = File.expand_path("lib", __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "chat_box/version"

Gem::Specification.new do |spec|
  spec.name          = "chat_box"
  spec.version       = ChatBox::VERSION
  spec.authors       = ["ravi kumar"]
  spec.email         = ["ravikumar@codegaragetech.com"]

  spec.summary       = %q{creating a chatbox}
  spec.description   = %q{creating a chatbox}
  spec.homepage      = "https://github.com/sharmaparas4444/chat_box"

  # spec.metadata["allowed_push_host"] = "TODO: Set to 'http://mygemserver.com'"

  # spec.metadata["homepage_uri"] = spec.homepage
  # spec.metadata["source_code_uri"] = "TODO: Put your gem's public repo URL here."
  # spec.metadata["changelog_uri"] = "TODO: Put your gem's CHANGELOG.md URL here."

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end

  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 2.0"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rails", "~> 5.2"
  spec.add_runtime_dependency 'devise', '~> 4'
  spec.add_runtime_dependency 'jquery-rails', '~> 4'
end
