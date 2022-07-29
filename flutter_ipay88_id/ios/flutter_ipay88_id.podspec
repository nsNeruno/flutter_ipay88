#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html.
# Run `pod lib lint flutter_ipay88_id.podspec` to validate before publishing.
#
Pod::Spec.new do |s|
  s.name             = 'flutter_ipay88_id'
  s.version          = '0.0.1'
  s.summary          = 'Unofficial Implementation for Indonesian IPay88 Payment Gateway Mobile SDK.'
  s.description      = <<-DESC
Unofficial Implementation for Indonesian IPay88 Payment Gateway Mobile SDK.
                       DESC
  s.homepage         = 'https://github.com/nsNeruno/flutter_ipay88'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'Nanan Setiady' => 'infinia249@gmail.com' }
  s.source           = { :path => '.' }
  s.source_files = 'Classes/**/*'
  s.dependency 'Flutter'
  s.platform = :ios, '9.0'

  # Flutter.framework does not contain a i386 slice.
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES', 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'i386' }
  # s.public_header_files = 'Classes/**/*.h'
  # s.static_framework = true
end
