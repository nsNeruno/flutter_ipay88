#import <Flutter/Flutter.h>
#import "Ipay.h"

@interface FlutterIpay88IdPlugin : NSObject<FlutterPlugin, PaymentResultDelegate> {
    Ipay* paymentSdk;
}
@end
