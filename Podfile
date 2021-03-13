platform :ios, '11.4'

target 'Waqay' do
  use_frameworks! :linkage => :static
  

  pod 'WaqayKit', :path => "WaqayKit", :preserve_pod_file_structure => true
  pod 'Waqay_iOS', :path => "Waqay_iOS", :preserve_pod_file_structure => true
  pod 'PATools'

  pod 'OneSignal'

  target 'WaqayTests' do
    inherit! :search_paths
    # Pods for testing
  end
  
  target 'WaqayNotificationServiceExtension' do
    pod 'OneSignal'
  end

end
