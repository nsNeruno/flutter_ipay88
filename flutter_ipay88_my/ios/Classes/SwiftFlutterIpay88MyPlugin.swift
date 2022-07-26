import Flutter
import UIKit

public class SwiftFlutterIpay88MyPlugin: NSObject, FlutterPlugin, PaymentResultDelegate {
    
    private static var channel: FlutterMethodChannel?
    
    private lazy var paymentSdk: Ipay = {
        let paymentSdk = Ipay()
        paymentSdk.delegate = self
        return paymentSdk
    }()
    
    public static func register(with registrar: FlutterPluginRegistrar) {
        channel = FlutterMethodChannel(name: "flutter_ipay88_my", binaryMessenger: registrar.messenger())
        let instance = SwiftFlutterIpay88MyPlugin()
        registrar.addMethodCallDelegate(instance, channel: channel!)
    }
    
    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        guard let rootVc = UIApplication.shared.delegate?.window??.rootViewController else {
            return
        }
        
        let arguments = call.arguments as? [String:Any?]
        switch (call.method) {
            case "checkout":
                result(nil)
                let payment = IpayPayment()
                payment.merchantCode = arguments?["merchantCode"] as? String ?? ""
                payment.paymentId = arguments?["paymentId"] as? String ?? ""
                payment.refNo = arguments?["refNo"] as? String ?? ""
                payment.amount = arguments?["amount"] as? String ?? "1.00"
                payment.currency = arguments?["currency"] as? String ?? "IDR"
                payment.prodDesc = arguments?["prodDesc"] as? String ?? ""
                payment.userName = arguments?["userName"] as? String ?? ""
                payment.userEmail = arguments?["userEmail"] as? String ?? ""
                payment.userContact = arguments?["userContact"] as? String ?? ""
                payment.remark = arguments?["remark"] as? String
                payment.lang = arguments?["lang"] as? String
                payment.country = "ID"
                payment.backendPostURL = arguments?["backendPostURL"] as? String ?? ""
                payment.appdeeplink = arguments?["appDeepLink"] as? String
                
                if let checkoutView = self.paymentSdk.checkout(payment) {
                    rootVc.view.addSubview(checkoutView)
                }
                break
            case "requery":
                result(nil)
                let payment = IpayPayment()
                payment.merchantCode = arguments?["merchantCode"] as? String ?? ""
                payment.refNo = arguments?["refNo"] as? String ?? ""
                payment.amount = arguments?["amount"] as? String ?? "1.00"
                self.paymentSdk.requery(payment)
                break
            default:
                result(FlutterMethodNotImplemented)
                break
        }
    }
    
    public func paymentSuccess(_ refNo: String!, withTransId transId: String!, withAmount amount: String!, withRemark remark: String!, withAuthCode authCode: String!) {
        let channel = SwiftFlutterIpay88MyPlugin.channel
        channel?.invokeMethod(
            "onPaymentSuccess",
            arguments: [
                "transId": transId,
                "refNo": refNo,
                "amount": amount,
                "remark": remark,
                "authCode": authCode
            ]
        )
    }
    
    public func paymentFailed(_ refNo: String!, withTransId transId: String!, withAmount amount: String!, withRemark remark: String!, withErrDesc errDesc: String!) {
        let channel = SwiftFlutterIpay88MyPlugin.channel
        channel?.invokeMethod(
            "onPaymentFailed",
            arguments: [
                "transId": transId,
                "refNo": refNo,
                "amount": amount,
                "remark": remark,
                "errDesc": errDesc
            ]
        )
    }
    
    public func paymentCancelled(_ refNo: String!, withTransId transId: String!, withAmount amount: String!, withRemark remark: String!, withErrDesc errDesc: String!) {
        let channel = SwiftFlutterIpay88MyPlugin.channel
        channel?.invokeMethod(
            "onPaymentCanceled",
            arguments: [
                "transId": transId,
                "refNo": refNo,
                "amount": amount,
                "remark": remark,
                "errDesc": errDesc
            ]
        )
    }
    
    public func requerySuccess(_ refNo: String!, withMerchantCode merchantCode: String!, withAmount amount: String!, withResult result: String!) {
        let channel = SwiftFlutterIpay88MyPlugin.channel
        channel?.invokeMethod(
            "onRequeryResult",
            arguments: [
                "merchantCode": merchantCode,
                "refNo": refNo,
                "amount": amount,
                "result": result
            ]
        )
    }
    
    public func requeryFailed(_ refNo: String!, withMerchantCode merchantCode: String!, withAmount amount: String!, withErrDesc errDesc: String!) {
        let channel = SwiftFlutterIpay88MyPlugin.channel
        channel?.invokeMethod(
            "onRequeryResult",
            arguments: [
                "merchantCode": merchantCode,
                "refNo": refNo,
                "amount": amount,
                "errDesc": errDesc
            ]
        )
    }
}
