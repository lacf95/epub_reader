# frozen_string_literal: true

require_relative "lib/epub_worm/version"

Gem::Specification.new do |spec|
  spec.name = "epub_worm"
  spec.version = EpubWorm::VERSION
  spec.authors = ["Luis Adrián Chávez Fregoso"]
  spec.email = ["biolacf@gmail.com"]

  spec.summary = "Another Ruby epub reader"
  spec.description = "EpubWorm is just another EPUB parser gem, with only two dependencies: \"rubyzip\" and \"nokogiri\"."
  spec.homepage = "https://github.com/lacf95/epub_worm"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 3.0.0"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/lacf95/epub_worm"
  spec.metadata["changelog_uri"] = "https://github.com/lacf95/epub_worm/blob/main/CHANGELOG.md"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  gemspec = File.basename(__FILE__)
  spec.files = IO.popen(%w[git ls-files -z], chdir: __dir__, err: IO::NULL) do |ls|
    ls.readlines("\x0", chomp: true).reject do |f|
      (f == gemspec) ||
        f.start_with?(*%w[bin/ test/ spec/ features/ coverage/ .git appveyor Gemfile Session.vim tags])
    end
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  # Parse XML files.
  spec.add_dependency "nokogiri", "~> 1.18"
  # Unzip and zip epub files.
  spec.add_dependency "rubyzip", "~> 2.4"
end
