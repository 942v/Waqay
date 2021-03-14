platform :ios, '11.4'

target 'Waqay' do
  use_frameworks! :linkage => :static
  
  pod 'PromiseKit', :inhibit_warnings => true
  pod 'RxCocoa', :inhibit_warnings => true
  pod 'R.swift'
  pod 'SnapKit'
  pod 'OneSignal'
  
  pod 'WaqayKit', :path => "WaqayKit", :preserve_pod_file_structure => true
  pod 'PATools', :path => "PATools", :preserve_pod_file_structure => true

  target 'WaqayTests' do
    inherit! :search_paths
    # Pods for testing
  end
  
  target 'WaqayNotificationServiceExtension' do
    pod 'OneSignal'
  end

end
