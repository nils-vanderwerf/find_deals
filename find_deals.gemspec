# frozen_string_literal: true

require_relative "lib/find_deals/version"

Gem::Specification.new do |spec|
  spec.name = "find_deals"
  spec.version = FindDeals::VERSION
  spec.authors = ["nils-vanderwerf"]
  spec.email = ["n.vanderw.92@gmail.com"]

  spec.summary = "A Web scraper for Scoopon to find deals and promotions"
  spec.description = "Based on the users city and category input, they scrape a list of deals from Scoopon.com. They have they choice to save to the database and view their saved deals."
  spec.homepage = "https://github.com/nils-vanderwerf/find_deals/"
  spec.license = "MIT"
  spec.required_ruby_version = Gem::Requirement.new(">= 2.4.0")

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/nils-vanderwerf/find_deals"
  spec.metadata["changelog_uri"] = "https://github.com/nils-vanderwerf/find_deals/blob/master/CHANGELOG.md"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{\A(?:test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "nokogiri"
  spec.add_dependency "require_all"
  spec.add_dependency "activerecord"
  spec.add_dependency "sqlite3"


  spec.add_development_dependency "bundler", "~> 2.2.11"
  spec.add_development_dependency "rake", "~> 10.0"

  spec.add_development_dependency "pry"

end
