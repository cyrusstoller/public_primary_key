# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'public_primary_key/version'

Gem::Specification.new do |spec|
  spec.name          = "public_primary_key"
  spec.version       = PublicPrimaryKey::VERSION
  spec.authors       = ["Cyrus Stoller"]
  spec.email         = ["cyrus.stoller@gmail.com"]

  spec.summary       = %q{Public primay key makes it easy to obscure how many records you have in your application.}
  spec.description   = %q{It's often advantageous to use integer primary keys,
                          but it may be disadvantageous to expose the size of your database to open internet.
                          This gem makes it easy to continue using an integer primary key internally in your code,
                          while displaying a more obscure public primary key that does not give clues to the size of
                          your database to your users.}
  spec.homepage      = "https://github.com/cyrusstoller/public_primary_key"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.14"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "minitest", "~> 5.0"
  spec.add_development_dependency "sqlite3"

  spec.add_dependency "activerecord", "> 4.0"
end
