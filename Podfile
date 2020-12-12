# Uncomment the next line to define a global platform for your project
# platform :ios, '10.0'

target 'Biofit' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for Biofit

	pod 'Firebase/Analytics'
	pod 'Firebase/Auth'
	pod 'Firebase/Core'
	pod 'Firebase/Firestore'
	pod 'FirebaseFirestoreSwift'


post_install do |pi|
    pi.pods_project.targets.each do |t|
      t.build_configurations.each do |config|
        config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '10.0'
      end
    end
end



  target 'BiofitTests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'BiofitUITests' do
    # Pods for testing
  end

end
