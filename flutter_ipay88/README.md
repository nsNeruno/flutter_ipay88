# flutter_ipay88

Unofficial Implementation for IPay88 Payment Gateway Mobile SDK.

## Getting Started

### Installation
The SDK binaries are already included within this plugin. You may proceed to check the additional platform specific setups below.
#### Flutter Side
```yaml
# Add this under dependencies on your pubspec.yaml
flutter_ipay88_my:
  git:
    url: https://github.com/nsNeruno/flutter_ipay88.git
    path: flutter_ipay88
    ref: master
```

#### Android Side
Add declaration of additional Activities provided by _**IPay88**_ under `AndroidManifest.xml`.
##### Malaysian and Other Countries
```xml
<!-- AndroidManifest.xml under android/app/src/main/ -->
<manifest ...>
    <application ...>
        <!-- Your MainActivity declaration -->
        
        <!--- Declare these Activities -->
        <activity android:name="com.ipay.IPayIHAcitivity" android:configChanges="orientation|screenSize"/>
        <activity android:name="com.ipay.IPayIHAcitivityR" android:configChanges="orientation|screenSize"/>
    </application>
</manifest>
```
##### Indonesia Only
```xml
<!-- AndroidManifest.xml under android/app/src/main/ -->
<manifest ...>
    <application ...>
        <!-- Your MainActivity declaration -->
        
        <!--- Declare these Activities -->
        <activity android:name="com.ipay.IpayAcitivity" android:configChanges="orientation|screenSize"/>
        <activity android:name="com.ipay.IpayAcitivityR" android:configChanges="orientation|screenSize"/>
    </application>
</manifest>
```
If you're covering all regions, you may add both declarations.
**Notice the different Activity class names.**
#### IOS Side
Regardless of region, there's an additional **C static library** file named `libipay88sdk.a` that needs to be installed separatedly through XCode. The file could be obtained by different means, where for Indonesia region, you can download it directly at [IPay88 Official Mobile SDK Documentation page](https://ipay88.co.id/docs/mobilesdk). As for the rest, you may contact IPay88 Team and get a quote.
##### Installing the static library
- Select your App Build Target (assumed to be named _**Runner**_) on the left pane on your XCode
- Look for **Build Phases** tab
- Under **Link Binary with Libraries** section, add the static library file mentioned before
- Just in case, when you're done, run `pod install` under the `ios` directory of your Flutter Project

### Importing
```dart
// Import the plugin
import 'package:flutter_ipay88/flutter_ipay88.dart';
```

## Basic Usage
```dart
import 'package:flutter_ipay88/flutter_ipay88.dart';

final plugin = FlutterIPay88();

// Access the Malaysian SDK
IPay sdk = plugin.sdk;

// Access the Indonesian SDK
IPay sdkID = plugin.sdkID;

// Create an empty IPay88 Payment Object and assign some values to it's fields
IPayPayment payment = IPayPayment()
    ..paymentId = "test"
    ..amount = "100.0";

// Create an IPay88 Payment Object with pre-init values
payment = IPayPayment(
    paymentId: "test",
    amount: "100.0",
);

// Checking out with the Payment Object
sdk.checkout(payment,);

// Create an empty IPay88 Requery Object and assign some values to it's fields
IPayRequery requery = IPayRequery()
    ..merchantCode = "test"
    ..refNo = "123"
    ..amount = "100.0";
    
// Create an IPay88 Payment Object with pre-init values
requery = IPayRequery(
    merchantCode: "test",
    refNo: "123",
    amount: "100.0",
);
    
sdk.requery(requery);
```

## Listening to Events
You can intercept when IPay88 send various events:
- Successful payment
- Failed payment
- Cancelled payment
- Requery resolved (both success and failed events)

