#import "FlutterIpay88IdPlugin.h"
#import "Ipay.h"
#import "IpayPayment.h"

@implementation FlutterIpay88IdPlugin

static FlutterMethodChannel* channel;

-(id) init {
    self = [super init];
    paymentSdk = [[Ipay alloc] init];
    paymentSdk.delegate = self;
    return self;
}

+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
    channel = [FlutterMethodChannel
      methodChannelWithName:@"id.lab.neruno.ipay88/platform"
            binaryMessenger:[registrar messenger]];
    FlutterIpay88IdPlugin* instance = [[FlutterIpay88IdPlugin alloc] init];
    [registrar addMethodCallDelegate:instance channel:channel];
}

- (void)handleMethodCall:(FlutterMethodCall*)call result:(FlutterResult)result {
    if ([call.method isEqualToString:@"checkout"]) {
        result(nil);
        if (![call.arguments isKindOfClass:[NSDictionary class]]) {
            return;
        }
        NSDictionary* arguments = call.arguments;
        id merchantKey = [arguments objectForKey:@"merchantKey"];
        id merchantCode = [arguments objectForKey:@"merchantCode"];
        id paymentId = [arguments objectForKey:@"paymentId"];
        id refNo = [arguments objectForKey:@"refNo"];
        id amount = [arguments objectForKey:@"amount"];
        id currency = [arguments objectForKey:@"currency"];
        id prodDesc = [arguments objectForKey:@"prodDesc"];
        id userName = [arguments objectForKey:@"username"];
        id userEmail = [arguments objectForKey:@"userEmail"];
        id userContact = [arguments objectForKey:@"userContact"];
        id remark = [arguments objectForKey:@"remark"];
        id lang = [arguments objectForKey:@"lang"];
        id backendPostURL = [arguments objectForKey:@"backendPostURL"];
        
        IpayPayment* payment = [[IpayPayment alloc] init];
        [payment setMerchantKey:merchantKey ? [merchantKey description] : @""];
        [payment setMerchantCode:merchantCode ? [merchantCode description] : @""];
        [payment setPaymentId:paymentId ? [paymentId description] : @""];
        [payment setRefNo:refNo ? [refNo description] : @""];
        [payment setAmount:amount ? [amount description] : @"1.00"];
        [payment setCurrency:currency ? [currency description] : @"IDR"];
        [payment setProdDesc:prodDesc ? [prodDesc description] : @""];
        [payment setUserName:userName ? [userName description] : @""];
        [payment setUserEmail:userEmail ? [userEmail description] : @""];
        [payment setUserContact:userContact ? [userContact description] : @""];
        [payment setRemark:remark ? [remark description] : @""];
        [payment setLang:lang ? [lang description] : @""];
        [payment setCountry:@"ID"];
        [payment setBackendPostURL:backendPostURL ? [backendPostURL description] : @""];
        
        UIView* paymentView = [paymentSdk checkout:payment];
        if (paymentView != nil) {
            UIViewController* rootController = [[[UIApplication.sharedApplication delegate] window] rootViewController];
            [[rootController view] addSubview:paymentView];
        }
    } else if ([call.method isEqualToString:@"requery"]) {
        result(nil);
        if (![call.arguments isKindOfClass:[NSDictionary class]]) {
            return;
        }
        NSDictionary* arguments = call.arguments;
        id merchantCode = [arguments objectForKey:@"merchantCode"];
        id refNo = [arguments objectForKey:@"refNo"];
        id amount = [arguments objectForKey:@"amount"];
        IpayPayment* payment = [[IpayPayment alloc] init];
        [payment setMerchantCode:merchantCode ? [merchantCode description] : @""];
        [payment setRefNo:refNo ? [refNo description] : @""];
        [payment setAmount:amount ? [amount description] : @"1.00"];
        [paymentSdk requery:payment];
    } else {
        result(FlutterMethodNotImplemented);
    }
}

- (void)paymentSuccess:(NSString *)refNo withTransId:(NSString *)transId withAmount:(NSString *)amount withRemark:(NSString *)remark withAuthCode:(NSString *)authCode {
    [channel invokeMethod:@"onPaymentSuccess" arguments:@{
        @"transId": transId,
        @"refNo": refNo,
        @"amount": amount,
        @"remark": remark,
        @"authCode": authCode
    }];
}

- (void)paymentCancelled:(NSString *)refNo withTransId:(NSString *)transId withAmount:(NSString *)amount withRemark:(NSString *)remark withErrDesc:(NSString *)errDesc {
    [channel invokeMethod:@"onPaymentCanceled" arguments: @{
        @"transId": transId,
        @"refNo": refNo,
        @"amount": amount,
        @"remark": remark,
        @"errDesc": errDesc
    }];
}

- (void)requeryFailed:(NSString *)refNo withMerchantCode:(NSString *)merchantCode withAmount:(NSString *)amount withErrDesc:(NSString *)errDesc {
    [channel invokeMethod:@"onRequeryResult" arguments: @{
        @"merchantCode": merchantCode,
        @"refNo": refNo,
        @"amount": amount,
        @"errDesc": errDesc
    }];
}

- (void)paymentFailed:(NSString *)refNo withTransId:(NSString *)transId withAmount:(NSString *)amount withRemark:(NSString *)remark withErrDesc:(NSString *)errDesc {
    [channel invokeMethod:@"onPaymentCanceled" arguments: @{
        @"transId": transId,
        @"refNo": refNo,
        @"amount": amount,
        @"remark": remark,
        @"errDesc": errDesc
    }];
}


- (void)requerySuccess:(NSString *)refNo withMerchantCode:(NSString *)merchantCode withAmount:(NSString *)amount withResult:(NSString *)result {
    [channel invokeMethod:@"onRequeryResult" arguments: @{
        @"merchantCode": merchantCode,
        @"refNo": refNo,
        @"amount": amount,
        @"result": result
    }];
}


@end
