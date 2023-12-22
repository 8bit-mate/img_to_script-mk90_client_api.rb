# frozen_string_literal: true

require_relative "lib/img_to_script/mk90_client_api/version"

Gem::Specification.new do |spec|
  spec.name = "img_to_script-mk90_client_api"
  spec.version = ImgToScript::MK90ClientApi::VERSION
  spec.authors = ["8bit-m8"]
  spec.email = ["you@example.com"]

  spec.summary = "Provides an API between a client app and the img_to_script gem."
  spec.homepage = "https://github.com/8bit-mate/img_to_script-mk90_client_api.rb"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 3.0.0"

  spec.metadata["allowed_push_host"] = "https://rubygems.org"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = spec.homepage
  spec.metadata["changelog_uri"] = spec.homepage

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(__dir__) do
    `git ls-files -z`.split("\x0").reject do |f|
      (File.expand_path(f) == __FILE__) ||
        f.start_with?(*%w[bin/ test/ spec/ features/ .git .circleci appveyor Gemfile])
    end
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "dry-validation", "~> 1.10", ">= 1.10.0"
  spec.add_dependency 'dry-schema', "~> 1.13", '>= 1.13.3'
  spec.add_dependency "img_to_script", "~> 1.0", ">= 1.0.0"
  spec.add_dependency "rmagick-bin_magick", "~> 0.2", ">= 0.2.0"
  spec.add_dependency "zeitwerk", "~> 2.6", ">= 2.6.12"
end
