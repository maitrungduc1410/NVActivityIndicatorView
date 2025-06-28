Pod::Spec.new do |s|
  s.name             = 'NVActivityIndicatorView-ObjC'
  s.version          = '1.0.1'
  s.summary          = 'A collection of awesome loading animations for iOS, ported to Objective-C'

  s.description      = <<-DESC
NVActivityIndicatorView-ObjC is a comprehensive collection of 30+ beautiful loading animations for iOS applications. 
This library is a complete 1:1 Objective-C port of the popular Swift NVActivityIndicatorView library, providing 
the same stunning animations and functionality for Objective-C projects. Features include customizable colors, 
sizes, and animation speeds with an easy-to-use API.
                       DESC

  s.homepage         = 'https://github.com/maitrungduc1410/NVActivityIndicatorView'
  s.screenshots      = 'https://raw.githubusercontent.com/maitrungduc1410/NVActivityIndicatorView/master/demo.PNG'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'maitrungduc1410' => 'maitrungduc1410@gmail.com' }
  s.source           = { :git => 'https://github.com/maitrungduc1410/NVActivityIndicatorView.git', :tag => s.version.to_s }
  s.social_media_url = 'https://x.com/maitrungduc1410'

  s.ios.deployment_target = '9.0'

  s.source_files = 'NVActivityIndicatorView-ObjC/Classes/**/*'
  
  s.public_header_files = 'NVActivityIndicatorView-ObjC/Classes/**/*.h'
  s.frameworks = 'UIKit', 'QuartzCore'
end
