Pod::Spec.new do |s|
  s.requires_arc = true
  s.name         = 'XXBNav'
  s.version      = '0.0.1'
  s.summary      = "20160415"
  s.homepage     = "https://github.com/sixTiger/XXBNav"
  s.license      = "MIT"
  s.authors      = { '杨小兵' => 'six_tiger@163.com' }
  s.platform     = :ios
  s.ios.deployment_target = '7.0'
  s.source       = { :git => "https://github.com/sixTiger/XXBNav.git"}
  s.public_header_files = 'XXBNav/XXBNavigationController.h'
  s.source_files = 'XXBNav/XXBNavigationController.{h,m}'
  s.requires_arc  = true
end
