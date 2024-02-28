require_relative "lib/tinysky/version"

Gem::Specification.new do |spec|
  spec.name = "tinysky"
  spec.version = Tinysky::VERSION
  spec.authors = ["Jon Allured"]
  spec.email = ["jon@jonallured.com"]

  spec.summary = "Very tiny client gem for the Bluesky API."
  spec.description = spec.summary
  spec.homepage = "https://github.com/jonallured/tinysky"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 2.6.0"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = spec.homepage

  spec.files = Dir.chdir(__dir__) do
    `git ls-files -z`.split("\x0").reject do |f|
      (File.expand_path(f) == __FILE__) ||
        f.start_with?(*%w[bin/ test/ spec/ features/ .git .circleci appveyor Gemfile])
    end
  end

  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]
end
