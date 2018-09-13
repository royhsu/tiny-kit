Pod::Spec.new do |spec|
  spec.name = 'TinyKit'
  spec.version = '0.8.0'
  spec.license = 'MIT'
  spec.summary = 'TinyKit provides practical functionalities that will help us to build apps much more quickly.'
  spec.homepage = 'https://github.com/royhsu/tiny-kit'
  spec.authors = { 'Roy Hsu' => 'roy.hsu@tinyworld.cc' }
  spec.source = { :git => 'https://github.com/royhsu/tiny-kit.git', :tag => spec.version }
  spec.framework = 'Foundation'
  spec.dependency 'TinyCore'
  spec.source_files = 'Sources/*.swift'
  spec.ios.source_files = 'Sources/iOS/*.swift'
  spec.ios.deployment_target = '9.0'
  spec.swift_version = '4.2'
end