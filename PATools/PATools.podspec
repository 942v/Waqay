Pod::Spec.new do |s|
  s.name             = 'PATools'
  s.version          = '0.1.0'
  s.summary          = 'Common tools'
  s.description      = 'Common tools of PA'
  s.homepage         = 'https://proatomicdev.com'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { '942v' => 'gsaenz@proatomicdev.com' }
  s.source           = { :git => 'https://github.com/942v/PATools.git', :tag => s.version.to_s }
  s.ios.deployment_target = '11.4'
  s.swift_versions = '5.1'
  s.source_files = 'PATools/Classes/**/*.{swift}'
  
  # s.resource_bundles = {
  #   'PATools' => ['PATools/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
