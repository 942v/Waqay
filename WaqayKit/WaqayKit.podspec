Pod::Spec.new do |s|
  s.name             = 'WaqayKit'
  s.version          = '0.1.0'
  s.summary          = 'Data and logic layers of Waqay.'
  s.description      = 'Contains the logic and the data of all Waqay to be used in the targets that are needed'

  s.homepage         = 'https://proatomicdev.com'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { '942v' => 'gsaenz@proatomicdev.com' }
  s.source           = { :path => '.' }
  s.ios.deployment_target = '11.4'
  s.swift_versions = '5.1'
  s.source_files = 'WaqayKit/Classes/**/*.{swift}'
  s.resources = 'WaqayKit/Classes/**/*.xcdatamodeld'
  s.frameworks = 'CoreData'
  s.dependency 'RxSwift'
  s.dependency 'PromiseKit'
end
