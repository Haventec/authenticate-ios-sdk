Pod::Spec.new do |s|
  s.name             = 'HaventecAuthenticate'
  s.version          = '0.0.2'
  s.summary          = 'SDK providing functions for interacting with the Authenticate API.'

  s.description      = <<-DESC
'SDK providing functions for interacting with the Authenticate API.'
                       DESC

  s.homepage         = 'https://github.com/Haventec/authenticate-ios-sdk'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'htclifford' => 'clifford.phan@haventec.com' }
  s.source           = { :git => 'https://github.com/Haventec/authenticate-ios-sdk.git', :tag => s.version.to_s }

  s.ios.deployment_target = '8.0'

  s.source_files = 'HaventecAuthenticate/Classes/**/*'
  
  s.dependency 'HaventecCommon'
  s.dependency 'SwiftKeychainWrapper'
  s.swift_version = '4.2'
end
