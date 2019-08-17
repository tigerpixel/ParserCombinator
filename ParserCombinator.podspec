#
# Be sure to run `pod lib lint ParserCombinator.podspec' to ensure this is a
# valid spec before submitting.
#
# The podspec file for ParserCombinator. A simple functional parser.

Pod::Spec.new do |s|
  s.name             = 'ParserCombinator'
  s.version          = '2.0.0'
  s.summary          = 'Exquisitely simple functional parsing in Swift.'
  s.description      = <<-DESC
A simple parser combinator, created in Swift. Functional parser combinators can be extremely useful but can also be difficult to understand. ParserCombinator attempts to strip this back and create a simple and user friendly way to parse complex strings into other objects. Technical terms, like 'monad', are avoided or explained if necessary and docs are provided in plain English, with examples. 
                       DESC

  s.homepage         = 'https://github.com/tigerpixel/ParserCombinator'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Tigerpixel' => 'l.flynn2@live.co.uk' }
  s.source           = { :git => 'https://github.com/tigerpixel/ParserCombinator.git', :tag => s.version.to_s }

  s.requires_arc          = true
  s.ios.deployment_target = '8.0'
  s.watchos.deployment_target = '2.0'
  s.osx.deployment_target = '10.9'
  s.tvos.deployment_target = '9.0'
  s.swift_version = '5.0'

  s.source_files = 'Source/**/*.swift'
end
