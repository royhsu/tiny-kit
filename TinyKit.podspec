Pod::Spec.new do |spec|
  spec.name = 'TinyKit'
  spec.version = '0.11.0'
  spec.license = 'MIT'
  spec.summary = 'TinyKit provides practical functionalities that will help us to build apps much more quickly.'
  spec.homepage = 'https://github.com/royhsu/tiny-kit'
  spec.authors = { 'Roy Hsu' => 'roy.hsu@tinyworld.cc' }
  spec.source = { 
    :git => 'https://github.com/royhsu/tiny-kit.git',
    :tag => spec.version
  }
  spec.framework = 'UIKit'
  spec.source_files = 'Sources/Core/Sources/*.swift', 'Sources/Core/Sources/**/*.swift', 'Sources/Core/Sources/**/**/*.swift', 'Sources/Core/Sources/**/**/**/*.swift'
  spec.ios.source_files = 'Sources/iOS/Sources/*.swift', 'Sources/iOS/Sources/**/*.swift', 'Sources/iOS/Sources/**/**/*.swift', 'Sources/iOS/Sources/**/**/**/*.swift'
  spec.ios.deployment_target = '10.0'
  spec.swift_version = '5.0'
  spec.dependency 'TinyCore', '0.9.0'
  spec.dependency 'TinyValidation', '0.3.0'
end
