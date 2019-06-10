platform :ios, '11.0'

target 'SwiftFest' do
  use_frameworks!

  pod 'SwiftGen'
  pod 'SwiftLint'
  pod 'BonMot'
  pod 'SnapKit'
  pod 'Pastel'
  pod 'Down'
  pod 'AlamofireImage'

  pod 'SimulatorStatusMagic', :configurations => ['Debug']

end

target 'SwiftFestTests' do
  inherit! :search_paths
  pod 'Quick'
  pod 'Nimble'
end

target 'SwiftFestUITests' do
  inherit! :search_paths
  pod 'Quick'
  pod 'Nimble'
end
