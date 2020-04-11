#
# Be sure to run `pod lib lint MessageDispatcher.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'MessageDispatcher'
  s.version          = '0.2.0'
  s.summary          = 'A simple class for sending messages of a generic type to weakly held listeners.'
  s.description      = <<-DESC
A simple class for sending messages of a generic type to multiple listeners. Listeners are weakly held and the message dispatcher auto-resizes its table of listeners on message send, or when `resize` is manually called.
                       DESC

  s.homepage         = 'https://github.com/popwarsweet/MessageDispatcher'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'popwarsweet' => 'popwarsweet@gmail.com' }
  s.source           = { :git => 'https://github.com/popwarsweet/MessageDispatcher.git', :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/kylezaragoza'

  s.ios.deployment_target = '8.0'

  s.source_files = 'MessageDispatcher/Classes/**/*'
end
