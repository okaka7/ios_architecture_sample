# Uncomment the next line to define a global platform for your project
platform :ios, '11.0'

target 'iOSArchitectureKKSample' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  def shared_pods
    pod 'R.swift', '5.0.3'
    pod 'SwiftLint', '0.33.0'
  end

  # Pods for iOSArchitectureKKSample
  shared_pods

  target 'iOSArchitectureKKSampleTests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'iOSArchitectureKKSampleUITests' do
    inherit! :search_paths
    # Pods for testing
    shared_pods
  end

post_install do |installer|
    installer.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
            # This works around a unit test issue introduced in Xcode 10.
            # We only apply it to the Debug configuration to avoid bloating the app size
            if config.name == "Debug" && defined?(target.product_type) && target.product_type == "com.apple.product-type.framework"
                config.build_settings['ALWAYS_EMBED_SWIFT_STANDARD_LIBRARIES'] = "YES"
            end
        end
    end
end 


end
