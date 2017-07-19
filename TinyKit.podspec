Pod::Spec.new do |spec|
  spec.name             = 'TinyKit'
  spec.version          = '0.1.1'
  spec.license          = 'MIT'
  spec.homepage         = 'https://github.com/royhsu/tiny-kit.git'
  spec.authors          = { 'Roy Hsu' => 'roy.hsu@tinyworld.cc' }
  spec.summary          = 'To speed up the iOS development.'
  spec.source           = { :git => 'https://github.com/royhsu/tiny-kit.git', :tag => spec.version }

  spec.ios.deployment_target = '10.0'

  spec.source_files     = 'Sources/**/*.swift', 'Sources/*.swift'

  spec.dependency 'TinyCore', '0.1.0'
end
