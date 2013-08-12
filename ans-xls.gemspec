# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'ans-xls/version'

Gem::Specification.new do |gem|
  gem.name          = "ans-xls"
  gem.version       = Ans::Xls::VERSION
  gem.authors       = ["sakai shunsuke"]
  gem.email         = ["sakai@ans-web.co.jp"]
  gem.description   = %q{xls mime type を追加、 xml spreadsheet を出力する layout と helper を提供}
  gem.summary       = %q{xls 形式で出力、を実現する}
  gem.homepage      = "https://github.com/answer/ans-xls"

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]
end
