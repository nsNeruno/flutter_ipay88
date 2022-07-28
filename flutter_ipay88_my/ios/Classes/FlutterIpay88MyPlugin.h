#import <Flutter/Flutter.h>
#import "Ipay.h"

@interface FlutterIpay88MyPlugin : NSObject<FlutterPlugin, PaymentResultDelegate> {
    Ipay* paymentSdk;
}
@end
