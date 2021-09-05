#
# Be sure to run `pod lib lint SDWebImageSwiftUI.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'QzLib'
  s.version          = '1.0.4'
  s.summary          = 'SwiftUI Helper'

  s.description      = <<-DESC
a lot of help utils
                       DESC

  s.homepage         = 'https://github.com/qsfty/qzlib'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'qsfty' => '1009510944@qq.com' }
  s.source           = { :git => 'https://github.com/qsfty/qzlib.git', :tag => s.version.to_s }

  s.ios.deployment_target = '14.0'

  s.source_files = 'Lib/**/*'
  s.pod_target_xcconfig = {
    'SUPPORTS_MACCATALYST' => 'YES',
    'DERIVE_MACCATALYST_PRODUCT_BUNDLE_IDENTIFIER' => 'NO',
    'BUILD_LIBRARY_FOR_DISTRIBUTION' => 'YES'
  }

  s.weak_frameworks = 'SwiftUI', 'Combine'
  s.dependency 'Alamofire', '~> 5.4.1'
  s.dependency 'CleanJSON', '~> 1.0.8'

  s.swift_version = '5.2'
end