First you need to implement `IPayResultDelegate` interface.
#### Start Listening to Events
`IPay` instance has method `addDelegate` to add `IPayResultDelegate` implementations.
```dart
sdk.addDelegate(this,);
```
#### Stop Listening
It's recommended to remove the delegate listener on certain moments.
```dart
sdk.removeDelegate(this,);
```
#### State Example
```dart
class _CheckoutPageState extends State<CheckoutPage> implements IPayResultDelegate {

    IPay get _sdk => FlutterIPay88().sdk;

    @override
    void initState() {
        super.initState();
        // Start listening
        _sdk.addDelegate(this,);
    }

    @override
    void onPaymentSucceeded(String? transId, String? refNo, String? amount, String? remark, String? authCode,) {
        // call setState or do something
    }

    @override
    void onPaymentFailed(String? transId, String? refNo, String? amount, String? remark, String? errDesc,) {
        // call setState or do something
    }

    @override
    void onPaymentCanceled(String? transId, String? refNo, String? amount, String? remark, String? errDesc,) {
        // call setState or do something
    }

    @override
    void onRequeryResult(String? merchantCode, String? refNo, String? amount, String? result,) {
        // call setState or do something
    }
    
    @override
    void dispose() {
        // Stop listening
        _sdk.removeDelegate(this,);
        super.dispose();
    }
}
```

#### Flutter BLoC Example
```dart
class CheckoutBloc extends Bloc<CheckoutEvent, CheckoutState> implements IPayResultDelegate {

    IPay get _sdk => FlutterIPay88().sdk;

    CheckoutBloc() {
        // Start listening
        _sdk.addDelegate(this,);
    }

    @override
    void onPaymentSucceeded(String? transId, String? refNo, String? amount, String? remark, String? authCode,) {
        // emit a State or do something
    }

    @override
    void onPaymentFailed(String? transId, String? refNo, String? amount, String? remark, String? errDesc,) {
        // emit a State or do something
    }

    @override
    void onPaymentCanceled(String? transId, String? refNo, String? amount, String? remark, String? errDesc,) {
        // emit a State or do something
    }

    @override
    void onRequeryResult(String? merchantCode, String? refNo, String? amount, String? result,) {
        // emit a State or do something
    }
    
    @override
    void close() {
        // Stop listening
        _sdk.removeDelegate(this,);
        super.close();
    }
}
```

#### GetX Example
```dart
class CheckoutController extends GetxController implements IPayResultDelegate {
    
    IPay get _sdk => FlutterIPay88().sdk;

    @override
    void onInit() {
        super.onInit();
        // Start listening
        _sdk.addDelegate(this,);
    }

    @override
    void onPaymentSucceeded(String? transId, String? refNo, String? amount, String? remark, String? authCode,) {
        // add value to .obs or do something
    }

    @override
    void onPaymentFailed(String? transId, String? refNo, String? amount, String? remark, String? errDesc,) {
        // add value to .obs or do something
    }

    @override
    void onPaymentCanceled(String? transId, String? refNo, String? amount, String? remark, String? errDesc,) {
        // add value to .obs or do something
    }

    @override
    void onRequeryResult(String? merchantCode, String? refNo, String? amount, String? result,) {
        // add value to .obs or do something
    }
    
    @override
    void onClose() {
        // Stop listening
        _sdk.removeDelegate(this,);
        super.onClose();
    }
}
```

## Additional Info
#### Payment ID
This plugin comes with existing Payment IDs including the payment method names, or you can request a quote directly to IPay88 Team.
#### Merchant Code
Please request a quote to IPay88 Team.
#### Backend POST URL and App Deep Linking
Please consult the [Mobile SDK Documentation](https://ipay88.co.id/docs/mobilesdk). For implementing Deep Linking, you may checkout [uni_links](https://pub.dev/packages/uni_links) plugin.

## Disclaimer
Once again stating that **THIS IS NOT AN OFFICIAL PLUGIN** by **IPay88 Team**. This plugin was written to alleviate the tedious preparation process to get the Payment Gateway SDK running. In case of issues/questions that I cannot answer, I will try to forward it to the IPay88 Team for the details.

## Bugs, Issues or Suggestions
Feel free to raise an issue [here](https://github.com/nsNeruno/flutter_ipay88/issues).

## Credits
**IPay88** as the owner of the SDK. If you're interested with their SDK, you can contact them at either [Malaysia](https://ipay88.com/) (preferrable) and [Indonesian](https://ipay88.co.id/) official website.