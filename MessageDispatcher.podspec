#
# Be sure to run `pod lib lint MessageDispatcher.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'MessageDispatcher'
  s.version          = '0.1.1'
  s.summary          = 'A simple class for sending messages of a generic type to weakly held listeners.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
A simple class for sending messages of a generic type to multiple listeners. Listeners are weakly held and the message dispatcher auto-resizes its table of listeners on message send, or when `resize` is manually called.
                       DESC

  s.homepage         = 'https://github.com/popwarsweet/MessageDispatcher'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'popwarsweet' => 'popwarsweet@gmail.com' }
  s.source           = { :git => 'https://github.com/popwarsweet/MessageDispatcher.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/kylezaragoza'

  s.ios.deployment_target = '8.0'

  s.source_files = 'MessageDispatcher/Classes/**/*'
  
  # s.resource_bundles = {
  #   'MessageDispatcher' => ['MessageDispatcher/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
