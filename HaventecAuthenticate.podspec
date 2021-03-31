Pod::Spec.new do |s|
  s.name             = 'HaventecAuthenticate'
  s.version          = '1.2.0'
  s.summary          = 'SDK providing functions for interacting with the Authenticate API.'

  s.description      = <<-DESC
'SDK providing functions for interacting with the Authenticate API.'
                       DESC

  s.homepage         = 'https://github.com/Haventec/authenticate-ios-sdk'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Haventec' => 'info@haventec.com' }
  s.source           = { :git => 'https://github.com/Haventec/authenticate-ios-sdk.git', :tag => s.version.to_s }

  s.ios.deployment_target = '9.0'

  s.source_files = 'HaventecAuthenticate/Classes/**/*'
  
  s.dependency 'HaventecCommon', '~> 1.1.0'
  s.dependency 'SwiftKeychainWrapper'
  s.dependency 'JWTDecode', '~> 2.2'
  s.swift_version = '4.2'
end
