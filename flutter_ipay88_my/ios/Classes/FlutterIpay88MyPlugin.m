#import "FlutterIpay88MyPlugin.h"
#if __has_include(<flutter_ipay88_my/flutter_ipay88_my-Swift.h>)
#import <flutter_ipay88_my/flutter_ipay88_my-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "flutter_ipay88_my-Swift.h"
#endif

@implementation FlutterIpay88MyPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftFlutterIpay88MyPlugin registerWithRegistrar:registrar];
}
@end
