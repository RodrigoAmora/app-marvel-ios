# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'Marvel App' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  post_install do |installer|
      installer.generated_projects.each do |project|
            project.targets.each do |target|
                target.build_configurations.each do |config|
                    config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '15.0'
                 end
            end
     end
  end
  
  # Pods for Marvel App
  pod 'Alamofire', '~> 5.7.1'
  pod 'ObjectMapper', '~> 3.5'
  pod 'MaterialComponents/Buttons'
  
  target 'Marvel AppTests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'Marvel AppUITests' do
    # Pods for testing
  end

end
