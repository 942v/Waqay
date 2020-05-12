#
# Be sure to run `pod lib lint Waqay_iOS.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'Waqay_iOS'
  s.version          = '0.1.0'
  s.summary          = 'All UI logic for iOS.'
  s.description      = 'Contains all iOS specific logic for Waqay'
  s.homepage         = 'https://proatomicdev.com'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { '942v' => 'gsaenz@proatomicdev.com' }
  s.source           = { :path => '.' }
  s.ios.deployment_target = '11.4'
  s.swift_versions = '5.1'
  s.source_files = 'Waqay_iOS/Classes/**/*.{swift}'
  
  s.resource_bundles = {
    'Waqay_iOS' => ['Waqay_iOS/Classes/**/*.storyboard']
  }
  # s.frameworks = 'UIKit', 'MapKit'
  s.dependency 'RxCocoa'
  s.dependency 'WaqayKit'
  s.dependency 'PATools'
end
