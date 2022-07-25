#import "FlutterIpay88IdPlugin.h"
#if __has_include(<flutter_ipay88_id/flutter_ipay88_id-Swift.h>)
#import <flutter_ipay88_id/flutter_ipay88_id-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "flutter_ipay88_id-Swift.h"
#endif

@implementation FlutterIpay88IdPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftFlutterIpay88IdPlugin registerWithRegistrar:registrar];
}
@end
